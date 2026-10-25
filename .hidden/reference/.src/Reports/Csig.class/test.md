# Csig — Tests

> Source : `.src/Reports/Csig.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit paysage sans accès à la base : tests gb.test directs (texte `pdftotext -layout`) et un
replay des SIG sur le jeu comptable dérivé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CSIG-T01 | gbtest | Page, en-têtes, filets | `Level0`, `Level3`, `Lines`, `Lines2`, `Lines3`, `BasPage` (paysage) | texte de référence ; rendu raster des filets | `tests/entetes/` | à faire |
| CSIG-T02 | gbtest | Formatage de `Level1`/`Level2` | montants `"1234"`, `"-1234"`, `"0"`, `""`, `"1234.56"`, `"1234,56"` | texte de référence (chaîne brute pour `"1234.56"`, A01 figée) | `tests/formatage_montants/` | à faire |
| CSIG-T03 | gbtest | Multi-pages | `AliasNbPages`, 2 pages (`Level0`, `Level3`, 30 `Level1`, `Lines3`, `BasPage`) | `Page 1/2`, `Page 2/2` | `tests/multipages/` | à faire |
| CSIG-T04 | replay | SIG complet (`RubImp` → `Imp_Sig`) | jeu comptable dérivé (classes 6 et 7, montants avec centimes) | `pdftotext` de `~/tmp/SIG.pdf` identique entre clones | `tests/replay_sig/` | à faire |

## Détail des tests

- **Outil commun** : extraction et normalisation des PDF (date, utilisateur, métadonnées) par le
  script commun `check_output.py` décrit dans [PdfWriter/test.md](../PdfWriter.class/test.md).
- **Valeurs attendues** : générées dans le clone **Laurux non modifié** (même module, même
  scénario), stockées dans `expected/`.
- **Locale** : `fr_FR.UTF-8` (vérifié avec gbs3 : `Val("1234.56")` = `Null`, `Format$(Null, …)` lève
  « Type mismatch », capturé par le `Try`).
- **Normalisation** : date et `User.Name` du pied de page.
- **Niveaux morts** : non testés (suppression CSIG-002) ; si l'utilisateur préfère les garder, un
  test de `Level1S` avec chaîne vide figerait l'erreur de la ligne 141.
- **Couverture visée** : 100 % des niveaux vivants.
