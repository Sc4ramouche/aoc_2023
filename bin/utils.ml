(* TODO: move into /lib *)
let read_file_lines filename =
  let file = open_in filename in
  let rec read_lines acc =
    try
      let line = input_line file in
      read_lines (line :: acc)
    with End_of_file ->
      close_in file;
      List.rev acc
  in
  read_lines []

let is_digit c =
  let code = Char.code c in
  code >= Char.code '0' && code <= Char.code '9'

let unique l =
  let rec aux l acc =
    match l with
    | [] -> List.rev acc
    | h :: t -> if List.mem h acc then aux t acc else aux t (h :: acc)
  in
  aux l []
