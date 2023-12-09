open Utils

let is_digit c =
    let code = Char.code c in
    code >= Char.code '0' && code <= Char.code '9'

let find_first_numeric_char str =
    let rec find_numeric_char index = 
        if index >= String.length str then
            None
        else if is_digit str.[index] then 
            Some str.[index]
        else 
            find_numeric_char (index + 1)
    in
    find_numeric_char 0

let find_last_numeric_char str =
    let rec find_numeric_char index =
        if index < 0 then
            None
        else if is_digit str.[index] then
            Some str.[index]
        else 
            find_numeric_char (index - 1)
    in
    find_numeric_char (String.length str - 1)

let process line = 
    let first = find_first_numeric_char line in 
    let last = find_last_numeric_char line in 
    match (first, last) with
    | (Some f, Some l) ->  String.make 1 f ^ String.make 1 l
    | _ -> "0"

let nums =
    let filename = "inputs/day_1.txt" in
    let lines = read_file_lines filename in
    List.map(process) lines;;

let sum = List.fold_left (fun acc str ->  acc + int_of_string str) 0 nums;;
print_int sum

(* TODO: Solve part 2 *) 
