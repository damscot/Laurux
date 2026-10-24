# GesTar — Synthèse

> Source : `.src/Gestion/Entrées/GesTar.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Panneau des tarifs de vente incrusté dans l'écran d'achat `commande1` : pour l'article de la
ligne d'achat courante, il affiche et fait saisir le tarif général, les tarifs par client et par
type de client (coefficient de marge → prix HT/TTC par cascade `LPrix` + `LTaxe`), puis les
enregistre immédiatement (`Fiches_Art`, `Fiches_Tarcli`, `Fiches_TarTypcli`) ou en différé
(`Fiches_TarTemp`, appliqué au démarrage par `DateTar.EnrTouTar`).

## Points clés

- Trois `SaiTableau` créés `As "Tarif"`, une quinzaine de handlers d'observateurs.
- Les saisies sont conservées par ligne d'achat dans un `VarMajTar` (`AutresObj[Achat.Tarif]`).
- `IgnoreTarif` signifie en réalité « mettre à jour les tarifs ».
- Fonctions les plus complexes : `EnrTar` et `affichetarif` (CC 14).
- `Enreg_Click`/`majtarif_Click` : faux positifs de `deps.py` (contrôles publics `!`).

## Dépendances principales

- Utilise : `SaiTableau`, `Sailig`, `ObjProp`, `LPrix`, `LTaxe`, `VarMajTar`, `TriCpt`,
  `Utils.db`.
- Utilisé par : `commande1` (instanciation, `LecArt`, `ligachat`, `EnrTar`, `EnrTarTemp`,
  `EnrArt`, `EnrEtiqu`, `SupTarTemp`, `Delete`), `DateTar` et `VarMajTar` (énumérations).

## Risques

- Suppression d'un achat : seuls les tarifs temporaires du dernier article lu sont supprimés
  (A01).
- Division par zéro sur un prix de revient nul (A02) ; `art_dpa` renseigné avec l'ancien prix
  (A03, à confirmer) ; remise sans `%` tronquée (A05).
- Transactions imbriquées avec `commande1` (A07, à confirmer).
- Cascade de prix dupliquée dans 5 fichiers, avec des variantes (marge, remise négative,
  montant) et un calcul différent dans `TarArt`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 675 |
| Lignes de commentaire | 21 |
| Fonctions | 41 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 145 |
| Complexité max (fonction) | 14 (`EnrTar`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 scénarios `replay` depuis l'écran d'achat (GESTAR-T01 à T10) : cascade de prix, saisie
inverse HT/TTC, tarifs client et type, enregistrement immédiat et différé, suppressions,
prix de revient nul, étiquettes. Un gb.test de la cascade deviendra possible après GESTAR-008.

## Rework

9 étapes (GESTAR-001 à 009) : documentation, code mort, factorisation de `EnrTar` et
`EnrTarTemp`, `Cbase.Table`, réduction de portée de `EnrTarArt`, séparation traitement/GUI,
fabrique de prix commune avec `DateTar`/`VarMajTar`/`TarTypeCli`, helper de coefficient.
7 anomalies (GESTAR-A01 à A07).
