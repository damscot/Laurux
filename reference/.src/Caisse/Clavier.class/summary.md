# Clavier — Synthèse

> Source : `.src/Caisse/Clavier.class` · Synthèse des autres documents.

## Rôle

Clavier virtuel AZERTY (formulaire sans bordure) de l'écran de connexion de la caisse en mode
tactile : chaque bouton du groupe `Clav` ajoute sa touche (dérivée de son nom) au mot de passe
`Ouverture.Mdp` ; « Entrée » et « Fermer » ferment le clavier et lancent la connexion.

## Points clés

- Ouvert par `Ouverture.Button3_Click` (`New Clavier`), journalisé (`Utils.Observers`).
- `Numerique` est du code mort (homonyme dans `Caisse`) ; `Alpha` est réductible en `Private`.
- `Alpha`/`Numerique` sont dupliqués dans `Caisse` : fonction pure commune proposée.
- Touches inactives (`*`, `,`, `;`), « Fermer » qui valide, saisie physique écrasée.
- `Ouverture` ferme l'auto-instance `Clavier` au lieu du clavier affiché (défaut côté Ouverture).

## Dépendances principales

- Appelant : `Ouverture` (dépendance circulaire : `Ouverture.Mdp`, `Ouverture.Button1_Click`).
- Utilise `Utils.Observers`. Aucun SQL.

## Risques

- Rejeu de la connexion caisse dépendant de plusieurs instances successives du clavier.
- Toute correction de A02 change le parcours de connexion des caissières : validation requise.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 59 |
| Lignes de commentaire | 5 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 8 (`Alpha`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `replay` (saisie, touches ignorées, « Fermer » = connexion) sur l'écran Ouverture en mode
tactile, et 1 `gbtest` de la fonction pure après CLAVIER-005 ; valeurs attendues capturées dans
le clone non modifié.

## Rework

6 étapes sans changement de comportement (CLAVIER-001 à 006) : documentation, code mort,
`Select Case`, réduction de portée d'`Alpha`, fonction pure `ToucheVirtuelle`, commonalisation
avec `Caisse`. 3 anomalies (CLAVIER-A01 à A03) soumises à validation.
