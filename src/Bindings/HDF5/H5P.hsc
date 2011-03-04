#include <bindings.h>
#include <H5Ppublic.h>

module Bindings.HDF5.H5P where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5AC
import Bindings.HDF5.H5D
import Bindings.HDF5.H5F
import Bindings.HDF5.H5FD
import Bindings.HDF5.H5I
import Bindings.HDF5.H5L
import Bindings.HDF5.H5MM
import Bindings.HDF5.H5T
import Bindings.HDF5.H5Z

import Foreign.Ptr.Conventions
import System.Posix.Types (COff)

#cinline H5P_ROOT,                          <hid_t>
#cinline H5P_OBJECT_CREATE,                 <hid_t>
#cinline H5P_FILE_CREATE,                   <hid_t>
#cinline H5P_FILE_ACCESS,                   <hid_t>
#cinline H5P_DATASET_CREATE,                <hid_t>
#cinline H5P_DATASET_ACCESS,                <hid_t>
#cinline H5P_DATASET_XFER,                  <hid_t>
#cinline H5P_FILE_MOUNT,                    <hid_t>
#cinline H5P_GROUP_CREATE,                  <hid_t>
#cinline H5P_GROUP_ACCESS,                  <hid_t>
#cinline H5P_DATATYPE_CREATE,               <hid_t>
#cinline H5P_DATATYPE_ACCESS,               <hid_t>
#cinline H5P_STRING_CREATE,                 <hid_t>
#cinline H5P_ATTRIBUTE_CREATE,              <hid_t>
#cinline H5P_OBJECT_COPY,                   <hid_t>
#cinline H5P_LINK_CREATE,                   <hid_t>
#cinline H5P_LINK_ACCESS,                   <hid_t>

#cinline H5P_FILE_CREATE_DEFAULT,           <hid_t>
#cinline H5P_FILE_ACCESS_DEFAULT,           <hid_t>
#cinline H5P_DATASET_CREATE_DEFAULT,        <hid_t>
#cinline H5P_DATASET_ACCESS_DEFAULT,        <hid_t>
#cinline H5P_DATASET_XFER_DEFAULT,          <hid_t>
#cinline H5P_FILE_MOUNT_DEFAULT,            <hid_t>
#cinline H5P_GROUP_CREATE_DEFAULT,          <hid_t>
#cinline H5P_GROUP_ACCESS_DEFAULT,          <hid_t>
#cinline H5P_DATATYPE_CREATE_DEFAULT,       <hid_t>
#cinline H5P_DATATYPE_ACCESS_DEFAULT,       <hid_t>
#cinline H5P_ATTRIBUTE_CREATE_DEFAULT,      <hid_t>
#cinline H5P_OBJECT_COPY_DEFAULT,           <hid_t>
#cinline H5P_LINK_CREATE_DEFAULT,           <hid_t>
#cinline H5P_LINK_ACCESS_DEFAULT,           <hid_t>

#num H5P_CRT_ORDER_TRACKED
#num H5P_CRT_ORDER_INDEXED


-- /* Define property list class callback function pointer types */
-- typedef herr_t (*H5P_cls_create_func_t)(hid_t prop_id, void *create_data);
type H5P_cls_create_func_t a = FunPtr (HId_t -> Ptr a -> IO HErr_t)

-- typedef herr_t (*H5P_cls_copy_func_t)(hid_t new_prop_id, hid_t old_prop_id,
--                                       void *copy_data);
type H5P_cls_copy_func_t a = FunPtr (HId_t -> HId_t -> Ptr a -> IO HErr_t)

-- typedef herr_t (*H5P_cls_close_func_t)(hid_t prop_id, void *close_data);
type H5P_cls_close_func_t a = FunPtr (HId_t -> Ptr a -> IO HErr_t)


-- /* Define property list callback function pointer types */
-- typedef herr_t (*H5P_prp_cb1_t)(const char *name, size_t size, void *value);
type H5P_prp_cb1_t a = FunPtr (CString -> CSize -> Ptr a -> IO HErr_t)

-- typedef herr_t (*H5P_prp_cb2_t)(hid_t prop_id, const char *name, size_t size, void *value);
type H5P_prp_cb2_t a = FunPtr (HId_t -> CString -> CSize -> Ptr a -> IO HErr_t)

type H5P_prp_create_func_t a = H5P_prp_cb1_t a

type H5P_prp_set_func_t    a = H5P_prp_cb2_t a
type H5P_prp_get_func_t    a = H5P_prp_cb2_t a
type H5P_prp_delete_func_t a = H5P_prp_cb2_t a
type H5P_prp_copy_func_t   a = H5P_prp_cb1_t a

