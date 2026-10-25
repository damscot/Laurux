# Attrib — Synthèse

> Source : `.src/Caisse/Attrib.class` · Synthèse des autres documents.

## Rôle

Paramétrage des **touches de la caisse tactile** pour la caisse connectée (`Start.$Tcai`) : libellé,
code article, couleur, image et sous-famille de chacune des 35 touches de famille (`A<n>`), puis des
35 touches de chaque sous-famille (`A<n>B<m>`, créées dynamiquement). Données dans
`Fiches_Touches (touche, cai)`, relues par `Caisse` pour le clavier de vente. Ouvert par
`Cmenu.ControleCai`.

## Points clés

- Contrôles retrouvés par leur nom (`Me.Controls[…]`), existence testée par un `Try` détourné.
- Membres publics nécessaires : `Bsel`/`Bval` (écrits par `TriArticles` via `Object.SetProperty`),
  `fnd` (lu par `FSetFormat`). `Libellearticle` n'est écrit par personne.
- Duplications internes : `Init`/`Init2`, `Clav2_Dblclick`/`Fond_ImageButton`,
  `Button5_Click`/`Bouton_KeyPress`.
- `Bsel` est remis à `False` avant la recherche d'article (pas de défaut MATERIEL-A09).

## Dépendances principales

- Utilise : `Utils.db`, `Cbase.Table("TabTouches")`, `TriArticles`, `FSetFormat`, `CFormat`,
  `ImageButton`, `Caisse` (auto-instance).
- Utilisé par : `Cmenu` ; `FSetFormat` lit `Attrib.fnd`.

## Risques

- **A01** : le repli après un `INSERT` en échec met à jour `cai` des touches dont le **nom égale le
  code article** (`Attrib.class:174`).
- **A03** : l'image de fond est enregistrée pour la touche de **toutes les caisses**
  (`FSetFormat.class:72`) ; A02 : couleur testée toutes caisses, perdue si la touche n'existe pas.
- A05 : rechargement `Init()` en mode sous-famille (mélange famille/sous-famille, à confirmer).
- A04 (désignation jamais affichée), A06 (`Caisse.origine` crée une fenêtre `Caisse` cachée), A07
  (suppression sans confirmation, erreurs non gérées sur un nom de touche saisi).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 298 |
| Lignes de commentaire | 7 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 82 |
| Complexité max (fonction) | 12 (`Init2`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` en mode caisse sur un jeu `touches_base` à deux caisses (ouverture, enregistrement,
suppression, recherche d'article, sous-familles, couleur/image, nom de touche saisi) ; le rejeu des
touches dynamiques et du double-clic est à confirmer en phase 2.

## Rework

7 étapes (ATTRIB-001 à 007) : documentation, code mort, fonction `Touche()`, factorisation de la
suppression et du choix de couleur, réduction de portée de 6 fonctions, séparation SQL/GUI.
7 anomalies (ATTRIB-A01 à A07) soumises à validation.
