#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>

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
#include <mach/clock.h>
#include <mach/mach.h>

//Error checking needed here
CAMLprim value ocaml_clock_posix_period_ns (value unit)
{
  clock_serv_t clock_service;
  int ns;
  mach_msg_type_number_t count;
  host_get_clock_service(mach_host_self(), CALENDAR_CLOCK, &clock_service);
  clock_get_attributes(clock_service, CLOCK_GET_TIME_RES, (clock_attr_t)&ns, &count);
  mach_port_deallocate(mach_task_self(), clock_service);

  return caml_copy_int64 (ns); //cast uint64_t ?????
}

#elif defined(OCAML_MIRAGE_CLOCK_POSIX)

#include <time.h>
#include <stdint.h>

CAMLprim value ocaml_clock_posix_period_ns (value unit)
{
  struct timespec clock_period;
  if (clock_getres (CLOCK_REALTIME, &clock_period)) return caml_copy_int64 (0L);
  return caml_copy_int64 ((uint64_t) clock_period.tv_nsec);
}
#else
  return caml_copy_int64 ((uint64_t) 0);
#endif