-- typedef int (*H5P_prp_compare_func_t)(const void *value1, const void *value2, size_t size);
type H5P_prp_compare_func_t a = FunPtr (Ptr a -> Ptr a -> CSize -> IO CInt)

-- typedef H5P_prp_cb1_t H5P_prp_close_func_t;
type H5P_prp_close_func_t a = H5P_prp_cb1_t a

-- /* Define property list iteration function type */
-- typedef herr_t (*H5P_iterate_t)(hid_t id, const char *name, void *iter_data);
type H5P_iterate_t a = FunPtr (HId_t -> CString -> Ptr a -> IO HErr_t)

-- /*********************/
-- /* Public Prototypes */
-- /*********************/

-- /* Generic property list routines */
-- hid_t H5Pcreate_class(hid_t parent, const char *name,
--     H5P_cls_create_func_t cls_create, void *create_data,
--     H5P_cls_copy_func_t cls_copy, void *copy_data,
--     H5P_cls_close_func_t cls_close, void *close_data);
#ccall H5Pcreate_class, <hid_t> -> CString -> H5P_cls_create_func_t a -> Ptr a -> H5P_cls_copy_func_t b -> Ptr b -> H5P_cls_close_func_t c -> Ptr c -> IO <hid_t>

-- char *H5Pget_class_name(hid_t pclass_id);
#ccall H5Pget_class_name, <hid_t> -> IO CString

-- hid_t H5Pcreate(hid_t cls_id);
#ccall H5Pcreate, <hid_t> -> IO <hid_t>

-- herr_t H5Pregister2(hid_t cls_id, const char *name, size_t size,
--     void *def_value, H5P_prp_create_func_t prp_create,
--     H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
--     H5P_prp_delete_func_t prp_del, H5P_prp_copy_func_t prp_copy,
--     H5P_prp_compare_func_t prp_cmp, H5P_prp_close_func_t prp_close);
#ccall H5Pregister2, <hid_t> -> CString -> <size_t> -> Ptr a -> H5P_prp_create_func_t a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_compare_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- herr_t H5Pinsert2(hid_t plist_id, const char *name, size_t size,
--     void *value, H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
--     H5P_prp_delete_func_t prp_delete, H5P_prp_copy_func_t prp_copy,
--     H5P_prp_compare_func_t prp_cmp, H5P_prp_close_func_t prp_close);
#ccall H5Pinsert2, <hid_t> -> CString -> CSize -> Ptr a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_compare_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- herr_t H5Pset(hid_t plist_id, const char *name, void *value);
#ccall H5Pset, <hid_t> -> CString -> Ptr a -> IO <herr_t>

-- htri_t H5Pexist(hid_t plist_id, const char *name);
#ccall H5Pexist, <hid_t> -> CString -> IO <htri_t>

-- herr_t H5Pget_size(hid_t id, const char *name, size_t *size);
#ccall H5Pget_size, <hid_t> -> CString -> Ptr <size_t> -> IO <herr_t>

-- herr_t H5Pget_nprops(hid_t id, size_t *nprops);
#ccall H5Pget_nprops, <hid_t> -> Ptr <size_t> -> IO <herr_t>

-- hid_t H5Pget_class(hid_t plist_id);
#ccall H5Pget_class, <hid_t> -> IO <hid_t>

-- hid_t H5Pget_class_parent(hid_t pclass_id);
#ccall H5Pget_class_parent, <hid_t> -> IO <hid_t>

-- herr_t H5Pget(hid_t plist_id, const char *name, void * value);
#ccall H5Pget, <hid_t> -> CString -> Ptr a -> IO <herr_t>

-- htri_t H5Pequal(hid_t id1, hid_t id2);
#ccall H5Pequal, <hid_t> -> <hid_t> -> IO <htri_t>

-- htri_t H5Pisa_class(hid_t plist_id, hid_t pclass_id);
#ccall H5Pisa_class, <hid_t> -> <hid_t> -> IO <htri_t>

-- int H5Piterate(hid_t id, int *idx, H5P_iterate_t iter_func,
--             void *iter_data);
#ccall H5Piterate, <hid_t> -> Ptr CInt -> H5P_iterate_t a -> Ptr a -> IO CInt

-- herr_t H5Pcopy_prop(hid_t dst_id, hid_t src_id, const char *name);
#ccall H5Pcopy_prop, <hid_t> -> <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Premove(hid_t plist_id, const char *name);
#ccall H5Premove, <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Punregister(hid_t pclass_id, const char *name);
#ccall H5Punregister, <hid_t> -> CString -> IO <herr_t>

