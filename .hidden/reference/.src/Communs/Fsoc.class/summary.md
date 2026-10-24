# Fsoc — Synthèse

> Source : `.src/Communs/Fsoc.class` · Synthèse des autres documents.

## Rôle

Écran « Gestion des sociétés » : liste les sociétés (une base MySQL `Laurux<XX>` ou
`<préfixe>_Laurux<XX>` par société), affiche et enregistre la fiche `Fiches_Societes`, crée une
société (via `LauruxConf.Createbase`), supprime sa base, ouvre la duplication (`Dup`) et change la
société de travail (reconnexion, réécriture de `Laurux.conf`, redémarrage ou arrêt de Laurux).

## Points clés

- Écran **GUI** avec SQL intégré ; MySQL uniquement (`Utils.db.Databases`, requêtes inter-bases,
  `Shell mysql`, `ALTER DATABASE … COLLATE`).
- `Soc_KeyPress` (CC 30) : navigation au clavier par tag + calcul et contrôle du n° TVA
  intracommunautaire (`CTestTVA`).
- Trois copies de l'écriture « société de travail » et deux copies de la séquence de reconnexion
  (aussi présente dans `LauruxConf` et `Fmenu`).
- Code mort : `Nsoc` (copie de `Utils.Nsoc`), `Nbase_MouseDown` (contrôle inexistant), `Soc1`,
  `chkNbase`.

## Dépendances principales

- Utilisé par : `Fmenu.Menu26_Click` (`New Fsoc(Me)`), `Prgm.class:81` (appel sans argument,
  défaillant).
- Utilise : `Utils.db`, `Start.LocalSettings`/`Start.Societe`, `LauruxConf.Createbase`,
  `CTestTVA`, `Dup`, `MDP`, `Fmenu.Text`, `Syntheses`, `Doc`.

## Risques

- **Suppression** : `DROP DATABASE` sans préfixe, possible sur la base courante, clés de
  configuration incohérentes remises à zéro (A01, A02).
- **Préfixe** ignoré à la création et à la sélection (A03) ; création sans reconnexion (A05).
- Mot de passe MySQL en clair dans `ps` ; port et tunnel SSH ignorés par `Shell mysql` (A07).
- Contrôle TVA de logique inversée (A04) ; `Prgm` « Fsoc » probablement cassé (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 488 |
| Lignes de commentaire | 40 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 113 |
| Complexité max (fonction) | 30 (`Soc_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 replays (FSOC-T01 à T13) sur MariaDB Docker avec plusieurs bases société : ouverture, création,
modification, suppression, sélection (par la liste ; le bouton « Créer » ne déclenche pas l'ancien `Button4_Click`, code mort), TVA, navigation, préfixe, duplication.
Critère : dump de toutes les bases `Laurux*` et `Laurux.conf` final. Prérequis : `Host=127.0.0.1`,
port 3306, droits `CREATE`/`DROP DATABASE`.

## Rework

11 étapes sans changement de comportement (FSOC-001 à 011) : documentation, code mort (dont
`Button4_Click`, jamais déclenché car `Button4` est dans le groupe `Btn`), réduction de
portée, `Cbase.Table`, table de navigation pour `Soc_KeyPress`, helpers partagés avec `LauruxConf`
(`Utils.OuvreBase`, `Utils.BasesLaurux`) et `CTestTVA` (SIREN), séparation SQL/GUI. 10 anomalies
(FSOC-A01 à A10) soumises à validation, dont A08 sans objet (code mort).
