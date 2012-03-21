#include <bindings.h>
#include <H5Ipublic.h>
#include <H5Zpublic.h>

module Bindings.HDF5.Raw.H5Z where
#strict_import

import Bindings.HDF5.Raw.H5
import Bindings.HDF5.Raw.H5I

import Foreign.Ptr.Conventions

-- |Filter identifiers.  Values 0 through 255 are for filters defined by the
-- HDF5 library.  Values 256 through 511 are available for testing new
-- filters.  Subsequent values should be obtained from the HDF5 development
-- team at <mailto:hdf5dev@ncsa.uiuc.edu>.  These values will never change 
-- because they appear in the HDF5 files.
#newtype H5Z_filter_t, Eq

-- |no filter
#newtype_const H5Z_filter_t, H5Z_FILTER_ERROR

-- |reserved indefinitely
#newtype_const H5Z_filter_t, H5Z_FILTER_NONE

-- |deflation like gzip
#newtype_const H5Z_filter_t, H5Z_FILTER_DEFLATE

-- |shuffle the data
#newtype_const H5Z_filter_t, H5Z_FILTER_SHUFFLE

-- |fletcher32 checksum of EDC
#newtype_const H5Z_filter_t, H5Z_FILTER_FLETCHER32

-- |szip compression
#newtype_const H5Z_filter_t, H5Z_FILTER_SZIP

-- |nbit compression
#newtype_const H5Z_filter_t, H5Z_FILTER_NBIT

-- |scale+offset compression
#newtype_const H5Z_filter_t, H5Z_FILTER_SCALEOFFSET

-- |filter ids below this value are reserved for library use
#newtype_const H5Z_filter_t, H5Z_FILTER_RESERVED

-- |maximum filter id
#newtype_const H5Z_filter_t, H5Z_FILTER_MAX

-- |Symbol to remove all filters in 'h5p_remove_filter'
#newtype_const H5Z_filter_t, H5Z_FILTER_ALL

-- |Maximum number of filters allowed in a pipeline
-- (should probably be allowed to be an unlimited amount, but
-- currently each filter uses a bit in a 32-bit field, so the
-- format would have to be changed to accomodate that)
#num H5Z_MAX_NFILTERS

-- ** Flags for filter definition (stored)

-- |definition flag mask
#num H5Z_FLAG_DEFMASK

-- |filter is mandatory
#num H5Z_FLAG_MANDATORY

-- |filter is optional
#num H5Z_FLAG_OPTIONAL

