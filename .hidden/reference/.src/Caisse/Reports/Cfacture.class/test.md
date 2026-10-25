# Cfacture — Tests

> Source : `.src/Caisse/Reports/Cfacture.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de rendu PDF sans SQL : les tests `gbtest` appellent directement les primitives sur un
`New Cfacture("P", "mm", <format>)`, écrivent le PDF (`Output(fichier, False)`) et comparent un
PDF **normalisé** (suppression de `/CreationDate`, du texte date/heure et de `User.Name` du pied de
page) au PDF de référence produit par le même script dans le clone **Laurux non modifié**.
Ils nécessitent l'affichage (Xvfb) car `Caisse.Ba4` crée l'auto-instance d'un formulaire.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CFACTURE-T01 | gbtest | `_new` : formats | `a3`, `80mm`, `a4`, `a5`, `letter`, `legal`, puis `dymoc` | PDF d'une ligne `Entete` par format ; `dymoc` → texte d'erreur figé (A02) | `tests/cfacture_formats/` | à faire |
| CFACTURE-T02 | gbtest | Ticket A4 | séquence de `Defaut_Tk` : `Entete2`/`Entete`, `Entete3`, `Com`, `Level2T`, `Level1` (`Typel` `""`, `"K"`, `"TA"`, intitulé de 60 caractères) | PDF normalisé de référence | `tests/cfacture_ticket_a4/` | à faire |
| CFACTURE-T03 | gbtest | Ticket 80 mm | même séquence en `80mm` | PDF normalisé de référence | `tests/cfacture_ticket_80/` | à faire |
| CFACTURE-T04 | gbtest | Facture de caisse | `Lines`, `Entete2`, `Level2F`, `Lines2`, `Level4` en A4 et 80 mm | PDF normalisé de référence (troncature 28/40) | `tests/cfacture_facture/` | à faire |
| CFACTURE-T05 | gbtest | Livre de caisse | `Level3`, `Level2E`, `Level2`, `Lines2`, `BasPage` sur 2 pages | PDF normalisé (pied de page masqué) | `tests/cfacture_livre/` | à faire |
| CFACTURE-T06 | gbtest | Couplage `Caisse.Ba4` (A01) | `Level1`/`Level4` en A4 avec `Caisse.Ba4` laissé à `False`, puis forcé à `True` sur l'auto-instance | deux PDF distincts ; le premier est le comportement de production | `tests/cfacture_ba4/` | à faire |
| CFACTURE-T07 | gbtest | `Logo2` | `/caisse/logo` faux ; vrai + PNG existant (`fac`/`tk`, A4/80) ; vrai + fichier absent ; vrai + `.gif` | PDF de référence ; erreurs `PdfWriter.Image` figées (A03) | `tests/cfacture_logo2/` | à faire |
| CFACTURE-T08 | replay | Impression ticket depuis la caisse | `./Laurux -p`, vente de 2 articles, imprimante « DéfautA4 » puis « Défaut80 » | `~/Ticket.pdf` normalisé identique ; dump des tables de ticket identique | `tests/cfacture_replay_ticket/` | à faire |
| CFACTURE-T09 | replay | Livre de caisse | écran Moulinage, date du jeu de test, bouton livre de caisse | PDF `~/Caisse/Livre_caisse*.pdf` normalisé | `tests/cfacture_replay_livre/` | à faire |

## Détail des tests

- **Normalisation PDF** : script `check_output.py` commun aux classes `Inherits PdfWriter` (lot
  Reports) : décompression éventuelle des flux, suppression de `/CreationDate` et de la ligne
  produite par `BasPage`.
- **Données** : T01-T07 n'ont pas besoin de base (chaînes fixes) ; `Start.LocalSettings` est
  préparé dans un `Laurux.conf` de test (`/Soc01/caisse/logo`, `ilogo`). T08/T09 utilisent
  `Laurux01.sql` + un jeu `caisse_base` (caisse 1, vendeur, articles, tickets du jour), à partager
  avec les tests de `Caisse` et `Moulinage`.
- **Caisse** est un module complexe : les scénarios T08/T09 sont soumis à la validation de
  l'utilisateur avant génération (PLAN §0).
- **Non testable automatiquement** : l'impression physique (`Impression.Ticket`), le rendu visuel
  (seul le flux PDF est comparé).
- Couverture visée : 100 % des lignes après suppression de `Logo`/`Level1T` (CFACTURE-002).
