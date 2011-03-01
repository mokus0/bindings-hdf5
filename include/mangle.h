#ifndef ___n_mangle_h__
#define ___n_mangle_h__

#include <util.h>

static struct {
    char *from, *to;
} hardcoded_mangles[] = {
    {NULL, NULL},
};

inline int isH5Name(char *s) {
    if (s[0] != 'H' && s[0] != 'h') return FALSE;
    
    if (s[1] != '5')                return FALSE;
    
    if (s[2] == '\0')               return FALSE;
    if (s[2] == '_')                return TRUE;
    if ('a' <= s[2] && s[2] <= 'z') return TRUE;
    if ('A' <= s[2] && s[2] <= 'Z') return TRUE;
    
    return FALSE;
}

#define mangle_tycon(name)                                          \
    ({                                                              \
        unsigned i;                                                 \
        char *res = ucn(name, isH5Name(name) ? 3 : 2);              \
        for(i = 0; hardcoded_mangles[i].from != NULL; i++) {        \
            if (strcmp(name, hardcoded_mangles[i].from) == 0) {     \
                res = hardcoded_mangles[i].to;                      \
                break;                                              \
            }                                                       \
        }                                                           \
                                                                    \
        res;                                                        \
    })

#define mangle_datacon(name)        mangle_tycon(name)
#define mangle_ident(name)          (lcn(name, isH5Name(name) ? 3 : 2))

#define mangle_varid(name)          mangle_ident(name)
#define mangle_fieldname(name)      mangle_varid(name)
#define mangle_conid(name)          mangle_tycon(name)
#define mangle_ptrid(name)          concat("p_", name)
#define mangle_famaccess(name)      mangle_ptrid(name)
#define mangle_unionupdate(name)    concat("u_", name)


#define hsc_mangle(as,name)         printf("%s", mangle_ ## as(name));

#define hsc_mangle_tycon(name)      hsc_mangle(tycon,   name)
#define hsc_mangle_datacon(name)    hsc_mangle(datacon, name)
#define hsc_mangle_ident(name)      hsc_mangle(ident,   name)


#endif /* ___n_mangle_h__ */
