# ExportA47 — Tests

> Source : `.src/Compta/Impressions/ExportA47.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Le FEC est un **format réglementaire** : chaque test compare le fichier produit à une référence
**octet par octet**, après une normalisation limitée au **nom du répertoire** de sortie (le contenu
n'est pas transformé : fins de ligne `\r\n`, espaces de bourrage, séparateur décimal et `|` final
sont comparés tels quels). Tests de type **replay** sur l'écran ; après EXPORTA47-005
(`GenereFEC`), les mêmes jeux pourront être rejoués en `gbtest`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXPORTA47-T01 | replay | FEC définitif, exercice précédent | `EN`, période complète antérieure à `dtepc`, écritures validées avec `numerodef` | fichier `<SIREN>FEC<fin>-<début>` identique à la référence ; message de succès | `tests/fec_definitif/` | à faire |
| EXPORTA47-T02 | replay | FEC provisoire | période dont la fin dépasse `dtepc` | numérotation `numero` | `tests/fec_provisoire/` | à faire |
| EXPORTA47-T03 | replay | Champs réglementaires manquants | écritures sans `numerodef`, sans libellé, journal sans libellé | valeurs `Err:…` dans le fichier ; message listant les numéros (tronqué à ~20 caractères) | `tests/fec_erreurs/` | à faire |
| EXPORTA47-T04 | replay | Règles de lignes | collectifs, lignes à débit et crédit, lignes à zéro, écritures non validées | collectifs, zéros et non validées absents ; montants compensés | `tests/fec_regles_lignes/` | à faire |
| EXPORTA47-T05 | replay | Dates de ligne | `datee` et `dteval` nulles ou renseignées | `EcritureDate`/`ValidDate` selon la règle de repli sur `dte` | `tests/fec_dates/` | à faire |
| EXPORTA47-T06 | replay | Caractères spéciaux et longueurs | libellés avec `'`, `é`, `ô`, retour ligne ; intitulé de 40 caractères avec apostrophe ; `numdoc` de 10 caractères | octets de référence (`\'`, `ô` → `e`, A08 figée ou erreur capturée) | `tests/fec_caracteres/` | à faire |
| EXPORTA47-T07 | replay | Compte absent du plan comptable | écriture sur un compte supprimé | message d'abandon puis erreur Gambas, fichier partiel (A01 figée) | `tests/fec_compte_absent/` | à faire |
| EXPORTA47-T08 | replay | Annulation | annuler la barre de progression à mi-parcours (≥ 1 500 lignes) | fichier tronqué et message de succès (A03 figée) | `tests/fec_annulation/` | à faire |
| EXPORTA47-T09 | replay | Choix de période | `EC`, `EN`, `E1`…`E5` avec `dteclec*` de référence, date système figée | `DteN0`/`Dten1` de référence (`EC` : A02 figée) | `tests/fec_periodes/` | à faire |
| EXPORTA47-T10 | replay | Contrôle des dates | début avant `dte1`, fin après `dte2`, calendrier | avertissements et remise aux bornes ; pas d'export | `tests/fec_controle_dates/` | à faire |
| EXPORTA47-T11 | replay | Dernier jour avec heure non nulle | écriture datée `<fin> 14:00:00` | ligne absente (A07 figée, à confirmer) | `tests/fec_heure/` | à faire |
| EXPORTA47-T12 | replay | Préférences | choisir un répertoire, saisir une adresse, Quitter, rouvrir | `Chemin-export`/`Adr-export` restaurés ; case « Envoi par Mail » sans effet (A06) | `tests/fec_preferences/` | à faire |
| EXPORTA47-T13 | replay | Base SQLite | T01 sur la base SQLite dérivée | fichier identique à T01 (ou écart figé) | `tests/fec_sqlite/` | à faire |
| EXPORTA47-T14 | replay | Performance | 50 000 lignes | durée et nombre de requêtes de référence (`gbx3 -p`, log `Exec_SQL`) | `tests/fec_perf/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : export dans le clone **Laurux non modifié**, base Docker
  importée du jeu dérivé, `Laurux.conf` de test (`-c`, `/Soc01/Chemin-export` vers le répertoire
  du test) ; le fichier produit est copié dans `tests/<nom>/expected/`. Les deux clones sont
  rejoués avec la même locale (`LANG=fr_FR.UTF-8`, séparateur décimal `,`) : la locale est
  enregistrée dans le test car elle change les octets produits.
- **`check_output.py`** : `cmp` strict entre `expected/<SIREN>FEC…` et le fichier produit, plus
  vérification du nom de fichier ; en cas d'écart, diff champ par champ (`|`) pour le rapport.
- **Données** : `Laurux01.sql` ne contient aucune écriture et un `siret_sc` à vérifier : jeu
  dérivé jeu dérivé commun (Balance) (au moins 3 journaux, collectifs 401/411, écritures validées et non
  validées, `numerodef` nul, `datee`/`dteval` nuls, libellés accentués et apostrophes, une
  écriture sur compte absent, un exercice antérieur dans `Fiches_Mvt1`), SIREN renseigné.
- **Date système** : `Ex1` utilise `Now` (figer avec `faketime`).
- **Non testable automatiquement** : ouverture de l'éditeur (répondre « Non »), aide, son ;
  la conformité réglementaire elle-même (outil « Test Compta Demat » de la DGFiP) est hors
  périmètre des tests de non-régression et relève des anomalies A04/A05.
