#include <bindings.h>
#include <H5Cpublic.h>

module Bindings.HDF5.Raw.H5C where
#strict_import

import Bindings.HDF5.Raw.H5

#def typedef enum H5C_cache_incr_mode H5C_cache_incr_mode;
#newtype H5C_cache_incr_mode, Eq
#newtype_const H5C_cache_incr_mode, H5C_incr__off
#newtype_const H5C_cache_incr_mode, H5C_incr__threshold

#def typedef enum H5C_cache_flash_incr_mode H5C_cache_flash_incr_mode;
#newtype H5C_cache_flash_incr_mode, Eq
#newtype_const  H5C_cache_flash_incr_mode, H5C_flash_incr__off
#newtype_const  H5C_cache_flash_incr_mode, H5C_flash_incr__add_space

#def typedef enum H5C_cache_decr_mode H5C_cache_decr_mode;
#newtype H5C_cache_decr_mode, Eq
#newtype_const H5C_cache_decr_mode, H5C_decr__off
#newtype_const H5C_cache_decr_mode, H5C_decr__threshold
#newtype_const H5C_cache_decr_mode, H5C_decr__age_out
#newtype_const H5C_cache_decr_mode, H5C_decr__age_out_with_threshold

