# ImageButton — Synthèse

> Source : `.src/Caisse/ImageButton.class` · Synthèse des autres documents.

## Rôle

`UserControl` exporté qui dessine les touches de la caisse tactile (fond en dégradé via
`MyStyle`, image semi-transparente, texte blanc) et lève `Click` au relâchement de la souris.

## Points clés

- Utilisé dans `Caisse.form` et `Attrib.form` (35 touches chacun, groupe `Clav2`) et créé par
  code pour les sous-familles (`Clav3`).
- Propriétés `Text`, `Picture`, `BackGround` (qui masque `Control.Background`) ; `Position` est
  du code mort.
- Handlers `View_*` de la `DrawingArea` interne : doivent rester `Public`.
- Non observé par le harnais de rejeu : les touches de caisse ne sont pas journalisées.

## Dépendances principales

- Utilise `MyStyle` (seul utilisateur de cette classe).
- Utilisé par `Caisse` et `Attrib` (handlers `Clav2_Click`, `Clav3_Click`).

## Risques

- Toute modification du dessin ou de l'événement touche directement la saisie en caisse.
- Rejeu automatisé de la caisse impossible par les touches tant que le harnais ne gère pas ce
  contrôle.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 103 |
| Lignes de commentaire | 5 |
| Fonctions | 16 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 7 (`View_Draw`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `gbtest` sous Xvfb (propriétés, événement `Click`, rendu par capture) et 1 `replay`
bloqué par l'absence de journalisation des `UserControl`.

## Rework

2 étapes (IMAGEBUTTON-001 documentation, 002 suppression de `Position` et des commentaires).
1 anomalie (IMAGEBUTTON-A01 : clic hors bouton, pas de clavier, pas de rafraîchissement).
