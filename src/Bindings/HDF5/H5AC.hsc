#include <bindings.h>
#include <H5ACpublic.h>

module Bindings.HDF5.H5AC where
#strict_import

import Bindings.HDF5.H5
import Bindings.HDF5.H5C

#starttype H5AC_cache_config_t
#field version,                 CInt
#field rpt_fcn_enabled,         <hbool_t>
#field open_trace_file,         <hbool_t>
#field close_trace_file,        <hbool_t>
#array_field trace_file_name,   CChar
#field evictions_enabled,       <hbool_t>
#field set_initial_size,        <hbool_t>
#field initial_size,            <size_t>
#field min_clean_fraction,      CDouble
#field max_size,                <size_t>
#field min_size,                <size_t>
#field epoch_length,            CLong
#field incr_mode,               <H5C_cache_incr_mode>
#field lower_hr_threshold,      CDouble
#field increment,               CDouble
#field apply_max_increment,     <hbool_t>
#field max_increment,           <size_t>
#field flash_incr_mode,         <H5C_cache_flash_incr_mode>
#field flash_multiple,          CDouble
#field flash_threshold,         CDouble
#field decr_mode,               <H5C_cache_decr_mode>
#field upper_hr_threshold,      CDouble
#field decrement,               CDouble
#field apply_max_decrement,     <hbool_t>
#field max_decrement,           <size_t>
#field epochs_before_eviction,  CInt
#field apply_empty_reserve,     <hbool_t>
#field empty_reserve,           CDouble
#field dirty_bytes_threshold,   CInt
#field metadata_write_strategy, CInt
#stoptype