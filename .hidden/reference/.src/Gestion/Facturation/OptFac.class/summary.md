# OptFac — Synthèse

> Source : `.src/Gestion/Facturation/OptFac.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre d'options d'édition d'un document de vente (BL, facture, devis, commande, proforma,
atelier, archive, fin de mois, périodique). Elle crée un objet `ObjFacB` (sous-classe d'`ObjFac`),
synchronise ses options avec les cases à cocher, puis lance l'édition, la visualisation,
l'envoi par courriel ou SMS.

## Points clés

- 44 fonctions, dont 40 handlers d'une ou deux lignes (case → membre de l'objet).
- `form_Close` persiste 10 options dans `Start.LocalSettings` et met à jour `Fiches_AdrlivBL`.
- Les appelants passent `Me.Parent` en 4ᵉ argument : Gambas le transmet au constructeur de
  `Form` (arguments qui suivent les paramètres obligatoires), vérifié sur un projet minimal.
- `entete_Click`/`edite_Click` sont de vrais handlers (contrôles publics `!Entete`, `!edite`) :
  faux positifs « jamais référencés » de `deps.py`.

## Dépendances principales

- Utilisé par : `Facture`, `Archives`, `Facturefm`, `FacturefmA`, `SaiReg`.
- Utilise : `ObjFacB`/`ObjFac` (≈ 35 membres publics), `Fiches_AdrlivBL`, `Fiches_AdrlivC`,
  `Fiches_Bl`, `Gsm`, `TextReg`, `chainage`.

## Risques

- `Aff_AdrC("F2")` référence un membre inexistant `numcl` (erreur d'exécution) — OPTFAC-A01.
- `ImpPDF_Click` écrit dans `pdf` (chemin du PDF joint) au lieu de l'indicateur d'archivage — A02.
- Fermeture d'une fin de mois sans édition : `adrliv` `Null` (à confirmer) — A03.
- `sms_Click` ne retire pas les points du numéro — A04 ; `Dtech_LostFocus` ignore les tables `M`
  et l'archive — A05.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 389 |
| Lignes de commentaire | 21 |
| Fonctions | 43 |
| Fonctions Public | 43 |
| Complexité cyclomatique totale | 91 |
| Complexité max (fonction) | 16 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `replay` (OPTFAC-T01 à T10) sur le jeu `facturation_base` : éditions BL/facture/fin de
mois, persistance des options, adresse de livraison, échéance, anomalies figées. Comparaison
du dump, du `Laurux.conf` et du texte des PDF.

## Rework

6 étapes (OPTFAC-001 à 006) : documentation, code mort, portée de `Aff_AdrC`, séparation de
`form_Close`, `UPDATE` d'échéance conditionnel, table d'options commune avec `ObjFac`.
5 anomalies (A01 à A05) soumises à validation.
