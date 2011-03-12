#include <bindings.h>
#include <H5FDlog.h>

-- |The POSIX unbuffered file driver using only the HDF5 public
-- API and with a few optimizations: the lseek() call is made
-- only when the current file position is unknown or needs to be
-- changed based on previous I/O through this driver (don't mix
-- I/O from this driver with I/O from other parts of the
-- application to the same file).
--     With custom modifications...
module Bindings.HDF5.H5FD.Log where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.H5
import Bindings.HDF5.H5I

import Foreign.Ptr.Conventions

#mangle_ident "H5FD_LOG"
    = unsafePerformIO (#mangle_ident "H5FD_log_init")

-- * Flags for 'h5p_set_fapl_log'

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

-- * Functions

-- |Initialize this driver by registering the driver with the library.
-- 
-- > hid_t H5FD_log_init(void);
#ccall H5FD_log_init, IO <hid_t>

-- |Shut down the VFD.
-- 
-- > void H5FD_log_term(void);
#ccall H5FD_log_term, IO ()

-- TODO: evaluate the claim that "There are no driver-specific properties."  It appears to be patently false.
-- |Modify the file access property list to use the H5FD_LOG
-- driver.  There are no driver-specific properties.
--
-- > herr_t H5Pset_fapl_log(hid_t fapl_id, const char *logfile, unsigned flags, size_t buf_size);
#ccall H5Pset_fapl_log, <hid_t> -> CString -> CUInt -> <size_t> -> IO <herr_t>

