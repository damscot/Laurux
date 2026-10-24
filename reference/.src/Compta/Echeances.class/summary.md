# Echeances — Synthèse

> Source : `.src/Compta/Echeances.class` · Synthèse des autres documents.

## Rôle

Écran de paramétrage des conditions d'échéance (`Fiches_Echeances` : code, libellé, durée, jour,
fin de mois) : liste, création, modification, suppression, et simulateur de date d'échéance
(`Utils.Calcech`). Ouvert depuis `Fmenu` (`Menu131_Click`).

## Points clés

- Écran GUI CRUD simple : 3 formes de requêtes sur une seule table, nommée en dur
  (`Cbase.Table("TabEch")` existe mais n'est pas utilisée).
- Saisie pilotée par le handler de groupe `ech_KeyPress` (enchaînement des champs par tag).
- Le simulateur délègue le calcul à `Utils.Calcech` ; sa fin (`Date(dateech, …)`) est du code mort.
- Normalisation de date par sentinelle `"00.00.0:00"`, dupliquée dans `Tresor`.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Calcech`, `Utils.Cdate_calc`/`Cdate_aff`, `Utils.convBool`,
  `Utils.SetEditColor`, `Utils.Observers`, `Start.Son`/`Musique`.
- Utilisé par : `Fmenu` uniquement. Les données sont lues par `FClient`, `FFournisseur` et la
  facturation (`Facture`, `ObjFac`, `ValidBR`, `Moulinage`).

## Risques

- Suppression sans contrôle d'usage par les fiches tiers (ECHEANCES-A01).
- Conversion du booléen `finmois` non homogène entre lecture liste et rappel par code (A04).
- Faible risque de régression au rework : écran isolé, un seul point d'entrée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 220 |
| Lignes de commentaire | 68 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 57 |
| Complexité max (fonction) | 18 (`ech_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 replays (ECHEANCES-T01 à T08) : liste, création, modification, suppression, simulateur,
contrôles de saisie, rappel par code, normalisation de date. Valeurs attendues capturées dans le
clone Laurux non modifié ; critère = dump de `Fiches_Echeances`.

## Rework

6 étapes (ECHEANCES-001 à 006) : documentation, suppression du code mort du simulateur et d'une
branche de tag inexistante, passage par `Cbase.Table`, séparation SQL/GUI, helper de date commun
avec `Tresor`, réduction de portée de 5 méthodes. 4 anomalies (A01 à A04) soumises à validation.
