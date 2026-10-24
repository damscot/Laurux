# EditcompteM — Tests

> Source : `.src/Compta/Impressions/EditcompteM.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Imprime` est testé par `replay` depuis l'écran `Editcompte` (menu Grands livres, dates et comptes
saisis, **Imprimer**). Le PDF `~/tmp/Glivre.pdf` est capturé (script `/Soc01/caisse/CmdVis`), converti
par `pdftotext -layout` et normalisé (date d'édition et utilisateur du pied de page). `finmois` est
testé en `gbtest`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITCOMPTEM-T01 | replay | Grand livre client | `Bclient`, plage par défaut, exercice courant | texte PDF de référence (soldes cumulés, totaux par compte, total général) | `tests/client/` | à faire |
| EDITCOMPTEM-T02 | replay | Grand livre fournisseur | `Bfournisseur` | texte PDF de référence | `tests/fournisseur/` | à faire |
| EDITCOMPTEM-T03 | replay | Grand livre gestion | `Bgestion`, 60000 → 79999999 | texte PDF ; titre « Grand livre gestion » | `tests/gestion/` | à faire |
| EDITCOMPTEM-T04 | replay | Grand livre bilan | `Bbilan` | texte PDF | `tests/bilan/` | à faire |
| EDITCOMPTEM-T05 | replay | Grand livre général | `Bgen`, plage complète, puis plage 6… à 7… seulement | totaux « Bilan » puis « Gestion » ; total « Bilan » à zéro en tête pour la 2e plage (A02 figée) | `tests/general/` | à faire |
| EDITCOMPTEM-T06 | replay | Compte centralisé | compte `cent_cc = 1`, écritures sur 3 mois, 2 journaux | lignes mensuelles « Centralisation » datées fin de mois, journal = dernière écriture (A03 figée) ; dump : `Ctrln` | `tests/centralise/` | à faire |
| EDITCOMPTEM-T07 | replay | Sous-comptes | compte avec 2 sous-comptes dans `Fiches_SousComptes`, plage finissant puis ne finissant pas dans le groupe | « Total sous-comptes » imprimé seulement si un compte suit le groupe (A01 figée) | `tests/sous_comptes/` | à faire |
| EDITCOMPTEM-T08 | replay | Saut de page | compte de plus de 60 écritures | pages 2+ titrées « Grand livre », pied « Page n/N » | `tests/saut_page/` | à faire |
| EDITCOMPTEM-T09 | replay | Aucune écriture | plage de comptes sans écriture dans la période | message « Aucune ecriture pour cette demande », pas de PDF | `tests/aucune_ecriture/` | à faire |
| EDITCOMPTEM-T10 | replay | Bornes de la période | écritures le premier et le dernier jour (dont une à 12:00 le dernier jour) | lignes présentes / absentes selon le filtre SQL actuel | `tests/bornes_dates/` | à faire |
| EDITCOMPTEM-T11 | gbtest | `finmois` | 15/01/2024, 10/02/2024, 10/02/2023, 30/04/2023, 31/12/2023 | 31, 29, 28, 30, 31 | `tests/finmois/` | à faire |
| EDITCOMPTEM-T12 | replay | Solde nul | compte dont le solde cumulé revient à 0 | affichage `0,00` (pas `-0,00`) | `tests/solde_nul/` | à faire |
| EDITCOMPTEM-T13 | replay | Deux impressions successives | T01 puis T05 sans fermer l'écran | second PDF identique à T05 seul | `tests/impressions_successives/` | à faire |

## Détail des tests

- **Données** : jeu dérivé commun aux éditions comptables (voir [Balance](../Balance.class/test.md))
  avec en plus `Fiches_SousComptes` (un compte parent et ses sous-comptes), un compte centralisé et des
  écritures horodatées.
- **Base** : l'impression écrit `Ctrln` : le dump final est comparé (table `Ctrln` incluse).
- **T11** appelle `EditcompteM.finmois` directement (fonction `Public`, pure) ; les valeurs attendues
  sont produites dans le clone non modifié.
- **Non testable automatiquement** : curseur `Editcompte.Mouse`, son, visualiseur.
