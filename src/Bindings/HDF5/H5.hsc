#include <bindings.h>
#include <H5public.h>

module Bindings.HDF5.H5 where
#strict_import

import Data.Version
import Foreign.Ptr.Conventions

-- *Version numbers

-- |For major interface/format changes
#num H5_VERS_MAJOR

-- |For minor interface/format changes
#num H5_VERS_MINOR

-- |For tweaks, bug-fixes, or development
#num H5_VERS_RELEASE

-- |For pre-releases like snap0
#str H5_VERS_SUBRELEASE

-- |'h5_VERS_MAJOR', et al., wrapped up as a 'Version'
vers :: Version
vers = Version
    [ h5_VERS_MAJOR
    , h5_VERS_MINOR
    , h5_VERS_RELEASE 
    ]
    (filter (not.null) [ h5_VERS_SUBRELEASE ])

-- |Full version string
#str H5_VERS_INFO

-- |Check that the HDF5 library that is linked with the current executable is
-- the same version that these bindings were compiled against.  Should return
-- 'HErr_t 0'.
#cinline H5check, <herr_t>

-- * Types and constants

-- |Status return values.  Failed integer functions in HDF5 result almost
-- always in a negative value (unsigned failing functions sometimes return
-- zero for failure) while successfull return is non-negative (often zero).
-- The negative failure value is most commonly -1, but don't bet on it.  The
-- proper way to detect failure is something like:
--
-- @
-- if((dset = H5Dopen2(file, name)) < 0)
--    fprintf(stderr, "unable to open the requested dataset\n");
-- @
#newtype herr_t

-- |Boolean type.  Successful return values are zero (false) or positive
-- (true). The typical true value is 1 but don't bet on it.  Boolean
-- functions cannot fail.  Functions that return `htri_t' however return zero
-- (false), positive (true), or negative (failure). The proper way to test
-- for truth from a htri_t function is:
--
-- @
--  if ((retval = H5Tcommitted(type))>0) {
--    printf("data type is committed\n");
--  } else if (!retval) {
--    printf("data type is not committed\n");
--  } else {
--    printf("error determining whether data type is committed\n");
--  }
-- @
#newtype hbool_t

instance Eq HBool_t where
    HBool_t x == HBool_t y
        = (x /= 0) == (y /= 0)

#newtype htri_t

instance Eq HTri_t where
    HTri_t x == HTri_t y
        = compare x 0 == compare y 0

-- |C signed size type.  This is a semi-standard POSIX type that isn't in
-- the "Foreign.C.Types" module.  It is in "System.Posix.Types", but I'm not 
-- sure whether that module is available on all platforms.
#newtype ssize_t, Eq, Ord

h5_SIZEOF_SSIZE_T :: CSize
h5_SIZEOF_SSIZE_T = #const H5_SIZEOF_SSIZE_T

#newtype hsize_t, Eq, Ord
#newtype hssize_t, Eq, Ord

h5_SIZEOF_HSIZE_T, h5_SIZEOF_HSSIZE_T :: CSize
h5_SIZEOF_HSIZE_T  = #const H5_SIZEOF_HSIZE_T
h5_SIZEOF_HSSIZE_T = #const H5_SIZEOF_HSSIZE_T

#newtype haddr_t, Eq, Ord
#newtype_const haddr_t, HADDR_UNDEF

h5_SIZEOF_HADDR_T :: CSize
h5_SIZEOF_HADDR_T = #const H5_SIZEOF_HADDR_T

#str H5_PRINTF_HADDR_FMT

#newtype_const haddr_t, HADDR_MAX

-- |Default value for all property list classes
#num H5P_DEFAULT

-- |Common iteration orders
#newtype H5_iter_order_t

-- |Unknown order
#newtype_const H5_iter_order_t, H5_ITER_UNKNOWN

-- |Increasing order
#newtype_const H5_iter_order_t, H5_ITER_INC

-- |Decreasing order
#newtype_const H5_iter_order_t, H5_ITER_DEC

-- |No particular order, whatever is fastest
#newtype_const H5_iter_order_t, H5_ITER_NATIVE

-- |Number of iteration orders
#num H5_ITER_N

-- |Iteration callback return value indicating that iteration should stop 
-- and report an error.
#newtype_const herr_t, H5_ITER_ERROR

-- |Iteration callback return value indicating that iteration should continue.
#newtype_const herr_t, H5_ITER_CONT

-- |Iteration callback return value indicating that iteration should stop 
-- without error.
-- 
-- Actually, any postive value will cause the iterator to stop and pass back
-- that positive value to the function that called the iterator
#newtype_const herr_t, H5_ITER_STOP

-- |The types of indices on links in groups/attributes on objects.
-- Primarily used for \"\<do\> \<foo\> by index\" routines and for iterating over
-- links in groups/attributes on objects.
#newtype H5_index_t

-- |Unknown index type
#newtype_const H5_index_t, H5_INDEX_UNKNOWN

-- |Index on names
#newtype_const H5_index_t, H5_INDEX_NAME

-- |Index on creation order
#newtype_const H5_index_t, H5_INDEX_CRT_ORDER

-- |Number of indices defined
#num H5_INDEX_N

-- |Storage info struct used by 'H5O_info_t' and 'H5F_info_t'
#starttype H5_ih_info_t
#field index_size , <hsize_t>
#field heap_size  , <hsize_t>
#stoptype

-- *Functions in H5.c

#ccall H5open                   , IO <herr_t>
#ccall H5close                  , IO <herr_t>
#ccall H5dont_atexit            , IO <herr_t>
#ccall H5garbage_collect        , IO <herr_t>
#ccall H5set_free_list_limits   , CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> IO <herr_t>
#ccall H5get_libversion         , Out CUInt -> Out CUInt -> Out CUInt -> IO <herr_t>
#ccall H5check_version          , CUInt -> CUInt -> CUInt -> IO <herr_t>