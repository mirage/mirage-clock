(*
 * Copyright (c) 2010 Anil Madhavapeddy <anil@recoil.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

type tm = {
  tm_sec : int;
  tm_min : int;
  tm_hour : int;
  tm_mday : int;
  tm_mon : int;
  tm_year : int;
  tm_wday : int;
  tm_yday : int;
  tm_isdst : bool;
}

let time () = Unix.gettimeofday ()

let gmtime x =
  let t = Unix.gmtime x in
  { tm_sec=t.Unix.tm_sec; tm_min=t.Unix.tm_min; tm_hour=t.Unix.tm_hour; tm_mday=t.Unix.tm_mday;
    tm_mon=t.Unix.tm_mon; tm_year=t.Unix.tm_year; tm_wday=t.Unix.tm_wday;
    tm_yday=t.Unix.tm_yday; tm_isdst=t.Unix.tm_isdst }

let ps_count_in_s = 1_000_000_000_000L

external posix_clock_gettime_s_ns : unit -> int * int = "ocaml_posix_clock_gettime_s_ns"

let now_d_ps () =
  let secs, ns = posix_clock_gettime_s_ns () in
  let days = secs / 86_400 in
  let rem_s = secs mod 86_400 in
  let frac_ps = Int64.(mul (of_int ns) 1000L) in
  let rem_ps = Int64.(mul (of_int rem_s) ps_count_in_s) in
  (days, (Int64.add rem_ps frac_ps))

let current_tz_offset_s () =
  let ts_utc = Unix.gettimeofday () in
  let (ts_local, _) = Unix.gmtime ts_utc |> Unix.mktime in
  int_of_float (ts_utc -. ts_local)

external clock_posix_period_ns : unit -> int64 = "ocaml_clock_posix_period_ns"
let period_d_ps () =
  let period_ns = clock_posix_period_ns () in
  match period_ns with
    | 0L -> None
    | ns -> Some (0, Int64.mul ns 1000L)
