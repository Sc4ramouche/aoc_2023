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
