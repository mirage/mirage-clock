(* This code can be used to test the implementation
   of Xen's Clock.gmtime against Unix.gmtime. *)

let test () =
  let test_diff t =
    let mine = gmtime t in
    let unix = Unix.gmtime t in
    let pp_diff head m u =
      if m <> u
      then Printf.printf "time %f differs on %s: %d <> %d\n%!" t head m u
    in
    pp_diff "tm_sec" mine.tm_sec unix.Unix.tm_sec;
    pp_diff "tm_min" mine.tm_min unix.Unix.tm_min;
    pp_diff "tm_hour" mine.tm_hour unix.Unix.tm_hour;
    pp_diff "tm_mday" mine.tm_mday unix.Unix.tm_mday;
    pp_diff "tm_mon" mine.tm_mon unix.Unix.tm_mon;
    pp_diff "tm_year" mine.tm_year unix.Unix.tm_year;
    pp_diff "tm_wday" mine.tm_wday unix.Unix.tm_wday;
    pp_diff "tm_yday" mine.tm_yday unix.Unix.tm_yday;
    if mine.tm_isdst <> unix.Unix.tm_isdst then
      Printf.printf "time %f differs on isdst: %b <> %b\n%!" t
        mine.tm_isdst unix.Unix.tm_isdst;
    mine.tm_year
  in
  let seq_test () =
    let t = ref (0.) in
    let y = ref 0 in
    while true do
      let year = test_diff !t in
      if !y <> year
      then (y := year; Printf.printf "year: %d\n%!" (year + 1900));
      t := !t +. 1.;
    done
  in
  let rand_test () =
    let () = Random.self_init () in
    let about_200_years = Int64.(mul 200L (mul 365L 86_400L)) in
    let rtime span = Int64.(sub (Random.int64 (add span one)) (div span 2L)) in
    for i = 1 to 1_000_000_000 do
      let ti = rtime about_200_years (* around the unix epoch *) in
      let t = Int64.to_float ti in
      ignore (test_diff t);
    done
  in
  seq_test ();
(*  rand_test (); *)
  ()
