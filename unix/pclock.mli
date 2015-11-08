
(*
 * Copyright (c) 2010-2011 Anil Madhavapeddy <anil@recoil.org>
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

(** Clock operations.
    Currently read-only to retrieve the time in various formats. *)

val now_d_ps : unit -> int * int64
(** [now_d_ps ()] is [(d, ps)] representing the POSIX time occuring
    at [d] * 86'400e12 + [ps] POSIX picoseconds from the epoch
    1970-01-01 00:00:00 UTC. [ps] is in the range
    \[[0];[86_399_999_999_999_999L]\]. *)

val current_tz_offset_s : unit -> int option
(** [current_tz_offset_s ()] is the clock's current local time zone
    offset to UTC in seconds. *)

val period_d_ps : unit -> (int * int64) option
  (** [period_d_ps ()] is if available [Some (d, ps)] representing the
      clock's picosecond period [d] * 86'400e12 + [ps]. [ps] is in the
      range \[[0];[86_399_999_999_999_999L]\]. *)
