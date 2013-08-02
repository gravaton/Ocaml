(* Define the constants required by the problem set *)
let stra = "1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679"
let strb = "8214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196"

(* Define the constant phi^2 for use in the equation *)
let phi = (((sqrt 5.0) +. 1.0) /. 2.0)**2.0;;

(* Determine which character in the string we're looking for
 * Oh god the standard int type is a bit small, time to use Int64 *)
let getterm n = Int64.mul (Int64.add 127L (Int64.mul 19L (Int64.of_int n)))
(Int64.of_float (7.0 ** (float n)))

(* This function determines if a multiple of phi exists within the range (term -
 * 1, term).  This allows us to determine whether that character will be "A" or "B"
 * for this L-system *)
let findlet term = if Int64.of_float (ceil ((floor ((Int64.to_float term) /. phi)) *.
phi)) = term then true else false;;

(* For a given N, use the figure out what character we're looking for, determine
 * the string that will contain that character and extract the target digit from
 * the string.  *)
let d n = let term = (getterm n) in String.sub (if findlet (Int64.div term 100L) then stra else
        strb) ((Int64.to_int (Int64.rem term 100L)) - 1) 1;;

(* This function references a target function and calls it with a single numeric
 * parameter starting at "cur" and going up by 1 until "max".  The outputs are
 * summed in "acc" *)
let rec sigma ?(acc = 0L) func cur max =
        if cur == max
        then Int64.add acc (Int64.mul (Int64.of_string (func cur))
        (Int64.of_float (10.0 ** (float cur))))
        else sigma func (cur + 1) max ~acc:(Int64.add acc (Int64.mul (Int64.of_string
        (func cur)) (Int64.of_float (10.0 ** (float cur)))));;

Printf.printf "Result: %s\n" (Int64.to_string (sigma d 0 17));;
