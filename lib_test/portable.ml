module C = Pclock

let print_time () =
  let d, ps = C.now_d_ps () in
  Printf.printf "The time is %d days and %Ld picoseconds since the epoch.\n" d ps

let print_offset () = match C.current_tz_offset_s () with
  | Some offset -> Printf.printf "The offset from UTC is %d minutes.\n" offset
  | None -> Printf.printf "Clock UTC offset unavailable\n"

let print_period () = match C.period_d_ps () with
  | Some (d, ps) -> Printf.printf "The clock period is: %Ld picoseconds\n" ps
  | None -> Printf.printf "Clock period unavailable\n"

let _ =
  print_time ();
  print_time ();
  print_time ();
  print_offset ();
  print_period ();
