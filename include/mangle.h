#ifndef ___n_mangle_h__
#define ___n_mangle_h__

#include <util.h>

static struct {
    char *from, *to;
} hardcoded_mangles[] = {
    {"size_t",  "CSize"},
    {"ssize_t", "CSSize"},
    {"time_t",  "CTime"},
    {"off_t",   "COff"},
    {NULL, NULL},
};

// Most type names are already uppercase, including all that have the "H5" 
// prefix.  That means we don't need to mess with figuring out the length
// of the prefix.  Just check for a leading 'h' and, if present, uppercase
// 2 chars instead of 1.
inline char *uc_prefix(char *s) {
    if (s[0] == '\0' || isupper(s[0]))
        return s;
    
    if (s[0] != 'h')
        return ucn(s,1);
    
    return ucn(s,2);
}

// the logic used in lc_prefix to identify the prefix.
inline void skip_prefix(char *s, char **rest, unsigned *prefix_len) {
    char    *r = s;
    unsigned p = 0;
    unsigned n = *prefix_len;
    
    while (p < n && *r != '\0' && isupper(*r) || *r == '5') {
        r++;
        p++;
    }
    
    *rest = r;
    *prefix_len = p;
}

// Lowercasing the prefix is a little trickier, for 2 reasons:
// 1. the uppercase prefixes are not all the same length (eg., H5T and H5AC)
// 2. they are terminated by an underscore in the case of all-caps macro names
//    but not in the case of lowercase function names.  So sometimes we
//    need to add an underscore* and other times we don't.
// 
//   * because otherwise prefixes are potentially ambiguous after mangling;
//     is 'h5a_create2' the mangling of 'H5Acreate2' or 'H5ACreate2'?
//     Obviously a human can tell the difference, but a machine can't as 
//     easily.
inline char *lc_prefix(char *s) {
    char *rest;
    unsigned prefix_len = 4;
    
    if (s[0] == '\0' || islower(s[0]))
        return s;
    
    skip_prefix(s, &rest, &prefix_len);
    
    {
        char lc_pref[prefix_len+1];
        int i;
        
        for (i = 0; i < prefix_len; i++) {
            lc_pref[i] = tolower(s[i]);
        }
        
        if (s[prefix_len] != '_') {
            lc_pref[prefix_len] = '_';
            prefix_len++;
        }
        
        return (concatn(lc_pref, prefix_len, rest, strlen(rest)));
    }
}

#define mangle_tycon(name)                                          \
    ({                                                              \
        unsigned i;                                                 \
        char *res = NULL;                                           \
        for(i = 0; hardcoded_mangles[i].from != NULL; i++) {        \
            if (strcmp(name, hardcoded_mangles[i].from) == 0) {     \
                res = hardcoded_mangles[i].to;                      \
                break;                                              \
            }                                                       \
        }                                                           \
                                                                    \
        if (res == NULL) res = uc_prefix(name);                     \
        res;                                                        \
    })

#define mangle_datacon(name)        mangle_tycon(name)
#define mangle_ident(name)          (lc_prefix(name))

#define mangle_varid(name)          mangle_ident(name)
#define mangle_fieldname(name)      mangle_varid(name)
#define mangle_conid(name)          mangle_tycon(name)
#define mangle_ptrid(name)          concat("p_", name)
#define mangle_famaccess(name)      mangle_ptrid(name)
#define mangle_unionupdate(name)    concat("u_", name)
#define mangle_wrapper(name)        concat("mk_",name)
#define mangle_dynamic(name)        concat("mK_",name)

#define hsc_mangle(as,name)         printf("%s", mangle_ ## as(name));

#define hsc_mangle_tycon(name)      hsc_mangle(tycon,   name)
#define hsc_mangle_datacon(name)    hsc_mangle(datacon, name)
#define hsc_mangle_ident(name)      hsc_mangle(ident,   name)


#endif /* ___n_mangle_h__ */
