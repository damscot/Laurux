# DocActif — Synthèse

> Source : `.src/Communs/DocActif.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Service de **verrous applicatifs** sur les documents (`Is_Lock`, `Get_Lock`, `Free_Lock`), stockés
dans `Fiches_Docactif` avec l'identité du propriétaire (utilisateur, PID, machine-id, hôte, login
de base), et fenêtre d'administration de ces verrous (Fmenu `Menu328`).

## Points clés

- Utilisé via l'**auto-instance** de la fenêtre par 9 fichiers : `Facture`, `Facturergbl`,
  `ObjFacB`, `Caisse`, `commande1`, `Materiel`, `Tresor`, `EcrAuto`, `Parametre`.
- Sections critiques en `LOCK TABLES WRITE` / `UNLOCK TABLES` (neutralisées sous SQLite).
- Reprise d'un verrou d'un processus mort du même poste (`ps -p`), refus sinon.
- Identité calculée par trois `Shell` dans `_new`.
- Fonction la plus complexe : `Get_Lock` (CC 13).

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Base2`/`Utils.rs2`, `Utils.Bip`, `Cbase.Table("TabActif")`.
- Utilisé par : les 9 fichiers ci-dessus ; `Facture`, `Caisse`, `commande1`, `Facturergbl`,
  `ObjFacB` exploitent la valeur renvoyée.

## Risques

- `Free_Lock` renvoie toujours `False` alors que `Facture` teste ce retour (A01).
- `Return False` sans `UNLOCK TABLES` (A02, chemin aujourd'hui inatteignable).
- Dialogues modaux pendant le verrou de table : blocage des autres postes (A03).
- Suppression manuelle sans contrôle et dépendance au global `Utils.rs2` (A04).
- Retour de `Get_Lock` porté par une variable `String` (conversion implicite correcte, fragile).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 149 |
| Lignes de commentaire | 11 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 13 (`Get_Lock`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests (DOCACTIF-T01 à T12) : 4 `gbtest` (verrou libre, `Is_Lock`, libération propre, statut
pur après séparation) et 8 `replay` (même processus, processus mort ou vivant, autre poste,
libération étrangère ou absente, fenêtre d'administration, intégration `Parametre`). Comparaison du
dump de `Fiches_Docactif` avec identités masquées.

## Rework

6 étapes sans changement de comportement (DOCACTIF-001 à 006) : documentation, typage de `bok`,
suppression d'un `Shell`, séparation SQL/dialogues avec un statut pur, factorisation des messages,
réduction de portée de `Deb1`. 4 anomalies (DOCACTIF-A01 à A04) soumises à validation utilisateur.
