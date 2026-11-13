# MajFbtarif2 — Tests

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif2.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran à un seul traitement (`Button2_Click`) : tests par **replay** sur la base Docker, avec
comparaison du dump de `Fiches_Art`, `Fiches_EtiProd`, `Fiches_EtiGond`. Le jeu dérivé de
`Laurux01.sql` contient une dizaine d'articles avec `art_pbfbt`/`art_datefbt` renseignés :
arrondis `art_cdarr` différents, `art_nbd` 0/2/3, taux de conversion ≠ 1, frais, remise, stock
nul et positif, `art_etiq` vrai/faux.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MAJFBTARIF2-T01 | replay | Mode prix brut (`prix_base`) | menu Future base tarif > Maj, date D, articles sans étiquette ni stock | dump `Fiches_Art` (prix, coefficient, `art_pbfbt`/`art_datefbt` vidés, `art_ddatefbt` masqué) | `tests/brut/` | implémenté |
| MAJFBTARIF2-T02 | replay | Étiquettes et verrou (A02) | date D, articles `art_etiq = 1` et stock > 0 | MySQL : erreur après le 1er article concerné (caractérisation), état des tables ; SQLite : étiquettes créées | `tests/etiquettes_verrou/` | implémenté (MySQL ; volet SQLite : voir T06) |
| MAJFBTARIF2-T03 | replay | Mode prix net (`Prix_achat`) | `Tnet`, date D, taux de conversion 1,5 et frais non nuls | dump `Fiches_Art` (fige l'effet de `Val` sans `cpoint`) | `tests/net/` | implémenté |
| MAJFBTARIF2-T04 | replay | Date vide (A01) | T01 exécuté, puis nouveau lancement avec date vide | dump `Fiches_Art` (fige la remise à zéro des prix des articles déjà traités) | `tests/date_vide/` | implémenté |
| MAJFBTARIF2-T05 | replay | Aucune ligne | date sans article | message « Aucune mise à jour… », dump inchangé | `tests/aucun_article/` | implémenté |
| MAJFBTARIF2-T06 | replay | SQLite | T01 et T02 sur la base SQLite (`LOCK` neutralisé) | dump de référence SQLite | `tests/sqlite/` | à faire : le runner ne prend pas en charge de base SQLite (besoin d'outillage) |
| MAJFBTARIF2-T07 | gbtest | Chaîne de calcul (après commonalisation `LTarifCalc`) | jeu des articles de T01/T03 passé à `LTarifCalc` | mêmes prix que les dumps de T01/T03 | `tests/calcul_tarif/` | à faire : après commonalisation LTarifCalc (MAJFBTARIF2-004) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (`./Laurux -l --logfile`),
  colonnes volatiles masquées (`art_ddatefbt`).
- **`sql_mode`** : la base Docker doit être en `NO_ENGINE_SUBSTITUTION` comme en production
  (Laurux le force), sinon l'`UPDATE … art_pbfbt = ''` échoue en mode strict.
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` une seule fois ; l'écran est modal ; les
  boîtes `Message.Warning`/`Message.Info` doivent être acquittées par le scénario.
- **gb.test** : les fonctions de calcul sont des méthodes d'une `Form` (non instanciable sans
  GUI) : T07 n'est possible qu'après l'extraction `LTarifCalc` (MAJFBTARIF2-004).
- **Export serveur** : les drapeaux `Variables.Sprix/Sexport/SMajArt` restent faux (pas de fichier
  d'échange à comparer).

### Implémentation (phase 2)
- Jeux `.hidden/Tests/Gestion/assets/majfbtarif2_shared/majfbtarif2_base.sql` (001-003 au 15.06.2018, sans étiquette
  ni stock ; 002 avec conversion 1,5 et frais 0,40) et `majfbtarif2_etiquettes_verrou/majfbtarif2_etiquettes_verrou.sql`.
- Scénarios `.hidden/Tests/Gestion/assets/majfbtarif2_{brut,etiquettes_verrou,net,date_vide,aucun_article}/` (Menu246).
- T02 : erreur fatale figée (code 125) dans `Maj_Etiqp` (DB_Connection.Exec, Fiches_EtiProd hors LOCK TABLES) après la
  mise à jour de 002 ; 003 non traité.
- T03 : chaque article lève une erreur dans `Prix_achat` (`Val` sans `cpoint` sur « 1.5 », « 0.4 », « 1.8 ») : 3 boîtes
  d'erreur acquittées, prix NULL/partiels figés.
- T04 : la date vide donne `art_datefbt = NULL` (aucune ligne) et « Aucune mise à jour » : pas de remise à zéro observée.
