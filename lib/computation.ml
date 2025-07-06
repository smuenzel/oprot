open! Core

module Operator = struct
  type t =
    | Plus
    | Minus
  [@@deriving sexp]
end

type t =
  | Offsetof of Field_name.t
  | Field_value of Field_name.t
  | Constant of int
  | Operator of t * Operator.t * t
[@@deriving sexp, variants]

let (+) a b = operator a Operator.Plus b
let (-) a b = operator a Operator.Minus b
