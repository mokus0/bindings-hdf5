#include <bindings.h>
#include <H5Lpublic.h>

module Bindings.HDF5.H5MM where
#strict_import

import Bindings.HDF5.H5

type H5MM_allocate_t info mem = FunPtr (CSize -> Ptr info -> IO (Ptr mem))
type H5MM_free_t     info mem = FunPtr (Ptr mem -> Ptr info -> IO ())
