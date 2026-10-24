# SupprArt — Tests

> Source : `.src/Gestion/SupprArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SUPPRART-T01 | replay | Mode sélection (familles, fournisseurs, date) | jeu dérivé : articles de familles et fournisseurs variés (dont les bornes exactes), un article vendu après `Dte1`, un article en BL en cours, un article stocké avec stock ≠ 0 ; Supprimer → Supprimer | dump de `Fiches_Art` et des tables du tableau d'architecture identique ; contenu de `~/tmp/Artsuppr.txt` (fige A01, A02, A03) | `tests/mode_selection/` | à faire |
| SUPPRART-T02 | replay | Mode suspendus | mêmes données, `art_suspendu = 1` sur une partie | idem T01 | `tests/mode_suspendus/` | à faire |
| SUPPRART-T03 | replay | Liste manuelle | création de la liste, saisie par code, code fournisseur, code-barre, doublon, code inconnu ; Supprimer | table `Artsup` (contenu après traitement, A04), dump des tables articles, messages | `tests/liste_manuelle/` | à faire |
| SUPPRART-T04 | replay | Liste existante : compléter / remplacer | `Artsup` non vide à l'ouverture du mode liste ; choix 1 puis choix 2 | `Artsup` vidée ou complétée | `tests/liste_existante/` | à faire |
| SUPPRART-T05 | replay | Fichier texte | fichier de 4 codes (dont un inconnu et une ligne vide) | dump identique ; rapport | `tests/mode_fichier/` | à faire |
| SUPPRART-T06 | replay | Annulation | Supprimer → Sortir | aucune modification de la base ; `~/tmp/Artsuppr.txt` tronqué (comportement actuel) | `tests/annulation/` | à faire |
| SUPPRART-T07 | replay | Orphelins après suppression | article présent dans `Fiches_PrdComp`, `Fiches_Tarcli`, `Fiches_CdFour`, `Fiches_Rpl1.coderpl1`, `Fiches_Mvtexpdc` | fige A05 : lignes orphelines conservées | `tests/orphelins/` | à faire |

## Détail des tests

- **Valeurs attendues** générées dans le clone **Laurux non modifié** (dump normalisé de toutes
  les tables listées dans architecture.md, rapport texte, `Artsup`).
- **Données** : `Laurux01.sql` + jeu dérivé ajoutant des articles et leurs références (BL en
  cours, factures archivées datées avant/après `Dte1`, commandes, réceptions non validées,
  matériels, tickets, tarifs, produits composés, remplaçants).
- **Rejeu** : le constructeur n'appelle pas `Utils.Observers(Me)` ; si les événements ne sont pas
  journalisés, les replays exigent l'ajout de cet appel dans les **deux** clones (SUPPRART-A06)
  ou un pilotage direct par le harnais.
- **Fichiers** : le harnais isole `HOME` (rapport `~/tmp/Artsuppr.txt`) et ignore l'ouverture de
  l'éditeur externe (`Editeur.Prog_Editeur`).
- **SQLite** : `art_Suppr` utilise `DELETE IGNORE`/`SHOW TABLES` ; les replays sont limités à
  MariaDB.
