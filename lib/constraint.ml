

module Pre = struct
  type 'a t =
    | Constant of 'a
    | Computation of Computation.t
  [@@deriving sexp, variants]
end

type 'a t =
  { pre : 'a Pre.t
  ; typ : 'a Typ.t
  } [@@deriving sexp_of]


let constant = Pre.constant
let computation = Pre.computation

let make (type a) (pre : a Pre.t) (typ : a Typ.t) =
  { pre; typ }
