bindings-hdf5
==============

This is a very thin Haskell wrapper around the C API of the HDF5 library (see <http://www.hdfgroup.org/HDF5/>).  Because the interface uses pointers so heavily, this package also defines some newtype wrappers around `Ptr` that express the intended usage of the pointer, along with functions to marshall pointers in their intended ways.

For example, the C function `H5Dread` has the following signature:

    herr_t H5Dread( hid_t dataset_id, hid_t mem_type_id, hid_t mem_space_id, hid_t file_space_id, hid_t xfer_plist_id, void * buf )

This is mapped to a Haskell function with the following signature:

    h5d_read :: HId_t -> HId_t -> HId_t -> HId_t -> HId_t -> OutArray a -> IO HErr_t

One way of invoking this function would be to use the `withOutVector_` function:

    withOutVector_ (fromIntegral n) $ \buf ->
        h5d_read dset_id h5t_NATIVE_DOUBLE h5s_ALL h5s_ALL h5p_DEFAULT buf

`withOutVector_` here creates an `n`-element vector (the type of which will either need to be explicitly given or inferred from its usage elsewhere), passing the lambda expression a pointer to the vector's contents and returning the vector.

Installation
-------------

Installing this package is not as simple as I'd like.  It uses a pkgconfig dependency to locate the C headers and library, but HDF5 does not ship with a pkgconfig file.  There is an example included in the source distribution which you can customize and place in pkg-config's search path (you can find the search path using `pkg-config --variable pc_path pkg-config`).  For example, to get started on a Mac with homebrew, you can say:

    $ brew install pkgconfig
    $ brew install hdf5
    $ git clone https://github.com/mokus0/bindings-hdf5.git
    $ cd bindings-hdf5
    $ vi doc/hdf5.pc    # set prefix=/opt/homebrew/Cellar/hdf5/1.8.8
    $ cp doc/hdf5.pc /opt/homebrew/lib/pkgconfig/

Once all that is done:

    $ cabal install

See also
---------

The API exposed here is very low level; I strongly recommend against using it directly.  Instead, check out <http://github.com/mokus0/hs-hdf5>, which is a higher level wrapper that makes it quite a bit harder to shoot yourself in the foot.  That library is still fairly incomplete, though.  If it's missing something you need, feel free to ask me to implement it or just send a pull request.