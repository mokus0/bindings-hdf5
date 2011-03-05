#include <bindings.h>
#include <H5FDcore.h>

module Bindings.HDF5.H5FD.Sec2 where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

#mangle_ident "H5FD_SEC2"
    = unsafePerformIO (#mangle_ident "H5FD_sec2_init")

-- hid_t H5FD_sec2_init(void);
#ccall H5FD_sec2_init, IO <hid_t>

-- void H5FD_sec2_term(void);
#ccall H5FD_sec2_term, IO ()

-- herr_t H5Pset_fapl_sec2(hid_t fapl_id);
#ccall H5Pset_fapl_sec2, <hid_t> -> IO <herr_t>

