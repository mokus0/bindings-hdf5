#include <H5FDpublic.h>

#include <string.h>

#define MIN(a,b) (a < b ? a : b)
#define BC_INLINE_ARRAY(name, t)                \
    void inline_ ## name (t *b, size_t n) {   \
        t a[] = name;                           \
        memcpy(b, a, MIN(n, sizeof(a)));        \
    }

BC_INLINE_ARRAY(H5FD_FLMAP_SINGLE,      H5FD_mem_t)
BC_INLINE_ARRAY(H5FD_FLMAP_DICHOTOMY,   H5FD_mem_t)
BC_INLINE_ARRAY(H5FD_FLMAP_DEFAULT,     H5FD_mem_t)