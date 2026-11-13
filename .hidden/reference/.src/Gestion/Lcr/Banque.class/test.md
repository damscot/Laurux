# Banque — Tests

> Source : `.src/Gestion/Lcr/Banque.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI de saisie. `Utils.Observers(Me)` n'est pas appelé : les replays supposent l'ajout de cet
appel dans les **deux** clones (BANQUE-A04) ou un pilotage direct par le harnais. Jeu de données :
`Laurux01.sql` + 2 banques complètes dans `Fiches_Banques`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| BANQUE-T01 | replay | Ouverture, tri et filtre | ouverture ; clic `Inte` ; frappe « B » ; double clic `CO` | lignes `Exec_SQL` (`like "B%"`, `Desc`) | `tests/liste_filtre/` | implémenté (double clic Desc non rejouable) |
| BANQUE-T02 | replay | Consultation | clic sur une ligne de `ColBanque` | zones remplies (requête `banques_code = &1`) | `tests/consultation/` | implémenté |
| BANQUE-T03 | replay | Création | code `3`, toutes les zones, Valider | dump `Fiches_Banques` (nouvelle ligne, 16 colonnes) | `tests/creation/` | implémenté |
| BANQUE-T04 | replay | Modification | sélection, changement du mail et de la fin d'enregistrement `Ws`, Valider | dump `Fiches_Banques` | `tests/modification/` | implémenté (mail sans « @ », non rejouable) |
| BANQUE-T05 | replay | Suppression | sélection, Supprimer, Oui | dump `Fiches_Banques` ; `Fiches_Lcr` inchangée (références orphelines) | `tests/suppression/` | implémenté |
| BANQUE-T06 | replay | Code vide | Valider sans code | message « VOUS DEVEZ D'ABORD… », base inchangée | `tests/code_vide/` | implémenté |
| BANQUE-T07 | replay | Saisie d'un code existant | nouvelle fenêtre, frappe d'un code existant, sortie de zone | fiche chargée (`banques_man`) | `tests/code_existant/` | implémenté |
| BANQUE-T08 | replay | Filtre avec guillemet | frappe `"` dans `CO` | message d'erreur SQL (caractérisation BANQUE-A03) | `tests/filtre_guillemet/` | implémenté (code_sortie 125, BANQUE-A03) |

## Détail des tests

- Valeurs attendues capturées dans le clone **Laurux non modifié** ; dump normalisé de
  `Fiches_Banques` (et `Fiches_Lcr` pour T05).
- T03/T04 vérifient aussi le double enregistrement éventuel (Entrée sur « Valider » : `KeyPress` +
  `Click`) par le nombre de lignes `Exec_SQL` `INSERT`/`UPdate`.
- La sortie standard contient `ok` à chaque clic d'onglet (`TabStrip1_Click`) : à ignorer ou à
  figer dans le test qui clique les onglets.
- Non testable automatiquement : `Doc.Open("Banques")` (navigateur externe), `Music.Play`.

### Implémentation (phase 2, vague 5)
- Jeu partagé `.hidden/Tests/Gestion/assets/banque_shared/banque_deux.sql` (banques 1 et 2 complètes).
- Scénarios `.hidden/Tests/Gestion/assets/banque_<nom>/` (`liste_filtre`, `consultation`, `creation`,
  `modification`, `suppression`, `code_vide`, `code_existant`, `filtre_guillemet`). `Utils.ReplayObservers(Me)`
  est présent dans les deux clones (BANQUE-A04 levée pour les tests).
- Le caractère « @ » coupe la ligne du journal de rejeu : les mails saisis sont sans « @ ».
- Observé (T04) : la zone `siren` a `MaxLength = 5` alors que `banques_numsiren` est en `varchar(15)` ;
  une modification tronque le SIREN existant à 5 caractères (figé, candidat anomalie).
