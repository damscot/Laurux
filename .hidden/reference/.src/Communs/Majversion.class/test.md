# Majversion — Tests

> Source : `.src/Communs/Majversion.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MAJVERSION-T01 | gbtest | `RecupVersionApp` | `Application.Version` du projet (3.69.0) | `"3.69"` | `tests/version_app/` | implémenté |
| MAJVERSION-T02 | gbtest | `RecupVersion(False)` | base `Laurux01.sql` (version 3.69) | `"3.69"`, variable `Version` renseignée, aucun accès réseau | `tests/version_base/` | implémenté |
| MAJVERSION-T03 | gbtest | `RecupVersion(True)` sans contrôle | `/Majver` = 0 | `"3.69"`, aucun fichier créé dans `~/tmp` | `tests/version_base_sans_maj/` | implémenté |
| MAJVERSION-T04 | replay | Écran sans réseau | réseau du conteneur coupé, ouverture par `Menu173` | figer le comportement actuel (erreur sur `Type.Current`, A04, à confirmer) | `tests/ecran_hors_ligne/` | à faire : le réseau du conteneur runner n'est pas coupable par scénario (réseau compose partagé avec la base) ; l'écran interrogerait le vrai site www.laurux.fr (résultat non déterministe) |
| MAJVERSION-T05 | replay | Écran avec serveur simulé | serveur HTTP local servant un index (`Stable/`, versions) et `Stable/version.txt` = `Laurux V3.70.0` | `Type`, `ListVersion`, `VerAct`, `VerWeb` (log GUI) ; nécessite de rediriger `www.laurux.fr` (entrée `/etc/hosts` + certificat, à confirmer) | `tests/ecran_serveur_simule/` | à faire : URL https://www.laurux.fr en dur : redirection DNS + certificat de test non disponibles dans le runner |
| MAJVERSION-T06 | replay | Comparaison de versions | serveur simulé avec `version.txt` = `3.70.0`, `3.69.1`, `3.69.0`, `4.0.0`, `3.70` | question proposée ou non selon la règle actuelle (majeur ignoré A01, 2 composants A03) | `tests/comparaison_versions/` | à faire : même raison que T05 (serveur simulé non redirigeable) |
| MAJVERSION-T07 | gbtest | `Avancement` | `~/tmp/pb1.txt` préparé (journal `wget` réel, progression jusqu'à 100 %) ; `Label`/`ProgressBar` créés par le test | `hpb.Value` = 1, `pb1.txt` supprimé | `tests/avancement/` | implémenté |

## Détail des tests

- **Valeurs attendues** : produites en exécutant les mêmes appels dans le clone **Laurux non
  modifié** (T01-T03, T07) ou capturées par replay (T04-T06).
- **gb.test et formulaire** : `RecupVersion`/`RecupVersionApp`/`Avancement` sont des méthodes d'un
  `Form` ; le module `.test` doit tourner avec un composant graphique (affichage virtuel `xvfb`),
  à confirmer en début de phase 2. T02/T03 requièrent `Utils.db` connecté à la base Docker.
- **Réseau** : l'URL `https://www.laurux.fr/…` est en dur ; T05/T06 dépendent d'une redirection
  DNS et d'un certificat de test (à confirmer). À défaut, ils sont joués manuellement.
- **Non testable automatiquement** : `Maj` (remplacement réel de l'exécutable, `Quit`), le
  téléchargement réel depuis le site.

## Implémentation (phase 2)

- gb.test : `.src/Tests/Communs/MajversionTest.test` (T01, T02, T03, T07), auto-instance du formulaire non
  affichée (Xvfb du runner). T03 : `/Majver` = 0, contenu de `~/tmp` inchangé.
- T07 : `assets/MajversionTest/pb1_wget.txt` = journal réel `wget --progress=dot` (LANG=fr_FR.UTF-8, 300 000
  octets servis par un serveur HTTP local), copié dans `~/tmp/pb1.txt` ; `Label`/`ProgressBar` créés dans une
  `Window` du test. `hpb.Value` = 1, dernière ligne du journal dans `hlb`, `pb1.txt` supprimé.
