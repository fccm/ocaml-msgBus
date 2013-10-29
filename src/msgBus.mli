(** Message Bus experimentation for Game Development *)
(** Inspired from this article:
{{:http://stefan.boxbox.org/2013/04/02/game-development-design-3-message-bus/}
Game Development Design: Message Bus}
*)

(** {3 Types} *)

type 'a bus     (** communication bus *)
type 'a msg     (** messages *)
type 'a attr    (** attributes *)

(** {3 Makes} *)

val make_msg : tag:string -> attrs:'a attr list -> 'a msg

val make_attr : tag:string -> value:'a -> 'a attr

val make_bus : tags:string list -> 'a bus
(* [tags] is the exhaustive list of messages name
   (to avoid typos that would make a tag mismatch) *)

val add_msg : 'a bus -> 'a msg -> 'a bus

(** {3 Gets} *)

val pop_msg : 'a bus -> 'a msg * 'a bus

val filter : bus:'a bus -> msg_tag:string -> 'a msg list

val attrs_of_msg : 'a msg -> 'a attr list

val tag_of_msg : 'a msg -> string

val assoc_of_attrs : 'a attr list -> (string * 'a) list

(** {3 Prints} *)

val print_bus : ('a -> string) -> 'a bus -> unit

val print_msg : ('a -> string) -> 'a msg -> unit

