

(*
  val (?:) : string -> Field_name.t
  val (?@) : string -> Message_name.t
  val (?@@) : string -> Scope_name.t
   *)

let (?:) = Field_name.of_string
let (?@) = Message_name.of_string
let (?@@) = Scope_name.of_string
