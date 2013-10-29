module MB = MsgBus
module MA = MsgAttr

let colors = [
  "red";
  "green";
  "blue";
  "yellow";
]

let objects = [
  "cube";
  "sphere";
  "cylinder";
  "cone";
]

let make_msg id (obj, color) =
  MB.make_msg ~tag:"entity_created"
    ~attrs:[
      MB.make_attr "entity_id" (`Int id);
      MB.make_attr "type" (`String obj);
      MB.make_attr "color" (`String color);
    ]

let make_msg_list () =
  List.fold_left2
    (fun (acc, i) obj color ->
      let msg = make_msg i (obj, color) in
      (msg::acc, succ i)
    )
    ([], 0)
    objects colors

let make_msg_list () =
  List.rev (
    fst (make_msg_list ()) )

let () =
  let lst = make_msg_list () in
  let tags = ["entity_created"] in
  let bus = MB.make_bus ~tags in
  let bus = List.fold_left MB.add_msg bus lst in
  let msgs = MB.filter ~bus ~msg_tag:"entity_created" in
  List.iter (MB.print_msg MA.print_attr) msgs;
  print_endline "-------------------------";
  MB.print_bus MA.print_attr bus;
;;