-- herr_t H5Pclose_class(hid_t plist_id);
#ccall H5Pclose_class, <hid_t> -> IO <herr_t>

-- herr_t H5Pclose(hid_t plist_id);
#ccall H5Pclose, <hid_t> -> IO <herr_t>

-- hid_t H5Pcopy(hid_t plist_id);
#ccall H5Pcopy, <hid_t> -> IO <hid_t>

-- /* Object creation property list (OCPL) routines */
-- herr_t H5Pset_attr_phase_change(hid_t plist_id, unsigned max_compact, unsigned min_dense);
#ccall H5Pset_attr_phase_change, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_attr_phase_change(hid_t plist_id, unsigned *max_compact, unsigned *min_dense);
#ccall H5Pget_attr_phase_change, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_attr_creation_order(hid_t plist_id, unsigned crt_order_flags);
#ccall H5Pset_attr_creation_order, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_attr_creation_order(hid_t plist_id, unsigned *crt_order_flags);
#ccall H5Pget_attr_creation_order, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_obj_track_times(hid_t plist_id, hbool_t track_times);
#ccall H5Pset_obj_track_times, <hid_t> -> <hbool_t> -> IO <herr_t>

-- herr_t H5Pget_obj_track_times(hid_t plist_id, hbool_t *track_times);
#ccall H5Pget_obj_track_times, <hid_t> -> Out <hbool_t> -> IO <herr_t>

-- herr_t H5Pmodify_filter(hid_t plist_id, H5Z_filter_t filter,
--         unsigned int flags, size_t cd_nelmts,
--         const unsigned int cd_values[/*cd_nelmts*/]);
#ccall H5Pmodify_filter, <hid_t> -> <H5Z_filter_t> -> CUInt -> <size_t> -> InArray CUInt -> IO <herr_t>

-- herr_t H5Pset_filter(hid_t plist_id, H5Z_filter_t filter,
--         unsigned int flags, size_t cd_nelmts,
--         const unsigned int c_values[]);
#ccall H5Pset_filter, <hid_t> -> <H5Z_filter_t> -> CUInt -> <size_t> -> InArray CUInt -> IO <herr_t>

-- int H5Pget_nfilters(hid_t plist_id);
#ccall H5Pget_nfilters, <hid_t> -> IO CInt

-- H5Z_filter_t H5Pget_filter2(hid_t plist_id, unsigned filter,
--        unsigned int *flags/*out*/,
--        size_t *cd_nelmts/*out*/,
--        unsigned cd_values[]/*out*/,
--        size_t namelen, char name[],
--        unsigned *filter_config /*out*/);
#ccall H5Pget_filter2, <hid_t> -> CUInt -> Out CUInt -> Out <size_t> -> OutArray CUInt -> <size_t> -> OutArray CChar -> Out CUInt -> IO <H5Z_filter_t>

-- herr_t H5Pget_filter_by_id2(hid_t plist_id, H5Z_filter_t id,
--        unsigned int *flags/*out*/, size_t *cd_nelmts/*out*/,
--        unsigned cd_values[]/*out*/, size_t namelen, char name[]/*out*/,
--        unsigned *filter_config/*out*/);
#ccall H5Pget_filter_by_id2, <hid_t> -> <H5Z_filter_t> -> Out CUInt -> Out CSize -> OutArray CUInt -> CSize -> OutArray CChar -> Out CUInt -> IO <herr_t>

-- htri_t H5Pall_filters_avail(hid_t plist_id);
#ccall H5Pall_filters_avail, <hid_t> -> IO <htri_t>

-- herr_t H5Premove_filter(hid_t plist_id, H5Z_filter_t filter);
#ccall H5Premove_filter, <hid_t> -> <H5Z_filter_t> -> IO <herr_t>

-- herr_t H5Pset_deflate(hid_t plist_id, unsigned aggression);
#ccall H5Pset_deflate, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pset_fletcher32(hid_t plist_id);
#ccall H5Pset_fletcher32, <hid_t> -> IO <herr_t>


