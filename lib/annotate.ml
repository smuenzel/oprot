open Core

module Presence = struct
  module T = struct
    type t =
      | Always
      | Sometimes
    [@@deriving sexp]
  end
  include T

  let key = Amap.Key.create "Presence" (module T)
end

let rec annotate_down
    ~parent
    ~f
    (e : Dsl.Entry.t)
  =
  let { Dsl.Entry.t ;per_entry; } = e in
  let per_entry, down = f ~parent t per_entry in
  match t with
  | Field _ ->
    { Dsl.Entry.t
    ; per_entry
    }
  | Group g ->
    let entries = List.map g.entries ~f:(annotate_down ~parent:down ~f) in
    { Dsl.Entry.t = Group { g with entries }
    ; per_entry
    }
  | Select { default; name; selector = S { typ; cases } } ->
    let default = Option.map default ~f:(annotate_down ~parent:down ~f) in
    let cases = List.map cases ~f:(fun (t,e) -> (t, annotate_down ~parent:down ~f e)) in
    { Dsl.Entry.t = Select { default; name; selector = S { typ; cases } }
    ; per_entry
    }
  | Named_message { scope; name; entry } ->
    let entry = annotate_down ~parent:down ~f entry in
    { Dsl.Entry.t = Named_message { scope; name; entry }
    ; per_entry
    }
  | Repeating_group { count; name; entries } ->
    let entries = List.map entries ~f:(annotate_down ~parent:down ~f) in
    { Dsl.Entry.t = Repeating_group { count; name; entries }
    ; per_entry
    }
  | Buffer _ ->
    { Dsl.Entry.t
    ; per_entry
    }
  

let annotate_presence
    ~parent:(parent_presence : Presence.t)
    (t : Dsl.Entry.t')
    (per_entry : Amap.t)
  =
  let this_presence, down =
    match t with
    | Field _ -> parent_presence, parent_presence
    | Group g ->
      if g.optional
      then Presence.Sometimes, Presence.Sometimes
      else parent_presence, parent_presence
    | Select _ -> parent_presence, Presence.Sometimes
    | Named_message _ -> parent_presence, parent_presence
    | Repeating_group _ -> parent_presence, parent_presence
    | Buffer _ -> parent_presence, parent_presence
  in
  let per_entry = Presence.(Amap.set per_entry ~key ~data:this_presence) in
  per_entry
, down

let annotate_presence = annotate_down ~parent:Presence.Always ~f:annotate_presence

(*
module type Annotator = sig
  type pre
  type post
  type contents

  val annotate : pre -> contents -> post
end

type ('pre, 'post, 'contents) t =
  (module Annotator
    with type pre = 'pre
     and type post = 'post
     and type contents = 'contents)

let rec annotate_presence
  (type pre pos)
  (type a)
  (annotator : (pre, pos, Presence.t) t)
  (e : a Dsl.Entry.t)
  (parent_presence : Presence.t)
  : (a, pos) Dsl.Annot.update_per_entry Dsl.Entry.t
  =
  let module Ann = (val annotator) in
  match e with
  | E { t; per_entry; specific } ->
    let this_presence =
      match t with
      | Field _ -> parent_presence
      | Group g ->
        if g.optional
        then Presence.Sometimes
        else parent_presence
      | Select _ -> parent_presence
      | Named_message _ -> parent_presence
      | Repeating_group _ -> parent_presence
      | Buffer _ -> parent_presence
    in
    Dsl.Entry.E { t
                ; per_entry =
                    Ann.annotate
                      per_entry
                      this_presence
                ; specific
                }
   *)
