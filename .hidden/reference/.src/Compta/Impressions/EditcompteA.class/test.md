# EditcompteA — Tests

> Source : `.src/Compta/Impressions/EditcompteA.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran avec impression intégrée : tests `replay` depuis le menu Analytiques > Comptes. Le PDF
`~/tmp/Extrait.pdf` est capturé (script `/Soc01/caisse/CmdVis`), converti par `pdftotext -layout` et
normalisé (date d'édition et utilisateur du pied de page). Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITCOMPTEA-T01 | replay | Ouverture et bornes d'exercice | ouverture (date fixée), `E1`, `N1`…`N5`, `E0` | `dteN0`/`dteN1`, `cpt`/`cpt2` (`60000`/`69999999`) | `tests/bornes_exercice/` | implémenté (gb.test `EditcompteATest.T01BornesExercice` : écran instancié, gestionnaires appelés ; date du jour masquée) |
| EDITCOMPTEA-T02 | replay | Prétraitement des dates saisies | `dteN0` = `12`, `1.2`, `1210`, `12.10`, `121025`, `12.10.25` (Entrée) | texte obtenu (A03 figée : année perdue pour `121025`) | `tests/saisie_dates/` | implémenté (gb.test `EditcompteATest.T02SaisieDates` : A03 confirmée, 121025 → 12.10.<année courante> ; « 1.2 » non saisi : résultat selon le mois courant, Message.Error en décembre) |
| EDITCOMPTEA-T03 | replay | Impression avec écritures analytiques | compte 6… ventilé (`Fiches_Analytiques`) avec écritures `Fiches_MvtA` dans la période | comportement actuel figé : erreur « Not enough arguments » sur `level4C` (A01, à confirmer), pas de PDF | `tests/impression_mouvemente/` | implémenté (erreur fatale « Not enough arguments » ligne 726, level4C : A01 confirmée, code_sortie 125 figé ; Ctrlnc recréée) |
| EDITCOMPTEA-T04 | replay | Comptes ventilés sans écriture | compte ventilé sans `Fiches_MvtA` dans la période | message « Aucune ecriture pour cette demande » | `tests/sans_ecriture/` | implémenté (Compta/editcomptea_sans_ecriture, jeu editcomptea_ventile) |
| EDITCOMPTEA-T05 | replay | Aucun compte | plage sans compte de la nature | message « Aucune ecriture… » | `tests/aucun_compte/` | implémenté |
| EDITCOMPTEA-T06 | replay | Exercice N-1 | `N1` puis **Imprimer** sur une période N-1 | lecture de `Fiches_MvtA` (A02 figée) : message ou PDF selon le jeu | `tests/exercice_n1/` | implémenté (Compta/editcomptea_exercice_n1, jeu editcomptea_mvta1 : écritures 2017 dans Fiches_MvtA1, lecture de Fiches_MvtA, A02 figée) |
| EDITCOMPTEA-T07 | replay | Nature bilan et `TriCpt` | `Bbilan`, F2 sur `cpt` | plage `10000`/`99999999`, `TriCpt` en mode `Bilan` | `tests/bilan_tricpt/` | implémenté pour la partie Bbilan (gb.test `EditcompteATest.T07Bbilan` : 10000/99999999, puis Bgestion 60000/79999999) ; à faire : F2/TriCpt (TriCpt ouvert en ShowModal par Button4_Click, F2 non rejouée) |
| EDITCOMPTEA-T08 | replay | Fermeture | T04 puis **Quitter** ; puis impression réussie (après correction A01) puis **Quitter** | `~/tmp/Extrait.pdf` supprimé à la fermeture s'il existe | `tests/fermeture/` | à faire : suppression de ~/tmp/Extrait.pdf non observable sans PDF produit (A01) ; non scénarisé |

## Détail des tests

- **Données** : jeu dérivé commun aux éditions comptables (voir [Balance](../Balance.class/test.md))
  complété par `Fiches_Analytiques` (ventilation de 2 comptes de gestion), des écritures
  `Fiches_MvtA` (dont un compte centralisé) et `Fiches_MvtA1` pour T06.
- **T03** est le test clé : il établit dans le clone non modifié si l'impression analytique échoue
  réellement (A01). Si Gambas interrompt l'application sur cette erreur non interceptée, le replay
  enregistre la sortie et le code retour ; le scénario s'arrête là.
- **Base** : l'impression écrit `Ctrlnc` (DROP/CREATE à chaque compte mouvementé) : le dump final est
  comparé (y compris `Ctrlnc`).
- **Non testable automatiquement** : son, coloration du focus, aide HTML, curseur `Mouse.Pointing`.

- **Phase 2 (agent 3, vague 3)** : scénarios `.hidden/Tests/Compta/assets/editcomptea_<nom>/`
  (`impression_mouvemente`, `aucun_compte`), jeu `editcomptea_impression_mouvemente/editcomptea_mvta.sql`
  (607000 ventilé A01 100 %, 2 écritures Fiches_MvtA 2018). T03 : erreur fatale reproduite dans le clone non
  modifié (`EditcompteA.Button1_Click.726: #4: Not enough arguments`, appel `pdf.level4C(totdeb, totcred,
  totsld, Posy)`), `"code_sortie": 125`.
- **Vague 7** : module `.src/Tests/Compta/EditcompteATest.test` (T01, T02) : `New EditcompteA` sans affichage, `/Coul/Focus` posé, contrôles `DteN0`/`Dten1`/`Cpt`/`Cpt2` ; T02 porte `dteclec` au 31.12.2099 et choisit E1 pour qu'aucune date saisie ne sorte de la période (Message.Warning bloquant en gb.test).
