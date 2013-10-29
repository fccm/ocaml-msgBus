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

let print_attr = function
  | `Int d -> Printf.sprintf "%d" d
  | `Int2(d1, d2) -> Printf.sprintf "(%d, %d)" d1 d2
  | `Int3(d1, d2, d3) -> Printf.sprintf "(%d, %d, %d)" d1 d2 d3
  | `Float f -> Printf.sprintf "%g" f
  | `Float2(f1, f2) -> Printf.sprintf "(%g, %g)" f1 f2
  | `Float3(f1, f2, f3) -> Printf.sprintf "(%g, %g, %g)" f1 f2 f3
  | `String s -> Printf.sprintf "%s" s
  | `String2(s1, s2) -> Printf.sprintf "(%s, %s)" s1 s2
  | `Char c -> Printf.sprintf "%c" c
  | `Char2(c1, c2) -> Printf.sprintf "(%c, %c)" c1 c2

let of_int d = `Int d
let of_int2 d2 = `Int2 d2
let of_int3 d3 = `Int3 d3
let of_float f = `Float f
let of_float2 f2 = `Float2 f2
let of_float3 f3 = `Float3 f3
let of_string s = `String s
let of_string2 s2 = `String2 s2
let of_char c = `Char c
let of_char2 (c1, c2) = `Char2 (c1, c2)

let to_int = function `Int d -> d | _ -> invalid_arg "to_int"
let to_int2 = function `Int2(d1, d2) -> (d1, d2) | _ -> invalid_arg "to_int2"
let to_int3 = function `Int3(d1, d2, d3) -> (d1, d2, d3) | _ -> invalid_arg "to_int3"
let to_float = function `Float f -> f | _ -> invalid_arg "to_float"
let to_float2 = function `Float2(f1, f2) -> (f1, f2) | _ -> invalid_arg "to_float2"
let to_float3 = function `Float3(f1, f2, f3) -> (f1, f2, f3) | _ -> invalid_arg "to_float3"
let to_string = function `String s -> s | _ -> invalid_arg "to_string"
let to_string2 = function `String2(s1, s2) -> (s1, s2) | _ -> invalid_arg "to_string2"
let to_char = function `Char c -> c | _ -> invalid_arg "to_char"
let to_char2 = function `Char2(c1, c2) -> (c1, c2) | _ -> invalid_arg "to_char2"

