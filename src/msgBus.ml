(* Copyright (C) 2013 Florent Monnier *)
(** This software is provided "AS-IS", without any express or
    implied warranty.  In no event will the authors be held liable
    for any damages arising from the use of this software.
 
    Permission is granted to anyone to use this software for any
    purpose, including commercial applications, and to alter it
    and redistribute it freely. *)
(** Message Bus experimentation for Game Development *)
(** Inspired from this article:
    Game Development Design: Message Bus
http://stefan.boxbox.org/2013/04/02/game-development-design-3-message-bus/
*)

(** Utils *)

module Int = struct
  type t = int
  let compare (a:t) (b:t) = Pervasives.compare a b
end
module IntSet = Set.Make(Int) ;;
module IntMap = Map.Make(Int) ;;

(** Types *)

type 'a attr = {        (** attributes *)
  attr_id: int;         (** hash of attr_name *)
  attr_tag: string;     (** attribute kind *)
  attr_val: 'a;         (** value of the attribute *)
}

type 'a msg = {         (** messages *)
  msg_id: int;          (** hash of msg_tag *)
  msg_tag: string;      (** the message kind *)
  msg_attrs: 'a attr IntMap.t;  (** attributes *)
}

type 'a bus = {         (** communication bus *)
  tag_ids: IntSet.t;    (** possible messages predefined *)
  bus_msg_i: 'a msg list;   (** input list *)
  bus_msg_o: 'a msg list;   (** output list *)
}

(** Makes *)

let make_msg ~tag ~attrs = {
  msg_id = Hashtbl.hash tag;
  msg_tag = tag;
  msg_attrs =
    List.fold_left
      (fun map attr -> IntMap.add attr.attr_id attr map)
      IntMap.empty attrs;
}

let make_attr ~tag ~value = {
  attr_id = Hashtbl.hash tag;
  attr_tag = tag;
  attr_val = value;
}

let make_bus ~tags = {
  bus_msg_i = [];
  bus_msg_o = [];
  tag_ids =
    let ids_lst = List.map Hashtbl.hash tags in
    List.fold_left
      (fun set elt -> IntSet.add elt set)
      IntSet.empty ids_lst;
}

let add_msg bus msg =
  if not (IntSet.mem msg.msg_id bus.tag_ids)
  then invalid_arg "MsgBus.add_msg" else
  { bus with
    bus_msg_i = msg :: bus.bus_msg_i }

(* Gets *)

let rec pop_msg bus =
  match bus.bus_msg_o with
  | msg :: tail -> (msg, { bus with bus_msg_o = tail })
  | [] ->
      if bus.bus_msg_i = [] then failwith "empty" else
      pop_msg { bus with
        bus_msg_o = List.rev bus.bus_msg_i;
        bus_msg_i = [];
      }

let out_ready bus = {
  bus with
  bus_msg_o = List.rev_append bus.bus_msg_i bus.bus_msg_o;
  bus_msg_i = [];
}

let filter ~bus ~msg_tag =
  let msg_id = Hashtbl.hash msg_tag in
  let bus = out_ready bus in
  List.filter (fun msg -> msg.msg_id = msg_id) bus.bus_msg_o

let attrs_of_msg msg =
  IntMap.fold
    (fun k v acc -> v::acc)
    msg.msg_attrs []

let tag_of_msg msg =
  msg.msg_tag

let assoc_of_attrs attrs =
  List.map (fun attr ->
    (attr.attr_tag,
     attr.attr_val)
  ) attrs

(* Prints *)

let print_attr to_string attr =
  Printf.printf "  attr: %s = %S\n"
    attr.attr_tag
    (to_string attr.attr_val)

let print_msg to_string msg =
  Printf.printf " msg: %S\n"
    msg.msg_tag;
  IntMap.iter
    (fun id attr -> print_attr to_string attr)
    msg.msg_attrs

let print_bus to_string bus =
  let bus = out_ready bus in
  List.iter (print_msg to_string) bus.bus_msg_o

