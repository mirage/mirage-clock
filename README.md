This library implements portable support for an operating system timesource
that is compatible with the Mirage library interfaces found in:
   <https://github.com/mirage/mirage-types>

The following sources are used:

* The Unix version uses `gettimeofday`
* The Xen version uses the paravirtual clock source.
