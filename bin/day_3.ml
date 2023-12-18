open Utils

let lines = read_file_lines "inputs/day_3.txt"

(* used to check all possible engine symbols
   module CharSet = Set.Make (Char)

   let print_set s = CharSet.iter print_char s
   let unique_chars = CharSet.of_list [ '1'; '2'; '3' ]

   let get_unique_chars line acc =
     String.fold_right (fun c a -> CharSet.add c a) line acc

   let final_unique_chars = List.fold_right get_unique_chars lines unique_chars;;
   print_string "\nunique chars in the line: \n";;
   print_set final_unique_chars
*)

(* testing area
   let sample = "...7523897" in
   let l, r =
     match get_num_indices sample 5 with Ok (l, r) -> (l, r) | Error _ -> (0, 0)
   in
   let _ = print_string " rigth: " in
   let _ = print_int r in
   let _ = print_string " left: " in
   print_int l
*)

let get_rigth_index s i =
  let rec dive ind =
    try
      let c = String.get s ind in
      if not (is_digit c) then ind else dive (ind + 1)
    with Invalid_argument _ -> ind
  in
  dive i

let get_left_index s i =
  let rec dive ind =
    try
      let c = String.get s ind in
      if not (is_digit c) then ind + 1 else dive (ind - 1)
    with Invalid_argument _ -> ind + 1
  in
  dive i

let get_num_indices s i =
  try
    let c = String.get s i in
    if is_digit c then
      let l = get_left_index s i in
      let r = get_rigth_index s i in
      Ok (l, r)
    else Error "Incorrect index"
  with Invalid_argument _ -> Error "Incorrect index"

let engine_symbols = [| '#'; '$'; '%'; '&'; '*'; '+'; '-'; '/'; '='; '@' |]

let unique l =
  let rec aux l acc =
    match l with
    | [] -> List.rev acc
    | h :: t -> if List.mem h acc then aux t acc else aux t (h :: acc)
  in
  aux l []

let get_row_nums line nums_to_check =
  let indices =
    List.fold_right
      (fun c acc ->
        match get_num_indices line c with
        | Ok (l, r) -> (l, r) :: acc
        | Error _ -> acc)
      nums_to_check []
  in
  List.map (fun (l, r) -> String.sub line l (r - l)) indices

let process_lines row line =
  let rec iter col acc =
    try
      let c = line.[col] in
      if Array.exists (fun c' -> c' = c) engine_symbols then
        let top_nums =
          unique
            (get_row_nums (List.nth lines (row - 1)) [ col - 1; col; col + 1 ])
        in
        let curr_nums =
          unique (get_row_nums (List.nth lines row) [ col - 1; col + 1 ])
        in
        let bottom_nums =
          unique
            (get_row_nums (List.nth lines (row + 1)) [ col - 1; col; col + 1 ])
        in
        let sum =
          List.fold_right
            (fun s acc' -> acc' + int_of_string s)
            (List.concat [ top_nums; curr_nums; bottom_nums ])
            0
        in
        iter (col + 1) (sum + acc)
      else iter (col + 1) acc
    with Invalid_argument _ -> acc
  in
  iter 0 0
;;

let line_sums = List.mapi process_lines lines in
let total = List.fold_right ( + ) line_sums 0 in
print_int total
