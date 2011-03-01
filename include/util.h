#ifndef ___n_util_h__
#define ___n_util_h__

#include <stdlib.h>

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif


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

inline char *concat(char *s1, char *s2) {
    unsigned n1 = strlen(s1);
    unsigned n2 = strlen(s2);
    char *t = (char *) malloc(1 + n1 + n2);
    strcpy(t,    s1);
    strcpy(t+n1, s2);
    return t;
}

#define lcn(s,n)     mapstrn(s, n, &tolower)
#define ucn(s,n)     mapstrn(s, n, &toupper)

#endif /* ___n_util_h__ */
