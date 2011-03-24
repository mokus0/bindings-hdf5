#include <bindings.h>
#include <H5FDfamily.h>

-- |Implements a family of files that acts as a single hdf5
-- file.  The purpose is to be able to split a huge file on a
-- 64-bit platform, transfer all the <2GB members to a 32-bit
-- platform, and then access the entire huge file on the 32-bit
-- platform.
-- 
-- All family members are logically the same size although their
-- physical sizes may vary.  The logical member size is
-- determined by looking at the physical size of the first member
-- when the file is opened.  When creating a file family, the
-- first member is created with a predefined physical size
-- (actually, this happens when the file family is flushed, and
-- can be quite time consuming on file systems that don't
-- implement holes, like nfs).
module Bindings.HDF5.Raw.H5FD.Family where
#strict_import

import Foreign (unsafePerformIO)

import Bindings.HDF5.Raw.H5
import Bindings.HDF5.Raw.H5I

import Foreign.Ptr.Conventions

#mangle_ident "H5FD_FAMILY"
    = unsafePerformIO (#mangle_ident "H5FD_family_init")

-- |Initialize this driver by registering the driver with the library.
-- 
-- > hid_t H5FD_family_init(void);
#ccall H5FD_family_init, IO <hid_t>

-- |Shut down the VFD.
-- 
-- > void H5FD_family_term(void);
#ccall H5FD_family_term, IO ()

-- |Sets the file access property list 'fapl_id' to use the family
-- driver. The 'memb_size' is the size in bytes of each file
-- member (used only when creating a new file) and the
-- 'memb_fapl_id' is a file access property list to be used for
-- each family member.
-- 
-- > herr_t H5Pset_fapl_family(hid_t fapl_id, hsize_t memb_size,
-- >        hid_t memb_fapl_id);
#ccall H5Pset_fapl_family, <hid_t> -> <hsize_t> -> <hid_t> -> IO <herr_t>

-- |Returns information about the family file access property
-- list though the function arguments.
-- 
-- > herr_t H5Pget_fapl_family(hid_t fapl_id, hsize_t *memb_size/*out*/,
-- >        hid_t *memb_fapl_id/*out*/);
#ccall H5Pget_fapl_family, <hid_t> -> Out <hsize_t> -> Out <hid_t> -> IO <herr_t>

