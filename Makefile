all:
	ocaml pkg/pkg.ml build -n mirage-clock -q
	ocaml pkg/pkg.ml build -n mirage-clock-lwt -q
	ocaml pkg/pkg.ml build -n mirage-clock-unix -q
	ocaml pkg/pkg.ml build -n mirage-clock-freestanding -q

clean:
	ocaml pkg/pkg.ml clean -n mirage-clock
	ocaml pkg/pkg.ml clean -n mirage-clock-lwt
	ocaml pkg/pkg.ml clean -n mirage-clock-unix
	ocaml pkg/pkg.ml clean -n mirage-clock-freestanding
