module C = Clock

let print_time () =
  let d, ps = C.now_d_ps () in
  Printf.printf "The time is %d days and %Ld picoseconds since the epoch.\n" d ps

let print_offset () =
  let offset = C.current_tz_offset_s () in
  Printf.printf "The offset from UTC is %d minutes.\n" offset

let print_period () = match C.period_d_ps () with
  | Some (d, ps) -> Printf.printf "The clock period is: %Ld picoseconds\n" ps
  | None -> Printf.printf "Clock period unavailable\n"

let _ =
  print_time ();
  print_time ();
  print_time ();
  print_offset ();
  print_period ();
