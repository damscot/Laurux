# SaisieInvT — Tests

> Source : `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (inventaire)** : la liste des scénarios ci-dessous est **à faire valider par
> l'utilisateur avant la phase 2** (PLAN.md §0 et §4.5). Elle reprend les scénarios de SaisieInv
> sur `Fiches_InvT` et ajoute les cas propres à cette variante.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAISIEINVT-T01 | replay | Ouverture et affichages | inventaire tournant généré (GENINVT-T02) ; saisis / non saisis | log grille ; dump inchangé | `tests/affichage/` | à faire |
| SAISIEINVT-T02 | replay | Saisie par n° de ligne | n° renumérotés par l'impression (GENINVT-T10) | `inv_qtecomptee`, `inv_comptee = 1` | `tests/saisie_numero/` | à faire |
| SAISIEINVT-T03 | replay | Saisie par code | code, `art_cequ`, réf. centrale, `*codebarre` | lignes comptées | `tests/saisie_code/` | à faire |
| SAISIEINVT-T04 | replay | Codes invalides / article hors plage | article stocké hors de la plage tournante | « absent du fichier inventaire » | `tests/saisie_invalide/` | à faire |
| SAISIEINVT-T05 | replay | Ressaisie : cumuler | réponse « 1 » | somme | `tests/doublon_cumul/` | à faire |
| SAISIEINVT-T06 | replay | Ressaisie : remplacer | réponse « 2 » | remplacement | `tests/doublon_remplace/` | à faire |
| SAISIEINVT-T07 | replay | Rappel (double-clic) puis correction | double-clic sur une ligne après une saisie | ligne rechargée : figer `Item` vs `Current` (A08) | `tests/rappel_correction/` | à faire |
| SAISIEINVT-T08 | replay | Rappel puis abandon | double-clic puis Quitter | comptage remis à 0 (figé A01) | `tests/rappel_abandon/` | à faire |
| SAISIEINVT-T09 | replay | Suppression | Suppr + Oui / Non | `DELETE` de la ligne (figé A02) | `tests/suppression/` | à faire |
| SAISIEINVT-T10 | replay | Quantités | invalide, décimales virgule/point, `art_dec` 0/2/3 | normalisation | `tests/quantites/` | à faire |
| SAISIEINVT-T11 | replay | Import portable nominal | fichier valide | lignes comptées | `tests/import_ok/` | à faire |
| SAISIEINVT-T12 | replay | Import avec rejets et quantité vide | lignes `code;` (quantité vide), code inconnu, déjà compté | `~/tmp/Inv.txt` ; comportement de `cle <> 0` figé (A10) | `tests/import_rejets/` | à faire |
| SAISIEINVT-T13 | replay | Import, fichier absent | pas de fichier | erreur non gérée figée (A09) | `tests/import_absent/` | à faire |
| SAISIEINVT-T14 | replay | Sans inventaire tournant | `Fiches_InvT` absente (après ValidinvT) | message et fermeture | `tests/sans_inventaire/` | à faire |
| SAISIEINVT-T15 | replay | Article supprimé après génération | idem SAISIEINV-T15 | erreur figée (A04) | `tests/article_supprime/` | à faire |
| SAISIEINVT-T16 | gbtest | Parseur d'import | fichiers de T11/T12 | (code, quantité) et rejets | `tests/import_parse/` | à faire (après SAISIEINVT-005) |

## Détail des tests

- Valeurs attendues générées dans le clone **Laurux non modifié** ; données `Laurux01.sql` +
  `invt_genere.sql` ; fichiers portables produits par `gen_input.py` (partagés avec SaisieInv).
- `Colinv` sans `Colinv_Click` et sans rappel par Entrée : T07/T08 exigent un double-clic
  (`Activate`) ; s'il n'est pas journalisé par `ReplayObserver`, ces deux tests restent manuels
  jusqu'à REPLAYOBSERVER-A06.
- Écran instrumenté par `Utils.Observers` dans `_New`.
