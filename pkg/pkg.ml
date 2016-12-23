#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let meta_file = Pkg.meta_file ~install:false

let opam_file no_lint name =
  Pkg.opam_file ~install:false ~lint_deps_excluding:(Some no_lint) name

let metas = [
    meta_file "pkg/META";
    meta_file "pkg/META.lwt";
    meta_file "pkg/META.unix";
    meta_file "pkg/META.freestanding";
]

let opams = [
  opam_file ["lwt"; "mirage-clock"; "mirage-clock-lwt"] "mirage-clock.opam";
  opam_file ["mirage-device"; "mirage-clock-lwt"] "mirage-clock-lwt.opam";
  opam_file ["mirage-device"] "mirage-clock-unix.opam";
  opam_file ["mirage-device"] "mirage-clock-freestanding.opam";
]

let () =
  Pkg.describe ~metas ~opams "mirage-clock" @@ fun c ->
  match Conf.pkg_name c with
  | "mirage-clock" ->
    Ok [ Pkg.lib "pkg/META";
         Pkg.lib ~exts:Exts.interface "src/mirage_clock" ]
  | "mirage-clock-lwt" ->
    Ok [ Pkg.lib "pkg/META.lwt" ~dst:"META";
         Pkg.lib ~exts:Exts.interface "lwt/mirage_clock_lwt" ]
  | "mirage-clock-unix" ->
      Ok [  Pkg.lib "pkg/META.unix" ~dst:"META";
            Pkg.mllib "unix/mirage-clock-unix.mllib";
            Pkg.clib "unix/libmirage-clock-unix_stubs.clib";
            Pkg.test "lib_test/portable"]
  | "mirage-clock-freestanding" ->
      Ok [  Pkg.lib "pkg/META.freestanding" ~dst:"META";
            Pkg.mllib "freestanding/mirage-clock-freestanding.mllib" ]
  | other ->
      R.error_msgf "unknown package name: %s" other
