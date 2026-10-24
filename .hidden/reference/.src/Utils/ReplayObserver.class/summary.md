# ReplayObserver — Synthèse

> Source : `.src/Utils/ReplayObserver.class` · Synthèse des autres documents.

## Rôle

Moitié GUI du mécanisme log/replay. En capture, un observateur par contrôle (posé par
`Utils.Recursive_Observers`) transmet clics, frappes, focus et fermetures à `Utils.db.GUI_Event`.
En rejeu (`-r`), `Replay_Event`, appelé par le timer de `Start.module`, analyse chaque ligne `GUI`,
retrouve fenêtre et contrôle, programme le délai suivant et rejoue l'action.

## Points clés

- Capture conditionnée au focus ; valeur selon la classe (`Value`, `Index`, `Key`, `Row x Column`).
- Rejeu par réflexion : `Object.Call(ctx.Window, "<Contrôle>_Click")` pour `GridView`, `ColumnView`,
  `ListBox` ; frappes via `Desktop.SendKeys` ; clics de `Label` via `xdotool`/`ydotool`.
- `Replay_Event` (CC 26) : analyse de ligne `;`/`#`/`@`/`=`, date `MM/JJ/AAAA HH:MM:SS.mmm`, `Quit` si
  la fenêtre active n'est pas celle attendue.
- Outil central des tests `replay` de la phase 2.

## Dépendances principales

- Utilise : `DB_Connection.GUI_Event`, `DB_Desktop` (`wayland`, `SendKeys`), `xdotool`, `ydotool`.
- Utilisé par : `Utils.Recursive_Observers` (instances), `Start.ReplayTimer_Timer` (`Replay_Event`).

## Risques

- Le rejeu appelle `<Grille>_Click` par son nom (`Object.Call`) : faux pour les contrôles groupés,
  `Last` non positionné, ListView non rejouée. Correction proposée par `Object.Raise` (A06, à valider).

- Rejeu fragile : séparateurs non échappés, format de date figé (A01), Wayland ignoré au clavier
  (A02), caractères non rejouables (A03), contrôles non gérés ou mal ciblés (A04), arrêt brutal (A05).
- Appel dynamique des handlers `_Click` de toutes les fenêtres : aucun handler ne doit changer de
  nom ou de portée.
- Hors fichier : dépassement d'indice probable au dernier événement dans `Start.ReplayTimer_Timer`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 261 |
| Lignes de commentaire | 27 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 86 |
| Complexité max (fonction) | 26 (`Replay_Event`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests prévus (REPLAYOBSERVER-T01 à T07) : 1 `gbtest` sur l'analyse de ligne extraite et 6 `replay`
de fidélité capture → rejeu (boutons et menus, saisie clavier, listes et grilles, cases et labels,
fenêtre inattendue, délais) sous Xvfb, avec comparaison normalisée du log `.out` et de la base.

## Rework

6 étapes sans changement de comportement (REPLAYOBSERVER-001 à 006) : documentation, code mort,
extraction d'`AnalyseLigne`, enum partagée du format, `Select Case` par classe, réduction de portée
des méthodes `Replay_*`. 5 anomalies (REPLAYOBSERVER-A01 à A05).
