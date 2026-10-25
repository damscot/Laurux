# Ccompta — Synthèse

> Source : `.src/Reports/Ccompta.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF (`Inherits PdfWriter`) des éditions comptables : 52 méthodes de mise en page
(« niveaux » `Level*`) regroupées par édition — grand livre et extraits, impayés, échéancier,
journaux et centralisation, écritures modifiées, plan comptable, rapprochement bancaire, traites,
analytique. Aucune lecture de base, aucune pagination : l'écran appelant gère `PosY`, appelle
`BasPage` puis `Entete` (seul niveau qui crée une page).

## Points clés

- 15 appelants (12 éditions de `Compta/Impressions`, `Pointage`, `Traites`, `Lcr.Imp_Traites`).
- Rendu pur ; seuls calculs : `Format$` des montants, `-0,00` → `0,00`, solde de `Level2s`.
- Code mort : `Level2sbis`, `Level3T`, `_free`.
- Doublons internes : `Level2C` = `Level2CA`, `Level3` = `Level2A`, `Level4` ≈ `Level5`,
  12 en-têtes de colonnes de même structure.
- Doublons externes : `BasPage` identique dans 8 gabarits, `_new` dans 12 ; base commune
  `PdfLaurux` proposée (avec `CLcr`).

## Dépendances principales

- Utilise : `PdfWriter` (héritage), `Start.R/G/B`, `Utils.cpoint`, `User.Name`, `Now`.
- Utilisé par : `Anomalies`, `Echeancier`, `EcrM`, `EdImpayes`, `EdNjustifiees`, `EdNlettrees`,
  `EditcompteA`, `EditcompteM`, `Jourcent`, `JournauxA`, `JournauxM`, `Plancomptable`, `Pointage`,
  `Gestion/Impressions/Traites`, `Gestion/Lcr/Lcr`.

## Risques

- Défauts communs à tous les gabarits, hérités de `PdfWriter` : encodage (€ → ¤, accents perdus,
  PDFWRITER-A01) et largeur de texte fausse qui décale les montants alignés à droite
  (PDFWRITER-A02).
- Deux appelants ont une arité fausse (`EditcompteA:726` `Level4C` 4/5, `JournauxA:695` `level2J`
  9/10) : ces éditions échouent à l'exécution (anomalies EDITCOMPTEA-A01, JOURNAUXA-A01).
- Couleur de remplissage héritée de l'appel précédent (fond blanc du « Total compte » après des
  sous-comptes) : CCOMPTA-A01.
- Débit de centralisation non formaté (`level7J`) : CCOMPTA-A02.
- Le saut de page automatique de `PdfWriter` (≈ 295 mm) crée une page sans en-tête si un appelant
  dépasse son seuil.
- Tout changement de signature `Level*` touche jusqu'à 15 fichiers.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 546 |
| Lignes de commentaire | 50 |
| Fonctions | 53 |
| Fonctions Public | 53 |
| Complexité cyclomatique totale | 60 |
| Complexité max (fonction) | 5 (`Level2s`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests `gbtest` (CCOMPTA-T01 à T08 : une famille de niveaux par test, multi-pages avec
`{nb}` et saut automatique, couleur héritée, conversion des montants `String`) et 2 replays
(extrait de compte, journaux) sur le jeu comptable dérivé. Comparaison du texte `pdftotext` (date
et utilisateur normalisés), rendu raster pour la couleur.

## Rework

8 étapes sans changement de comportement (CCOMPTA-001 à 008) : documentation, suppression du
code mort, délégations internes, helpers d'en-tête de colonnes et de solde, séparation du calcul de
`Level2s`, typage de `Lines`, dérivation de la base commune `PdfLaurux`. 2 anomalies (A01 couleur
héritée, A02 débit non formaté) soumises à validation.
