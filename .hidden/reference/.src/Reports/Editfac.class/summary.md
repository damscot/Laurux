# Editfac — Synthèse

> Source : `.src/Reports/Editfac.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

État imprimé (report **gb.report**, `Editfac.report`) des documents de vente : facture, avoir,
BL, devis/estimation, commande, proforma, fiche atelier, factures fin de mois et d'abonnement.
Le constructeur adapte la mise en page au document décrit par un `ObjFacB` ; dix handlers
`*_Data` fournissent les valeurs des lignes au moteur de report.

## Points clés

- Jamais instancié directement : seule la sous-classe `EditfacB` est créée
  (`New EditfacB(Me, Me)` dans `ObjFacB`, 5 sites), puis imprimée par `edit.Print(imp)`.
- `EditfacB` surcharge `code_Data` et `intitule_Data` : les versions d'`Editfac` ne
  s'exécutent pas aujourd'hui (limite connue de `deps.py`).
- `_new` : CC 112, 315 lignes ; 2 requêtes (`Fiches_Societes` filtrée par `cd_sc`, `Fiches_Bl`),
  noms de table en dur ; `Message.Question` dans le constructeur.
- `lgint`, `clr`, `longueur` sont `Public` pour `EditfacB` ; `$vfac` est réductible.
- Remplace depuis 2019 (`a2e027f1`) les éditions de facture PDF de `Cdocuments`/`Cdocuments2`.

## Dépendances principales

- `ObjFacB`/`ObjFac` (≈ 60 membres lus, énumération `choix`), `EditfacB` (sous-classe),
  `LDate`, `LTaxe`, `Utils.db`, `Utils.totobs`, `Start.LocalSettings` (logos).
- Dépendance circulaire `ObjFacB` → `EditfacB` → `Editfac` → `ObjFacB`.

## Risques

- **EDITFAC-A01** : « Duplicata facture n° » inatteignable, une facture réimprimée depuis
  l'archive porte « Facture n° ».
- **EDITFAC-A02** : lignes de TVA inutilisées jamais masquées (espace vide), taux au-delà de 5
  ignorés.
- **EDITFAC-A03** : « Total BL a facturer » compte devis, commandes et BL déjà facturés.
- Question posée dans le constructeur : bloque les chaînes non interactives (mail) et doit être
  enregistrée dans les replays.
- Tout changement d'`ObjFac`/`ObjFacB` (membres lus) se répercute sur l'état imprimé.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 476 |
| Lignes de commentaire | 23 |
| Fonctions | 14 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 154 |
| Complexité max (fonction) | 112 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `replay` (EDITFAC-T01 à T10) par la chaîne réelle de facturation (option `N`) sur le
jeu `facturation_base` : facture HT/TTC, multi-pages, avoir/duplicata, BL, devis/commande/
proforma, fiche atelier, régimes sans TVA, options d'affichage, lignes de TVA. Comparaison du
texte `pdftotext` (+ `pdfinfo`, `-bbox`), valeurs produites dans le clone non modifié, date
figée. L'option boisson est couverte par les tests d'`EditfacB`.

## Rework

9 étapes (EDITFAC-001 à 009) : documentation, code mort (`tot`, `New LTaxe`), `$vfac` en
`Private`, découpage de `_new`, `LigneDoc` partagée avec `EditfacB`, simplification d'`edtva`,
`Cbase.Table` et `COUNT(*)`, séparation des lectures SQL et de la question, en-tête société par
`LEnteteSoc`. 3 anomalies (A01 à A03).
