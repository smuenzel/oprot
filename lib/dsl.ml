
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
       >

  type 'a per_field = 'b constraint 'a = < per_field : 'b; .. >
  type 'a per_select = 'b constraint 'a = < per_select : 'b; .. >
  type 'a per_named_message = 'b constraint 'a = < per_named_message : 'b; .. >
  type 'a per_repeating_group = 'b constraint 'a = < per_repeating_group : 'b; .. >
  type 'a per_buffer = 'b constraint 'a = < per_buffer : 'b; .. >
  type 'a per_group = 'b constraint 'a = < per_group : 'b; .. >
end

module rec Entry : sig
  type 'a t =
    | Field of 'a Field.t
    | Group of 'a Group.t
    | Select of 'a Select.t
    | Named_message of 'a Named_message.t
    | Repeating_group of 'a Repeating_group.t
    | Buffer of 'a Buffer.t
    constraint 'a = 'a0 Annot.t
end = Entry
and Field : sig
  type t' =
    | F : { constraint_ : 't Constraint.t option
          ; typ : 't Typ.t
          ; name : Field_name.t option
          } -> t'

  type 'a t =
    { t : t'
    ; annot : 'a Annot.per_field
    }
end = Field
and Group : sig
  type 'a t' =
    { optional : bool
    ; name : Field_name.t option
    ; entries : 'a Entry.t list
    }

  type 'a t =
    { t : 'a t'
    ; annot : 'a Annot.per_group
    }
end = Group
and Select : sig
  type 'a selector =
    | S : 
        { typ : 't Typ.t
        ; cases : ('t * 'a Entry.t) list
        }
        -> 'a selector

  type 'a t' =
    { default : 'a Entry.t option
    ; name : Field_name.t
    ; selector : 'a selector
    }

  type 'a t =
    { t : 'a t'
    ; annot : 'a Annot.per_select
    }
end = Select
and Named_message : sig
  type 'a t' =
    { scope : Scope_name.t option
    ; name : Message_name.t
    ; entry : 'a Entry.t
    }

  type 'a t =
    { t : 'a t'
    ; annot : 'a Annot.per_named_message
    }
end = Named_message
and Repeating_group : sig
  type 'a t' =
    { count : int Constraint.Pre.t option
    ; name : Field_name.t
    ; entries : 'a Entry.t list
    }

  type 'a t =
    { t : 'a t'
    ; annot : 'a Annot.per_repeating_group
    }
end = Repeating_group
and Buffer : sig
  type 'a t' =
    { length : int Constraint.Pre.t option
    ; name : Field_name.t
    }

  type 'a t =
    { t : 'a t'
    ; annot : 'a Annot.per_buffer
    }
end = Buffer

module D = struct

  let field ?constraint_ typ name =
    let constraint_ = 
      match constraint_ with
      | Some constraint_ -> Some (Constraint.make constraint_ typ)
      | None -> None
    in
    Entry.Field
      { Field.t = F { constraint_; typ; name = Some name}; annot = () }

  let field_reserved typ =
    Entry.Field
      { Field.t = F { constraint_ = None; typ; name = None}; annot = () }

  let group ?(optional = false) ?name entries =
    Entry.Group
      { Group.t = { optional; name; entries}; annot = () }

  let select ?default name typ entries =
    Entry.Select
      { Select.t = { default; name; selector = S { typ; cases = entries } }; annot = () }

  let message_name ?scope name entry =
    Entry.Named_message
      { Named_message.t = { scope; name; entry }; annot = () }

  let repeating_group ?count name entries =
    Entry.Repeating_group
      { Repeating_group.t = { count; name; entries }; annot = () }

  let buffer ?length name =
    Entry.Buffer
      { Buffer.t = { length; name }; annot = () }

end
