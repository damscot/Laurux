# Remisecli — Synthèse

> Source : `.src/Gestion/Tables/Remisecli.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de la table des remises par client et par famille (`Fiches_RemCliFam`), lue par `TarArt`
et `Facture`. Grille virtuelle filtrable et triable par client, saisie client / famille /
remise, enregistrement et suppression.

## Points clés

- Grille alimentée par `Utils.Base` (résultat global `Utils.rs1`) et `Tabcli_Data`.
- En-têtes `TextBox` interactifs : filtre par préfixe et inversion du tri sur le client ; le
  tri par famille n'est pas branché (handlers `Cdf_*` inactifs).
- Gabarit de saisie commun avec `Remisec` et `CoefTypeC` ; contrôles `Quitte_*` non bloquants.
- Filtre concaténé dans le SQL.

## Dépendances principales

- Utilise : `Utils` (`Base`, `rs1`, couleurs, observateurs, `cpoint`), `Cbase` (`RemCliFam`,
  `TabCli`, `TabFam`), `Doc`.
- Utilisé par : `Fmenu` (ouverture) ; la table est lue par `TarArt` et `Facture`.

## Risques

- Tri / filtre par famille inopérant (A01).
- SQL concaténé avec le texte tapé (A02).
- Enregistrement de clients / familles inexistants (A03).
- Repositionnement après suppression de la dernière ligne (A04, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 351 |
| Lignes de commentaire | 37 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 86 |
| Complexité max (fonction) | 12 (`Rem_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 scénarios `replay` (REMISECLI-T01 à T07) : création, modification, saisie invalide,
suppressions, filtre et tri par client, en-tête famille, caractères spéciaux.

## Rework

6 étapes (REMISECLI-001 à 006) : documentation, code mort (dont `Cdf_*` si A01 est refusée),
fusion de `Deb2`/`Deb3`, réduction de portée de 11 fonctions, séparation traitement/GUI,
gabarit commun avec `Remisec`/`CoefTypeC`. 4 anomalies (REMISECLI-A01 à A04).
