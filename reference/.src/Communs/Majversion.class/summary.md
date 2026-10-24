# Majversion — Synthèse

> Source : `.src/Communs/Majversion.class` · Synthèse des autres documents.

## Rôle

Double rôle : écran de **mise à jour en ligne** de Laurux (index HTTP `www.laurux.fr`, comparaison
avec `Stable/version.txt`, téléchargement `wget` et extraction `tar` de `Laurux.tar.gz`) et
**service de version** appelé sur l'auto-instance du formulaire : `RecupVersion` (version de la
base, `Fiches_Parametres.version`, variable `Public Version`) et `RecupVersionApp`
(`"majeur.mineur"` de l'exécutable).

## Points clés

- `RecupVersion` est appelé à chaque démarrage (`Fmenu`) et peut lancer `Verif_Maj` (réseau) si
  `/Majver` est actif ; `LauruxMaj` l'utilise pour diagnostiquer une migration en échec.
- `Verif_Maj` (CC 21) : logique `ping.txt` morte, comparaison sur le seul mineur.
- `Avancement` suit le journal `wget` par positions de colonnes, avec attente active.
- URL du site en dur : tests réseau dépendants d'une redirection (à confirmer).

## Dépendances principales

- Utilisé par : `Fmenu` (démarrage, menu 173), `Caisse/Preferences`, `LauruxConf` (`Version`),
  `LauruxMaj` (`Version`, `RecupVersion`, `RecupVersionApp`).
- Utilise : `Utils.db` (`Fiches_Parametres`), `Start.LocalSettings["/Majver"]`, `gb.net.curl`,
  `gb.xml.html`, `wget`, `tar`.

## Risques

- Version majeure ignorée (A01) ; erreurs non interceptées hors ligne (A02, A04) ; index hors
  bornes sur une version à deux composants (A03).
- Boucle infinie / CPU à 100 % pendant le téléchargement (A05) ; extraction dans `~` (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 294 |
| Lignes de commentaire | 16 |
| Fonctions | 13 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 70 |
| Complexité max (fonction) | 21 (`Verif_Maj`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 4 `gbtest` (`RecupVersionApp`, `RecupVersion` avec et sans contrôle réseau,
`Avancement` sur un journal `wget` préparé) et 3 replays de l'écran (hors ligne, serveur simulé,
comparaison de versions). `Maj` n'est pas testable automatiquement.

## Rework

8 étapes (MAJVERSION-001 à 008) : documentation, code mort, helper de lecture d'index HTTP,
réutilisation de `RecupVersionApp` par `FRestore`, comparaison de versions pure, lecture SQL
isolée, réduction de portée, simplification de `Maj`. 7 anomalies (MAJVERSION-A01 à A07).
