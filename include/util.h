#ifndef ___n_util_h__
#define ___n_util_h__

#include <stdlib.h>

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#define H5_VERSION_ATLEAST(a,b,c)                    \
    ((H5_VERS_MAJOR > a) || (H5_VERS_MAJOR == a && ( \
        H5_VERS_MINOR > b || H5_VERS_MINOR == b && ( \
            H5_VERS_RELEASE >= c))))

#define H5_VERSION_ATMOST(a,b,c)                     \
    ((H5_VERS_MAJOR < a) || (H5_VERS_MAJOR == a && ( \
        H5_VERS_MINOR < b || H5_VERS_MINOR == b && ( \
            H5_VERS_RELEASE <= c))))

#define signed(t)       ((t)(-1) < 0)
#define floating(t)     ((t)(int)(t) 1.4 == (t) 1.4)
#define nbitsof(t)      (sizeof(t) * 8)
#define countof(x)      (sizeof(x) / sizeof((x)[0]))

inline char *dupstr(char *s) {
    // don't worry about freeing, this is a throw-away program
    char *t = (char *) malloc(strlen(s) + 1);
    strcpy(t,s);
    return t;
}

inline char *mapstrn(char *s, unsigned n, int (*f)(int)) {
    unsigned i;
    char *t = dupstr(s);
    
    for (i = 0; i < n && t[i] != '\0'; i++) {
        t[i] = f(t[i]);
    }
    
    return t;
}

inline char *concatn(char *s1, unsigned n1, char *s2, unsigned n2) {
    char *t = (char *) malloc(1 + n1 + n2);
    strncpy(t,    s1, n1+1);
    strncpy(t+n1, s2, n2+1);
    t[n1+n2] = '\0';
    return t;
}

inline char *concat(char *s1, char *s2) {
    unsigned n1 = strlen(s1);
    unsigned n2 = strlen(s2);
    return concatn(s1,n1,s2,n2);
}

#define lcn(s,n)     mapstrn(s, n, &tolower)
#define ucn(s,n)     mapstrn(s, n, &toupper)

#endif /* ___n_util_h__ */
