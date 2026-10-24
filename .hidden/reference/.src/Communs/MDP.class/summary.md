# MDP — Synthèse

> Source : `.src/Communs/MDP.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Boîte modale de saisie du mot de passe administrateur (local `MdpPrefs` ou global `MdpPrefsG`),
ouverte avant les écrans protégés de `Fmenu` et `Fsoc`. Le résultat est écrit dans le global
`Start.Motdepasse` (`"OK"` ou `""`).

## Points clés

- Déchiffrement par `hexdblKey.Crypt` (clé `"Laurux"`) et comparaison directe à la saisie.
- Entrée, Retour ou Tab valident ; échec : son, `Message.Error`, fermeture.
- Le protocole (ouvrir, tester `Start.Motdepasse`, remettre à `""`) est recopié 9 fois chez les
  appelants ; la comparaison est recopiée dans `Prgm` et `Prefs`.

## Dépendances principales

- Appelé par `Fmenu` (9 menus) et `Fsoc` ; `deps.py` signale à tort `Caisse/Ouverture` (contrôle
  homonyme `Mdp`).
- Utilise `Start` (`Motdepasse`, `LocalSettings`, `Societe`, `son`) et `hexdblKey`.

## Risques

- Mot de passe vide accepté si aucun mot de passe n'est enregistré (A01, à confirmer).
- Validation par Tab ; « Escape pour sortir » non implémenté (A02).
- Pas d'observateurs de replay : saisie à injecter par le harnais.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 33 |
| Lignes de commentaire | 4 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 6 (`Mdp2_LF`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests (MDP-T01 à T05) : 4 `replay` (bon / mauvais mot de passe local, mot de passe global,
fermeture sans saisie) et un `gbtest` sur `MDP.Verifie` après extraction.

## Rework

3 étapes (MDP-001 à 003) : documentation, simplification, API statiques `Verifie` et `Autorise`
partagées avec `Fmenu`, `Prgm`, `Fsoc` et `Prefs`. 2 anomalies (MDP-A01, A02).
