# CFormat — Synthèse

> Source : `.src/Utils/CFormat.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Objet valeur « format d'affichage » (fond, texte, alignement, police, marge, largeur, hauteur,
format numérique), sérialisé en chaîne `"Clé: valeur; …"` (`ToString`) et relu par `CFormat["…"]`
(`_Get`). Il porte la configuration des couleurs d'écran (`/Coul/…`), des touches de caisse et des
colonnes de `RichDataGrid`.

## Points clés

- Calcul pur, sans base ; dépend de `gb.gui` pour `Font` et `Align`.
- `-1`/`Null` = « non défini ».
- `_Get` met toute la chaîne en minuscules et convertit le format numérique par `Val` (A01).
- `Copy` est du code mort.
- Le bloc « appliquer un CFormat à un contrôle » est dupliqué dans 4 fichiers.

## Dépendances principales

- Utilisé par `SetColors`, `FSetFormat`, `RichDataGrid`, `Attrib` (caisse) et `Remisec`
  (ce dernier non détecté par `deps.py`).
- N'utilise aucune classe Laurux.

## Risques

- Format numérique perdu à la lecture (A01) ; alignement dépendant de la casse (A02, à confirmer) ;
  sérialisation d'un alignement inconnu erronée (A03).
- `RichDataGrid` appelle des propriétés `BackColor`/`ForeColor` qui n'existent pas dans `CFormat`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 123 |
| Lignes de commentaire | 5 |
| Fonctions | 19 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 48 |
| Complexité max (fonction) | 18 (`ToString`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `gbtest` (lecture des couleurs, alignement/police, dimensions/format, erreurs, `ToString`,
aller-retour sur un `Laurux.conf` réel, `Copy`), valeurs attendues générées dans le clone non
modifié.

## Rework

4 étapes (CFORMAT-001 à 004) : documentation, suppression de `Copy`, simplification de
`ToString`, méthode commune `Applique` pour `SetColors`, `FSetFormat` et `Attrib`.
3 anomalies (CFORMAT-A01 à A03) soumises à validation.
