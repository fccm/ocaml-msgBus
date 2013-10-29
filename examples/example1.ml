module MB = MsgBus
module MA = MsgAttr

let colors = [|
  "red";
  "green";
  "blue";
  "yellow";
  "magenta";
  "cyan";
|]

let objects = [|
  "cube";
  "sphere";
  "cylinder";
  "cone";
  "pyramid";
  "torus";
|]

let rand_take ar =
  let n = Array.length ar in
  Array.unsafe_get ar (Random.int n)

let rand_color () =
  rand_take colors

let rand_object () =
  rand_take objects

let rand_int () =
  Random.int 100_000


let make_rand_msg_a () =
  let id = rand_int () in
  let color = rand_color () in
  MB.make_msg ~tag:"entity_created"
    ~attrs:[
      MB.make_attr "entity_id" (`Int id);
      MB.make_attr "color" (`String color);
    ]


let make_rand_msg_b () =
  let color = rand_color () in
  let obj = rand_object () in
  MB.make_msg ~tag:"render_object"
    ~attrs:[
      MB.make_attr "type" (`String obj);
      MB.make_attr "color" (`String color);
    ]

(* message to Network *)

let get_entity_created_msg msg =
  if MB.tag_of_msg msg <> "entity_created" then None else
  let attrs = MB.attrs_of_msg msg in
  let assoc = MB.assoc_of_attrs attrs in
  match assoc with
  | [ "entity_id", (`Int id);
      "color", (`String color); ] ->
      Some(id, color)
  | _ -> None

(* message to Renderer *)

let get_render_object_msg msg =
  if MB.tag_of_msg msg <> "render_object" then None else
  let attrs = MB.attrs_of_msg msg in
  let assoc = MB.assoc_of_attrs attrs in
  match assoc with
  | [ "type", (`String obj);
      "color", (`String color); ] ->
      Some(obj, color)
  | _ -> None


let make_list n f =
  let rec aux i acc =
    if i <= 0 then acc
    else aux (i-1) ((f i)::acc)
  in
  aux n []


let () =
  Random.self_init ();
  let f i =
    if Random.bool ()
    then make_rand_msg_a ()
    else make_rand_msg_b ()
  in
  let lst = make_list 10 f in
  let tags = ["entity_created"; "render_object"] in
  let bus = MB.make_bus ~tags in
  let bus = List.fold_left MB.add_msg bus lst in
  let msgs = MB.filter ~bus ~msg_tag:"entity_created" in

  List.iter (MB.print_msg MA.print_attr) msgs;
  print_endline "=========================";
  List.iter (fun msg ->
    match get_entity_created_msg msg with
    | Some (id, color) ->
        Printf.printf " ent: %d ; %s\n" id color;
    | None -> ()
  ) msgs;
;;
