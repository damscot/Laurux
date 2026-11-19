# Edinv — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDINV-T01 | replay | Fin d'exercice, familles sur 2 niveaux | `inv_saisi.sql` ; `/Soc01/ipr` = 2 niveaux ; menu 85 ; « Imprimer » | texte du PDF : lignes comptées par famille, sous-totaux remontés aux parents, total | `tests/edition_fin/` | implémenté (`Gestion/edinv_edition_fin`, jeu `validinv_shared/inv_fin_partiel`) |
| EDINV-T02 | replay | Inventaire tournant | `invt_saisi.sql` ; menu 99 | idem sur `Fiches_InvT` | `tests/edition_tournant/` | implémenté (`Gestion/edinv_edition_tournant`, jeu `validinvt_shared/invt_partiel`) |
| EDINV-T03 | replay | Sans inventaire | table absente (F et T) | message puis comportement de `ed.Show` figé (A02) | `tests/sans_inventaire/` | implémenté (`Gestion/edinv_sans_inventaire`, jeu `validinvt_shared/invt_absent` ; code 125 figé) |
| EDINV-T04 | replay | Article hors arbre de familles | article compté avec `art_fam` absente de `Fiches_Fam` | article absent de l'édition et du total (figé A01) | `tests/hors_famille/` | implémenté (`Gestion/edinv_hors_famille`, jeu `ecarts_shared/inv_hors_famille`) |
| EDINV-T05 | replay | Pagination et en-têtes | > 45 lignes comptées | en-tête des pages suivantes `Me.Text & date` (figé A03) | `tests/pagination/` | implémenté (`Gestion/edinv_pagination`, jeu `ecarts_shared/inv_pagination`) |
| EDINV-T06 | replay | Décimales | `art_dec` 0/2/3, `art_nbd` 0/2/3 | formats et valeurs | `tests/decimales/` | implémenté (`Gestion/edinv_decimales`, jeu `ecarts_shared/inv_decimales`) |
| EDINV-T07 | replay | Aucune ligne comptée | inventaire non saisi | PDF avec totaux à zéro (cas « aucun article » commenté) | `tests/vide/` | implémenté (`Gestion/edinv_vide`, jeu `ecarts_shared/inv_non_compte`) |

## Détail des tests

- Critère : texte du PDF (`pdftotext -layout`, dates masquées) produit dans le clone Laurux non
  modifié ; dump inchangé ; la sortie standard (trace `Print`) est ignorée.
- Configuration de test : `/Soc01/ipr` obligatoire (sinon `Trifam` quitte l'application).
- Données : inventaires saisis issus des scénarios SAISIEINV/SAISIEINVT ; jeu dérivé
  `famille_orpheline.sql` pour T04.
- Mise en œuvre (vague 9) : scénarios `Gestion/edinv_*` (texte du PDF, `edition.txt`) ; T01 pose `/Soc01/ipr` = `[1, 2]` (liste JSON dans `conf`) pour obtenir 2 niveaux (0 > 01, 02, 03 ; 1 > 10, 11) ; jeux `validinv_shared`, `validinvt_shared` (lecture seule) et `ecarts_shared/*` ; T03 couvre le menu 85 (le menu 99 suit le même chemin).
