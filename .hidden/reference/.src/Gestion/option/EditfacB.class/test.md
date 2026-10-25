# EditfacB — Tests

> Source : `.src/Gestion/option/EditfacB.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`EditfacB` est un état (report) : il est testé par la **sortie PDF** produite via
`ObjFacB.visualisation` (pas d'écriture en base). La comparaison porte sur le texte extrait
(`pdftotext -layout`) et le nombre de pages / l'orientation (`pdfinfo`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITFACB-T01 | replay | Sans option ou document non boisson | option `N` ; option `B` avec un BL sans alcool ni consigne | PDF identique à `Editfac` (portrait) | `tests/etat_standard/` | à faire |
| EDITFACB-T02 | replay | BL non chiffré boisson | option `B`, `blchif` faux, articles consignés | colonnes « Colis »/« Pal » et valeurs | `tests/etat_bl_non_chiffre/` | à faire |
| EDITFACB-T03 | replay | Facture boisson | option `B`, consignes P/C/B, régies A/V/B, déconsignes, frais de gestion | paysage ; colonnes, bandeau des frais, totaux, lignes de déconsigne | `tests/etat_facture_boisson/` | à faire |
| EDITFACB-T04 | replay | Lignes de déconsigne et volumes (A01) | facture éditée avec `Fiches_ligregie` et déconsignes | valeurs V.E/A.P des lignes de déconsigne (figées) | `tests/etat_deconsignes/` | à faire |

## Détail des tests

- **Données** : jeu `facturation_boisson` (voir [ObjFacB/test.md](../ObjFacB.class/test.md)).
- **Valeurs attendues** : PDF produits dans le clone Laurux **non modifié**, date figée ; seules
  les dates d'impression éventuelles sont masquées dans le texte comparé.
- **gbtest** : non retenu, la construction du report exige gb.report et un `ObjFacB` calculé ;
  à réévaluer en phase 2 (création possible sans affichage).
