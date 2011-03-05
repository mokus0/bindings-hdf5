#include <bindings.cmacros.h>
#include <hdf5.h>

// I would wrap this macro, but despite being in the public headers it uses
// a macro internally that is not...
// BC_INLINE1(IS_H5FD_MPI, hid_t *, int)

#ifdef H5_HAVE_PARALLEL

BC_INLINE_(H5FD_mpi_native_g, char *)

#endif /* H5_HAVE_PARALLEL */