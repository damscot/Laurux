/* Tests Laurux (phase 2) : HOME de test pour l'utilisateur courant, hors conteneur.
 * Gambas lit User.Home dans la base des comptes (getpwuid/getpwnam), pas dans $HOME. Chargée par LD_PRELOAD,
 * cette bibliothèque remplace le répertoire personnel de l'utilisateur courant par $LAURUX_TEST_HOME et son nom
 * par $LAURUX_TEST_USER (User.Name, ex. « nuser » de l'Agenda), s'ils sont définis.
 * Compilation : gcc -shared -fPIC -O2 -o libhome.so libhome.c -ldl */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <pwd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

static struct passwd *corrige(struct passwd *p)
{
    const char *h = getenv("LAURUX_TEST_HOME");
    const char *u = getenv("LAURUX_TEST_USER");
    if (p && p->pw_uid == getuid()) {
        if (h && *h) p->pw_dir = (char *)h;
        if (u && *u) p->pw_name = (char *)u;
    }
    return p;
}

struct passwd *getpwuid(uid_t uid)
{
    static struct passwd *(*vrai)(uid_t);
    if (!vrai) vrai = dlsym(RTLD_NEXT, "getpwuid");
    return corrige(vrai(uid));
}

struct passwd *getpwnam(const char *nom)
{
    static struct passwd *(*vrai)(const char *);
    if (!vrai) vrai = dlsym(RTLD_NEXT, "getpwnam");
    return corrige(vrai(nom));
}

int getpwuid_r(uid_t uid, struct passwd *pw, char *buf, size_t n, struct passwd **res)
{
    static int (*vrai)(uid_t, struct passwd *, char *, size_t, struct passwd **);
    if (!vrai) vrai = dlsym(RTLD_NEXT, "getpwuid_r");
    int r = vrai(uid, pw, buf, n, res);
    if (r == 0 && res && *res) corrige(*res);
    return r;
}

int getpwnam_r(const char *nom, struct passwd *pw, char *buf, size_t n, struct passwd **res)
{
    static int (*vrai)(const char *, struct passwd *, char *, size_t, struct passwd **);
    if (!vrai) vrai = dlsym(RTLD_NEXT, "getpwnam_r");
    int r = vrai(nom, pw, buf, n, res);
    if (r == 0 && res && *res) corrige(*res);
    return r;
}
