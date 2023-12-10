open Utils

let lines = read_file_lines "inputs/day_2.txt"

let extract_id str =
  let i_pre = Str.search_forward (Str.regexp " ") str 0 in
  let i_post = Str.search_forward (Str.regexp ":") str 0 in
  String.sub str (i_pre + 1) (i_post - i_pre - 1)

let count_color color limit str =
  let regex = Str.regexp ("\\([0-9]+\\) " ^ color) in
  let rec search idx =
    try
      let match_position = Str.search_forward regex str idx in
      let color_value = int_of_string (String.trim (String.sub str match_position 2)) in
      if color_value > limit then false else search (Str.match_end ())
    with Not_found -> true
  in
  search 0

let process acc line =
  try
    let id = extract_id line in
    let red_possible = count_color "red" 12 line in
    let green_possible = count_color "green" 13 line in
    let blue_possible = count_color "blue" 14 line in
    if red_possible && green_possible && blue_possible then
      acc + int_of_string id
    else acc
  with Invalid_argument _ -> acc

let sum = List.fold_left process 0 lines;;

Printf.printf "\nSum: %d\n" sum
