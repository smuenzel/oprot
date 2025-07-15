open! Core

let%expect_test "" =
  let msg = Ubx_protocol.full_message in
  let msg = Oprot.Annotate.annotate_presence msg in
  [%message.omit_nil ""
          ~_:(msg : Oprot.Dsl.Entry.t)
  ]
  |> print_s;
  [%expect {|
    ((per_entry ((Presence Always)))
     (t
      (Group
       ((optional false) (name ())
        (entries
         (((per_entry ((Presence Always)))
           (t
            (Group
             ((optional false) (name (header))
              (entries
               (((per_entry ((Presence Always)))
                 (t
                  (Field
                   ((constraint_
                     (((pre (Constant "\181"))
                       (typ ((id Char) (descriptor ((size_in_bytes 1))))))))
                    (typ ((id Char) (descriptor ((size_in_bytes 1)))))
                    (name (sync_char_1))))))
                ((per_entry ((Presence Always)))
                 (t
                  (Field
                   ((constraint_
                     (((pre (Constant b))
                       (typ ((id Char) (descriptor ((size_in_bytes 1))))))))
                    (typ ((id Char) (descriptor ((size_in_bytes 1)))))
                    (name (sync_char_2))))))
                ((per_entry ((Presence Always)))
                 (t
                  (Field
                   ((constraint_ ())
                    (typ ((id Raw.bit8) (descriptor ((size_in_bytes 1)))))
                    (name (class_id))))))
                ((per_entry ((Presence Always)))
                 (t
                  (Field
                   ((constraint_ ())
                    (typ ((id Raw.bit8) (descriptor ((size_in_bytes 1)))))
                    (name (message_id))))))
                ((per_entry ((Presence Always)))
                 (t
                  (Field
                   ((constraint_
                     (((pre
                        (Computation
                         (Operator (Offsetof ck_a) Minus (Offsetof class_id))))
                       (typ ((id Int.uint16) (descriptor ((size_in_bytes 2))))))))
                    (typ ((id Int.uint16) (descriptor ((size_in_bytes 2)))))
                    (name (length))))))))))))
          ((per_entry ((Presence Always)))
           (t
            (Select
             ((default ()) (name class_id)
              (selector
               ((typ ((id Raw.bit8) (descriptor ((size_in_bytes 1)))))
                (cases
                 ((5
                   ((per_entry ((Presence Sometimes)))
                    (t
                     (Named_message
                      ((scope (class)) (name ack)
                       (entry
                        ((per_entry ((Presence Sometimes)))
                         (t
                          (Group
                           ((optional false) (name ())
                            (entries
                             (((per_entry ((Presence Sometimes)))
                               (t
                                (Select
                                 ((default ()) (name message_id)
                                  (selector
                                   ((typ
                                     ((id Raw.bit8)
                                      (descriptor ((size_in_bytes 1)))))
                                    (cases
                                     ((1
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name ack)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries ())))))))))))
                                      (0
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name nack)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries ())))))))))))))))))))
                              ((per_entry ((Presence Sometimes)))
                               (t
                                (Field
                                 ((constraint_ ())
                                  (typ
                                   ((id Raw.bit8)
                                    (descriptor ((size_in_bytes 1)))))
                                  (name (ack_class_id))))))
                              ((per_entry ((Presence Sometimes)))
                               (t
                                (Field
                                 ((constraint_ ())
                                  (typ
                                   ((id Raw.bit8)
                                    (descriptor ((size_in_bytes 1)))))
                                  (name (ack_message_id))))))))))))))))))
                  (6
                   ((per_entry ((Presence Sometimes)))
                    (t
                     (Named_message
                      ((scope (class)) (name cfg)
                       (entry
                        ((per_entry ((Presence Sometimes)))
                         (t
                          (Group
                           ((optional false) (name ())
                            (entries
                             (((per_entry ((Presence Sometimes)))
                               (t
                                (Select
                                 ((default ()) (name message_id)
                                  (selector
                                   ((typ
                                     ((id Raw.bit8)
                                      (descriptor ((size_in_bytes 1)))))
                                    (cases
                                     ((19
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name ant)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name (antenna_flag_mask))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name
                                                       (antenna_pin_configuration))))))))))))))))))
                                      (9
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name cfg)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (clear_mask))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (save_mask))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (load_mask))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Group
                                                     ((optional true)
                                                      (name (device))
                                                      (entries
                                                       (((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (device_mask))))))))))))))))))))))))
                                      (4
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name rst)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name (nav_bbr_mask))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (reset_mode))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name ())))))))))))))))))
                                      (140
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name valdel)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (layers))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((0
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries
                                                                (((per_entry
                                                                   ((Presence
                                                                     Sometimes)))
                                                                  (t
                                                                   (Field
                                                                    ((constraint_
                                                                      ())
                                                                     (typ
                                                                      ((id
                                                                        Int.uint8)
                                                                       (descriptor
                                                                        ((size_in_bytes
                                                                        1)))))
                                                                     (name ()))))))))))))
                                                          (1
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries
                                                                (((per_entry
                                                                   ((Presence
                                                                     Sometimes)))
                                                                  (t
                                                                   (Field
                                                                    ((constraint_
                                                                      ())
                                                                     (typ
                                                                      ((id
                                                                        Int.uint8)
                                                                       (descriptor
                                                                        ((size_in_bytes
                                                                        1)))))
                                                                     (name
                                                                      (transaction)))))))))))))))))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Repeating_group
                                                     ((count ()) (name items)
                                                      (entries
                                                       (((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint32)
                                                              (descriptor
                                                               ((size_in_bytes 4)))))
                                                            (name (key))))))))))))))))))))))))
                                      (139
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name valget)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (layer))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name (position))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((0
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Repeating_group
                                                              ((count ())
                                                               (name keys)
                                                               (entries
                                                                (((per_entry
                                                                   ((Presence
                                                                     Sometimes)))
                                                                  (t
                                                                   (Field
                                                                    ((constraint_
                                                                      ())
                                                                     (typ
                                                                      ((id
                                                                        Int.uint32)
                                                                       (descriptor
                                                                        ((size_in_bytes
                                                                        4)))))
                                                                     (name (key)))))))))))))
                                                          (1
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Buffer
                                                              ((length ())
                                                               (name cfg_data))))))))))))))))))))))))))
                                      (138
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name valset)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (layers))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((0
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries
                                                                (((per_entry
                                                                   ((Presence
                                                                     Sometimes)))
                                                                  (t
                                                                   (Field
                                                                    ((constraint_
                                                                      ())
                                                                     (typ
                                                                      ((id
                                                                        Int.uint8)
                                                                       (descriptor
                                                                        ((size_in_bytes
                                                                        1)))))
                                                                     (name ()))))))))))))
                                                          (1
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries
                                                                (((per_entry
                                                                   ((Presence
                                                                     Sometimes)))
                                                                  (t
                                                                   (Field
                                                                    ((constraint_
                                                                      ())
                                                                     (typ
                                                                      ((id
                                                                        Int.uint8)
                                                                       (descriptor
                                                                        ((size_in_bytes
                                                                        1)))))
                                                                     (name
                                                                      (transaction)))))))))))))))))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Buffer
                                                     ((length ())
                                                      (name cfg_data)))))))))))))))))))))))))))))))))))))
                  (10
                   ((per_entry ((Presence Sometimes)))
                    (t
                     (Named_message
                      ((scope (class)) (name mon)
                       (entry
                        ((per_entry ((Presence Sometimes)))
                         (t
                          (Group
                           ((optional false) (name ())
                            (entries
                             (((per_entry ((Presence Sometimes)))
                               (t
                                (Select
                                 ((default ()) (name message_id)
                                  (selector
                                   ((typ
                                     ((id Raw.bit8)
                                      (descriptor ((size_in_bytes 1)))))
                                    (cases
                                     ((56
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name rf)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((0
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries ()))))))))))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (n_blocks))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id
                                                         (Fixed_array Int.uint8))
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Repeating_group
                                                     ((count
                                                       ((Computation
                                                         (Field_value n_blocks))))
                                                      (name blocks)
                                                      (entries
                                                       (((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (block_id))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (flags))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (antenna_status))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (antenna_power))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint32)
                                                              (descriptor
                                                               ((size_in_bytes 4)))))
                                                            (name (post_status))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint32)
                                                              (descriptor
                                                               ((size_in_bytes 4)))))
                                                            (name ())))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint16)
                                                              (descriptor
                                                               ((size_in_bytes 2)))))
                                                            (name (noise_per_ms))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint16)
                                                              (descriptor
                                                               ((size_in_bytes 2)))))
                                                            (name (agc_count))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (cw_suppression))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.int8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (ofs_i))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (mag_i))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.int8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (ofs_q))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (mag_q))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id
                                                               (Fixed_array
                                                                Int.uint8))
                                                              (descriptor
                                                               ((size_in_bytes 3)))))
                                                            (name ())))))))))))))))))))))))))))))))))))))))))))
                  (1
                   ((per_entry ((Presence Sometimes)))
                    (t
                     (Named_message
                      ((scope (class)) (name nav)
                       (entry
                        ((per_entry ((Presence Sometimes)))
                         (t
                          (Group
                           ((optional false) (name ())
                            (entries
                             (((per_entry ((Presence Sometimes)))
                               (t
                                (Select
                                 ((default ()) (name message_id)
                                  (selector
                                   ((typ
                                     ((id Raw.bit8)
                                      (descriptor ((size_in_bytes 1)))))
                                    (cases
                                     ((1
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name clock)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (time_of_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (bias))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (drift))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (time_accuracy))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (frequency_accuracy))))))))))))))))))
                                      (97
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name end_of_epoch)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (time_of_week))))))))))))))))))
                                      (19
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ())
                                           (name high_precision_solution_ecef)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((0
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries ()))))))))))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id
                                                         (Fixed_array Int.uint8))
                                                        (descriptor
                                                         ((size_in_bytes 3)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (time_of_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (ecef_x))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (ecef_y))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (ecef_z))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name
                                                       (ecef_x_high_precision))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name
                                                       (ecef_y_high_precision))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name
                                                       (ecef_z_high_precision))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Raw.bit8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (flags))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (position_accuracy))))))))))))))))))
                                      (20
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ())
                                           (name
                                            high_precision_solution_geodetic)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((0
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries ()))))))))))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id
                                                         (Fixed_array Int.uint8))
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Raw.bit8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (flags))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (time_of_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (longitude))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (latitude))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (height))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (height_msl))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name
                                                       (longitude_high_precision))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name
                                                       (latitude_high_precision))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name
                                                       (height_high_precision))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name
                                                       (height_msl_high_precision))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name
                                                       (horizontal_accuracy))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (vertical_accuracy))))))))))))))))))
                                      (52
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name orbit)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (time_of_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((0
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries ()))))))))))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (num_space_vehicles))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id
                                                         (Fixed_array Int.uint8))
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Repeating_group
                                                     ((count
                                                       ((Computation
                                                         (Field_value
                                                          num_space_vehicles))))
                                                      (name space_vehicle)
                                                      (entries
                                                       (((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (gnss_id))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (sv_id))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (flags))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (ephimeris_status))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (almanac_status))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (other_orbits))))))))))))))))))))))))))))))))))))))))))))
                  (2
                   ((per_entry ((Presence Sometimes)))
                    (t
                     (Named_message
                      ((scope (class)) (name rxm)
                       (entry
                        ((per_entry ((Presence Sometimes)))
                         (t
                          (Group
                           ((optional false) (name ())
                            (entries
                             (((per_entry ((Presence Sometimes)))
                               (t
                                (Select
                                 ((default ()) (name message_id)
                                  (selector
                                   ((typ
                                     ((id Raw.bit8)
                                      (descriptor ((size_in_bytes 1)))))
                                    (cases
                                     ((52
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name correction)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((1
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries ()))))))))))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (energy_per_bit))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id
                                                         (Fixed_array Int.uint8))
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (status_info))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name
                                                       (received_message_type))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name
                                                       (received_message_subtype))))))))))))))))))
                                      (20
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name measurement)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((0
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries ()))))))))))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id
                                                         (Fixed_array Int.uint8))
                                                        (descriptor
                                                         ((size_in_bytes 3)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (gps_time_of_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name
                                                       (glonass_time_of_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name
                                                       (beidou_time_of_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint32)
                                                        (descriptor
                                                         ((size_in_bytes 4)))))
                                                      (name (qzss_time_of_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name (gps_time_accuracy))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name
                                                       (glonass_time_accuracy))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name
                                                       (beidou_time_accuracy))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name (qzss_time_accuracy))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (num_space_vehicles))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (flags))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id
                                                         (Fixed_array Int.uint8))
                                                        (descriptor
                                                         ((size_in_bytes 8)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Repeating_group
                                                     ((count
                                                       ((Computation
                                                         (Field_value
                                                          num_space_vehicles))))
                                                      (name space_vehicle)
                                                      (entries
                                                       (((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (gnss_id))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (space_vehicle_id))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (carrier_noise_ratio))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (multipath_index))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.int32)
                                                              (descriptor
                                                               ((size_in_bytes 4)))))
                                                            (name
                                                             (doppler_meter_second))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.int32)
                                                              (descriptor
                                                               ((size_in_bytes 4)))))
                                                            (name (doppler_hz))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint16)
                                                              (descriptor
                                                               ((size_in_bytes 2)))))
                                                            (name (whole_chips))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint16)
                                                              (descriptor
                                                               ((size_in_bytes 2)))))
                                                            (name
                                                             (fractional_chips))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint32)
                                                              (descriptor
                                                               ((size_in_bytes 4)))))
                                                            (name (code_phase))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (int_code_phase))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (pseudorange_rms_error_index))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id
                                                               (Fixed_array
                                                                Int.uint8))
                                                              (descriptor
                                                               ((size_in_bytes 2)))))
                                                            (name ())))))))))))))))))))))))
                                      (21
                                       ((per_entry ((Presence Sometimes)))
                                        (t
                                         (Named_message
                                          ((scope ()) (name raw_measurement)
                                           (entry
                                            ((per_entry ((Presence Sometimes)))
                                             (t
                                              (Group
                                               ((optional false) (name ())
                                                (entries
                                                 (((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Float.binary64)
                                                        (descriptor
                                                         ((size_in_bytes 8)))))
                                                      (name
                                                       (receiver_time_of_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint16)
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name (receiver_week))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.int8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (leap_seconds))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (num_measurements))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name
                                                       (receiver_tracking_status))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id Int.uint8)
                                                        (descriptor
                                                         ((size_in_bytes 1)))))
                                                      (name (message_version))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Select
                                                     ((default ())
                                                      (name message_version)
                                                      (selector
                                                       ((typ
                                                         ((id Int.uint8)
                                                          (descriptor
                                                           ((size_in_bytes 1)))))
                                                        (cases
                                                         ((1
                                                           ((per_entry
                                                             ((Presence
                                                               Sometimes)))
                                                            (t
                                                             (Group
                                                              ((optional false)
                                                               (name ())
                                                               (entries ()))))))))))))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Field
                                                     ((constraint_ ())
                                                      (typ
                                                       ((id
                                                         (Fixed_array Int.uint8))
                                                        (descriptor
                                                         ((size_in_bytes 2)))))
                                                      (name ())))))
                                                  ((per_entry
                                                    ((Presence Sometimes)))
                                                   (t
                                                    (Repeating_group
                                                     ((count
                                                       ((Computation
                                                         (Field_value
                                                          num_measurements))))
                                                      (name measurement)
                                                      (entries
                                                       (((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Float.binary64)
                                                              (descriptor
                                                               ((size_in_bytes 8)))))
                                                            (name (pseudorange))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Float.binary64)
                                                              (descriptor
                                                               ((size_in_bytes 8)))))
                                                            (name
                                                             (carrier_phase))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Float.binary32)
                                                              (descriptor
                                                               ((size_in_bytes 4)))))
                                                            (name (doppler))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (gnss_id))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (space_vehicle_id))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (signal_id))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name (frequency_id))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint16)
                                                              (descriptor
                                                               ((size_in_bytes 2)))))
                                                            (name (lock_time))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (carrier_to_noise_density_ratio))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (pseudorange_standard_deviation))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (carrier_phase_standard_deviation))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (doppler_standard_deviation))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id Int.uint8)
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name
                                                             (tracking_status))))))
                                                        ((per_entry
                                                          ((Presence Sometimes)))
                                                         (t
                                                          (Field
                                                           ((constraint_ ())
                                                            (typ
                                                             ((id
                                                               (Fixed_array
                                                                Int.uint8))
                                                              (descriptor
                                                               ((size_in_bytes 1)))))
                                                            (name ())))))))))))))))))))))))))))))))))))))))))))))))))))
          ((per_entry ((Presence Always)))
           (t
            (Group
             ((optional false) (name (trailer))
              (entries
               (((per_entry ((Presence Always)))
                 (t
                  (Field
                   ((constraint_ ())
                    (typ ((id Int.uint8) (descriptor ((size_in_bytes 1)))))
                    (name (ck_a))))))
                ((per_entry ((Presence Always)))
                 (t
                  (Field
                   ((constraint_ ())
                    (typ ((id Int.uint8) (descriptor ((size_in_bytes 1)))))
                    (name (ck_b))))))))))))))))))
    |}]
