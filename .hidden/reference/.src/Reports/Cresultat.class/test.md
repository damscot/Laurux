# Cresultat — Tests

> Source : `.src/Reports/Cresultat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CRESULTAT-T01 | gbtest | Niveaux et formatage | `Level0`, `Level3`, `Level1` (`p5` vide puis `"X"` ; montants `"1234"`, `"1234.56"`, `"-5"`, `""`), `Level7`, `Level2`, `BasPage` | texte `pdftotext` de référence (chaîne brute pour `"1234.56"`, A01 figée ; `p5` imprimé deux fois) | `tests/niveaux/` | à faire |
| CRESULTAT-T02 | gbtest | Multi-pages | `AliasNbPages`, 2 × (`Level0`, `Level3`, 44 `Level1`, `BasPage`) | `Page 1/2`, `Page 2/2` | `tests/multipages/` | à faire |
| CRESULTAT-T03 | replay | Compte de résultat (`RubImp`, bouton d'impression du résultat) | jeu comptable dérivé (classes 6 et 7 avec centimes), avec et sans détail des comptes | `pdftotext` de `~/tmp/Resultat.pdf` identique entre clones | `tests/replay_resultat/` | à faire |

## Détail des tests

- **Outil commun** : extraction et normalisation des PDF (date, utilisateur, métadonnées) par le
  script commun `check_output.py` décrit dans [PdfWriter/test.md](../PdfWriter.class/test.md).
- **Valeurs attendues** : générées dans le clone **Laurux non modifié** ; `expected/` contient le
  texte extrait.
- **Locale** : `fr_FR.UTF-8` (`Val` localisé, voir [Csig/test.md](../Csig.class/test.md)).
- **Normalisation** : date et `User.Name` du pied de page.
- **Données** : jeu dérivé de [Balance/test.md](../../Compta/Impressions/Balance.class/test.md) ;
  le scénario de `RubImp` est décrit dans [RubImp/test.md](../../Compta/Impressions/RubImp.class/test.md).
- **Couverture visée** : 100 %.
