open Utils

let lines = read_file_lines "inputs/day_2.txt"

let count_color_cubes color str =
  let regex = Str.regexp ("\\([0-9]+\\) " ^ color) in
  let rec search idx acc =
    try
      let _ = Str.search_forward regex str idx in
      let color_value = int_of_string (Str.matched_group 1 str) in
      search (Str.match_end ()) (max color_value acc)
    with Not_found -> acc
  in
  search 0 0

let process acc line =
  try
    let red_cubes = count_color_cubes "red" line in
    let green_cubes = count_color_cubes "green" line in
    let blue_cubes = count_color_cubes "blue" line in
    let power = red_cubes * green_cubes * blue_cubes in
    acc + power
  with Invalid_argument _ -> acc

let sum = List.fold_left process 0 lines;;

Printf.printf "\nSum: %d\n" sum
