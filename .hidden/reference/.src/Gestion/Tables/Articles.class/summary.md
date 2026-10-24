# Articles — Synthèse

> Source : `.src/Gestion/Tables/Articles.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de gestion de la **fiche article** (`Fiches_Art`) : consultation par liste filtrable
(`TriGen`), création, modification, suppression, avec les tables satellites (codes-barres,
équivalences, remplacements, documents GED), la chaîne de calcul des prix (prix de base → remises →
PA net → conversion → frais → prix de revient → coefficient / taux de marque → PV HT → PV TTC
arrondi), les remises quantitatives, les écotaxes, le stock, la photo, la centrale et les
statistiques. Il sert aussi de **bibliothèque** : `SupprArt` appelle `Articles.art_Suppr` sur
l'auto-instance.

## Points clés

- Fichier legacy : 4757 lignes, 144 fonctions dont 143 `Public`, CC 1127 ; `Maj_Zones` (CC 96),
  `Cmpt_KeyPress` (CC 84), `Cmpt_lostFocus` (CC 76), `EnrgArt` (CC 68).
- Nature **mixte** partout : calculs faits sur les chaînes des `TextBox` (`Format$`/`Val`, locale
  française), navigation pilotée par le `Tag` des contrôles des groupes `Cmpt`, `Stock`, `Btn`, `Ard`
  et par des drapeaux d'instance (`b`, `Chkfocus`, `Chkf`, `Reaf`, `nouveau`…).
- Enregistrement : `INSERT` (61 colonnes) + `UPdate` (23) à la création, deux `UPdate` (37 + 47)
  en modification ; export vers le serveur de prix (`Serveur.Pass`) sous la garde
  `Variables.Sprix And Sexport And SMajArt` (10 occurrences).
- Code mort : 6 fonctions sans appel, une vingtaine de variables d'instance inutilisées, une branche
  `mo_code` inatteignable dans `Update_Req`.
- Utilisé par son auto-instance (`Fmenu`, F3/F4 d'`Achat`, `Facture`, `TarTypeCli`,
  `Prodcomposes`) et par `New Articles(Null, code)` (`GesTar`).

## Dépendances principales

- Utilise : `Utils` (db, `cpoint`, `CDec`, `Find_cbarre`, `Calcode`, `Next_Code`…), `Cbase`,
  `CPrix` (`Cascade`, `CTva`), `ArtPromo`, `MajEqu`, `LGed`, `LPrix`, `TriGen`, `ObjProp`, `Gridvi`,
  `Artopt`, `Serveur`, `Variables`, écrans `TriHistos`, `Etiqart`, `Etigond`, `Etiqcasier`,
  `TarTypeCli`, `CoefTypeC`, `Materiel`, `ACom`, `AFacture`, `Famille`, `FFournisseur`.
- Utilisé par : `Fmenu`, `Achat`, `Facture`, `TarTypeCli`, `Prodcomposes`, `GesTar`, `SupprArt`.
- `Bsel`/`Bval` écrits par `TriGen` via `Object.SetProperty` (restent `Public`).

## Risques

- **ARTICLES-A01 (grave)** : Suppr dans le champ code-barre exécute `DELETE FROM Fiches_Art …
  and art_cbarre = …` : la fiche article est supprimée sans confirmation quand le code-barre est le
  principal.
- **A03** : la locale `b` d'`EnrgArt` masque le membre : doublons (référence fournisseur, code-barre,
  référence centrale) et changement de famille interdit (BL) n'empêchent pas l'enregistrement.
- **A04** : `art_Suppr` contrôle le stock sur les champs de l'écran : `SupprArt` supprime des
  articles en stock. **A05** : orphelins (composants, promotions, tarifs, stocks dépôts, liens de
  remplacement inverses…) par rapport à `Changefam.Modifart`. **A06** : `SHOW TABLES`/`DELETE IGNORE`
  non portables SQLite, échec silencieux.
- **A02** (équivalences supprimées en masse par Suppr), **A08** (`FamLF` : littéraux adjacents,
  ancien code famille remis), **A09** (changement de décimales qui vide codes-barres et équivalences),
  **A10/A11** (SQL concaténé), **A15** (contrôle « stocké » jamais branché).
- **LGED-A07** à requalifier (A07) : les documents GED sont bien supprimés ; seul le fichier reste
  sur le disque.
- Variables d'état multiples et auto-instance partagée : tout rework doit être couvert par replay.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 3775 |
| Lignes de commentaire | 334 |
| Fonctions | 145 |
| Fonctions Public | 144 |
| Complexité cyclomatique totale | 1128 |
| Complexité max (fonction) | 96 (`Maj_Zones`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

18 tests proposés, **à valider par l'utilisateur** avant la phase 2 (module complexe) :
17 `replay` (création, modification, chaîne de prix et arrondis, alertes, tarifs et coefficients
par type de client, promotion, GED, suppression unitaire et en masse, codes liés, famille,
décimales, références uniques, listes et filtres, SQLite, option métier, matériel/photo) et
1 `gbtest` sur les fonctions pures extraites (ARTICLES-T16). Les anomalies sont figées (base jetable
pour A01/A02).

## Rework

18 étapes sans changement de comportement (ARTICLES-001 à 018) : documentation, code mort,
`Cbase.Table`, garde `Serveur.Actif`, helpers d'idiomes, découpage de `Maj_Zones` et `EnrgArt`,
validations `*LF`, fonctions de prix pures, arrondi commun (`Movr`, `Materiel`, `FTvav`), grille de
remises commune (`Famille`), promotion du jour (`ArtPromo`), requêtes N+1, séparation de
`art_Suppr`, réduction de portée. 18 anomalies (ARTICLES-A01 à A18) soumises à validation.
