# Edbl — Tests

> Source : `.src/Gestion/Impressions/Edbl.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` : texte de `~/tmp/BonReception.pdf` (`pdftotext -layout`), lignes `Exec_SQL`, dump
normalisé (GED si `fo_copie`). Ils servent aussi de tests d'[`Edbr`](../Edbr.module/test.md).
Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDBL-T01 | replay | Numéro + Entrée | numéro de BR existant dans `Nbl`, Entrée | PDF du BR | `tests/numero_entree/` | xfail : Edbr.Ed.190 Type mismatch avant le PDF (code 125 figé) |
| EDBL-T02 | replay | Numéro inexistant | numéro absent, Entrée | message « Ce numéro de bon n'existe pas ! » | `tests/numero_inexistant/` | implémenté |
| EDBL-T03 | replay | Choix dans la liste | `ToggleButton1`, clic sur une ligne, Imprimer | PDF du BR choisi (date texte transmise) | `tests/choix_liste/` | xfail : Edbr.Ed.190 Type mismatch avant le PDF (code 125 figé) |
| EDBL-T04 | replay | Réimpression d'un autre numéro | T03 puis numéro d'un BR d'un autre fournisseur tapé dans `Nbl`, Imprimer | « Aucun mouvement » (fournisseur mémorisé, A01 figée) | `tests/autre_numero/` | à faire : la première impression (T03) s arrête sur l erreur fatale Edbr.Ed.190, réimpression impossible |
| EDBL-T05 | replay | Tri des colonnes | focus successif sur `Nm`, `Cd`, `Nr`, `Dt`, `Mt` (deux fois) | ordre des lignes de `Colbl` (log des contrôles) | `tests/tri_colonnes/` | implémenté |
| EDBL-T06 | replay | Fermeture de la liste au clavier | Entrée puis Échap dans `Colbl` | `Mt` reste visible (A03 figée) | `tests/clavier_liste/` | implémenté (gb.test `EdblTest.T06FermetureListe` : `ToggleButton1_Click` puis `cache_bl`, seul traitement de la branche Échap ; `Mt` reste visible, A03 figée ; l'affectation de `Nbl` par Entrée, écrite dans `Colbl_KeyPress`, n'est pas atteinte : `Key.Code` non simulable) |
| EDBL-T07 | replay | Numéro partagé | même `numrecpt` pour deux fournisseurs, Entrée | BR du premier fournisseur trouvé (A02 figée) | `tests/numero_partage/` | xfail : Edbr.Ed.190 Type mismatch (code 125 figé) ; premier fournisseur 401001 retenu (A02 visible dans sql.log) |

## Détail des tests

- **Données** : jeu `editions_gestion` (voir [Edbr](../Edbr.module/test.md)) : réceptions de trois
  fournisseurs, dont un numéro partagé (T07).
- **Rejeu** : `Colbl_Click` existe (pas de `replay_missing`) ; tri déclenché par `GotFocus` des
  `TextBox` d'en-tête — à vérifier que `ReplayObserver` rejoue le focus.
- **Implémentation (vague 5)** : scénarios `.hidden/Tests/Gestion/assets/edbl_<nom>/` ; jeu `edbl_shared/edbl_receptions.sql`
  (R002 chez 401002, R001 partagé par 401001 et 401002). Toute impression d'un BR s'arrête dans `Edbr.Ed` ligne 190 :
  `paht` formaté « 10,00 » reçoit une espace (ligne 189) puis `Val(paht)` renvoie Null → « Type mismatch: wanted
  Number, got Null » (erreur fatale, code 125 figé, aucun PDF). Candidat anomalie Edbr.
- **Non testable automatiquement** : son.
