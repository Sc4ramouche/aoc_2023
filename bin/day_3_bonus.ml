open Utils

let lines = read_file_lines "inputs/day_3.txt"

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
      if c = '*' then
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
        let all_nums = List.concat [ top_nums; curr_nums; bottom_nums ] in
        if List.length all_nums = 2 then
          let sum =
            List.fold_right (fun s acc' -> acc' * int_of_string s) all_nums 1
          in
          iter (col + 1) (sum + acc)
        else iter (col + 1) acc
      else iter (col + 1) acc
    with Invalid_argument _ -> acc
  in
  iter 0 0
;;

let line_sums = List.mapi process_lines lines in
let total = List.fold_right ( + ) line_sums 0 in
print_int total
