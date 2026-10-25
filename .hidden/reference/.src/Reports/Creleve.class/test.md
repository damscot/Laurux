# Creleve — Tests

> Source : `.src/Reports/Creleve.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CRELEVE-T01 | gbtest | En-tête société et destinataire | `Entete` avec tous les champs, puis avec seulement `rs`/adresse (autres `""`) ; `Entete2` (pays vide / « Belgique ») ; `glogo` désactivé | texte `pdftotext` de référence (ordre site puis courriel) | `tests/entetes/` | à faire |
| CRELEVE-T02 | gbtest | Logo | `glogo` actif avec une image PNG 200 × 100, puis une image de 5 pixels de large, puis un chemin inexistant | rendu raster de référence ; erreur de division par zéro figée pour l'image étroite (A02) ; pas de logo pour le chemin absent | `tests/logo/` | à faire |
| CRELEVE-T03 | gbtest | Relevé multi-pages | `AliasNbPages` ; `Entete`, `Entete2`, `Level1(…, "1")` puis `"2"`, `Level2`, 40 `Level3`, `Lines`, `Level4`, `Level9` sur 2 pages | « Relevé de facture/compte du … », `Page 1/2`, `Page 2/2` | `tests/releve/` | à faire |
| CRELEVE-T04 | gbtest | Lettre de relance | `Level5`, `Level6`, `Level7`, `Level8` avec un texte d'une ligne de 300 caractères et un texte à retours à la ligne | texte de référence (coupure à 294 mm, A01 figée) ; rendu raster | `tests/relance/` | à faire |
| CRELEVE-T05 | replay | Relevé de factures (`FRelFacture`) | `Laurux01.sql` + écritures clients non lettrées (jeu dérivé), un client sur 2 pages | `pdftotext` de `~/tmp/*.pdf` identique entre clones | `tests/replay_releve_factures/` | à faire |
| CRELEVE-T06 | replay | Lettres de relance (`FEditrel` / `Ligcli`) | jeu dérivé + `Fiches_relances` et textes `Fiches_Txt_Relances` | `pdftotext` de `~/tmp/Relances.pdf` identique ; dump BDD identique (colonne `relance` mise à jour par l'appelant) | `tests/replay_relances/` | à faire |

## Détail des tests

- **Outil commun** : extraction et normalisation des PDF (date, utilisateur, métadonnées) par le
  script commun `check_output.py` décrit dans [PdfWriter/test.md](../PdfWriter.class/test.md).
- **Valeurs attendues** : produites dans le clone **Laurux non modifié** (même module gb.test, mêmes
  scénarios) ; `expected/` contient le texte extrait et, pour T02/T04, les images `pdftoppm`.
- **Configuration** : `Laurux.conf` de test avec `/Soc01/glogo` et `/Soc01/Logo` pointant vers une
  image versionnée dans `tests/logo/data/`.
- **Données des replays** : jeu comptable dérivé de
  [Balance/test.md](../../Compta/Impressions/Balance.class/test.md) (comptes 411…, écritures non
  lettrées) ; scénarios de [FEditrel](../../Compta/Relances/FEditrel.class/test.md) et
  [FRelFacture](../../Compta/Relances/FRelFacture.class/test.md) à réutiliser.
- **Normalisation** : la date du courrier (`jour`, construite par l'appelant avec `Now`) est fixée
  par `faketime`.
- **Couverture visée** : 100 % hors `EnteteN` et `_free` (suppression prévue).
