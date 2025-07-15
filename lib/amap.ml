open Core

module Key_info = struct
  type 'a t =
    { name : string
    ; sexp : (module Sexpable.S with type t = 'a)
    }

end

module Hmap = Hmap.Make(Key_info)

include (Hmap : module type of Hmap with module Key := Hmap.Key)

module Key = struct
  type 'a t = 'a Hmap.key

  let create
      (type a)
      name
      (module Sexpable : Sexpable.S with type t = a)
    : a t
    =
    Hmap.Key.create { Key_info.
                      name 
                    ; sexp = (module Sexpable)
                    }
end

let empty = Hmap.empty

let set ~key ~data map = Hmap.add key data map


let t_of_sexp _ = assert false

let sexp_of_t t =
  Hmap.fold
    (fun (B (key, value) : binding) acc ->
       let info = Hmap.Key.info key in
       let (module Sexpable) = info.sexp in
       Sexp.List
         [ Sexp.Atom info.name
         ; Sexpable.sexp_of_t value
         ]
       :: acc
    ) t []
  |> Sexp.List
