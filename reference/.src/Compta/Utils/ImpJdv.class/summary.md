# ImpJdv — Synthèse

> Source : `.src/Compta/Utils/ImpJdv.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre « Import du JDV Laurux » (Comptabilité > Outils, quand `/Exp` est faux) : intègre en
comptabilité les fichiers `clients.txt` et `ecritures<JJ>.csv` produits par `ExportJdv` (format
« 1- Fichier texte ») : création / mise à jour des clients et de leur compte, contrôle des comptes
généraux, import des écritures avec lignes collectif et mise à jour des soldes.

## Points clés

- Dump préalable de la base par `mysqldump` construit à la main (`Sauve`).
- Clients : 31 champs lus sans protection ; création (`Creation_Client`) ou mise à jour
  (`Maj_Client`) de `Fiches_Cli` et `Fiches_Comptes` ; liste PDF des clients créés (`Cclients`).
- Comptes manquants listés via la table de travail `Nvcompte` et `Nvcomptes.txt` : import bloqué.
- Écritures : nouveau numéro sur chaque ligne 411 (+ ligne collectif), contreparties sur le même
  numéro ; doublon = même compte et même pièce ; solde mis à jour ligne à ligne ; pas de transaction.
- Copie adaptée par `ImpSage` (7 fonctions identiques) ; vestiges Kugar morts.

## Dépendances principales

- Appelant unique : `Fmenu.Menu134_Click`.
- Utilise `Utils.db`, `Utils.cpoint/PointBase/Cdate_Dbase`, `Cclients`, `Visualiseur`, `Editeur`,
  `Doc`, `Start.LocalSettings` (`/Soc<XX>/Chemin-import`).
- Tables : `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Journaux`,
  `Nvcompte` ; couplage de format avec `ExportJdv`.

## Risques

- **Grave** : chaque écriture importée remet à vide `Fiches_Parametres.dnfac` (dernier numéro de
  facture), utilisé par `Moulinage` et `EcrAuto` (IMPJDV-A01).
- Création de client probablement en erreur (`Cclients.Level2` attend 13 arguments, A04) et champs
  décalés dans l'`INSERT` (A02) ; téléphones inversés à la mise à jour (A03).
- Fichiers produits par `ExportJdv` (en-tête société) non relus par `ImpJdv` (A05, à confirmer).
- Compteur de rejets inopérant, import non transactionnel, contreparties rattachées à la mauvaise
  écriture en cas de rejet partiel (A06, A07) ; dump mal nommé (A08) ; SQL par concaténation (A09).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 533 |
| Lignes de commentaire | 41 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 85 |
| Complexité max (fonction) | 17 (`Compta`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests `replay` avec fichiers d'entrée de référence et diff des tables `Fiches_Cli`,
`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`, `Nvcompte` : import nominal, création de
clients, comptes manquants, ré-import, clôture, aller-retour avec ExportJdv, fichiers absents,
refus de confirmation, apostrophe. Plusieurs sont des tests de caractérisation d'anomalies.

## Rework

11 étapes (IMPJDV-001 à 011) : documentation, code mort (vestiges Kugar, `Parametres` en boucle),
réduction de portée de 11 fonctions, `Utils.DumpBase`, module commun d'import comptable avec
`ImpSage` (numéro d'écriture, ligne `Fiches_Mvt`, solde, collectif), état client structuré,
`Cbase.Table`, séparation traitement/GUI. 10 anomalies (IMPJDV-A01 à A10) soumises à validation.