-- /* File creation property list (FCPL) routines */
-- herr_t H5Pget_version(hid_t plist_id, unsigned *boot/*out*/,
--          unsigned *freelist/*out*/, unsigned *stab/*out*/,
--          unsigned *shhdr/*out*/);
#ccall H5Pget_version, <hid_t> -> Out CUInt -> Out CUInt -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_userblock(hid_t plist_id, hsize_t size);
#ccall H5Pset_userblock, <hid_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_userblock(hid_t plist_id, hsize_t *size);
#ccall H5Pget_userblock, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_sizes(hid_t plist_id, size_t sizeof_addr,
--        size_t sizeof_size);
#ccall H5Pset_sizes, <hid_t> -> <size_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_sizes(hid_t plist_id, size_t *sizeof_addr/*out*/,
--        size_t *sizeof_size/*out*/);
#ccall H5Pget_sizes, <hid_t> -> Out <size_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_sym_k(hid_t plist_id, unsigned ik, unsigned lk);
#ccall H5Pset_sym_k, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_sym_k(hid_t plist_id, unsigned *ik/*out*/, unsigned *lk/*out*/);
#ccall H5Pget_sym_k, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_istore_k(hid_t plist_id, unsigned ik);
#ccall H5Pset_istore_k, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_istore_k(hid_t plist_id, unsigned *ik/*out*/);
#ccall H5Pget_istore_k, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_shared_mesg_nindexes(hid_t plist_id, unsigned nindexes);
#ccall H5Pset_shared_mesg_nindexes, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_shared_mesg_nindexes(hid_t plist_id, unsigned *nindexes);
#ccall H5Pget_shared_mesg_nindexes, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_shared_mesg_index(hid_t plist_id, unsigned index_num, unsigned mesg_type_flags, unsigned min_mesg_size);
#ccall H5Pset_shared_mesg_index, <hid_t> -> CUInt -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_shared_mesg_index(hid_t plist_id, unsigned index_num, unsigned *mesg_type_flags, unsigned *min_mesg_size);
#ccall H5Pget_shared_mesg_index, <hid_t> -> CUInt -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_shared_mesg_phase_change(hid_t plist_id, unsigned max_list, unsigned min_btree);
#ccall H5Pset_shared_mesg_phase_change, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_shared_mesg_phase_change(hid_t plist_id, unsigned *max_list, unsigned *min_btree);
#ccall H5Pget_shared_mesg_phase_change, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>


-- /* File access property list (FAPL) routines */
-- herr_t H5Pset_alignment(hid_t fapl_id, hsize_t threshold,
--     hsize_t alignment);
#ccall H5Pset_alignment, <hid_t> -> <hsize_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_alignment(hid_t fapl_id, hsize_t *threshold/*out*/,
--     hsize_t *alignment/*out*/);
#ccall H5Pget_alignment, <hid_t> -> Out <hsize_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_driver(hid_t plist_id, hid_t driver_id,
--         const void *driver_info);
#ccall H5Pset_driver, <hid_t> -> <hid_t> -> Ptr a -> IO <herr_t>

-- hid_t H5Pget_driver(hid_t plist_id);
#ccall H5Pget_driver, <hid_t> -> IO <hid_t>

-- void *H5Pget_driver_info(hid_t plist_id);
#ccall H5Pget_driver_info, <hid_t> -> IO (Ptr a)

-- herr_t H5Pset_family_offset(hid_t fapl_id, hsize_t offset);
#ccall H5Pset_family_offset, <hid_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_family_offset(hid_t fapl_id, hsize_t *offset);
#ccall H5Pget_family_offset, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_multi_type(hid_t fapl_id, H5FD_mem_t type);
#ccall H5Pset_multi_type, <hid_t> -> <H5FD_mem_t> -> IO <herr_t>

-- herr_t H5Pget_multi_type(hid_t fapl_id, H5FD_mem_t *type);
#ccall H5Pget_multi_type, <hid_t> -> Out <H5FD_mem_t> -> IO <herr_t>

-- herr_t H5Pset_cache(hid_t plist_id, int mdc_nelmts,
--        size_t rdcc_nslots, size_t rdcc_nbytes,
--        double rdcc_w0);
#ccall H5Pset_cache, <hid_t> -> CInt -> <size_t> -> <size_t> -> CDouble -> IO <herr_t>

-- herr_t H5Pget_cache(hid_t plist_id,
--        int *mdc_nelmts, /* out */
--        size_t *rdcc_nslots/*out*/,
--        size_t *rdcc_nbytes/*out*/, double *rdcc_w0);
#ccall H5Pget_cache, <hid_t> -> Out CInt -> Out <size_t> -> Out <size_t> -> Out CDouble -> IO <herr_t>

-- herr_t H5Pset_mdc_config(hid_t    plist_id,
--        H5AC_cache_config_t * config_ptr);
#ccall H5Pset_mdc_config, <hid_t> -> In <H5AC_cache_config_t> -> IO <herr_t>

-- herr_t H5Pget_mdc_config(hid_t     plist_id,
--        H5AC_cache_config_t * config_ptr);	/* out */
#ccall H5Pget_mdc_config, <hid_t> -> Out <H5AC_cache_config_t> -> IO <herr_t>

