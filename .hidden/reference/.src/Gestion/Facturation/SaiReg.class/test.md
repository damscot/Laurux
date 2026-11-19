# SaiReg — Tests

> Source : `.src/Gestion/Facturation/SaiReg.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI qui écrit en comptabilité (via `EcrReg`) : tests `replay` depuis Gestion › Facturation ›
Saisie des règlements. Module complexe (écritures `Fiches_Mvt`, lettrage) : Décision utilisateur du 2026-11-18 : hors des
10 classes à revue manuelle, tests implémentés sans validation individuelle. Jeu `facturation_base`
([ObjFac.class/test.md](../ObjFac.class/test.md)) complété : règlements avec et sans compte
interne, avec `bordereaux`, `decaissement`, `caisse` ; écritures de vente non lettrées d'un
client ; un bordereau en cours sur un compte interne. Comparaisons : dump normalisé
(`Fiches_Mvt`, lettrage, soldes de `Fiches_Comptes`), texte des PDF (`EcrReg.pdf`,
`Bordereau.pdf`), journal de rejeu.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAIREG-T01 | replay | Saisie d'un règlement avec lettrage | règlement sans bordereau, client, coche de 2 factures (Espace), montant, Valider la ligne, Valider | écritures et lettrage (dump), PDF récapitulatif | `tests/saisie_lettrage/` | implémenté (scénario `Gestion/saireg_saisie_lettrage`) |
| SAIREG-T02 | replay | Modification et suppression dans le bordereau | double-clic sur une ligne, nouveau montant ; suppression d'une autre | états Mod/Sup ; dump après validation | `tests/modif_suppression/` | implémenté (gb.test `SaiRegTest.T02ModifSuppression` : double-clic non rejouable, `borderaux_Activate` appelé directement) |
| SAIREG-T03 | replay | Reprise et validation d'un bordereau | règlement `bordereaux` avec écritures en attente, Valider, date | écritures validées à la date saisie (dump) | `tests/bordereau/` | implémenté (gb.test `SaiRegTest.T03bReprise` et `T03Bordereau` : fenêtre de date validée par un Timer, voir Détail) |
| SAIREG-T04 | replay | Éditions | Éditer en mode Saisie puis Bordereau | texte de `Bordereau.pdf` (ajoutés / tous) | `tests/editions/` | implémenté (gb.test `SaiRegTest.T04Editions` : aiguillage et PDF produit ; texte gb.report illisible par pdftotext, contenu de l'état vérifié par EdRegTest) |
| SAIREG-T05 | replay | Décaissement refusé | montant négatif, règlement sans `decaissement` | message, aucune ligne ajoutée | `tests/decaissement/` | implémenté (scénario `Gestion/saireg_decaissement`) |
| SAIREG-T06 | replay | Filtres et recherche | lettrés / non lettrés / tous ; écritures / factures / BL ; recherche par document et par lot ; F2 client | contenu de `selection` | `tests/filtres/` | implémenté (scénario `Gestion/saireg_filtres` : requêtes de sélection comparées ; F2 client non rejouable, non joué ; contenu de la grille non comparé) |
| SAIREG-T07 | replay | Ouverture d'un document | double-clic sur un BL, une facture, une archive | `OptFac` ouvert sur le bon type (journal de rejeu) | `tests/ouverture_document/` | à faire : double-clic (Activate) non rejouable ; en gb.test `selection_Activate` ouvre `OptFac` en ShowModal, jeu Fiches_Bl/Fiches_HistoFac complet à construire |
| SAIREG-T08 | replay | Mode « Facture » depuis des BL | option BL, `SwitchSelec`, coche de 2 BL, Valider | tables de travail `Facturefm`/`Bl` ; édition fin de mois ; transaction laissée ouverte (A02 figée) | `tests/facture_depuis_bl/` | à faire : `Facture()` ouvre `OptFac` (fin de mois) en ShowModal ; jeu de BL Fiches_Bl complet à construire |
| SAIREG-T09 | replay | Mode caisse incrusté | édition d'une facture avec `/Rglt` actif (`ObjFacB.editef`) | règlement saisi, écritures ; fermeture par `win_close` | `tests/mode_caisse/` | à faire : mode caisse atteint par `ObjFacB.editef` (via OptFac, jeu de facture complet à construire) ou Moulinage (revue manuelle) |
| SAIREG-T10 | replay | Fermeture avec saisie en cours | ligne ajoutée puis fermeture, « Oui » puis « Non » | validation ou abandon (dump) | `tests/fermeture/` | implémenté (scénarios `Gestion/saireg_fermeture_oui` et `Gestion/saireg_fermeture_non` : fermeture par le bouton Sortie) |
| SAIREG-T11 | replay | Période close | date de règlement en période comptable close | message, focus sur la date | `tests/periode_close/` | implémenté (gb.test `SaiRegTest.T11PeriodeClose` : la boîte ouverte depuis `dtereg_LostFocus` n'est pas rejouable, Timer du module) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié, date figée (`faketime`) :
  `dtereg` vaut `LDate(Now)`, la sélection couvre ± 8 ans autour de `Now`.
- **`Listreg`** (ListView) n'est pas rejouable tant que REPLAYOBSERVER-A06 n'est pas validée :
  les scénarios saisissent le code règlement au clavier.
- La fenêtre de date du bordereau est construite dynamiquement (`Window` sans nom de classe
  propre) : vérifier en phase 2 que `ReplayObserver` capte ses contrôles, sinon T03 reste manuel.
- `RegCaisse` n'a pas de gestionnaire : A01 n'est observable qu'avec un gestionnaire de test
  (projet minimal), pas en replay.
- **Implémentation (phase 2, vague 9)** : jeux `.hidden/Tests/Gestion/assets/saireg_shared/` : `saireg_factures`
  (factures F100 120 € et F101 60 € non lettrées du client 411001, mai 2018) et `saireg_filtres` (+ F099 lettrée).
  Scénarios (fenêtre ouverte par le bouton `rglmt` de Fmenu, mode saisi au clavier, client 411001 puis Entrée, lignes
  de sélection cochées par `Click=<ligne>x1@selection`) : T01 (mode 05 « Saisie » : écritures 411001/411000/580002,
  lettrage des deux factures sous le lot L100), T05, T06, T10 (Oui : validation ; Non : Tab puis Espace, base
  inchangée). Fenêtre modale laissée ouverte en fin de rejeu (REPLAYOBSERVER-A15).
  gb.test `.src/Tests/Gestion/SaiRegTest.test` : écran instancié sans affichage, gestionnaires `Public` appelés
  directement ; dates des factures recalées à J-40/J-30 (la sélection couvre `Now` ± 8 ans et gb.test ne fige pas la
  date), dates relevées en écart au jour, date du libellé masquée, clés `control` seulement présentes/absentes.
  La fenêtre de date de `vldbordereau_Click` est une `Window` sans classe dont le nom automatique (« #48 ») contient
  le séparateur `#` du journal : non adressable au rejeu ; un Timer la ferme par `Close(0)` (= OK).
  T03b : mode 40 passé en « bordereaux » (cptint 580003) avec un règlement en attente : bordereau repris (« Val »),
  validation : contrepartie 580003 et banque 512000 du jour ; les lignes 580003 d'origine et de contrepartie ne sont
  pas lettrées (candidat anomalie : bordereau repris de nouveau à l'ouverture suivante, à confirmer).
  T02 : ligne 0 modifiée (30 €, état « Mod »), ligne 1 supprimée (« Sup »), validation en mode « Saisie » : écriture 3
  réécrite à 30 €, écriture 4 supprimée, 4 lignes dans Fiches_MvtM (`supprimee` posé pour la 4).