-- ** Additional flags for filter invocation (not stored

-- |invocation flag mask
#num H5Z_FLAG_INVMASK

-- |reverse direction; read
#num H5Z_FLAG_REVERSE

-- |skip EDC filters for read
#num H5Z_FLAG_SKIP_EDC

-- ** Special parameters for szip compression
-- [These are aliases for the similar definitions in szlib.h, which we can't
-- include directly due to the duplication of various symbols with the zlib.h
-- header file]
#num H5_SZIP_ALLOW_K13_OPTION_MASK
#num H5_SZIP_CHIP_OPTION_MASK
#num H5_SZIP_EC_OPTION_MASK
#num H5_SZIP_NN_OPTION_MASK
#num H5_SZIP_MAX_PIXELS_PER_BLOCK

-- ** Macros for the shuffle filter

-- |Number of parameters that users can set
#num H5Z_SHUFFLE_USER_NPARMS

-- |Total number of parameters for filter
#num H5Z_SHUFFLE_TOTAL_NPARMS

-- ** Macros for the szip filter

-- |Number of parameters that users can set
#num H5Z_SZIP_USER_NPARMS

-- |Total number of parameters for filter
#num H5Z_SZIP_TOTAL_NPARMS

-- |\"User\" parameter for option mask
#num H5Z_SZIP_PARM_MASK

-- |\"User\" parameter for pixels-per-block
#num H5Z_SZIP_PARM_PPB

-- |\"Local\" parameter for bits-per-pixel
#num H5Z_SZIP_PARM_BPP

-- |\"Local\" parameter for pixels-per-scanline
#num H5Z_SZIP_PARM_PPS

-- ** Macros for the nbit filter

-- |Number of parameters that users can set
#num H5Z_NBIT_USER_NPARMS

-- ** Macros for the scale offset filter

-- |Number of parameters that users can set
#num H5Z_SCALEOFFSET_USER_NPARMS

-- ** Special parameters for ScaleOffset filter
#num H5Z_SO_INT_MINBITS_DEFAULT
#newtype H5Z_SO_scale_type_t
#newtype_const H5Z_SO_scale_type_t, H5Z_SO_FLOAT_DSCALE
#newtype_const H5Z_SO_scale_type_t, H5Z_SO_FLOAT_ESCALE
#newtype_const H5Z_SO_scale_type_t, H5Z_SO_INT

-- |Current version of the H5Z_class_t struct
#num H5Z_CLASS_T_VERS

-- |Values to decide if EDC is enabled for reading data
#newtype H5Z_EDC_t
#newtype_const H5Z_EDC_t, H5Z_ERROR_EDC
#newtype_const H5Z_EDC_t, H5Z_DISABLE_EDC
#newtype_const H5Z_EDC_t, H5Z_ENABLE_EDC
#newtype_const H5Z_EDC_t, H5Z_NO_EDC

-- ** Bit flags for H5Zget_filter_info
#num H5Z_FILTER_CONFIG_ENCODE_ENABLED
#num H5Z_FILTER_CONFIG_DECODE_ENABLED

-- |Return values for filter callback function
#newtype H5Z_cb_return_t

#newtype_const H5Z_cb_return_t, H5Z_CB_ERROR

-- |I/O should fail if filter fails.
#newtype_const H5Z_cb_return_t, H5Z_CB_FAIL

-- |I/O continues if filter fails.
#newtype_const H5Z_cb_return_t, H5Z_CB_CONT

#newtype_const H5Z_cb_return_t, H5Z_CB_NO

-- |Filter callback function definition
-- 
-- > typedef H5Z_cb_return_t (*H5Z_filter_func_t)(H5Z_filter_t filter, void* buf,
-- >        size_t buf_size, void* op_data);
type H5Z_filter_func_t a b = FunPtr (H5Z_filter_t -> InOutArray a -> CSize -> InOut b -> IO H5Z_cb_return_t)

-- |Before a dataset gets created, the \"can_apply\" callbacks for any filters used
-- in the dataset creation property list are called
-- with the dataset's dataset creation property list, the dataset's datatype and
-- a dataspace describing a chunk (for chunked dataset storage).
-- 
-- The \"can_apply\" callback must determine if the combination of the dataset
-- creation property list setting, the datatype and the dataspace represent a
-- valid combination to apply this filter to.  For example, some cases of
-- invalid combinations may involve the filter not operating correctly on
-- certain datatypes (or certain datatype sizes), or certain sizes of the chunk
-- dataspace.
-- 
-- The \"can_apply\" callback can be the NULL pointer, in which case, the library
-- will assume that it can apply to any combination of dataset creation
-- property list values, datatypes and dataspaces.
-- 
-- The \"can_apply\" callback returns positive a valid combination, zero for an
-- invalid combination and negative for an error.
-- 
-- > typedef htri_t (*H5Z_can_apply_func_t)(hid_t dcpl_id, hid_t type_id, hid_t space_id);
#callback H5Z_can_apply_func_t, <hid_t> -> <hid_t> -> <hid_t> -> IO <htri_t>

-- |After the \"can_apply\" callbacks are checked for new datasets, the \"set_local\"
-- callbacks for any filters used in the dataset creation property list are
-- called.  These callbacks receive the dataset's private copy of the dataset
-- creation property list passed in to H5Dcreate (i.e. not the actual property
-- list passed in to H5Dcreate) and the datatype ID passed in to H5Dcreate
-- (which is not copied and should not be modified) and a dataspace describing
-- the chunk (for chunked dataset storage) (which should also not be modified).
-- 
-- The \"set_local\" callback must set any parameters that are specific to this
-- dataset, based on the combination of the dataset creation property list
-- values, the datatype and the dataspace.  For example, some filters perform
-- different actions based on different datatypes (or datatype sizes) or
-- different number of dimensions or dataspace sizes.
-- 
-- The \"set_local\" callback can be the NULL pointer, in which case, the library
-- will assume that there are no dataset-specific settings for this filter.
-- 
-- The \"set_local\" callback must return non-negative on success and negative
-- for an error.
-- 
-- > typedef herr_t (*H5Z_set_local_func_t)(hid_t dcpl_id, hid_t type_id, hid_t space_id);
#callback H5Z_set_local_func_t, <hid_t> -> <hid_t> -> <hid_t> -> IO <herr_t>

-- |A filter gets definition flags and invocation flags (defined above), the
-- client data array and size defined when the filter was added to the
-- pipeline, the size in bytes of the data on which to operate, and pointers
-- to a buffer and its allocated size.
-- 
-- The filter should store the result in the supplied buffer if possible,
-- otherwise it can allocate a new buffer, freeing the original.  The
-- allocated size of the new buffer should be returned through the 'buf_size'
-- pointer and the new buffer through the BUF pointer.
-- 
-- The return value from the filter is the number of bytes in the output
-- buffer.  If an error occurs then the function should return zero and leave
-- all pointer arguments unchanged.
-- 
-- > typedef size_t (*H5Z_func_t)(unsigned int flags, size_t cd_nelmts,
-- >        const unsigned int cd_values[], size_t nbytes,
-- >        size_t *buf_size, void **buf);
type H5Z_func_t a = FunPtr (CUInt -> CSize -> InArray CUInt -> CSize -> InOut CSize -> InOut (Ptr a) -> IO CSize)

-- | The filter table maps filter identification numbers to structs that
-- contain a pointers to the filter function and timing statistics.
#starttype H5Z_class2_t

-- | Version number of the H5Z_class_t struct
#field version, CInt

-- | Filter ID number
#field id, <H5Z_filter_t>

-- | Does this filter have an encoder?
#field encoder_present, CUInt

-- | Does this filter have a decoder?
#field decoder_present, CUInt

-- | Comment for debugging
#field name, CString

-- | The \"can apply\" callback for a filter
#field can_apply, <H5Z_can_apply_func_t>

-- | The \"set local\" callback for a filter
#field set_local, <H5Z_set_local_func_t>

-- | The actual filter function
#field filter, H5Z_func_t ()

#stoptype

-- |This function registers a new filter.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Zregister(const void *cls);
#ccall H5Zregister, In <H5Z_class2_t> -> IO <herr_t>

-- |This function unregisters a filter.
-- 
-- Returns non-negative on success, negative on failure.
-- 
-- > herr_t H5Zunregister(H5Z_filter_t id);
#ccall H5Zunregister, <H5Z_filter_t> -> IO <herr_t>

-- |Check if a filter is available
-- 
-- > htri_t H5Zfilter_avail(H5Z_filter_t id);
#ccall H5Zfilter_avail, <H5Z_filter_t> -> IO <htri_t>

-- |Gets information about a pipeline data filter and stores it
-- in 'filter_config_flags'.
-- 
-- Returns non-negative on success, negative on failure.
--
-- > herr_t H5Zget_filter_info(H5Z_filter_t filter, unsigned int *filter_config_flags);
#ccall H5Zget_filter_info, <H5Z_filter_t> -> Out CUInt -> IO <herr_t>
