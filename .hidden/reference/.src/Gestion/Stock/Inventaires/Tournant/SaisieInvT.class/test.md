# SaisieInvT — Tests

> Source : `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (inventaire)** : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle,
> tests implémentés sans validation individuelle (jeu `saisieinvt_shared/invt`, générateur `gen_saisieinvt.py`). Elle reprend les scénarios de SaisieInv
> sur `Fiches_InvT` et ajoute les cas propres à cette variante.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAISIEINVT-T01 | replay | Ouverture et affichages | inventaire tournant généré (GENINVT-T02) ; saisis / non saisis | log grille ; dump inchangé | `tests/affichage/` | implémenté (gb.test `SaisieInvTTest.T01Affichage` : contenu de Colinv saisis / non saisis) |
| SAISIEINVT-T02 | replay | Saisie par n° de ligne | n° renumérotés par l'impression (GENINVT-T10) | `inv_qtecomptee`, `inv_comptee = 1` | `tests/saisie_numero/` | implémenté (`Gestion/saisieinvt_saisie_numero`) |
| SAISIEINVT-T03 | replay | Saisie par code | code, `art_cequ`, réf. centrale, `*codebarre` | lignes comptées | `tests/saisie_code/` | implémenté (`Gestion/saisieinvt_saisie_code` : code, `art_cequ`, réf. centrale ; gb.test `SaisieInvTTest.T03CodeBarre` : `*codebarre` par `Fiches_CdBarre` et repli sur `art_code`, `Cart_LostFocus` appelé directement car son `Wait 0.2` bloque le rejeu, REPLAYOBSERVER-A18) |
| SAISIEINVT-T04 | replay | Codes invalides / article hors plage | article stocké hors de la plage tournante | « absent du fichier inventaire » | `tests/saisie_invalide/` | implémenté (`Gestion/saisieinvt_saisie_invalide`) |
| SAISIEINVT-T05 | replay | Ressaisie : cumuler | réponse « 1 » | somme | `tests/doublon_cumul/` | implémenté (`Gestion/saisieinvt_doublon_cumul`) |
| SAISIEINVT-T06 | replay | Ressaisie : remplacer | réponse « 2 » | remplacement | `tests/doublon_remplace/` | implémenté (`Gestion/saisieinvt_doublon_remplace`) |
| SAISIEINVT-T07 | replay | Rappel (double-clic) puis correction | double-clic sur une ligne après une saisie | ligne rechargée : figer `Item` vs `Current` (A08) | `tests/rappel_correction/` | implémenté (gb.test `SaisieInvTTest.T07RappelCorrection` : `Colinv_Activate` appelé directement, curseur et ligne courante sur la même ligne, puis `Valigne`) ; à faire : double-clic réel et cas Item ≠ Current (A08) |
| SAISIEINVT-T08 | replay | Rappel puis abandon | double-clic puis Quitter | comptage remis à 0 (figé A01) | `tests/rappel_abandon/` | implémenté (gb.test `SaisieInvTTest.T08RappelAbandon` : comptage remis à 0 en base, A01 figée) |
| SAISIEINVT-T09 | replay | Suppression | Suppr + Oui / Non | `DELETE` de la ligne (figé A02) | `tests/suppression/` | à faire : touche Suppr vers la ColumnView `Colinv` (Key.Code, non rejouée) |
| SAISIEINVT-T10 | replay | Quantités | invalide, décimales virgule/point, `art_dec` 0/2/3 | normalisation | `tests/quantites/` | implémenté (`Gestion/saisieinvt_quantites` : « 2,5 » `art_dec` 0 → 3.00 ; `Gestion/saisieinvt_quantites_dec` : `art_dec` 3 « 1.2345 » → 1.24 (colonne decimal(12,2)), `art_dec` 2 « 2,555 » → 2.56) ; à faire : saisie invalide (lettres refusées par l'expression régulière du TextReg avant `qtecomptee_LostFocus` : message « saisie erronée » non atteignable au clavier) |
| SAISIEINVT-T11 | replay | Import portable nominal | fichier valide | lignes comptées | `tests/import_ok/` | implémenté (`Gestion/saisieinvt_import_ok`) |
| SAISIEINVT-T12 | replay | Import avec rejets et quantité vide | lignes `code;` (quantité vide), code inconnu, déjà compté | `~/tmp/Inv.txt` ; comportement de `cle <> 0` figé (A10) | `tests/import_rejets/` | implémenté (`Gestion/saisieinvt_import_rejets` : « 002; » compté à 0, A10 figée ; `~/tmp/Inv.txt` et `@ouvrir.trace`) |
| SAISIEINVT-T13 | replay | Import, fichier absent | pas de fichier | erreur non gérée figée (A09) | `tests/import_absent/` | xfail (`Gestion/saisieinvt_import_absent` : code 125, Eof sur fichier non ouvert, A09) |
| SAISIEINVT-T14 | replay | Sans inventaire tournant | `Fiches_InvT` absente (après ValidinvT) | message et fermeture | `tests/sans_inventaire/` | implémenté (`Gestion/saisieinvt_sans_inventaire`) |
| SAISIEINVT-T15 | replay | Article supprimé après génération | idem SAISIEINV-T15 | erreur figée (A04) | `tests/article_supprime/` | xfail (`Gestion/saisieinvt_art_supprime_ouverture` : code 125 SaisieInvT.class:73 ; `Gestion/saisieinvt_art_supprime_ligne` : code 125 SaisieInvT.class:179 ; A04) |
| SAISIEINVT-T16 | gbtest | Parseur d'import | fichiers de T11/T12 | (code, quantité) et rejets | `tests/import_parse/` | à faire (après SAISIEINVT-005 : extraction du parseur) |

## Détail des tests

- Valeurs attendues générées dans le clone **Laurux non modifié** ; données `Laurux01.sql` +
  `invt_genere.sql` ; fichiers portables produits par `gen_input.py` (partagés avec SaisieInv).
- `Colinv` sans `Colinv_Click` et sans rappel par Entrée : T07/T08 exigent un double-clic
  (`Activate`) ; s'il n'est pas journalisé par `ReplayObserver`, ces deux tests restent manuels
  jusqu'à REPLAYOBSERVER-A06.
- Écran instrumenté par `Utils.Observers` dans `_New`.
