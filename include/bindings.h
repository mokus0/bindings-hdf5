#ifndef ___n_bindings_h__
#define ___n_bindings_h__

#include <util.h>

#include <bindings.dsl.h>

// Replace bindings-DSL naming scheme with our own
#include <mangle.h>

#undef bc_varid
#undef bc_conid
#undef bc_ptrid
#undef bc_wrapper
#undef bc_dynamic
#define bc_varid(name)              hsc_mangle(varid,       name);
#define bc_conid(name)              hsc_mangle(conid,       name);
#define bc_ptrid(name)              hsc_mangle(ptrid,       name);
#define bc_wrapper(name)            hsc_mangle(wrapper,     name);
#define bc_dynamic(name)            hsc_mangle(dynamic,     name);

#undef bc_fieldname
#undef bc_unionupdate
#undef bc_famaccess
#define bc_fieldname(type,field)    bc_glue(mangle_fieldname(type),   field);
#define bc_unionupdate(type,field)  bc_glue(mangle_unionupdate(type), field);
#define bc_famaccess(type,field)    bc_glue(mangle_famaccess(type),   field);


#define hsc_newtype(t,derive...)                                \
    {                                                           \
        printf("newtype ");                                     \
        hsc_mangle_tycon(# t);                                  \
        printf(" = ");                                          \
        hsc_mangle_datacon(# t);                                \
        printf(" ");                                            \
        hsc_type(t);                                            \
        { char *derives = # derive;                             \
            printf(" deriving (Storable, Show%s%s)\n",                    \
                strlen(derives) > 0 ? ", " : "",                \
                derives);                                       \
        }                                                       \
    }

#define hsc_newtype_const(t,c)      \
    {                               \
        hsc_mangle_ident(# c);      \
        printf(" :: ");             \
        hsc_mangle_tycon(# t);      \
        printf("\n");               \
        hsc_mangle_ident(# c);      \
        printf(" = ");              \
        hsc_mangle_datacon(# t);    \
        printf(" (");               \
        hsc_const(c);               \
        printf(")\n");              \
    }

#define hsc_str(name)               \
    {                               \
        hsc_mangle_ident(# name);   \
        printf(" :: String\n");     \
        hsc_mangle_ident(# name);   \
        printf(" = ");              \
        hsc_const_str(name);        \
        printf("\n");               \
    }

#endif /* ___n_bindings_h__ */
