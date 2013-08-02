(* Given a tuple of already selected items and items left to select from,
 * produce a set of output tuples representing every possible additional
 * selection as well and recalculated list of items left *)
let selectnext (a, b) = List.map (fun i -> let res = (List.partition (fun j -> j
= i) b) in (a @ fst res, snd res)) b;;

(* Tail Recursive version of selectnext *)
let rec trselectnext ?(whole = []) ?(acc = []) (a, b) = match b with
| [] -> acc
| h :: t -> trselectnext (a, t) ~whole:(if whole = [] then b else whole) ~acc:((let res = (List.partition (fun j -> j = h)
whole) in (a @ fst res, snd res)) :: acc);;

(* Combinatorics!  Returns a list of tuples containing every possible
 * Combination of "count" elements selected from "start" *)
let rec ncr start count = match count with
| 0 -> start
| _ -> ncr (List.flatten (List.map selectnext start)) (count - 1);;


(* Convert an integer into a list of digits *)
let rec inttolist ?(acc = []) num = match num with
| 0 -> acc
| _ -> inttolist ~acc:([(num mod 10)] @ acc) (num / 10);;

(* Determine whether an integer is composed only of the digits in the provided
 * list.  Return the integer if true, 0 if false *)
let digitcompare num digits = if (List.sort compare (inttolist num)) = (List.sort compare
digits) then num else 0;;

(* Given an list of 5 digits, construct a four digit number out of the first
 * four elements and multiply that by the last digit *)
let mult41 lst = (((List.nth lst 0) * 1000) + ((List.nth lst 1) * 100) +
((List.nth lst 2) * 10) + (List.nth lst 3)) * (List.nth lst 4);;

(* Given a list of 5 digits, construct a three digit number out of the first
 * three elements and multiply that by a two digit number constructed out of the
 * last two elements *)
let mult32 lst = (((List.nth lst 0) * 100) + ((List.nth lst 1) * 10) +
(List.nth lst 2)) * (((List.nth lst 3) * 10) + (List.nth lst 4))

(* Test a tuple to determine whether it's a pandigital *)
let pantest (sel,rem) = let res41 = (digitcompare (mult41 sel) rem) and
res32 = (digitcompare (mult32 sel) rem) in [ res41; res32 ]

(* Test a list of candidate tuples and return a list of all valid results *)
let rec testlist ?(answers = []) lst = match lst with
| [] -> snd (List.partition (fun t -> t = 0) answers)
| h :: t -> testlist t ~answers:( pantest h @ answers);;

(* Sum the unique integers in a given list *)
let rec sumuniq ?(acc = 0) lst = match lst with
| [] -> acc
| h :: t -> sumuniq ~acc:(acc + h) (snd (List.partition (fun t -> t = h) t))

let sum = sumuniq ( testlist ( ncr [([], [1; 2; 3; 4; 5; 6; 7; 8; 9])] 5));;
Printf.printf "The sum of all unique pandigital products is %d\n" sum;;
