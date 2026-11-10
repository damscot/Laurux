# Variables — Tests

> Source : `.src/Utils/Variables.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module sans fonction : le comportement à préserver est celui des écrans qui échangent des valeurs.
Les valeurs attendues sont capturées dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VARIABLES-T01 | gbtest | Initialisation depuis les réglages | `Laurux.conf` de test, société `01`, `/Soc01/Sprix`, `Sexport`, `SMaj*`, `Schmprix`, `/son` renseignés | valeurs des 8 variables | `tests/init_reglages/` | implémenté |
| VARIABLES-T02 | replay | `Tricp` → `Facture` (`codepostal`, `Bureaudistributeur`, `Bsel`) | `Facture`, recherche de code postal, sélection | champs CP/ville remplis ; `Fiches_Cpostaux` inchangée | `tests/replay_tricp_facture/` | à faire : scénario dans Facture (module complexe, PLAN §4 étape 5 : liste à valider par l'utilisateur) |
| VARIABLES-T03 | replay | `TriFac`/`TriFac2` → `Facture` (`numeroFac`, `Bsel`) | rappel d'une facture existante de `Laurux01.sql` | facture affichée identique | `tests/replay_trifac/` | à faire : scénario dans Facture (module complexe, PLAN §4 étape 5) |
| VARIABLES-T04 | replay | `TriEqu` → `Facture` (`$Codearticle`) | ajout d'une ligne par la recherche d'équivalence | ligne ajoutée ; `Fiches_Ligbl` comparée | `tests/replay_triequ/` | à faire : scénario dans Facture (module complexe, PLAN §4 étape 5) |
| VARIABLES-T05 | replay | `Articles` → `CoefTypeC` (`ArtCode`, `ArtHt`…) | fiche article, bouton coefficients par type de client | valeurs affichées ; `Fiches_CoeffTypec` comparée | `tests/replay_coeftypec/` | à faire : fiche Articles → CoefTypeC non synthétisé dans ce lot |
| VARIABLES-T06 | replay | `bRemise` → `Cdocuments` | impression d'une facture avec et sans remise (`Facture`, `Facturergbl`) | PDF texte comparé (`pdftotext`) | `tests/replay_bremise/` | à faire : comparaison de PDF non prise en charge par le runner |
| VARIABLES-T07 | replay | `sTexte` → `ObjFacB` | `FClient` / `ComMail`, envoi de facture par mail (option bois) | texte du courriel capturé (serveur SMTP factice) | `tests/replay_stexte/` | à faire : serveur SMTP factice absent du runner |

## Détail des tests

- T01 tourne en gb.test : le module de test lit `Variables.*` après avoir chargé un `Laurux.conf`
  dédié (`-c`). Il fige aussi le comportement « valeur figée au premier accès » (changement de
  réglage après le premier accès : valeur inchangée).
- T02 à T07 sont des scénarios log/replay sur `Laurux01.sql` ; la comparaison porte sur les tables
  citées et sur les captures d'écran textuelles du log.
- Non testable : `TBord` (`son`, `Musique`) ne produit que du son.
- Implémentation : `.src/Tests/Utils/VariablesTest.test` (`T01InitReglages` et complément `T01bSansReglage` : réglages absents). Réglages écrits dans la copie de `Laurux-test.conf` du HOME temporaire.
