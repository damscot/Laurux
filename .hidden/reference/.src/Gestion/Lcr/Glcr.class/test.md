# Glcr — Tests

> Source : `.src/Gestion/Lcr/Glcr.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI rejouable (`Utils.Observers(Me)` dans `_New`). Jeu de données dérivé de `Laurux01.sql` :
2 banques dans `Fiches_Banques`, une dizaine de LCR dans `Fiches_Lcr` couvrant écartée/non écartée,
banque 0/1/2, codes entrée 0/1/5, bordereau 0/1/2, échéances variées, avec les clients
correspondants dans `Fiches_Cli`. Ne pas cliquer dans `ColLcr` (pas de `ColLcr_Click`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GLCR-T01 | replay | Ouverture | menu LCR › Impression / suppression LCR | liste par défaut (toutes, `bordereau <> 1`) ; lignes `Exec_SQL` ; `BQ` vide (A01 figée) | `tests/ouverture/` | à faire |
| GLCR-T02 | replay | Filtre écartées | radios `E1` puis `E2` | requêtes `ecartee = 1`/`0` dans le log | `tests/filtre_ecartees/` | à faire |
| GLCR-T03 | replay | Filtre attribuées | `A1` puis saisie d'un code entrée | requête par banque vide (A01) ; caractérisation | `tests/filtre_attribuees/` | à faire |
| GLCR-T04 | replay | Filtre non attribuées | `A2` | message d'erreur SQL `andand` (A02 figée) | `tests/filtre_non_attribuees/` | à faire |
| GLCR-T05 | replay | Filtre échéance | `cd1`, dates `Ech1`/`Ech2`, combinaisons `T1`/`E1` | SQL émis (A03/A04 figées) | `tests/filtre_echeance/` | à faire |
| GLCR-T06 | replay | Impression | filtre « Toutes », bouton Imprimer | `~/Lcr.pdf` comparé par `pdftotext` (date figée) ; colonnes décalées (A05) | `tests/impression/` | à faire |
| GLCR-T07 | replay | Suppression des LCR affichées | filtre `E1`, Supprimer, Oui | dump `Fiches_Lcr` (LCR écartées supprimées, y compris celles d'un bordereau) | `tests/suppression/` | à faire |
| GLCR-T08 | replay | Boutons sans handler | clic « Quitter », « Doc HTML » | aucun effet (A09 figée) | `tests/boutons_inactifs/` | à faire |

## Détail des tests

- Valeurs attendues capturées dans le clone **Laurux non modifié** (`./Laurux -l --logfile …`),
  `faketime` pour la date du PDF ; dump normalisé de `Fiches_Lcr`, `Fiches_Bordereaux`.
- Le diff des lignes `Exec_SQL` est le critère principal des tests de filtre (T02-T05) : la base
  n'est pas modifiée.
- Si l'écriture de `Item[9]` lève une erreur (à confirmer), T01 fige le message affiché et T07
  ne supprime rien : le test documente le comportement observé.
- SQLite : mêmes scénarios sur la base `Laurux01.sqlite` (comparaisons de dates en texte).
