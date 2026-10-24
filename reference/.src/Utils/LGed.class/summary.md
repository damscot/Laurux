# LGed — Synthèse

> Source : `.src/Utils/LGed.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Objet métier « document GED » **et** fiche d'édition de ce document : ligne `Docs_Ged` (type,
code, compte, origine, URL, MIME, date, montants) avec ses tags (`Fiches_Tag` via `Docs_Tag`),
fichier stocké sous `<racine société>/<compte>/<année>/<origine>/`. Gère la recherche,
l'archivage de PDF imprimés (`PDFDupli`), les tags, l'épuration, le scan et la copie de fichiers.

## Points clés

- `Form` `Create Static` utilisée aussi comme objet sans fenêtre (`New LGed(Null, …)`) et en
  statique (`Search`, `String2Array`, épurations).
- 17 fichiers appelants (facturation, réceptions, comptabilité, fiches tiers et articles).
- Logique mêlée aux contrôles : `Commit` et `Default_URL` lisent `ListTags`, `MoveURL` lit `furl`.
- Tables écrites en dur alors que les clés `Cbase` existent.
- Fonction la plus complexe : `Enregistrer_Click` (CC 29).

## Dépendances principales

- Utilise : `Utils.db`, `Start.LocalSettings`, `LPrix`, `LDate`, `LBox`, `LTrans`, `LScript`,
  `ProgBar`, `TriCpt`, `TriGen`, `Visualiseur`, programmes `xdg-mime`, `curl`, `xsane`,
  `scanimage`, `convert`.
- Utilisé par : `GedR`, `Saisecrit`, `Tresor`, `EcrAuto`, `Extrait`, `ObjFac`, `Facture`,
  `commande1`, `ValidBR(1)`, `Edbr`, `Articles`, `FClient`, `FFournisseur`, `Fmenu`, `LauruxMaj`,
  `Changefam`.

## Risques

- Date modifiée dans la fiche jamais enregistrée (A01).
- Erreur de collection possible sur ajout d'un tag déjà présent (A02, à confirmer).
- Épuration des tags agressive en présence de liaisons pendantes (A03).
- GED inutilisable sous SQLite (A05) ; commandes shell non échappées (A06).
- Appel de `Supprime(True)` sur l'auto-instance dans `Articles` : épuration des tags seulement ; le
  fichier GED reste sur le disque (A07, requalifiée après le lot Gestion).
- Valeurs de l'énumération de type stockées en base : ordre à ne jamais modifier.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 756 |
| Lignes de commentaire | 21 |
| Fonctions | 52 |
| Fonctions Public | 43 |
| Complexité cyclomatique totale | 215 |
| Complexité max (fonction) | 29 (`Enregistrer_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

14 tests (LGED-T01 à T14) : 9 `gbtest` (dont 7 avec base Docker et jeu `ged.sql`) pour l'API
objet, 5 `replay` pour la fiche (création, déplacement, date, archivage depuis `Saisecrit`,
suppression). Scan et visualisation : manuels.

## Rework

10 étapes (LGED-001 à 010) : documentation, `Cbase.Table`, simplification de `trouve` et
`AddTag`, séparation des lectures de contrôles, découpage d'`Enregistrer_Click`, helpers d'URL
et de scan, méthode d'archivage commune, réduction de portée, documentation des handlers vides. 7 anomalies
(LGED-A01 à A07).
