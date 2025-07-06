open! Core
open! Int_repr

module type D = sig
  module Field_name : String_id.S
  module Message_name : String_id.S
  module Scope_name : String_id.S

  val (?:) : string -> Field_name.t
  val (?@) : string -> Message_name.t
  val (?@@) : string -> Scope_name.t

  module Typ : sig
    type 't t

    module Raw : sig
      val bit8 : uint8 t
      val bit16 : uint16 t
      val bit32 : uint32 t
      val bit64 : uint64 t
    end

    module Int : sig
      val uint8 : uint8 t
      val uint16 : uint16 t
      val uint32 : uint32 t
      val uint64 : uint64 t

      val int8 : int8 t
      val int16 : int16 t
      val int32 : int32 t
      val int64 : int64 t
    end

    module Float : sig
      val binary32 : float t
      val binary64 : float t
    end

    val char : char t

    val fixed_array : int -> 'a t -> 'a array t
  end

  module Computation : sig
    type t

    val offsetof : Field_name.t -> t

    val field_value : Field_name.t -> t

    val (+) : t -> t -> t
    val (-) : t -> t -> t
  end

  module Constraint : sig
    type 'a t

    val constant : 'a -> 'a t

    (* CR smuenzel: add type conversion? *)
    val computation : Computation.t -> 'a t
  end

  type entry

  val field
    :  ?constraint_:'a Constraint.t
    -> 'a Typ.t
    -> Field_name.t
    -> entry

  val field_reserved
    :  ?constraint_:'a Constraint.t
    -> 'a Typ.t
    -> entry

  val group
    :  ?optional:bool
    -> ?name:string
    -> entry list
    -> entry

  val select
    : ?default:entry
    -> Field_name.t
    -> 'a Typ.t
    -> ('a * entry) list
    -> entry

  val message_name
    : ?scope:Scope_name.t
    -> Message_name.t
    -> entry
    -> entry

  val repeating_group
    :  ?count:int Constraint.t
    -> Field_name.t
    -> entry list
    -> entry

  val buffer
    :  ?length:int Constraint.t
    -> Field_name.t
    -> entry
end

module Make(D : D) = struct
  open! D

  let header =
    group
      ~name:"header"
      [ field Typ.char ?:"sync_char_1"
          ~constraint_:(Constraint.constant '\xb5')
      ; field Typ.char ?:"sync_char_2"
          ~constraint_:(Constraint.constant '\x62')
      ; field Typ.Raw.bit8 ?:"class_id"
      ; field Typ.Raw.bit8 ?:"message_id"
      ; field Typ.Int.uint16 ?:"length"
          ~constraint_:(Constraint.computation
                          Computation.((offsetof ?:"ck_a") - (offsetof ?:"class_id"))
                       )
      ]

  let trailer =
    group
      ~name:"trailer"
      [ field Typ.Int.uint8 ?:"ck_a"
      ; field Typ.Int.uint8 ?:"ck_b"
      ]

  let messages_ack =
    group
      [ select ?:"message_id" Typ.Raw.bit8
          [ Uint8.of_base_int_exn 0x01, message_name ?@"ack" (group [])
          ; Uint8.of_base_int_exn 0x00, message_name ?@"nack" (group [])
          ]
      ; field Typ.Raw.bit8 ?:"ack_class_id"
      ; field Typ.Raw.bit8 ?:"ack_message_id"
      ]
    |> message_name ~scope:?@@"class" ?@"ack"

  let messages_cfg =
    group
      [ select ?:"message_id" Typ.Raw.bit8
          [ Uint8.of_base_int_exn 0x13, message_name ?@"ant"
              (group
                 [ field Typ.Int.uint16 ?:"antenna_flag_mask"
                 ; field Typ.Int.uint16 ?:"antenna_pin_configuration"
                 ])
          ; Uint8.of_base_int_exn 0x09, message_name ?@"cfg"
              (group
                 [ field Typ.Int.uint32 ?:"clear_mask"
                 ; field Typ.Int.uint32 ?:"save_mask"
                 ; field Typ.Int.uint32 ?:"load_mask"
                 ; group ~optional:true ~name:"device"
                     [ field Typ.Int.uint8 ?:"device_mask"
                     ]
                 ])
          ; Uint8.of_base_int_exn 0x04, message_name ?@"rst"
              (group
                [ field Typ.Int.uint16 ?:"nav_bbr_mask"
                ; field Typ.Int.uint8 ?:"reset_mode"
                ; field_reserved Typ.Int.uint8
                ])
          ; Uint8.of_base_int_exn 0x8c, message_name ?@"valdel"
              (group
                 [ field Typ.Int.uint8 ?:"message_version"
                 ; field Typ.Int.uint8 ?:"layers"
                 ; select ?:"message_version" Typ.Int.uint8
                     [ Uint8.of_base_int_exn 0x00,
                       group 
                         [ field_reserved Typ.Int.uint8
                         ]
                     ; Uint8.of_base_int_exn 0x01,
                       group
                         [ field Typ.Int.uint8 ?:"transaction"
                         ]
                     ]
                 ; field_reserved Typ.Int.uint8
                 ; repeating_group ?:"items"
                     [ field Typ.Int.uint32 ?:"key"
                     ]
                 ])
          ; Uint8.of_base_int_exn 0x8b, message_name ?@"valget"
              (group
                 [ field Typ.Int.uint8 ?:"message_version"
                 ; field Typ.Int.uint8 ?:"layer"
                 ; field Typ.Int.uint16 ?:"position"
                 ; select ?:"message_version" Typ.Int.uint8
                     [ Uint8.of_base_int_exn 0x00,
                       repeating_group ?:"keys"
                         [ field Typ.Int.uint32 ?:"key"
                         ]
                     ; Uint8.of_base_int_exn 0x01,
                       buffer ?:"cfg_data"
                     ]
                 ])
          ; Uint8.of_base_int_exn 0x8a, message_name ?@"valset"
              (group
                 [ field Typ.Int.uint8 ?:"message_version"
                 ; field Typ.Int.uint8 ?:"layers"
                 ; select ?:"message_version" Typ.Int.uint8
                     [ Uint8.of_base_int_exn 0x00,
                       group 
                         [ field_reserved Typ.Int.uint8
                         ]
                     ; Uint8.of_base_int_exn 0x01,
                       group
                         [ field Typ.Int.uint8 ?:"transaction"
                         ]
                     ]
                 ; field_reserved Typ.Int.uint8
                 ; buffer ?:"cfg_data"
                 ])
          ]
      ]
    |> message_name ~scope:?@@"class" ?@"cfg"

  let messages_mon =
    group
      [ select ?:"message_id" Typ.Raw.bit8
          [ Uint8.of_base_int_exn 0x38, message_name ?@"rf"
              (group
                 [ field Typ.Int.uint8 ?:"message_version"
                 ; select ?:"message_version" Typ.Int.uint8
                     [ Uint8.of_base_int_exn 0x00, group [] ] 
                 ; field Typ.Int.uint8 ?:"n_blocks"
                 ; field_reserved (Typ.fixed_array 2 Typ.Int.uint8)
                 ; repeating_group ?:"blocks"
                     ~count:(Constraint.computation (Computation.field_value ?:"n_blocks"))
                     [ field Typ.Int.uint8 ?:"block_id"
                     ; field Typ.Int.uint8 ?:"flags"
                     ; field Typ.Int.uint8 ?:"antenna_status"
                     ; field Typ.Int.uint8 ?:"antenna_power"
                     ; field Typ.Int.uint32 ?:"post_status"
                     ; field_reserved Typ.Int.uint32
                     ; field Typ.Int.uint16 ?:"noise_per_ms"
                     ; field Typ.Int.uint16 ?:"agc_count"
                     ; field Typ.Int.uint8 ?:"cw_suppression"
                     ; field Typ.Int.int8 ?:"ofs_i"
                     ; field Typ.Int.uint8 ?:"mag_i"
                     ; field Typ.Int.int8 ?:"ofs_q"
                     ; field Typ.Int.uint8 ?:"mag_q"
                     ; field_reserved (Typ.fixed_array 3 Typ.Int.uint8)
                     ]
                 ])
          ]
      ]
    |> message_name ~scope:?@@"class" ?@"mon"

  let messages_nav =
    group
      [ select ?:"message_id" Typ.Raw.bit8
          [ Uint8.of_base_int_exn 0x01, message_name ?@"clock"
              (group
                 [ field Typ.Int.uint32 ?:"time_of_week"
                 ; field Typ.Int.int32 ?:"bias"
                 ; field Typ.Int.int32 ?:"drift"
                 ; field Typ.Int.uint32 ?:"time_accuracy"
                 ; field Typ.Int.uint32 ?:"frequency_accuracy"
                 ])
          ; Uint8.of_base_int_exn 0x61, message_name ?@"end_of_epoch"
              (group
                 [ field Typ.Int.uint32 ?:"time_of_week"
                 ])
          ; Uint8.of_base_int_exn 0x13, message_name ?@"high_precision_solution_ecef"
              (group
                 [ field Typ.Int.uint8 ?:"message_version"
                 ; select ?:"message_version" Typ.Int.uint8
                     [ Uint8.of_base_int_exn 0x00, group [] ]
                 ; field_reserved (Typ.fixed_array 3 Typ.Int.uint8)
                 ; field Typ.Int.uint32 ?:"time_of_week"
                 ; field Typ.Int.int32 ?:"ecef_x"
                 ; field Typ.Int.int32 ?:"ecef_y"
                 ; field Typ.Int.int32 ?:"ecef_z"
                 ; field Typ.Int.int8 ?:"ecef_x_high_precision"
                 ; field Typ.Int.int8 ?:"ecef_y_high_precision"
                 ; field Typ.Int.int8 ?:"ecef_z_high_precision"
                 ; field Typ.Raw.bit8 ?:"flags"
                 ; field Typ.Int.uint32 ?:"position_accuracy"
                 ])
          ; Uint8.of_base_int_exn 0x14, message_name ?@"high_precision_solution_geodetic"
              (group
                 [ field Typ.Int.uint8 ?:"message_version"
                 ; select ?:"message_version" Typ.Int.uint8
                     [ Uint8.of_base_int_exn 0x00, group [] ]
                 ; field_reserved (Typ.fixed_array 2 Typ.Int.uint8)
                 ; field Typ.Raw.bit8 ?:"flags"
                 ; field Typ.Int.uint32 ?:"time_of_week"
                 ; field Typ.Int.int32 ?:"longitude"
                 ; field Typ.Int.int32 ?:"latitude"
                 ; field Typ.Int.int32 ?:"height"
                 ; field Typ.Int.int32 ?:"height_msl"
                 ; field Typ.Int.int8 ?: "longitude_high_precision"
                 ; field Typ.Int.int8 ?: "latitude_high_precision"
                 ; field Typ.Int.int8 ?: "height_high_precision"
                 ; field Typ.Int.int8 ?: "height_msl_high_precision"
                 ; field Typ.Int.uint32 ?: "horizontal_accuracy"
                 ; field Typ.Int.uint32 ?: "vertical_accuracy"
                 ])
          ; Uint8.of_base_int_exn 0x34, message_name ?@"orbit"
              (group
                 [ field Typ.Int.uint32 ?:"time_of_week"
                 ; field Typ.Int.uint8 ?:"message_version"
                 ; select ?:"message_version" Typ.Int.uint8
                     [ Uint8.of_base_int_exn 0x00, group [] ]
                 ; field Typ.Int.uint8 ?:"num_space_vehicles"
                 ; field_reserved (Typ.fixed_array 2 Typ.Int.uint8)
                 ; repeating_group ?:"space_vehicle"
                     ~count:(Constraint.computation (Computation.field_value ?:"num_space_vehicles"))
                     [ field Typ.Int.uint8 ?:"gnss_id"
                     ; field Typ.Int.uint8 ?:"sv_id"
                     ; field Typ.Int.uint8 ?:"flags"
                     ; field Typ.Int.uint8 ?:"ephimeris_status"
                     ; field Typ.Int.uint8 ?:"almanac_status"
                     ; field Typ.Int.uint8 ?:"other_orbits"
                     ]
                 ])
          ]
      ]
    |> message_name ~scope:?@@"class" ?@"nav"

  let messages_rxm =
    group
      [ select ?:"message_id" Typ.Raw.bit8
          [ Uint8.of_base_int_exn 0x34, message_name ?@"correction"
              (group
                 [ field Typ.Int.uint8 ?:"message_version"
                 ; select ?:"message_version" Typ.Int.uint8
                     [ Uint8.of_base_int_exn 0x01, group [] ]
                 ; field Typ.Int.uint8 ?:"energy_per_bit"
                 ; field_reserved (Typ.fixed_array 2 Typ.Int.uint8)
                 ; field Typ.Int.uint32 ?:"status_info"
                 ; field Typ.Int.uint16 ?:"received_message_type"
                 ; field Typ.Int.uint16 ?:"received_message_subtype"
                 ])
          ; Uint8.of_base_int_exn 0x14, message_name ?@"measurement"
              (group
                 [ field Typ.Int.uint8 ?:"message_version"
                 ; select ?:"message_version" Typ.Int.uint8
                     [ Uint8.of_base_int_exn 0x00, group [] ]
                 ; field_reserved (Typ.fixed_array 3 Typ.Int.uint8)
                 ; field Typ.Int.uint32 ?:"gps_time_of_week"
                 ; field Typ.Int.uint32 ?:"glonass_time_of_week"
                 ; field Typ.Int.uint32 ?:"beidou_time_of_week"
                 ; field_reserved Typ.Int.uint32
                 ; field Typ.Int.uint32 ?:"qzss_time_of_week"
                 ; field Typ.Int.uint16 ?:"gps_time_accuracy"
                 ; field Typ.Int.uint16 ?:"glonass_time_accuracy"
                 ; field Typ.Int.uint16 ?:"beidou_time_accuracy"
                 ; field_reserved Typ.Int.uint16
                 ; field Typ.Int.uint16 ?:"qzss_time_accuracy"
                 ; field Typ.Int.uint8 ?:"num_space_vehicles"
                 ; field Typ.Int.uint8 ?:"flags"
                 ; field_reserved (Typ.fixed_array 8 Typ.Int.uint8)
                 ; repeating_group ?:"space_vehicle"
                     ~count:(Constraint.computation (Computation.field_value ?:"num_space_vehicles"))
                     [ field Typ.Int.uint8 ?:"gnss_id"
                     ; field Typ.Int.uint8 ?:"space_vehicle_id"
                     ; field Typ.Int.uint8 ?:"carrier_noise_ratio"
                     ; field Typ.Int.uint8 ?:"multipath_index"
                     ; field Typ.Int.int32 ?:"doppler_meter_second"
                     ; field Typ.Int.int32 ?:"doppler_hz"
                     ; field Typ.Int.uint16 ?:"whole_chips"
                     ; field Typ.Int.uint16 ?:"fractional_chips"
                     ; field Typ.Int.uint32 ?:"code_phase"
                     ; field Typ.Int.uint8 ?:"int_code_phase"
                     ; field Typ.Int.uint8 ?:"pseudorange_rms_error_index"
                     ; field_reserved (Typ.fixed_array 2 Typ.Int.uint8)
                     ]
                 ])
          ; Uint8.of_base_int_exn 0x15, message_name ?@"raw_measurement"
              (group
                [ field Typ.Float.binary64 ?:"receiver_time_of_week"
                ; field Typ.Int.uint16 ?:"receiver_week"
                ; field Typ.Int.int8 ?:"leap_seconds"
                ; field Typ.Int.uint8 ?:"num_measurements"
                ; field Typ.Int.uint8 ?:"receiver_tracking_status"
                ; field Typ.Int.uint8 ?:"message_version"
                ; select ?:"message_version" Typ.Int.uint8
                    [ Uint8.of_base_int_exn 0x01, group [] ]
                ; field_reserved (Typ.fixed_array 2 Typ.Int.uint8)
                ; repeating_group ?:"measurement"
                    ~count:(Constraint.computation (Computation.field_value ?:"num_measurements"))
                    [ field Typ.Float.binary64 ?:"pseudorange"
                    ; field Typ.Float.binary64 ?:"carrier_phase"
                    ; field Typ.Float.binary32 ?:"doppler"
                    ; field Typ.Int.uint8 ?:"gnss_id"
                    ; field Typ.Int.uint8 ?:"space_vehicle_id"
                    ; field Typ.Int.uint8 ?:"signal_id"
                    ; field Typ.Int.uint8 ?:"frequency_id"
                    ; field Typ.Int.uint16 ?:"lock_time"
                    ; field Typ.Int.uint8 ?:"carrier_to_noise_density_ratio"
                    ; field Typ.Int.uint8 ?:"pseudorange_standard_deviation"
                    ; field Typ.Int.uint8 ?:"carrier_phase_standard_deviation"
                    ; field Typ.Int.uint8 ?:"doppler_standard_deviation"
                    ; field Typ.Int.uint8 ?:"tracking_status"
                    ; field_reserved (Typ.fixed_array 1 Typ.Int.uint8)
                    ]
                ])
          ]
      ]
    |> message_name ~scope:?@@"class" ?@"rxm"

  let messages =
    select ?:"class_id" Typ.Raw.bit8
      [ Uint8.of_base_int_exn 0x05, messages_ack
      ; Uint8.of_base_int_exn 0x06, messages_cfg
      ; Uint8.of_base_int_exn 0x0a, messages_mon
      ; Uint8.of_base_int_exn 0x01, messages_nav
      ; Uint8.of_base_int_exn 0x02, messages_rxm
      ]

  let full_message =
    group
      [ header
      ; messages
      ; trailer
      ]

end
