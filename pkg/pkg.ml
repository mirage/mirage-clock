#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  let install = false in
  let metas = [
    Pkg.meta_file ~install "unix/META";
    Pkg.meta_file ~install "xen/META" ]
  in
  let lint_deps_excluding = Some ["mirage-types-lwt"] in
  let opams = [
    Pkg.opam_file ~install ~lint_deps_excluding "mirage-clock-unix.opam";
    Pkg.opam_file ~install ~lint_deps_excluding "mirage-clock-xen.opam" ]
  in
  Pkg.describe ~metas ~opams "mirage-clock-unix" @@ fun c ->
  match Conf.pkg_name c with
  | "mirage-clock-unix" ->
      Ok [  Pkg.lib "unix/META";
            Pkg.mllib "unix/mirage-clock-unix.mllib";
            Pkg.clib "unix/libmirage-clock-unix_stubs.clib";
            Pkg.test "lib_test/portable"]
  | "mirage-clock-xen" ->
      Ok [  Pkg.lib "xen/META";
            Pkg.mllib "xen/mirage-clock-xen.mllib" ]
  | other ->
      R.error_msgf "unknown package name: %s" other
