open Core

let (?:) = Field_name.of_string
let (?@) = Message_name.of_string
let (?@@) = Scope_name.of_string

module%gen rec Entry : sig
  type t' =
    | Field of Field.t
    | Group of Group.t
    | Select of Select.t
    | Named_message of Named_message.t
    | Repeating_group of Repeating_group.t
    | Buffer of Buffer.t
  [@@deriving sexp_of]

  type t =
    { per_entry : Amap.t
    ; t : t'
    }
  [@@deriving sexp_of]
end = Entry
and Field : sig
  type t =
    | F : { constraint_ : 't Constraint.t option
          ; typ : 't Typ.t
          ; name : Field_name.t option
          } -> t
  [@@deriving sexp_of]
end = struct
  type t =
    | F : { constraint_ : 't Constraint.t option
          ; typ : 't Typ.t
          ; name : Field_name.t option
          } -> t

  let sexp_of_t (F { constraint_; typ; name }) =
    let sexp_of_t = Type_equal.Id.to_sexp typ.id in
    [%message ""
        (constraint_ : t Constraint.t option)
        (typ : t Typ.t)
        (name : Field_name.t option)
    ]
end
and Group : sig
  type t =
    { optional : bool
    ; name : Field_name.t option
    ; entries : Entry.t list
    }
  [@@deriving sexp_of]
end = Group
and Select : sig
  type t =
    { default : Entry.t option
    ; name : Field_name.t
    ; selector : Selector.t
    }
  [@@deriving sexp_of]
end = Select
and Selector : sig
  type t =
    | S : 
        { typ : 't Typ.t
        ; cases : ('t * Entry.t) list
        }
        -> t
  [@@deriving sexp_of]
end = struct
  type t =
    | S : 
        { typ : 't Typ.t
        ; cases : ('t * Entry.t) list
        }
        -> t

  let sexp_of_t (S { typ; cases }) =
    let sexp_of_t = Type_equal.Id.to_sexp typ.id in
    [%message ""
        (typ : t Typ.t)
        (cases : (t * Entry.t) list)
    ]
end
and Named_message : sig
  type t =
    { scope : Scope_name.t option
    ; name : Message_name.t
    ; entry : Entry.t
    }
  [@@deriving sexp_of]
end = Named_message
and Repeating_group : sig
  type t =
    { count : int Constraint.Pre.t option
    ; name : Field_name.t
    ; entries : Entry.t list
    }
  [@@deriving sexp_of]
end = Repeating_group
and Buffer : sig
  type t =
    { length : int Constraint.Pre.t option
    ; name : Field_name.t
    }
  [@@deriving sexp_of]
end = Buffer

module D = struct

  let field ?constraint_ typ name : Entry.t =
    let constraint_ = 
      match constraint_ with
      | Some constraint_ -> Some (Constraint.make constraint_ typ)
      | None -> None
    in
    { t = Field (F { constraint_; typ; name = Some name})
    ; per_entry = Amap.empty
    }

  let field_reserved typ : Entry.t =
      { t = Field (F { constraint_ = None; typ; name = None})
      ; per_entry = Amap.empty
      }

  let group ?(optional = false) ?name entries : Entry.t =
      { t = Group { optional; name; entries}
      ; per_entry = Amap.empty
      }

  let select ?default name typ entries : Entry.t =
      { t = Select { default; name; selector = S { typ; cases = entries } }
      ; per_entry = Amap.empty
      }

  let message_name ?scope name entry : Entry.t =
      { t = Named_message { scope; name; entry }
      ; per_entry = Amap.empty
      }

  let repeating_group ?count name entries : Entry.t =
      { t = Repeating_group { count; name; entries }
      ; per_entry = Amap.empty
      }

  let buffer ?length name : Entry.t =
      { t = Buffer { length; name }
      ; per_entry = Amap.empty
      }
end