-- herr_t H5Pset_gc_references(hid_t fapl_id, unsigned gc_ref);
#ccall H5Pset_gc_references, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_gc_references(hid_t fapl_id, unsigned *gc_ref/*out*/);
#ccall H5Pget_gc_references, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_fclose_degree(hid_t fapl_id, H5F_close_degree_t degree);
#ccall H5Pset_fclose_degree, <hid_t> -> <H5F_close_degree_t> -> IO <herr_t>

-- herr_t H5Pget_fclose_degree(hid_t fapl_id, H5F_close_degree_t *degree);
#ccall H5Pget_fclose_degree, <hid_t> -> Out <H5F_close_degree_t> -> IO <herr_t>

-- herr_t H5Pset_meta_block_size(hid_t fapl_id, hsize_t size);
#ccall H5Pset_meta_block_size, <hid_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_meta_block_size(hid_t fapl_id, hsize_t *size/*out*/);
#ccall H5Pget_meta_block_size, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_sieve_buf_size(hid_t fapl_id, size_t size);
#ccall H5Pset_sieve_buf_size, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_sieve_buf_size(hid_t fapl_id, size_t *size/*out*/);
#ccall H5Pget_sieve_buf_size, <hid_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_small_data_block_size(hid_t fapl_id, hsize_t size);
#ccall H5Pset_small_data_block_size, <hid_t> -> <hsize_t> -> IO <herr_t>

-- herr_t H5Pget_small_data_block_size(hid_t fapl_id, hsize_t *size/*out*/);
#ccall H5Pget_small_data_block_size, <hid_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_libver_bounds(hid_t plist_id, H5F_libver_t low,
--     H5F_libver_t high);
#ccall H5Pset_libver_bounds, <hid_t> -> <H5F_libver_t> -> <H5F_libver_t> -> IO <herr_t>

-- herr_t H5Pget_libver_bounds(hid_t plist_id, H5F_libver_t *low,
--     H5F_libver_t *high);
#ccall H5Pget_libver_bounds, <hid_t> -> Out H5F_libver_t -> Out H5F_libver_t -> IO <herr_t>


-- /* Dataset creation property list (DCPL) routines */
-- herr_t H5Pset_layout(hid_t plist_id, H5D_layout_t layout);
#ccall H5Pset_layout, <hid_t> -> <H5D_layout_t> -> IO <herr_t>

-- H5D_layout_t H5Pget_layout(hid_t plist_id);
#ccall H5Pget_layout, <hid_t> -> IO <H5D_layout_t>

-- herr_t H5Pset_chunk(hid_t plist_id, int ndims, const hsize_t dim[/*ndims*/]);
#ccall H5Pset_chunk, <hid_t> -> CInt -> InArray <hsize_t> -> IO <herr_t>

-- int H5Pget_chunk(hid_t plist_id, int max_ndims, hsize_t dim[]/*out*/);
#ccall H5Pget_chunk, <hid_t> -> CInt -> OutArray <hsize_t> -> IO CInt

-- herr_t H5Pset_external(hid_t plist_id, const char *name, off_t offset,
--           hsize_t size);
#ccall H5Pset_external, <hid_t> -> CString -> <off_t> -> <hsize_t> -> IO <herr_t>

-- int H5Pget_external_count(hid_t plist_id);
#ccall H5Pget_external_count, <hid_t> -> IO CInt

-- herr_t H5Pget_external(hid_t plist_id, unsigned idx, size_t name_size,
--           char *name/*out*/, off_t *offset/*out*/,
--           hsize_t *size/*out*/);
#ccall H5Pget_external, <hid_t> -> CUInt -> <size_t> -> OutArray CChar -> Out <off_t> -> Out <hsize_t> -> IO <herr_t>

-- herr_t H5Pset_szip(hid_t plist_id, unsigned options_mask, unsigned pixels_per_block);
#ccall H5Pset_szip, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pset_shuffle(hid_t plist_id);
#ccall H5Pset_shuffle, <hid_t> -> IO <herr_t>

-- herr_t H5Pset_nbit(hid_t plist_id);
#ccall H5Pset_nbit, <hid_t> -> IO <herr_t>

-- herr_t H5Pset_scaleoffset(hid_t plist_id, H5Z_SO_scale_type_t scale_type, int scale_factor);
#ccall H5Pset_scaleoffset, <hid_t> -> <H5Z_SO_scale_type_t> -> CInt -> IO <herr_t>

-- herr_t H5Pset_fill_value(hid_t plist_id, hid_t type_id,
--      const void *value);
#ccall H5Pset_fill_value, <hid_t> -> <hid_t> -> In a -> IO <herr_t>

