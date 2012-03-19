#include <bindings.h>
#include <H5FDmpi.h>
#include "H5FDmpio.h"
#include "H5FDmpiposix.h"

module Bindings.HDF5.Raw.H5FD.MPI where
#strict_import

import System.IO.Unsafe (unsafePerformIO)

import Bindings.HDF5.Raw.H5
import Bindings.HDF5.Raw.H5F
import Bindings.HDF5.Raw.H5I

import Foreign.Ptr.Conventions

-- TODO: Haddock docs.  This is a low priority right now because I don't even have an MPI library installed anywhere.

#num H5D_ONE_LINK_CHUNK_IO_THRESHOLD
#num H5D_MULTI_CHUNK_IO_COL_THRESHOLD

#newtype H5FD_mpio_xfer_t
#newtype_const H5FD_mpio_xfer_t, H5FD_MPIO_INDEPENDENT
#newtype_const H5FD_mpio_xfer_t, H5FD_MPIO_COLLECTIVE

#newtype H5FD_mpio_chunk_opt_t
#newtype_const H5FD_mpio_chunk_opt_t, H5FD_MPIO_CHUNK_DEFAULT
#newtype_const H5FD_mpio_chunk_opt_t, H5FD_MPIO_CHUNK_ONE_IO
#newtype_const H5FD_mpio_chunk_opt_t, H5FD_MPIO_CHUNK_MULTI_IO

#newtype H5FD_mpio_collective_opt_t
#newtype_const H5FD_mpio_collective_opt_t, H5FD_MPIO_COLLECTIVE_IO
#newtype_const H5FD_mpio_collective_opt_t, H5FD_MPIO_INDIVIDUAL_IO

#ifdef H5_HAVE_PARALLEL

#starttype H5FD_class_mpi_t
#field super, <H5FD_class_t>
#field get_rank, FunPtr (In <H5FD_t> -> IO CInt) int
#field get_size, FunPtr (In <H5FD_t> -> IO CInt) int
#field get_comm, FunPtr (In <H5FD_t> -> IO <MPI_Comm>)
#stoptype

#endif /* H5_HAVE_PARALLEL */

-- I would wrap this macro, but despite being in the public headers it uses
-- a macro internally that is not...
-- #cinline IS_H5FD_MPI, In <hid_t> -> IO CInt

#ifdef H5_HAVE_PARALLEL

#str H5FD_MPI_XFER_MEM_MPI_TYPE_NAME
#num H5FD_MPI_XFER_MEM_MPI_TYPE_SIZE

#str H5FD_MPI_XFER_FILE_MPI_TYPE_NAME
#num H5FD_MPI_XFER_FILE_MPI_TYPE_SIZE

#cinline H5FD_mpi_native_g, CString

-- haddr_t H5FD_mpi_MPIOff_to_haddr(MPI_Offset mpi_off);
#ccall H5FD_mpi_MPIOff_to_haddr, <MPI_Offset> -> IO <haddr_t>

-- herr_t H5FD_mpi_haddr_to_MPIOff(haddr_t addr, MPI_Offset *mpi_off/*out*/);
#ccall H5FD_mpi_haddr_to_MPIOff, <haddr_t> -> Out <MPI_Offset> -> IO <herr_t>

-- herr_t H5FD_mpi_comm_info_dup(MPI_Comm comm, MPI_Info info,
-- 				MPI_Comm *comm_new, MPI_Info *info_new);
#ccall H5FD_mpi_comm_info_dup, <MPI_Comm> -> <MPI_Info> -> Out <MPI_Comm> -> Out <MPI_Info> -> IO <herr_t>

-- herr_t H5FD_mpi_comm_info_free(MPI_Comm *comm, MPI_Info *info);
#ccall H5FD_mpi_comm_info_free, In <MPI_Comm> -> In <MPI_Info> -> IO <herr_t>


#ifdef NOT_YET

-- herr_t H5FD_mpio_wait_for_left_neighbor(H5FD_t *file);
#ccall H5FD_mpio_wait_for_left_neighbor, In <H5FD_t> -> IO <herr_t>

-- herr_t H5FD_mpio_signal_right_neighbor(H5FD_t *file);
#ccall H5FD_mpio_signal_right_neighbor, In <H5FD_t> -> IO <herr_t>

#endif /* NOT_YET */

-- herr_t H5FD_mpi_setup_collective(hid_t dxpl_id, MPI_Datatype btype,
--     MPI_Datatype ftype);
#ccall H5FD_mpi_setup_collective, <hid_t> -> <MPI_Datatype> -> <MPI_Datatype> -> IO <herr_t>

-- herr_t H5FD_mpi_teardown_collective(hid_t dxpl_id);
#ccall H5FD_mpi_teardown_collective, <hid_t> -> IO <herr_t>


-- /* Driver specific methods */
-- int H5FD_mpi_get_rank(const H5FD_t *file);
#ccall H5FD_mpi_get_rank, In <H5FD_t> -> IO CInt

-- int H5FD_mpi_get_size(const H5FD_t *file);
#ccall H5FD_mpi_get_size, In <H5FD_t> -> IO CInt

-- MPI_Comm H5FD_mpi_get_comm(const H5FD_t *_file);
#ccall H5FD_mpi_get_comm, In <H5FD_t> -> IO <MPI_Comm>

#endif /* H5_HAVE_PARALLEL */
