# ObjFacB — Synthèse

> Source : `.src/Gestion/option/ObjFacB.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Sous-classe d'`ObjFac` (`Inherits ObjFac`), seule instanciée : objet d'édition des documents de
vente. Elle ajoute à `ObjFac` l'option boisson (consignes, déconsignes, droits de régie et
sécurité sociale, comptabilité matière, vignettes), les éditions (`editef`, `editebl`, `editefm`,
`visualisation`, `mail`) et l'archivage d'une facture (`transblfac`).

## Points clés

- `calcul` redéfinit le parent (`Super.calcul`) ; `verifdat` le masque en `Private`
  (`Super.verifdat`) : `ObjFac.calcul`/`verifdat` doivent rester `Public`.
- ~35 membres hérités utilisés par `Me.` : contrainte forte sur les réductions de portée d'`ObjFac`.
- Option lue par `Utils.Option()` : `N`, `B` (boisson), `P` (carburant), `T` ; les tables et
  colonnes de l'option sont créées par `modfichier`, hors `db_control.csv`.
- `calcul` (CC 56) est la fonction la plus complexe ; éditions mixtes SQL + GUI.
- `_call`, `totht`, `clotmat` et 4 variables privées sont du code mort (`deps.py` prend les
  `New ObjFacB(…)` pour des appels de `_call`).
- Tables par concaténation non vues par `deps.py` : `Fiches_HistoLigfacM`, `Fiches_BlM`,
  `Fiches_LigblM`, tables de travail `Facturefm`, `Bl`.

## Dépendances principales

- Utilisé par : `OptFac` (éditions, courriel), `Facture` et `ClotureF` (`calcul`, `transblfac`),
  `Moulinage` (`editef`, `comptmat`), `Stockmvt` (`visualisation`), `Caleditcmat` (`calcul`),
  `EditfacB`/`Editfac` (propriétés de cumul).
- Utilise : `ObjFac`, `Calculdroit`, `VerifDate`, `DocActif`, `EditfacB`, `Impression`, `EnvMail`,
  `ComMail`, `SaiReg`, `Utils`, `Cbase`, `Variables.sTexte`.

## Risques

- **A01** : archivage d'une facture multi-dépôt en erreur (colonnes `typel`/`dtefac` inexistantes).
- **A02** : `comptmat` laisse une transaction ouverte pour toute facture non boisson (à confirmer).
- **A03** : TVA des droits/sécu corrompue ou erreur de clé dupliquée.
- A05 : verrous `DocActif` non libérés en fin de mois ; A06 : contrôle de clôture des droits
  jamais exécuté en fin de mois ; A09 : matériels (MATERIEL-A11) ; A14 : suppression du BL hors
  transaction.
- Module complexe : scénarios de test à valider par l'utilisateur avant la phase 2.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 930 |
| Lignes de commentaire | 39 |
| Fonctions | 30 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 226 |
| Complexité max (fonction) | 56 (`calcul`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

18 tests (OBJFACB-T01 à T18) : 11 `gbtest` sur le calcul, la comptabilité matière, le poids et
l'archivage, 6 `replay` via `OptFac` (éditions, courriel, visualisation, dates) et 1 de
performance. Jeu `facturation_boisson` dérivé de `facturation_base` après `modfichier`.

## Rework

11 étapes sans changement de comportement (OBJFACB-001 à 011) : documentation, code mort,
découpage de `calcul`, helpers TVA/impression/verrous/courriel, `Cbase.Table`, séparation
traitement/GUI, propriété d'orientation partagée avec `EditfacB`. 16 anomalies (A01 à A16)
soumises à validation.