-- herr_t H5Pget_fill_value(hid_t plist_id, hid_t type_id,
--      void *value/*out*/);
#ccall H5Pget_fill_value, <hid_t> -> <hid_t> -> Out a -> IO <herr_t>

-- herr_t H5Pfill_value_defined(hid_t plist, H5D_fill_value_t *status);
#ccall H5Pfill_value_defined, <hid_t> -> Ptr <H5D_fill_value_t> -> IO <herr_t>

-- herr_t H5Pset_alloc_time(hid_t plist_id, H5D_alloc_time_t
-- 	alloc_time);
#ccall H5Pset_alloc_time, <hid_t> -> <H5D_alloc_time_t> -> IO <herr_t>

-- herr_t H5Pget_alloc_time(hid_t plist_id, H5D_alloc_time_t
-- 	*alloc_time/*out*/);
#ccall H5Pget_alloc_time, <hid_t> -> Out H5D_alloc_time_t -> IO <herr_t>

-- herr_t H5Pset_fill_time(hid_t plist_id, H5D_fill_time_t fill_time);
#ccall H5Pset_fill_time, <hid_t> -> <H5D_fill_time_t> -> IO <herr_t>

-- herr_t H5Pget_fill_time(hid_t plist_id, H5D_fill_time_t
-- 	*fill_time/*out*/);
#ccall H5Pget_fill_time, <hid_t> -> Out <H5D_fill_time_t> -> IO <herr_t>


-- /* Dataset access property list (DAPL) routines */
-- herr_t H5Pset_chunk_cache(hid_t dapl_id, size_t rdcc_nslots,
--        size_t rdcc_nbytes, double rdcc_w0);
#ccall H5Pset_chunk_cache, <hid_t> -> <size_t> -> <size_t> -> CDouble -> IO <herr_t>

-- herr_t H5Pget_chunk_cache(hid_t dapl_id,
--        size_t *rdcc_nslots/*out*/,
--        size_t *rdcc_nbytes/*out*/,
--        double *rdcc_w0/*out*/);
#ccall H5Pget_chunk_cache, <hid_t> -> Out <size_t> -> Out <size_t> -> Out CDouble -> IO <herr_t>


-- /* Dataset xfer property list (DXPL) routines */
-- herr_t H5Pset_data_transform(hid_t plist_id, const char* expression);
#ccall H5Pset_data_transform, <hid_t> -> CString -> IO <herr_t>

-- ssize_t H5Pget_data_transform(hid_t plist_id, char* expression /*out*/, size_t size);
#ccall H5Pget_data_transform, <hid_t> -> OutArray CChar -> <size_t> -> IO <ssize_t>

-- herr_t H5Pset_buffer(hid_t plist_id, size_t size, void *tconv,
--         void *bkg);
#ccall H5Pset_buffer, <hid_t> -> <size_t> -> Ptr a -> Ptr b -> IO <herr_t>

-- size_t H5Pget_buffer(hid_t plist_id, void **tconv/*out*/,
--         void **bkg/*out*/);
#ccall H5Pget_buffer, <hid_t> -> Out (Ptr a) -> Out (Ptr b) -> IO <size_t>

-- herr_t H5Pset_preserve(hid_t plist_id, hbool_t status);
#ccall H5Pset_preserve, <hid_t> -> <hbool_t> -> IO <herr_t>

-- int H5Pget_preserve(hid_t plist_id);
#ccall H5Pget_preserve, <hid_t> -> IO CInt

-- herr_t H5Pset_edc_check(hid_t plist_id, H5Z_EDC_t check);
#ccall H5Pset_edc_check, <hid_t> -> <H5Z_EDC_t> -> IO <herr_t>

-- H5Z_EDC_t H5Pget_edc_check(hid_t plist_id);
#ccall H5Pget_edc_check, <hid_t> -> IO <H5Z_EDC_t>

-- herr_t H5Pset_filter_callback(hid_t plist_id, H5Z_filter_func_t func,
--                                      void* op_data);
#ccall H5Pset_filter_callback, <hid_t> -> H5Z_filter_func_t a b -> Ptr b -> IO <herr_t>

-- herr_t H5Pset_btree_ratios(hid_t plist_id, double left, double middle,
--        double right);
#ccall H5Pset_btree_ratios, <hid_t> -> CDouble -> CDouble -> CDouble -> IO <herr_t>

