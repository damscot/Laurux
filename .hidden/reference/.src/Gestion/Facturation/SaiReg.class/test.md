# SaiReg — Tests

> Source : `.src/Gestion/Facturation/SaiReg.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI qui écrit en comptabilité (via `EcrReg`) : tests `replay` depuis Gestion › Facturation ›
Saisie des règlements. Module complexe (écritures `Fiches_Mvt`, lettrage) : **liste de scénarios
à valider par l'utilisateur** avant la phase 2. Jeu `facturation_base`
([ObjFac.class/test.md](../ObjFac.class/test.md)) complété : règlements avec et sans compte
interne, avec `bordereaux`, `decaissement`, `caisse` ; écritures de vente non lettrées d'un
client ; un bordereau en cours sur un compte interne. Comparaisons : dump normalisé
(`Fiches_Mvt`, lettrage, soldes de `Fiches_Comptes`), texte des PDF (`EcrReg.pdf`,
`Bordereau.pdf`), journal de rejeu.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAIREG-T01 | replay | Saisie d'un règlement avec lettrage | règlement sans bordereau, client, coche de 2 factures (Espace), montant, Valider la ligne, Valider | écritures et lettrage (dump), PDF récapitulatif | `tests/saisie_lettrage/` | à faire |
| SAIREG-T02 | replay | Modification et suppression dans le bordereau | double-clic sur une ligne, nouveau montant ; suppression d'une autre | états Mod/Sup ; dump après validation | `tests/modif_suppression/` | à faire |
| SAIREG-T03 | replay | Reprise et validation d'un bordereau | règlement `bordereaux` avec écritures en attente, Valider, date | écritures validées à la date saisie (dump) | `tests/bordereau/` | à faire |
| SAIREG-T04 | replay | Éditions | Éditer en mode Saisie puis Bordereau | texte de `Bordereau.pdf` (ajoutés / tous) | `tests/editions/` | à faire |
| SAIREG-T05 | replay | Décaissement refusé | montant négatif, règlement sans `decaissement` | message, aucune ligne ajoutée | `tests/decaissement/` | à faire |
| SAIREG-T06 | replay | Filtres et recherche | lettrés / non lettrés / tous ; écritures / factures / BL ; recherche par document et par lot ; F2 client | contenu de `selection` | `tests/filtres/` | à faire |
| SAIREG-T07 | replay | Ouverture d'un document | double-clic sur un BL, une facture, une archive | `OptFac` ouvert sur le bon type (journal de rejeu) | `tests/ouverture_document/` | à faire |
| SAIREG-T08 | replay | Mode « Facture » depuis des BL | option BL, `SwitchSelec`, coche de 2 BL, Valider | tables de travail `Facturefm`/`Bl` ; édition fin de mois ; transaction laissée ouverte (A02 figée) | `tests/facture_depuis_bl/` | à faire |
| SAIREG-T09 | replay | Mode caisse incrusté | édition d'une facture avec `/Rglt` actif (`ObjFacB.editef`) | règlement saisi, écritures ; fermeture par `win_close` | `tests/mode_caisse/` | à faire |
| SAIREG-T10 | replay | Fermeture avec saisie en cours | ligne ajoutée puis fermeture, « Oui » puis « Non » | validation ou abandon (dump) | `tests/fermeture/` | à faire |
| SAIREG-T11 | replay | Période close | date de règlement en période comptable close | message, focus sur la date | `tests/periode_close/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié, date figée (`faketime`) :
  `dtereg` vaut `LDate(Now)`, la sélection couvre ± 8 ans autour de `Now`.
- **`Listreg`** (ListView) n'est pas rejouable tant que REPLAYOBSERVER-A06 n'est pas validée :
  les scénarios saisissent le code règlement au clavier.
- La fenêtre de date du bordereau est construite dynamiquement (`Window` sans nom de classe
  propre) : vérifier en phase 2 que `ReplayObserver` capte ses contrôles, sinon T03 reste manuel.
- `RegCaisse` n'a pas de gestionnaire : A01 n'est observable qu'avec un gestionnaire de test
  (projet minimal), pas en replay.
