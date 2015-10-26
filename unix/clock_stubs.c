#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>

#if defined(__APPLE__) && defined(__MACH__)
  #define OCAML_MIRAGE_CLOCK_DARWIN

#elif defined (__unix__) || defined(__unix)
 #include <unistd.h>
 #if defined(_POSIX_VERSION)
   #define OCAML_MIRAGE_CLOCK_POSIX
 #endif
#endif

#if defined(OCAML_MIRAGE_CLOCK_DARWIN)

#include <time.h>
#include <sys/time.h>
#include <mach/clock.h>
#include <mach/mach.h>

CAMLprim value ocaml_posix_clock_gettime_s_ns (value unit)
{
  CAMLparam1(unit);
  CAMLlocal1(time_s_ns);
  time_s_ns = caml_alloc(2, 0);
  struct timeval now;
  if (gettimeofday(&now, NULL) == -1) { caml_failwith("gettimeofday"); }

  Store_field(time_s_ns, 0, Val_int(now.tv_sec));
  Store_field(time_s_ns, 1, Val_int(now.tv_usec * 1000));

  CAMLreturn (time_s_ns);
}

CAMLprim value ocaml_posix_clock_period_ns (value unit)
{
  return caml_copy_int64 (1000L);
}

#elif defined(OCAML_MIRAGE_CLOCK_POSIX)

#include <time.h>
#include <stdint.h>

CAMLprim value ocaml_posix_clock_gettime_s_ns (value unit)
{
  CAMLparam1(unit);
  CAMLlocal1(time_s_ns);
  time_s_ns = caml_alloc(2, 0);
  struct timespec now;
  if (clock_gettime(CLOCK_REALTIME, &now) == -1) { caml_failwith("clock_gettime(CLOCK_REALTIME, ..)"); }

  Store_field(time_s_ns, 0, Val_int(now.tv_sec));
  Store_field(time_s_ns, 1, Val_long(now.tv_nsec));

  CAMLreturn (time_s_ns);
}

CAMLprim value ocaml_posix_clock_period_ns (value unit)
{
  struct timespec clock_period;
  if (clock_getres (CLOCK_REALTIME, &clock_period)) return caml_copy_int64 (0L);
  return caml_copy_int64 ((uint64_t) clock_period.tv_nsec);
}
#else
#warning Mirage PCLOCK - unsupported platform
CAMLprim value ocaml_posix_clock_gettime_s_ns (value unit)
{
  CAMLparam1(unit);
  CAMLlocal1(time_s_ns);
  time_s_ns = caml_alloc(2, 0);

  Store_field(time_s_ns, 0, Val_int(0));
  Store_field(time_s_ns, 1, Val_long(0L));

  CAMLreturn (time_s_ns);
}

CAMLprim value ocaml_posix_clock_period_ns (value unit)
{
  return caml_copy_int64 (0L);
}
#endif
