# ExportJdv — Tests

> Source : `.src/Compta/Utils/ExportJdv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests **replay** (menu Comptabilité > Outils > Export des journaux, `/Exp` vrai). Chaque scénario
saisit explicitement les dates (pour ne pas dépendre de la date du jour), le journal et le format,
puis compare :
- les **fichiers produits**, normalisés (`ecritures<JJ>.<ext>`, `clients.txt|.pnc`,
  `JDV<date>.<ext>`) : fins de ligne et `\r` conservés mais rendus visibles, encodage
  (windows-1252 pour Ciel/Winner) vérifié, aucune date volatile dans le contenu ;
- le **dump normalisé** de `Fiches_Mvt` (colonne `export`) et de la table `centralisations` ;
- les réglages `/Soc<XX>/Dte_exprt`, `Dte2_exprt`, `Numdoc_exprt` du `Laurux.conf` de test.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXPORTJDV-T01 | replay | Format 1 « Fichier texte » | `Laurux01.sql`, journal VE, période d'un mois, non exportées | `ecrituresVE.csv`, `clients.txt`, `JDV….csv` ; `export = '1'` | `tests/format1_texte/` | à faire |
| EXPORTJDV-T02 | replay | Format 2 « Quadra » | idem | fichier de référence (montant écrit deux fois, figé) | `tests/format2_quadra/` | à faire |
| EXPORTJDV-T03 | replay | Format 3 « Ciel » | idem | `.txt` windows-1252 de référence | `tests/format3_ciel/` | à faire |
| EXPORTJDV-T04 | replay | Format 4 « CCMX Winner » | idem | `.txt` de référence (compteur figé) | `tests/format4_winner/` | à faire |
| EXPORTJDV-T05 | replay | Format 5 « Cador » | idem | enregistrements `1`/`2`/`3` de référence | `tests/format5_cador/` | à faire |
| EXPORTJDV-T06 | replay | Format 6 « Sage », tous clients avec `cli_sage` | `/Soc01/Sage` vrai, codes Sage renseignés | `ecrituresVE.pnm`, `clients.pnc` ; copie `JDV….txt` absente (figé, A05) | `tests/format6_sage/` | à faire |
| EXPORTJDV-T07 | replay | Sage avec clients sans `cli_sage` (A04) | un client du journal sans code Sage | liste écrite dans `ecritures*.pnm`, message, aucun `export = '1'` | `tests/sage_controle/` | à faire |
| EXPORTJDV-T08 | replay | Ré-export | T01 puis nouvel export « non exportées », puis « ensemble des écritures » | message « Aucune écriture… » puis fichier complet | `tests/reexport/` | à faire |
| EXPORTJDV-T09 | replay | Erreurs de saisie | journal inexistant, code vide, chemin inaccessible | messages ; réglages et copie `cp` tout de même exécutés (figé, A05) | `tests/erreurs_saisie/` | à faire |
| EXPORTJDV-T10 | replay | Journal déséquilibré (A01) | base dérivée : une écriture VE à débit ≠ crédit | export réalisé sans message (figé) | `tests/desequilibre/` | à faire |
| EXPORTJDV-T11 | replay | Journal sans ligne collectif, formats 4 et 6 (A03) | base dérivée : journal OD sans collectif | message « Aucune écriture » malgré les lignes écrites et marquées (figé) | `tests/sans_collectif/` | à faire |
| EXPORTJDV-T12 | replay | Saisie des dates | dates partielles `05`, `05.03`, date hors période, fin < début, E0/E1 | textes des champs et messages de référence | `tests/saisie_dates/` | à faire |
| EXPORTJDV-T13 | replay | Intitulé de collectif avec apostrophe (A08) | compte collectif `Clients d'Europe` | erreur SQL attrapée par le `Catch`, export interrompu (figé) | `tests/apostrophe_collectif/` | à faire |
| EXPORTJDV-T14 | gbtest | Fonctions de ligne par format (après EXPORTJDV-009) | lignes `Fiches_Mvt` de T01-T06 en entrée | chaînes identiques aux lignes des fichiers de référence | `tests/lignes_formats/` | à faire |
| EXPORTJDV-T15 | replay | Aller-retour avec ImpJdv | fichiers de T01 importés dans une seconde base | voir IMPJDV-T06 | `tests/aller_retour_impjdv/` | à faire |
| EXPORTJDV-T16 | replay | Export format 4 CCMX Winner (A11) | journal avec au moins une écriture non collectif, format 4 | figer le comportement actuel : erreur « Too many arguments » attendue à `ExportJdv.class:758`, fichier partiel | `tests/format4_ccmx/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites en phase 2 dans le clone **Laurux non modifié**, sur
  `Laurux01.sql` (MariaDB jetable) ou un jeu dérivé (T10, T11, T13 : une écriture ajoutée par
  script SQL). Les fichiers sont comparés après normalisation par `check_output.py` (pas de
  comparaison de date du jour : les dates sont saisies dans le scénario).
- **Ajustement d'arrondi** : prévoir dans T01 une écriture dont le solde résiduel est < 0,03 pour
  figer le report sur débit/crédit.
- **Envoi par courriel** (`Envoi` coché, `export()`) : non testable automatiquement sans serveur
  SMTP ; à couvrir par un replay manuel ou un `EnvMail` simulé (hors périmètre).
- **`chmod`/`cp`** : vérifier les droits `666` et la présence de la copie `JDV<date>.<ext>`.
- T07, T09, T10, T11, T13 sont des tests de caractérisation d'anomalies.
- **T14** n'existe qu'après l'extraction des fonctions de ligne (`Public` dans un module, ou
  testées via une fonction publique).
