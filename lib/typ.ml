open! Core

(* Elementary, fixed size types *)

module Descriptor = struct
  type t =
    { size_in_bytes : int
    } [@@deriving sexp]

end

type 't t =
  { id : 't Type_equal.Id.t
  ; descriptor : Descriptor.t
  } [@@deriving sexp_of]


module Raw = struct
  let bit8 = 
    { id = Type_equal.Id.create ~name:"Raw.bit8" [%sexp_of: Int_repr.Uint8.t]
    ; descriptor =
        { size_in_bytes = 1
        }
    }

  let bit16 = 
    { id = Type_equal.Id.create ~name:"Raw.bit16" [%sexp_of: Int_repr.Uint16.t]
    ; descriptor =
        { size_in_bytes = 2
        }
    }

  let bit32 = 
    { id = Type_equal.Id.create ~name:"Raw.bit32" [%sexp_of: Int_repr.Uint32.t]
    ; descriptor =
        { size_in_bytes = 4
        }
    }

  let bit64 = 
    { id = Type_equal.Id.create ~name:"Raw.bit64" [%sexp_of: Int_repr.Uint64.t]
    ; descriptor =
        { size_in_bytes = 8
        }
    }
end

module Int = struct
  let uint8 =
    { id = Type_equal.Id.create ~name:"Int.uint8" [%sexp_of: Int_repr.Uint8.t]
    ; descriptor =
        { size_in_bytes = 1
        }
    }

  let uint16 =
    { id = Type_equal.Id.create ~name:"Int.uint16" [%sexp_of: Int_repr.Uint16.t]
    ; descriptor =
        { size_in_bytes = 2
        }
    }

  let uint32 =
    { id = Type_equal.Id.create ~name:"Int.uint32" [%sexp_of: Int_repr.Uint32.t]
    ; descriptor =
        { size_in_bytes = 4
        }
    }

  let uint64 =
    { id = Type_equal.Id.create ~name:"Int.uint64" [%sexp_of: Int_repr.Uint64.t]
    ; descriptor =
        { size_in_bytes = 8
        }
    }

  let int8 =
    { id = Type_equal.Id.create ~name:"Int.int8" [%sexp_of: Int_repr.Int8.t]
    ; descriptor =
        { size_in_bytes = 1
        }
    }

  let int16 =
    { id = Type_equal.Id.create ~name:"Int.int16" [%sexp_of: Int_repr.Int16.t]
    ; descriptor =
        { size_in_bytes = 2
        }
    }

  let int32 =
    { id = Type_equal.Id.create ~name:"Int.int32" [%sexp_of: Int_repr.Int32.t]
    ; descriptor =
        { size_in_bytes = 4
        }
    }

  let int64 =
    { id = Type_equal.Id.create ~name:"Int.int64" [%sexp_of: Int_repr.Int64.t]
    ; descriptor =
        { size_in_bytes = 8
        }
    }
end

module Float = struct
  let binary32 =
    { id = Type_equal.Id.create ~name:"Float.binary32" [%sexp_of: float]
    ; descriptor =
        { size_in_bytes = 4
        }
    }

  let binary64 =
    { id = Type_equal.Id.create ~name:"Float.binary64" [%sexp_of: float]
    ; descriptor =
        { size_in_bytes = 8
        }
    }
end


let char = 
  { id = Type_equal.Id.create ~name:"Char" [%sexp_of: Char.t]
  ; descriptor =
      { size_in_bytes = 1
      }
  }

let fixed_array (type a) size (base_type : a t) : a array t =
  let sexp_of_a = Type_equal.Id.to_sexp base_type.id in
  { id = Type_equal.Id.create ~name:"Fixed_array" [%sexp_of: a array]
  ; descriptor =
      { size_in_bytes = size * base_type.descriptor.size_in_bytes
      }
  }
