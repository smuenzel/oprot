
let (?:) = Field_name.of_string
let (?@) = Message_name.of_string
let (?@@) = Scope_name.of_string

module Annot = struct
  type 'a t = 'a constraint
    'a = < per_field : 'a0
       ; per_select : 'a2
       ; per_named_message : 'a3
       ; per_repeating_group : 'a4
       ; per_buffer : 'a5
       ; per_group : 'a6  
       ; per_entry : 'a7
       >

  type 'a per_field = 'b constraint 'a = < per_field : 'b; .. >
  type 'a per_select = 'b constraint 'a = < per_select : 'b; .. >
  type 'a per_named_message = 'b constraint 'a = < per_named_message : 'b; .. >
  type 'a per_repeating_group = 'b constraint 'a = < per_repeating_group : 'b; .. >
  type 'a per_buffer = 'b constraint 'a = < per_buffer : 'b; .. >
  type 'a per_group = 'b constraint 'a = < per_group : 'b; .. >
  type 'a per_entry = 'b constraint 'a = < per_entry : 'b; .. >
end

module rec Entry : sig
  type ('a, 's) t' =
    | Field : 'a Field.t -> ('a Annot.t, 'a Annot.per_field) t'
    | Group : 'a Group.t -> ('a Annot.t, 'a Annot.per_group) t'
    | Select : 'a Select.t -> ('a Annot.t, 'a Annot.per_select) t'
    | Named_message : 'a Named_message.t -> ('a Annot.t, 'a Annot.per_named_message) t'
    | Repeating_group : 'a Repeating_group.t -> ('a Annot.t, 'a Annot.per_repeating_group) t'
    | Buffer : 'a Buffer.t -> ('a Annot.t, 'a Annot.per_buffer) t'

  type 'a t =
      E : { t : ('a, 's) t'
          ; per_entry : 'a Annot.per_entry
          ; specific : 's
          } -> 'a t
end = Entry
and Field : sig
  type _ t =
    | F : { constraint_ : 't Constraint.t option
          ; typ : 't Typ.t
          ; name : Field_name.t option
          } -> _ t
end = Field
and Group : sig
  type 'a t =
    { optional : bool
    ; name : Field_name.t option
    ; entries : 'a Entry.t list
    }
end = Group
and Select : sig
  type 'a selector =
    | S : 
        { typ : 't Typ.t
        ; cases : ('t * 'a Entry.t) list
        }
        -> 'a selector

  type 'a t =
    { default : 'a Entry.t option
    ; name : Field_name.t
    ; selector : 'a selector
    }
end = Select
and Named_message : sig
  type 'a t =
    { scope : Scope_name.t option
    ; name : Message_name.t
    ; entry : 'a Entry.t
    }
end = Named_message
and Repeating_group : sig
  type 'a t =
    { count : int Constraint.Pre.t option
    ; name : Field_name.t
    ; entries : 'a Entry.t list
    }
end = Repeating_group
and Buffer : sig
  type 'a t =
    { length : int Constraint.Pre.t option
    ; name : Field_name.t
    }
end = Buffer

module D = struct

  let field ?constraint_ typ name =
    let constraint_ = 
      match constraint_ with
      | Some constraint_ -> Some (Constraint.make constraint_ typ)
      | None -> None
    in
    Entry.E
      { t = Field (F { constraint_; typ; name = Some name})
      ; per_entry = ()
      ; specific = ()
      }

  let field_reserved typ =
    Entry.E
      { t = Field (F { constraint_ = None; typ; name = None})
      ; per_entry = ()
      ; specific = ()
      }

  let group ?(optional = false) ?name entries =
    Entry.E
      { t = Group { optional; name; entries}
      ; per_entry = ()
      ; specific = ()
      }

  let select ?default name typ entries =
    Entry.E
      { t = Select { default; name; selector = S { typ; cases = entries } }
      ; per_entry = ()
      ; specific = ()
      }

  let message_name ?scope name entry =
    Entry.E
      { t = Named_message { scope; name; entry }
      ; per_entry = ()
      ; specific = ()
      }

  let repeating_group ?count name entries =
    Entry.E
      { t = Repeating_group { count; name; entries }
      ; per_entry = ()
      ; specific = ()
      }

  let buffer ?length name =
    Entry.E
      { t = Buffer { length; name }
      ; per_entry = ()
      ; specific = ()
      }
end
