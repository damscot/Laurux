# Impart — Tests

> Source : `.src/Gestion/Stock/Tarifs/Impart.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe** (import d'articles et de tarifs) : la liste des scénarios ci-dessous est
> **à faire valider par l'utilisateur avant la phase 2** (options à couvrir, formats de fichier,
> anomalies à figer, en particulier la boucle infinie IMPART-A01 qui fige l'application).

Tests par **replay** de l'écran, avec comparaison du dump de `Fiches_Art`, `Fiches_CdBarre`,
`Fiches_Cequ`, `Fiches_EtiProd`, `Fiches_EtiGond` et du contenu de `~/tmp/Artnew.txt` /
`Artmaj.txt`. Données : `Laurux01.sql` + définitions créées par IMPARTPARAM-T01/T02 + fichiers
`tests/<nom>/tarif.csv` (séparateur `;`, UTF-8) et `tarif.txt` (largeur fixe), une vingtaine de
lignes : articles existants (par code, code-barre, réf. fournisseur, réf. centrale), nouveaux
articles, prix fournis ou non, remises 1 à 4, ligne incomplète en fin de jeu dédié.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPART-T01 | replay | Maj des prix, mode séparé, prix brut | définition `S` choisie dans la liste, `MajPrix`, `Tbrut` | dump `Fiches_Art` (masquer `art_ddatefbt`), `Artmaj.txt` | `tests/majprix_sep/` | à faire |
| IMPART-T02 | replay | Création d'articles | `MajPrix` + `Creation`, articles absents, colonne code article absente (départ `dnart`) | dump `Fiches_Art`, `Fiches_CdBarre`, `Artnew.txt` | `tests/creation/` | à faire |
| IMPART-T03 | replay | Mode largeur fixe, prix net | définition `F`, `Tnet`, taux de change 1,1 | dump `Fiches_Art` | `tests/majprix_fixe_net/` | à faire |
| IMPART-T04 | replay | Future base tarif | `MajFtbt`, date D | dump `art_pbfbt`/`art_datefbt` ; enchaîner MAJFBTARIF2-T01 | `tests/future_base/` | à faire |
| IMPART-T05 | replay | Options de mise à jour | `Majdesg`, `MajCbarre`, `MajCequ` (A04), `Majpvcons`, `MajCoeff` | dump `Fiches_Art`, `Fiches_Cequ`, `Fiches_CdBarre` | `tests/options/` | à faire |
| IMPART-T06 | replay | Codes équivalents / codes-barres | `MajZones`, fichiers `code;équivalent` et `code;code-barre` | dump `Fiches_Cequ`, `Fiches_CdBarre`, `art_cequ`, `art_cbarre` | `tests/maj_equ/` | à faire |
| IMPART-T07 | replay | Zones diverses | `MajZones2` (réf. liée, mini, maxi, casier, poids, stocké) | dump `Fiches_Art` | `tests/maj_divers/` | à faire |
| IMPART-T08 | replay | Centrale et réf. fournisseur | `centrale` + code centrale ; `MajRefour` | dump `art_centrale`, `art_refcentrale`, `art_cfour` | `tests/centrale_reffour/` | à faire |
| IMPART-T09 | replay | Définition saisie au clavier (A01) | n° de définition tapé dans `Cdef` sans la liste, `MajPrix` | blocage (délai de garde du runner) : caractérisation | `tests/def_clavier/` | à faire |
| IMPART-T10 | replay | Fournisseur = code d'article (A02) | fournisseur dont le code existe comme `art_code` | aucune ligne importée, message dans `Artmaj.txt` | `tests/four_code_article/` | à faire |
| IMPART-T11 | replay | Ligne courte, état résiduel (A06, A07) | fichier dont une ligne a moins de champs ; champs absents d'une ligne à l'autre | erreur ou valeurs reprises (caractérisation) | `tests/ligne_courte/` | à faire |
| IMPART-T12 | replay | Second import (A08) | T02 rejoué deux fois sans modifier `dnart` | articles non créés au second passage, sans trace | `tests/second_import/` | à faire |
| IMPART-T13 | replay | Fichier vide / absent (A03) et `~/tmp` absent (A10) | chemin vide ; `HOME` sans `tmp` | messages et erreurs (caractérisation) | `tests/fichier_absent/` | à faire |
| IMPART-T14 | replay | Encodage | fichier ISO-8859-1 avec accents | dump `art_design` (fige l'absence de conversion) | `tests/encodage/` | à faire |
| IMPART-T15 | replay | SQLite | T01 et T02 sur base SQLite (`left(…)` traduit) | dump de référence | `tests/sqlite/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié**, `HOME` de test dédié
  (comptes rendus dans `$HOME/tmp`), colonnes volatiles masquées (`art_ddatefbt`).
- **Rejeu** : `Form_Open` appelle `Utils.Observers(Me)` **deux fois** : les événements peuvent être
  journalisés en double ; vérifier à la capture que le rejeu ne déclenche pas deux fois les
  handlers (sinon, scénarios à adapter ou IMPART-A12 à traiter d'abord). `FamList_Click`,
  `fourList_Click`, `DefList_Click` sont appelés dynamiquement. Les éditeurs ouverts en fin
  d'import (`Editeur.Prog_Editeur`) et la question d'impression doivent être fermés par le scénario.
- **T09** bloque l'application : le runner doit tuer le processus après un délai et ne comparer
  que l'état de la base.
- **gb.test** : aucun avant le découpage d'`Import` (méthodes d'une `Form`) ; après IMPART-004,
  `AffecteChamp` et la chaîne de prix deviennent testables unitairement.
- **Non couvert** : `Button4_MouseDown` (inatteignable), `Controle`, `InitCode`, `TrC` (morts).
