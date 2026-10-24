# Cielimp — Synthèse

> Source : `.src/Compta/Cielimp.class` · Synthèse des autres documents.

## Rôle

Import unique des écritures d'un fichier Ciel (positions fixes) dans `Fiches_Mvt` : contrôle
préalable (équilibre, comptes, correspondances tiers et journaux), création automatique des
comptes généraux absents, insertion des écritures et des lignes collectives, mise à jour des
soldes et des compteurs.

## Points clés

- `controle_comptes` (CC 54) et `Compta` (CC 24) mêlent lecture de fichier, SQL et messages.
- `Compta2` (158 lignes, variante Sage) est du code mort, copie à 92 % de `Compta`.
- Le bloc DDL de `Btn_Click` duplique `Utils.Ciel()` avec une longueur différente.
- `Ecritures`/`Majnum` : idiome de numérotation recopié dans 6 fichiers.
- Compte de trésorerie `51210000` en dur.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.cpoint`, `Utils.PointBase`, `Editeur`, `Doc`.
- Utilisé par : `Fmenu` (1 appel).
- Lié à `Cielcorsp`/`Cielcorspj` (tables `Ciel_Lrx*`) et `impfec`.

## Risques

- Import non transactionnel : une erreur en cours (compte de tiers sans fiche, A03) laisse un
  import partiel réimportable en double.
- Relance impossible dans la même fenêtre après création de comptes (A01).
- Conversion des montants dépendante du séparateur (A04) ; trésorerie mal détectée (A05).
- Format Ciel reconstitué depuis le code : à confirmer avec un export réel.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 520 |
| Lignes de commentaire | 45 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 140 |
| Complexité max (fonction) | 54 (`controle_comptes`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 replays (CIELIMP-T01 à T11 : nominal, comptes créés, relance, journal ou tiers manquant,
déséquilibre, déjà importé, fichier absent, trésorerie, montants, tiers sans compte) et 1 gbtest
(T12) sur le découpage de ligne.

## Rework

8 étapes (CIELIMP-001 à 008) : documentation, suppression de `Compta2` et du code mort,
numérotation commune, `Cbase.Table`, découpage de ligne pur, réduction de complexité,
séparation traitement/GUI, réduction de portée. 9 anomalies (CIELIMP-A01 à A09).
