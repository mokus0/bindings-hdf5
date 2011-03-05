#include <bindings.h>
#include <H5FDlog.h>

module Bindings.HDF5.H5FD.Log where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#mangle_ident "H5FD_LOG"
    = unsafePerformIO (#mangle_ident "H5FD_log_init")

-- * Flags for H5Pset_fapl_log()

-- ** Flags for tracking where reads/writes/seeks occur
#num H5FD_LOG_LOC_READ
#num H5FD_LOG_LOC_WRITE
#num H5FD_LOG_LOC_SEEK
#num H5FD_LOG_LOC_IO

-- ** Flags for tracking number of times each byte is read/written
#num H5FD_LOG_FILE_READ
#num H5FD_LOG_FILE_WRITE
#num H5FD_LOG_FILE_IO

-- ** Flag for tracking "flavor" (type) of information stored at each byte */
#num H5FD_LOG_FLAVOR

-- ** Flags for tracking total number of reads/writes/seeks */
#num H5FD_LOG_NUM_READ
#num H5FD_LOG_NUM_WRITE
#num H5FD_LOG_NUM_SEEK
#num H5FD_LOG_NUM_IO

-- ** Flags for tracking time spent in open/read/write/seek/close */
#num H5FD_LOG_TIME_OPEN
#num H5FD_LOG_TIME_READ
#num H5FD_LOG_TIME_WRITE
#num H5FD_LOG_TIME_SEEK
#num H5FD_LOG_TIME_CLOSE
#num H5FD_LOG_TIME_IO

-- ** Flag for tracking allocation of space in file */
#num H5FD_LOG_ALLOC
#num H5FD_LOG_ALL

-- hid_t H5FD_log_init(void);
#ccall H5FD_log_init, IO <hid_t>

-- void H5FD_log_term(void);
#ccall H5FD_log_term, IO ()

-- herr_t H5Pset_fapl_log(hid_t fapl_id, const char *logfile, unsigned flags, size_t buf_size);
#ccall H5Pset_fapl_log, <hid_t> -> CString -> CUInt -> <size_t> -> IO <herr_t>

