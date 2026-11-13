# EditcompteM — Tests

> Source : `.src/Compta/Impressions/EditcompteM.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Imprime` est testé par `replay` depuis l'écran `Editcompte` (menu Grands livres, dates et comptes
saisis, **Imprimer**). Le PDF `~/tmp/Glivre.pdf` est capturé (script `/Soc01/caisse/CmdVis`), converti
par `pdftotext -layout` et normalisé (date d'édition et utilisateur du pied de page). `finmois` est
testé en `gbtest`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITCOMPTEM-T01 | replay | Grand livre client | `Bclient`, plage par défaut, exercice courant | texte PDF de référence (soldes cumulés, totaux par compte, total général) | `tests/client/` | implémenté |
| EDITCOMPTEM-T02 | replay | Grand livre fournisseur | `Bfournisseur` | texte PDF de référence | `tests/fournisseur/` | implémenté |
| EDITCOMPTEM-T03 | replay | Grand livre gestion | `Bgestion`, 60000 → 79999999 | texte PDF ; titre « Grand livre gestion » | `tests/gestion/` | implémenté |
| EDITCOMPTEM-T04 | replay | Grand livre bilan | `Bbilan` | texte PDF | `tests/bilan/` | implémenté |
| EDITCOMPTEM-T05 | replay | Grand livre général | `Bgen`, plage complète, puis plage 6… à 7… seulement | totaux « Bilan » puis « Gestion » ; total « Bilan » à zéro en tête pour la 2e plage (A02 figée) | `tests/general/` | implémenté (plage complète seulement ; seconde plage 6… à 7… non jouée : à faire) |
| EDITCOMPTEM-T06 | replay | Compte centralisé | compte `cent_cc = 1`, écritures sur 3 mois, 2 journaux | lignes mensuelles « Centralisation » datées fin de mois, journal = dernière écriture (A03 figée) ; dump : `Ctrln` | `tests/centralise/` | implémenté |
| EDITCOMPTEM-T07 | replay | Sous-comptes | compte avec 2 sous-comptes dans `Fiches_SousComptes`, plage finissant puis ne finissant pas dans le groupe | « Total sous-comptes » imprimé seulement si un compte suit le groupe (A01 figée) | `tests/sous_comptes/` | à faire : jeu Fiches_SousComptes non écrit (vague 4, temps) |
| EDITCOMPTEM-T08 | replay | Saut de page | compte de plus de 60 écritures | pages 2+ titrées « Grand livre », pied « Page n/N » | `tests/saut_page/` | à faire : jeu de plus de 60 écritures non écrit (vague 4, temps) |
| EDITCOMPTEM-T09 | replay | Aucune écriture | plage de comptes sans écriture dans la période | message « Aucune ecriture pour cette demande », pas de PDF | `tests/aucune_ecriture/` | implémenté |
| EDITCOMPTEM-T10 | replay | Bornes de la période | écritures le premier et le dernier jour (dont une à 12:00 le dernier jour) | lignes présentes / absentes selon le filtre SQL actuel | `tests/bornes_dates/` | à faire : jeu d'écritures aux bornes non écrit (vague 4, temps) |
| EDITCOMPTEM-T11 | gbtest | `finmois` | 15/01/2024, 10/02/2024, 10/02/2023, 30/04/2023, 31/12/2023 | 31, 29, 28, 30, 31 | `tests/finmois/` | implémenté |
| EDITCOMPTEM-T12 | replay | Solde nul | compte dont le solde cumulé revient à 0 | affichage `0,00` (pas `-0,00`) | `tests/solde_nul/` | implémenté (couvert par `editcomptem_client` : 411001 revenu à 0 affiché `0,00`) |
| EDITCOMPTEM-T13 | replay | Deux impressions successives | T01 puis T05 sans fermer l'écran | second PDF identique à T05 seul | `tests/impressions_successives/` | implémenté |

## Détail des tests

- **Données** : jeu dérivé commun aux éditions comptables (voir [Balance](../Balance.class/test.md))
  avec en plus `Fiches_SousComptes` (un compte parent et ses sous-comptes), un compte centralisé et des
  écritures horodatées.
- **Base** : l'impression écrit `Ctrln` : le dump final est comparé (table `Ctrln` incluse).
- **T11** appelle `EditcompteM.finmois` directement (fonction `Public`, pure) ; les valeurs attendues
  sont produites dans le clone non modifié.
- **Non testable automatiquement** : curseur `Editcompte.Mouse`, son, visualiseur.
- **Implémentation (phase 2, vague 3)** : T11 → `.src/Tests/Compta/EditcompteMTest.test` ; T06 →
  `.hidden/Tests/Compta/assets/editcomptem_centralise/` (jeu `extrait_shared/extrait_base`, 707000 centralisé,
  grand livre gestion ; `Ctrln` du dump : 2 lignes « Centralisation » 201802/201804, `intitule` NULL) ;
  T09 → `.hidden/Tests/Compta/assets/editcomptem_aucune_ecriture/` (Laurux01 sans écriture, boîte validée par Entrée).
  `Ctrln` est supprimée et recréée pour chaque compte ayant des écritures : le dump ne garde que le dernier compte.
- **Implémentation (phase 2, vague 4)** : texte du PDF comparé (`CmdVis` → `pdftotext`, `edition.txt`), jeu
  `extrait_shared/extrait_base`. T01 `editcomptem_client/`, T02 `editcomptem_fournisseur/`, T03 `editcomptem_gestion/`,
  T04 `editcomptem_bilan/`, T05 `editcomptem_general/` (totaux « classe Bilan » / « classe Gestion », comptes clients
  et fournisseurs absents), T13 `editcomptem_successives/` (Client puis Général : `edition.txt` identique à celui de
  T05 joué seul, constaté sur les attendus). T12 est couvert par T01 (solde de 411001 revenu à `0,00`).
  Observé : les lignes « Centralisation » impriment débit/crédit avec un point (`0.00`, `100.00`) alors que les autres
  lignes utilisent la virgule (`0,00`).
