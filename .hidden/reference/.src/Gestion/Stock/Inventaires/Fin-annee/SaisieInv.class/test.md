# SaisieInv — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (inventaire)** : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle,
> tests implémentés sans validation individuelle (PLAN.md §0 et §4.5). Elle vise une couverture maximale de la
> saisie des comptages de fin d'exercice.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAISIEINV-T01 | replay | Ouverture et affichages | inventaire généré (GENINV-T01) avec quelques comptages ; bascule saisis / non saisis | log de la grille ; dump inchangé ; écart affiché pour qté 0 = `+stock` (figé A03) | `tests/affichage/` | implémenté (gb.test `SaisieInvTest.T01…`) |
| SAISIEINV-T02 | replay | Saisie par n° de ligne | `Nl` ; n° 1, Entrée, qté, Enregistrer ; enchaînement ligne 2 | `inv_qtecomptee`, `inv_comptee = 1` des lignes 1-2 | `tests/saisie_numero/` | implémenté (gb.test `SaisieInvTest.T02…`) |
| SAISIEINV-T03 | replay | Saisie par code | `Ca` ; code article, code équivalent, réf. centrale, `*codebarre` | lignes correspondantes comptées | `tests/saisie_code/` | implémenté (gb.test `SaisieInvTest.T03…`) |
| SAISIEINV-T04 | replay | Codes invalides | n° de ligne inexistant ; code inconnu ; article non stocké (hors inventaire) | messages ; dump inchangé | `tests/saisie_invalide/` | implémenté (gb.test `SaisieInvTest.T04…`) |
| SAISIEINV-T05 | replay | Ressaisie : cumuler | ligne déjà comptée (5) + 3, réponse « 1 » | `inv_qtecomptee = 8` | `tests/doublon_cumul/` | implémenté (gb.test `SaisieInvTest.T05…`) |
| SAISIEINV-T06 | replay | Ressaisie : remplacer | idem, réponse « 2 » | `inv_qtecomptee = 3` | `tests/doublon_remplace/` | implémenté (gb.test `SaisieInvTest.T06…`) |
| SAISIEINV-T07 | replay | Rappel puis correction | Entrée sur une ligne de la grille, nouvelle qté, Enregistrer | nouvelle quantité en base | `tests/rappel_correction/` | implémenté (gb.test `SaisieInvTest.T07…`) |
| SAISIEINV-T08 | replay | Rappel puis abandon | Entrée sur une ligne, puis Quitter | comptage remis à 0, `inv_comptee = 0` (figé A01) | `tests/rappel_abandon/` | implémenté (gb.test `SaisieInvTest.T08…`) |
| SAISIEINV-T09 | replay | Suppression d'une ligne | Suppr + Oui ; Suppr + Non | ligne absente de `Fiches_Inv` (figé A02) ; inchangé | `tests/suppression/` | à faire : Key.Code (Colinv_Keypress lit Key.Code hors d'un événement clavier : non appelable en gb.test ; au rejeu, grille sans `Colinv_Click`) |
| SAISIEINV-T10 | replay | Quantités | `abc` (rejet), `2,5` / `2.5`, articles `art_dec` 0/2/3 | `Message.Error` ; quantités normalisées | `tests/quantites/` | implémenté (gb.test `SaisieInvTest.T10Quantites` ; « abc » refusé par le filtre du TextReg, `Message.Error` non atteint) |
| SAISIEINV-T11 | replay | Import portable nominal | `~/Portable/inventaire.txt` : codes-barres et codes article valides, quantités décimales | lignes comptées ; message « n produits importés » | `tests/import_ok/` | implémenté (gb.test `SaisieInvTest.T11…`) |
| SAISIEINV-T12 | replay | Import avec rejets | code-barres inconnu, ligne sans code, article déjà compté, ligne sans `;` | `~/tmp/Inv.txt` (contenu comparé) ; rejet « Déjà saisit » trompeur figé (A06) | `tests/import_rejets/` | implémenté (gb.test `SaisieInvTest.T12…`) |
| SAISIEINV-T13 | replay | Import, fichier absent | pas de `~/Portable/inventaire.txt` | message d'erreur ; dump inchangé | `tests/import_absent/` | implémenté (gb.test `SaisieInvTest.T13…`) |
| SAISIEINV-T14 | replay | Sans inventaire | `Fiches_Inv` absente | message et fermeture (comportement exact à figer) | `tests/sans_inventaire/` | implémenté (gb.test `SaisieInvTest.T14…`) |
| SAISIEINV-T15 | replay | Article supprimé après génération | ligne d'inventaire dont l'article n'existe plus | erreur à l'ouverture (figé A04) | `tests/article_supprime/` | implémenté (gb.test `SaisieInvTest.T15…`) |
| SAISIEINV-T16 | gbtest | Parseur d'import | fichiers d'exemple de T11/T12 | liste (code, quantité) et rejets | `tests/import_parse/` | à faire (après SAISIEINV-005 : extraction du parseur) |

## Détail des tests

- **Implémentation (vague 9)** : module gb.test `.src/Tests/Gestion/SaisieInvTest.test` (prévu en replay) : écran
  instancié sans affichage, `Nseq`/`Cart`/`qtecomptee` posés puis `Nseq_LostFocus`, `Cart_LostFocus`,
  `qtecomptee_LostFocus`, `Colinv_Activate` (ligne rendue courante par `Key` + `MoveTo`) appelés ; Enregistrer, Quitter
  et Importer par `Value = True` suivi d'un `Wait` (clic différé à la boucle d'événements, `Btn_Click` lit `Last.Tag`) ;
  boîtes `Message.*` répondues par un Timer du module. Jeu `.hidden/Tests/Gestion/assets/saisieinv_shared/inv_saisie.sql`
  (6 lignes, ligne 1 comptée 5, ligne 3 comptée 0, code-barres, code équivalent, référence centrale) ; fichiers d'import
  `inventaire_ok.txt` et `inventaire_rejets.txt` du même répertoire copiés dans `~/Portable` ; T15 sur
  `geninv_shared/inv_gen_supprime`. T02 : la ligne 3 enchaînée étant déjà comptée, la question reçoit le premier bouton
  (« 1 », cumuler).

- Valeurs attendues produites dans le clone **Laurux non modifié** ; données : `Laurux01.sql` +
  inventaire généré (`inv_genere.sql`), fichiers `inventaire.txt` d'exemple créés par `gen_input.py`.
- **Grille sans `Colinv_Click`** (`replay_missing`) : ne jamais cliquer dans `Colinv` dans les
  scénarios ; utiliser Entrée (`Colinv_Keypress` → `Colinv_Activate`) et Suppr.
- `Nseq_LostFocus`/`Cart_LostFocus` ne sont pas levés à la souris : les scénarios saisissent avec
  Entrée/Tab (sinon la ligne n'est pas chargée, voir A07).
- Les questions (cumuler/remplacer, suppression) doivent être rejouées par le harnais.
- T16 n'est possible qu'après extraction du parseur dans une fonction `Public` (module
  `Inventaire` ou `Utils.LirePortable`).
