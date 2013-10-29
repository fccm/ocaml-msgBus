(** Generic / Polymorphic Types *)

type t = [
  | `Int of int
  | `Int2 of int * int
  | `Int3 of int * int * int
  | `Float of float
  | `Float2 of float * float
  | `Float3 of float * float * float
  | `String of string
  | `String2 of string * string
  | `Char of char
  | `Char2 of char * char
  ]

(** {4 Convertion to string} *)

val print_attr : t -> string

(** {4 Convertions from Basic Types} *)

val of_int : int -> t
val of_int2 : int * int -> t
val of_int3 : int * int * int -> t

val of_float : float -> t
val of_float2 : float * float -> t
val of_float3 : float * float * float -> t

val of_string : string -> t
val of_string2 : string * string -> t

val of_char : char -> t
val of_char2 : char * char -> t

(** {4 Convertions to Basic Types} *)

val to_int : t -> int
val to_int2 : t -> int * int
val to_int3 : t -> int * int * int

val to_float : t -> float
val to_float2 : t -> float * float
val to_float3 : t -> float * float * float

val to_string : t -> string
val to_string2 : t -> string * string

val to_char : t -> char
val to_char2 : t -> char * char

