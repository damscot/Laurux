# Edinv — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDINV-T01 | replay | Fin d'exercice, familles sur 2 niveaux | `inv_saisi.sql` ; `/Soc01/ipr` = 2 niveaux ; menu 85 ; « Imprimer » | texte du PDF : lignes comptées par famille, sous-totaux remontés aux parents, total | `tests/edition_fin/` | à faire |
| EDINV-T02 | replay | Inventaire tournant | `invt_saisi.sql` ; menu 99 | idem sur `Fiches_InvT` | `tests/edition_tournant/` | à faire |
| EDINV-T03 | replay | Sans inventaire | table absente (F et T) | message puis comportement de `ed.Show` figé (A02) | `tests/sans_inventaire/` | à faire |
| EDINV-T04 | replay | Article hors arbre de familles | article compté avec `art_fam` absente de `Fiches_Fam` | article absent de l'édition et du total (figé A01) | `tests/hors_famille/` | à faire |
| EDINV-T05 | replay | Pagination et en-têtes | > 45 lignes comptées | en-tête des pages suivantes `Me.Text & date` (figé A03) | `tests/pagination/` | à faire |
| EDINV-T06 | replay | Décimales | `art_dec` 0/2/3, `art_nbd` 0/2/3 | formats et valeurs | `tests/decimales/` | à faire |
| EDINV-T07 | replay | Aucune ligne comptée | inventaire non saisi | PDF avec totaux à zéro (cas « aucun article » commenté) | `tests/vide/` | à faire |

## Détail des tests

- Critère : texte du PDF (`pdftotext -layout`, dates masquées) produit dans le clone Laurux non
  modifié ; dump inchangé ; la sortie standard (trace `Print`) est ignorée.
- Configuration de test : `/Soc01/ipr` obligatoire (sinon `Trifam` quitte l'application).
- Données : inventaires saisis issus des scénarios SAISIEINV/SAISIEINVT ; jeu dérivé
  `famille_orpheline.sql` pour T04.
