#include <bindings.h>
#include <H5public.h>

module Bindings.HDF5.H5 where
#strict_import

import Data.Version
import Foreign.Ptr.Conventions

#num H5_VERS_MAJOR
#num H5_VERS_MINOR
#num H5_VERS_RELEASE
h5_VERS_SUBRELEASE = #const_str H5_VERS_SUBRELEASE

vers :: Version
vers = Version
    [ h5_VERS_MAJOR
    , h5_VERS_MINOR
    , h5_VERS_RELEASE 
    ]
    (filter (not.null) [ h5_VERS_SUBRELEASE ])

h5_VERS_INFO = #const_str H5_VERS_INFO

#newtype herr_t

#newtype hbool_t

hboolToBool (HBool_t n) = (n /= 0)

boolToHBool True  = HBool_t 1
boolToHBool False = HBool_t 0

instance Eq HBool_t where
    x == y      = hboolToBool x == hboolToBool y

#newtype htri_t

instance Eq HTri_t where
    HTri_t x == HTri_t y
        = compare x 0 == compare y 0

#newtype ssize_t
    deriving (Eq, Ord)

h5_SIZEOF_SSIZE_T :: CSize
h5_SIZEOF_SSIZE_T = #const H5_SIZEOF_SSIZE_T

#newtype hsize_t
    deriving (Eq, Ord)
#newtype hssize_t
    deriving (Eq, Ord)

h5_SIZEOF_HSIZE_T, h5_SIZEOF_HSSIZE_T :: CSize
h5_SIZEOF_HSIZE_T  = #const H5_SIZEOF_HSIZE_T
h5_SIZEOF_HSSIZE_T = #const H5_SIZEOF_HSSIZE_T

#newtype haddr_t
    deriving (Eq, Ord)
#newtype_const haddr_t, HADDR_UNDEF

h5_SIZEOF_HADDR_T :: CSize
h5_SIZEOF_HADDR_T = #const H5_SIZEOF_HADDR_T

h5_PRINTF_HADDR_FMT = #const_str H5_PRINTF_HADDR_FMT

#newtype_const haddr_t, HADDR_MAX

#num H5P_DEFAULT

#newtype H5_iter_order_t
#newtype_const H5_iter_order_t, H5_ITER_UNKNOWN
#newtype_const H5_iter_order_t, H5_ITER_INC
#newtype_const H5_iter_order_t, H5_ITER_DEC
#newtype_const H5_iter_order_t, H5_ITER_NATIVE
#num H5_ITER_N

-- TODO: find out what type these really are
#num H5_ITER_ERROR
#num H5_ITER_CONT
#num H5_ITER_STOP

#newtype H5_index_t
#newtype_const H5_index_t, H5_INDEX_UNKNOWN
#newtype_const H5_index_t, H5_INDEX_NAME
#newtype_const H5_index_t, H5_INDEX_CRT_ORDER
#num H5_INDEX_N

#starttype H5_ih_info_t
#field index_size , <hsize_t>
#field heap_size  , <hsize_t>
#stoptype

#ccall H5open                   , IO <herr_t>
#ccall H5close                  , IO <herr_t>
#ccall H5dont_atexit            , IO <herr_t>
#ccall H5garbage_collect        , IO <herr_t>
#ccall H5set_free_list_limits   , CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> IO <herr_t>
#ccall H5get_libversion         , Out CUInt -> Out CUInt -> Out CUInt -> IO <herr_t>
#ccall H5check_version          , CUInt -> CUInt -> CUInt -> IO <herr_t>