-- herr_t H5Pget_btree_ratios(hid_t plist_id, double *left/*out*/,
--        double *middle/*out*/,
--        double *right/*out*/);
#ccall H5Pget_btree_ratios, <hid_t> -> Out CDouble -> Out CDouble -> Out CDouble -> IO <herr_t>

-- herr_t H5Pset_vlen_mem_manager(hid_t plist_id,
--                                        H5MM_allocate_t alloc_func,
--                                        void *alloc_info, H5MM_free_t free_func,
--                                        void *free_info);
#ccall H5Pset_vlen_mem_manager, <hid_t> -> H5MM_allocate_t allocInfo mem -> Ptr allocInfo -> H5MM_free_t freeInfo mem -> Ptr freeInfo -> IO <herr_t>

-- herr_t H5Pget_vlen_mem_manager(hid_t plist_id,
--                                        H5MM_allocate_t *alloc_func,
--                                        void **alloc_info,
--                                        H5MM_free_t *free_func,
--                                        void **free_info);
#ccall H5Pget_vlen_mem_manager, <hid_t> -> Out (H5MM_allocate_t allocInfo mem) -> Out (Ptr allocInfo) -> Out (H5MM_free_t freeInfo mem) -> Out (Ptr freeInfo) -> IO <herr_t>

-- herr_t H5Pset_hyper_vector_size(hid_t fapl_id, size_t size);
#ccall H5Pset_hyper_vector_size, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_hyper_vector_size(hid_t fapl_id, size_t *size/*out*/);
#ccall H5Pget_hyper_vector_size, <hid_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_type_conv_cb(hid_t dxpl_id, H5T_conv_except_func_t op, void* operate_data);
#ccall H5Pset_type_conv_cb, <hid_t> -> H5T_conv_except_func_t a b -> Ptr b -> IO <herr_t>

-- herr_t H5Pget_type_conv_cb(hid_t dxpl_id, H5T_conv_except_func_t *op, void** operate_data);
#ccall H5Pget_type_conv_cb, <hid_t> -> Out (H5T_conv_except_func_t a b) -> Out (Ptr b) -> IO <herr_t>


-- /* Link creation property list (LCPL) routines */
-- herr_t H5Pset_create_intermediate_group(hid_t plist_id, unsigned crt_intmd);
#ccall H5Pset_create_intermediate_group, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_create_intermediate_group(hid_t plist_id, unsigned *crt_intmd /*out*/);
#ccall H5Pget_create_intermediate_group, <hid_t> -> Out CUInt -> IO <herr_t>


-- /* Group creation property list (GCPL) routines */
-- herr_t H5Pset_local_heap_size_hint(hid_t plist_id, size_t size_hint);
#ccall H5Pset_local_heap_size_hint, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_local_heap_size_hint(hid_t plist_id, size_t *size_hint /*out*/);
#ccall H5Pget_local_heap_size_hint, <hid_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_link_phase_change(hid_t plist_id, unsigned max_compact, unsigned min_dense);
#ccall H5Pset_link_phase_change, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_link_phase_change(hid_t plist_id, unsigned *max_compact /*out*/, unsigned *min_dense /*out*/);
#ccall H5Pget_link_phase_change, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_est_link_info(hid_t plist_id, unsigned est_num_entries, unsigned est_name_len);
#ccall H5Pset_est_link_info, <hid_t> -> CUInt -> CUInt -> IO <herr_t>

-- herr_t H5Pget_est_link_info(hid_t plist_id, unsigned *est_num_entries /* out */, unsigned *est_name_len /* out */);
#ccall H5Pget_est_link_info, <hid_t> -> Out CUInt -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_link_creation_order(hid_t plist_id, unsigned crt_order_flags);
#ccall H5Pset_link_creation_order, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_link_creation_order(hid_t plist_id, unsigned *crt_order_flags /* out */);
#ccall H5Pget_link_creation_order, <hid_t> -> Out CUInt -> IO <herr_t>


-- /* String creation property list (STRCPL) routines */
-- herr_t H5Pset_char_encoding(hid_t plist_id, H5T_cset_t encoding);
#ccall H5Pset_char_encoding, <hid_t> -> <H5T_cset_t> -> IO <herr_t>

-- herr_t H5Pget_char_encoding(hid_t plist_id, H5T_cset_t *encoding /*out*/);
#ccall H5Pget_char_encoding, <hid_t> -> Out <H5T_cset_t> -> IO <herr_t>


-- /* Link access property list (LAPL) routines */
-- herr_t H5Pset_nlinks(hid_t plist_id, size_t nlinks);
#ccall H5Pset_nlinks, <hid_t> -> <size_t> -> IO <herr_t>

