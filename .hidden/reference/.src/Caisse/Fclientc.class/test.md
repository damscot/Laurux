# Fclientc — Tests

> Source : `.src/Caisse/Fclientc.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI ouvert par Fmenu › Constantes › « Compte client caisse ». **L'écran n'appelle pas
`Utils.Observers(Me)`** : ses actions ne sont pas journalisées, donc pas capturables par
`./Laurux -l`. Tant que FCLIENTC-A03 n'est pas validée, les scénarios ci-dessous sont joués **à la
main** (ou par pilotage xdotool) sur les deux clones, et la comparaison porte sur le dump de
`Fiches_ClientCaisse`. Base `Laurux01.sql` + jeu `caisse_base` (table vide, puis une ligne ; quelques
clients `Fiches_Cli`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCLIENTC-T01 | replay | Création puis modification | table vide : code + libellé, Enregistrer ; réouverture, nouveau code, Enregistrer | 1 ligne `Fiches_ClientCaisse` (INSERT puis UPDATE sans WHERE) ; son joué même si `/son` désactivé (A02) | `tests/creation_modification/` | à faire |
| FCLIENTC-T02 | replay | Recherche du client | bouton loupe, Entrée sur un client ; Échap ; code saisi inexistant | zones remplies par le client choisi ; code inexistant enregistré sans contrôle (A04) | `tests/recherche_client/` | à faire |
| FCLIENTC-T03 | replay | Suppression | Supprimer, « Oui » ; puis « Non » | table vide ; zones toujours remplies après suppression (A01 figée) | `tests/suppression/` | à faire |
| FCLIENTC-T04 | gbtest | Lecture partagée (après FCLIENTC-005) | base avec 0 puis 1 ligne | `CompteClientCaisse()` : `Available` faux / code et nom attendus | `tests/compte_client_caisse/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone Laurux non modifié ; A01, A02, A04 figées.
- **Rejeu** : impossible par `ReplayObserver` sans `Utils.Observers(Me)` (A03) ; `Client_Click`
  serait rejoué par `Object.Call` (doit rester `Public`). `tvalist2` est invisible : aucun clic
  possible.
- **Effet aval** : le code enregistré est utilisé par le moulinage (`Moulinage`) et les bordereaux
  (`BordereauxC`) ; un test de moulinage du lot Caisse doit partir d'une table remplie par T01.
- **Non testable** : `Button5_Click` (aide, `xdg-open`) ; substituer un faux `xdg-open` si besoin.
