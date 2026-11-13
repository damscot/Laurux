# Etiqfbtarif — Tests

> Source : `.src/Gestion/Etiquettes/Etiqfbtarif.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` en lecture seule (PDF normalisé `~/tmp/EtiqGond.pdf`) et, après séparation du calcul,
`gbtest` sur le prix. Références capturées dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIQFBTARIF-T01 | replay | Impression nominale | menu ; date `art_datefbt` du jeu ; tri fournisseur ; prix brut | PDF (prix recalculés) | `tests/etiqfbtarif_nominal/` | implémenté |
| ETIQFBTARIF-T02 | replay | Prix net et tris | `Prix_achat` ; tris famille et casier | PDF | `tests/etiqfbtarif_net_tris/` | implémenté |
| ETIQFBTARIF-T03 | replay | Arrondis | articles `art_cdarr` = 0,05 / 0,10 / 0,50 / 1,00 / vide | prix TTC figés | `tests/etiqfbtarif_arrondis/` | implémenté (couvert par etiqfbtarif_nominal : arrondis 0,05 / 0,10 / 0,50 / 1,00 / vide) |
| ETIQFBTARIF-T04 | replay | Planche de plusieurs rangées | 40 articles, planche 3 × 8 | nombre de pages et positions figés (A01) | `tests/etiqfbtarif_pages/` | implémenté |
| ETIQFBTARIF-T05 | replay | Prix au kg/l HT et TTC | `RadioButton5`/`6`, articles avec/sans poids | PDF | `tests/etiqfbtarif_kgl/` | implémenté |
| ETIQFBTARIF-T06 | replay | Zebra / aucune date | `Impetiq = "2- Zebra"` ; date sans article | « Null object » figé ; pas de PDF ni message (A02) | `tests/etiqfbtarif_erreurs/` | implémenté |
| ETIQFBTARIF-T07 | gbtest | Calcul de prix (après ETIQFBTARIF-003) | tables de cas (pbfbt, remise, txconv, frais, coef, TVA, arrondi, brut/net) | `Pvht`/`PvTTC` relevés dans le clone non modifié | `tests/etiqfbtarif_prix/` | à faire : après extraction ETIQFBTARIF-003 (calcul de prix dans la Form) |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé de ≈ 40 articles avec `art_datefbt` à une date fixe et
  des paramètres de prix variés (remise, conversion, frais, coefficients, codes TVA, arrondis).
- **Rejeu** : un seul `Utils.Observers(Me)` ; `DateChooser1` piloté par la zone `Date` ; pas de
  grille. Pour T07, les valeurs de référence sont produites en appelant les fonctions actuelles
  (après passage temporaire en `Public` dans le clone de référence, ou par extraction du PDF de T03).
- **Non testable** : imprimante physique, visionneuse, aide.

### Implémentation (phase 2)
- Jeu partagé `.hidden/Tests/Gestion/assets/etiqfbtarif_shared/etiqfbtarif_base.sql` (001, 002, 003, 010, 011 au
  15.06.2018 avec remise, conversion, frais, coefficients, TVA 1/2/3, arrondis 0,05 / 0,10 / 0,50 / 1,00 / vide, poids ;
  012 à une autre date) ; jeu `etiqfbtarif_pages` (40 articles).
- Scénarios `.hidden/Tests/Gestion/assets/etiqfbtarif_{nominal,net_tris,pages,kgl,zebra,sans_article}/` (Menu242, date
  15.06.2018, modèle 2 - Gondole, texte des PDF par pdftotext dans `edition.txt`).
- T02 (prix net) : chaque génération ouvre une boîte d'erreur (`Catch` de `Prix_achat`, acquittée par Entrée) avant
  « Traitement terminé » ; l'article 011 garde les prix de l'article précédent et sa TVA non formatée (« 20.00 ») :
  comportement figé (candidat anomalie).
- T06 : `etiqfbtarif_zebra` (code de sortie 125, `Null object` ligne 127) et `etiqfbtarif_sans_article` (date sans
  article : ni PDF ni message, `compare_sql_log` ordered).
