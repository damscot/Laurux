# Fcaras — Synthèse

> Source : `.src/Gestion/Facturation/Fcaras.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre modale sans bordure affichant la photo (`art_photo`) et les caractéristiques
(`art_crst`) d'un article pendant la saisie d'un document de vente. Seul appelant :
`Facture.aff_photo`.

## Points clés

- GUI pure, sans accès à la base ; 4 fonctions, 38 lignes.
- `Tnom_Photo` calcule un nom de fichier qui n'est jamais lu : fonction sans effet.
- Le chargement d'image est protégé par `Try` ; le `Catch` final affiche l'erreur.

## Dépendances principales

- Utilisé par : `Facture` (`aff_photo`, l. 5283-5288).
- Utilise : `Start.son`, `Music`, `Image`/`Draw`.

## Risques

- Très faibles : classe isolée, aucun effet sur la base.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 7 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `replay` (FCARAS-T01, T02) : ouverture avec photo valide et avec photo absente, depuis la
saisie de documents ; le dump de la base doit rester inchangé.

## Rework

3 étapes (FCARAS-001 à 003) : documentation, suppression de `Tnom_Photo` (code mort fonctionnel)
et renommage d'un paramètre. Aucune anomalie.
