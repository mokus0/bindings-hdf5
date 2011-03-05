#include <bindings.h>
#include <H5FDcore.h>

module Bindings.HDF5.H5FD.Windows where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

#mangle_ident "H5FD_WINDOWS"
    = unsafePerformIO (#mangle_ident "H5FD_windows_init")

-- hid_t H5FD_windows_init(void);
#ccall H5FD_windows_init, IO <hid_t>

-- void H5FD_windows_term(void);
#ccall H5FD_windows_term, IO ()

-- herr_t H5Pset_fapl_windows(hid_t fapl_id);
#ccall H5Pset_fapl_windows, <hid_t> -> IO <herr_t>