-- herr_t H5Pget_nlinks(hid_t plist_id, size_t *nlinks);
#ccall H5Pget_nlinks, <hid_t> -> Out <size_t> -> IO <herr_t>

-- herr_t H5Pset_elink_prefix(hid_t plist_id, const char *prefix);
#ccall H5Pset_elink_prefix, <hid_t> -> CString -> IO <herr_t>

-- ssize_t H5Pget_elink_prefix(hid_t plist_id, char *prefix, size_t size);
#ccall H5Pget_elink_prefix, <hid_t> -> OutArray CChar -> CString -> IO <ssize_t>

-- hid_t H5Pget_elink_fapl(hid_t lapl_id);
#ccall H5Pget_elink_fapl, <hid_t> -> IO <hid_t>

-- herr_t H5Pset_elink_fapl(hid_t lapl_id, hid_t fapl_id);
#ccall H5Pset_elink_fapl, <hid_t> -> <hid_t> -> IO <herr_t>

-- herr_t H5Pset_elink_acc_flags(hid_t lapl_id, unsigned flags);
#ccall H5Pset_elink_acc_flags, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_elink_acc_flags(hid_t lapl_id, unsigned *flags);
#ccall H5Pget_elink_acc_flags, <hid_t> -> Out CUInt -> IO <herr_t>

-- herr_t H5Pset_elink_cb(hid_t lapl_id, H5L_elink_traverse_t func, void *op_data);
#ccall H5Pset_elink_cb, <hid_t> -> H5L_elink_traverse_t a -> Ptr a -> IO <herr_t>

-- herr_t H5Pget_elink_cb(hid_t lapl_id, H5L_elink_traverse_t *func, void **op_data);
#ccall H5Pget_elink_cb, <hid_t> -> Out (H5L_elink_traverse_t a) -> Out (Ptr a) -> IO <herr_t>


-- /* Object copy property list (OCPYPL) routines */
-- herr_t H5Pset_copy_object(hid_t plist_id, unsigned crt_intmd);
#ccall H5Pset_copy_object, <hid_t> -> CUInt -> IO <herr_t>

-- herr_t H5Pget_copy_object(hid_t plist_id, unsigned *crt_intmd /*out*/);
#ccall H5Pget_copy_object, <hid_t> -> Out CUInt -> IO <herr_t>

-- 
-- /* Symbols defined for compatibility with previous versions of the HDF5 API.
--  *
--  * Use of these symbols is deprecated.
--  */
#ifndef H5_NO_DEPRECATED_SYMBOLS

h5p_NO_CLASS = h5p_ROOT

-- /* Function prototypes */
-- herr_t H5Pregister1(hid_t cls_id, const char *name, size_t size,
--     void *def_value, H5P_prp_create_func_t prp_create,
--     H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
--     H5P_prp_delete_func_t prp_del, H5P_prp_copy_func_t prp_copy,
--     H5P_prp_close_func_t prp_close);
#ccall H5Pregister1, <hid_t> -> CString -> <size_t> -> Ptr a -> H5P_prp_create_func_t a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- herr_t H5Pinsert1(hid_t plist_id, const char *name, size_t size,
--     void *value, H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
--     H5P_prp_delete_func_t prp_delete, H5P_prp_copy_func_t prp_copy,
--     H5P_prp_close_func_t prp_close);
#ccall H5Pinsert1, <hid_t> -> CString -> <size_t> -> Ptr a -> H5P_prp_set_func_t a -> H5P_prp_get_func_t a -> H5P_prp_delete_func_t a -> H5P_prp_copy_func_t a -> H5P_prp_close_func_t a -> IO <herr_t>

-- H5Z_filter_t H5Pget_filter1(hid_t plist_id, unsigned filter,
--     unsigned int *flags/*out*/, size_t *cd_nelmts/*out*/,
--     unsigned cd_values[]/*out*/, size_t namelen, char name[]);
#ccall H5Pget_filter1, <hid_t> -> CUInt -> Out CUInt -> Out <size_t> -> OutArray CUInt -> <size_t> -> Out CChar -> IO <H5Z_filter_t>

-- herr_t H5Pget_filter_by_id1(hid_t plist_id, H5Z_filter_t id,
--     unsigned int *flags/*out*/, size_t *cd_nelmts/*out*/,
--     unsigned cd_values[]/*out*/, size_t namelen, char name[]/*out*/);
#ccall H5Pget_filter_by_id1, <hid_t> -> <H5Z_filter_t> -> Out CUInt -> Out <size_t> -> OutArray CUInt -> <size_t> -> OutArray CChar -> IO <herr_t>

#endif /* H5_NO_DEPRECATED_SYMBOLS */
