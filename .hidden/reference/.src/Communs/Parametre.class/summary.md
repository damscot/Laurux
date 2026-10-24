# Parametre — Synthèse

> Source : `.src/Communs/Parametre.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre des paramètres comptables et de numérotation de la société (menu Fmenu `Menu25`). Elle
édite l'unique ligne de `Fiches_Parametres` : dates de clôture N à N-5, comptes de résultat et de
régularisation, journaux, derniers numéros (client, fournisseur, bon, facture, article, ticket),
coefficient de rétrocession, devise, périodes, version du schéma, frais. Avec les options métiers
(boisson B, carburant P), elle édite aussi des colonnes optionnelles, `Fiches_Societes` et la table
`Art_Tipp` (catégories TICPE).

## Points clés

- Lecture `SELECT * FROM Fiches_Parametres` (blob `conf` compris) mais aucune écriture de `conf` :
  la configuration globale reste gérée par `Prefs` (mécanisme décrit dans
  `Prefs.class/architecture.md`).
- Seule clé de configuration lue : `/Soc<XX>/Caisse` ; option métier via `Utils.Option()`.
- Verrou applicatif `DocActif` « Parametres/0 » pris à l'ouverture (résultat ignoré).
- Enregistrement à chaque fermeture (et deux fois avec le bouton Quitter) ; fermeture impossible
  tant que la saisie est invalide.
- Handlers organisés par groupes (`Par`, `Btn`, `cpts`, `jrnal`) et `Tag` : `Button2_Click`/
  `Button3_Click` sont appelés par `Btn_Click`, et 4 handlers nominaux `*_LostFocus` ne sont
  jamais déclenchés.
- Fonctions les plus complexes : `Form_Open` (CC 62), `Button2_Click` (CC 50).

## Dépendances principales

- Appelant : `Fmenu.Menu25_Click` uniquement.
- Utilise : `Utils.db`, `Utils.Option`, `TextReg`, `Chainage`, `SaiTableau`/`Sailig`/`ObjProp`,
  `DocActif`, `FComptes`, `FTvav`, `FJournaux`, `Doc`.
- Tables : `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Journaux`, `Fiches_Comptes`,
  `Fiches_Tvaav`, `Fiches_Art`, `Art_Tipp` (la plupart en dur, sans `Cbase.Table`).
- Les valeurs écrites (`version`, numéros, journaux, dates de clôture) sont lues par `LauruxMaj`
  et la plupart des écrans de gestion et de comptabilité.

## Risques

- `Valtip_Click` : transaction ouverte sans `Commit` (A01).
- `datefedec` vide non détecté (`IsNan`, A02) ; verrou concurrent ignoré (A03).
- `version` du schéma modifiable à la main (A04) ; `Fiches_Societes` mise à jour sans `WHERE` (A05).
- Contrôles de préfixe 411/401 inactifs (A07, à confirmer par replay).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 539 |
| Lignes de commentaire | 25 |
| Fonctions | 26 |
| Fonctions Public | 24 |
| Complexité cyclomatique totale | 208 |
| Complexité max (fonction) | 62 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests (PARAMETRE-T01 à T12) : 11 `replay` comparant le dump de `Fiches_Parametres`,
`Fiches_Societes`, `Art_Tipp`, `Fiches_Docactif` et le nombre d'`UPDATE` du log (ouverture,
saisie complète, obligatoires, comptes et journaux inexistants, périodes, préfixes, options B et P,
caisse, verrou concurrent) et 1 `gbtest` sur les vérifications après séparation.

## Rework

11 étapes sans changement de comportement (PARAMETRE-001 à 011) : documentation, code mort (son
jamais joué, doublons), `Cbase.Table`, simplification de la validation (CC 50 → ≤ 15), séparation
du SQL, factorisation des propositions de création, suppression du double enregistrement (SQL
modifié, dump identique), réduction de portée, `Utils.CompteExiste`/`TvaExiste` partagés.
7 anomalies (PARAMETRE-A01 à A07) soumises à validation utilisateur.
