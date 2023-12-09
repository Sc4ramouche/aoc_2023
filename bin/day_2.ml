open Utils

let lines = read_file_lines "inputs/day_2.txt";;

let extract_number str =
  let regex = Str.regexp " \\([0-9]+\\):" in
  if Str.string_match regex str 0 then
    Some (int_of_string (Str.matched_group 1 str))
  else
    None

let process i l = 
    match extract_number l with
    | Some n -> print_int n
    | _ -> print_endline ("no id" ^ " " ^ string_of_int i);;


let () = List.iteri process lines 
