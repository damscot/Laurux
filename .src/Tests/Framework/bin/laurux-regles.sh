# Règles des outils externes de test (tests Laurux, phase 2), lues par les faux programmes et enveloppes de ce
# répertoire (fichier « sourcé », pas un programme). Le harnais (Start.Run_Scenario, clé « outils » de meta.json)
# exporte, pour chaque outil et paramètre, LAURUX_TEST_<OUTIL>_<PARAM>=<valeur> (OUTIL et PARAM en majuscules,
# tout caractère hors A-Z et 0-9 remplacé par « _ ») :
#   RC           code de retour forcé
#   TIMEOUT      délai en secondes avant la réponse (outil lent ou bloqué ; Laurux peut l'interrompre)
#   HIDDEN_ARGV  motifs (glob, un par ligne) des arguments masqués « <masqué> » dans la trace
#   SORTIE       texte forcé sur la sortie standard
#   ERREUR       texte forcé sur la sortie d'erreur
# Paramètre non défini : comportement d'origine de l'outil (faux programme ou vrai outil des enveloppes).
# Si RC, SORTIE ou ERREUR est défini, l'outil répond seulement avec ces valeurs et s'arrête (code RC, défaut 0) :
# une enveloppe n'appelle alors pas le vrai outil.

# regles_var OUTIL PARAM : valeur de LAURUX_TEST_<OUTIL>_<PARAM> (vide si non définie)
regles_var() {
  _n=$(printf '%s' "$1" | tr 'a-z' 'A-Z' | tr -c 'A-Z0-9' '_')
  _p=$(printf '%s' "$2" | tr 'a-z' 'A-Z' | tr -c 'A-Z0-9' '_')
  eval "printf '%s' \"\${LAURUX_TEST_${_n}_${_p}-}\""
}

# regles_actives OUTIL : vrai si au moins une règle LAURUX_TEST_<OUTIL>_* est définie
regles_actives() {
  _n=$(printf '%s' "$1" | tr 'a-z' 'A-Z' | tr -c 'A-Z0-9' '_')
  # paramètres connus seulement : ni LAURUX_TEST_MARIADB_DUMP_* pour mariadb, ni les variables du harnais
  # (LAURUX_TEST_DB_PORT, LAURUX_TEST_HOME…)
  env | grep -Eq "^LAURUX_TEST_${_n}_(RC|TIMEOUT|HIDDEN_ARGV|SORTIE|ERREUR)="
}

# regles_trace FICHIER OUTIL ARG… : ajoute « OUTIL [arg1] [arg2] » au fichier de trace, arguments masqués selon
# HIDDEN_ARGV (sans règle : ligne identique à celle des faux programmes)
regles_trace() {
  _f=$1; _o=$2; shift 2
  _m=$(regles_var "$_o" HIDDEN_ARGV)
  mkdir -p "$(dirname "$_f")"
  {
    printf '%s' "$_o"
    for _a in "$@"; do
      _r=$_a
      if [ -n "$_m" ]; then
        _ifs=$IFS; IFS='
'
        case $- in *f*) _sf=1 ;; *) _sf=0; set -f ;; esac
        for _motif in $_m; do
          case "$_a" in $_motif) _r='<masqué>' ;; esac
        done
        [ "$_sf" = 0 ] && set +f
        IFS=$_ifs
      fi
      printf ' [%s]' "$_r"
    done
    echo
  } >> "$_f"
}

# regles_appliquer OUTIL : délai (TIMEOUT), puis réponse forcée (SORTIE, ERREUR, RC) et sortie du programme ;
# sans réponse forcée, rend la main (comportement d'origine)
regles_appliquer() {
  _d=$(regles_var "$1" TIMEOUT)
  [ -n "$_d" ] && sleep "$_d"
  _rc=$(regles_var "$1" RC)
  _s=$(regles_var "$1" SORTIE)
  _e=$(regles_var "$1" ERREUR)
  if [ -n "$_rc$_s$_e" ]; then
    [ -n "$_s" ] && printf '%s\n' "$_s"
    [ -n "$_e" ] && printf '%s\n' "$_e" >&2
    exit "${_rc:-0}"
  fi
  return 0
}
