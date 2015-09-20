module C = Clock

let _ =
  match C.period_d_ps () with
    | Some (d, ps) -> Printf.printf "The clock period is: %Ld picoseconds" ps
    | None -> Printf.printf "Clock period unavailable"
