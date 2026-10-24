# FSetFormat — Synthèse

> Source : `.src/Utils/FSetFormat.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Boîte de dialogue modale qui modifie un `CFormat` partagé (`FSetFormat.Format`) : couleur de fond,
réinitialisation, aperçu, et choix d'une image de fond pour une touche de caisse.

## Points clés

- Protocole : `FSetFormat.Format = f` → `FSetFormat.Run()` → relecture ; objet modifié par
  référence, sans annulation.
- Couleur du texte et police : handlers présents mais contrôles masqués dans le `.form`.
- Seul SQL : `UPDATE Fiches_Touches SET fond` (via `Cbase.Table`), avec la touche lue dans
  `Attrib.fnd`.

## Dépendances principales

- Appelants : `SetColors` (couleurs d'écran) et `Attrib` (caisse).
- Utilise `CFormat`, `Utils.Observers`, `Utils.db`, `Cbase.Table`, `Attrib.fnd`.

## Risques

- Logo appliqué à toutes les caisses (A01) ; cadre logo actif hors caisse (A02, à confirmer).
- Couplage Utils → formulaire de caisse (`Attrib.fnd`), dépendance circulaire.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 57 |
| Lignes de commentaire | 1 |
| Fonctions | 9 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 4 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (fond depuis `SetColors`, réinitialisation, touche de caisse, logo depuis la
caisse et depuis `SetColors`), comparant `Laurux.conf` et `Fiches_Touches`.

## Rework

5 étapes (FSETFORMAT-001 à 005) : documentation, code mort, `CFormat.Applique`, extraction de
l'`UPDATE`, suppression du couplage à `Attrib.fnd`. 4 anomalies (A01 à A04) soumises à validation.
