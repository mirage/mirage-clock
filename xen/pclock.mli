val now_d_ps : unit -> int * int64
(** [now_d_ps ()] is [(d, ps)] representing the POSIX time occuring
    at [d] * 86'400e12 + [ps] POSIX picoseconds from the epoch
    1970-01-01 00:00:00 UTC. [ps] is in the range
    \[[0];[86_399_999_999_999_999L]\]. *)

val current_tz_offset_s : unit -> int
(** [current_tz_offset_s ()] is the clock's current local time zone
    offset to UTC in seconds. *)

val period_d_ps : unit -> (int * int64) option
(** [period_d_ps ()] is if available [Some (d, ps)] representing the
    clock's picosecond period [d] * 86'400e12 + [ps]. [ps] is in the
    range \[[0];[86_399_999_999_999_999L]\]. *)
