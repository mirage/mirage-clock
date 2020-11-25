(*
 * Copyright (c) 2015 Matt Gray <matthew.thomas.gray@gmail.com>
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

external time : unit -> int64 = "caml_get_wall_clock"

let nsec_per_day = Int64.mul 86_400L 1_000_000_000L
let ps_per_ns = 1_000L

let now_d_ps () =
  let nsec = time () in
  let days = Int64.div nsec nsec_per_day in
  let rem_ns = Int64.rem nsec nsec_per_day in
  let rem_ps = Int64.mul rem_ns ps_per_ns in
  (Int64.to_int days, rem_ps)

let current_tz_offset_s () = None

(* According to
 * https://github.com/mirage/mini-os/blob/edfd5aae6ec5ba7d0a8834a3e9dfe5e69424150a/arch/x86/time.c#L194
 * the clock period is 1 microsecond
 * *)
let period_d_ps () = Some (0, 1_000_000L)
