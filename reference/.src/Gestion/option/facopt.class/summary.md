# facopt — Synthèse

> Source : `.src/Gestion/option/facopt.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Onglets « consignes » et « régie » de l'écran `Facture` en option boisson : construit ses
contrôles par code dans deux panneaux de `Facture`, affiche droits et consignes du BL, gère la
saisie des déconsignes et maintient `Fiches_ligcons` quand les lignes de facture changent.

## Points clés

- Pas de `.form` ; instanciée une seule fois par `Facture.modifpanel5` (`As "option"`).
- Événement `recalcul` → `Facture.option_recalcul` à chaque changement du total des déconsignes.
- Nature mixte : SQL et remplissage de grilles mêlés ; nombreux blocs dupliqués (consignes
  palette/colis/bouteilles ×2, zones de saisie ×3).
- Code mort : `majdroit` (inexécutable) et 11 propriétés sans lecteur.
- `Utils.Observers` commenté : rejeu des contrôles dynamiques à vérifier.

## Dépendances principales

- Utilisé par : `Facture` (seul appelant).
- Utilise : `Calculdroit`, `Rechcons`, `TriArticles` (retour `Bsel`/`Bval`), `Utils`.
- Tables : `Fiches_ligcons`, `Fiches_consigne`, `Fiches_ligregie`, `Fiches_regie` (créées par
  `modfichier`), `Fiches_Art`, `Fiches_Ligbl`, `Fiches_Bl`.

## Risques

- A01 : déconsignes modifiables sur une facture imprimée via les grilles.
- A02 : la sélection multiple déconsigne aussi les lignes non sélectionnées.
- A03-A05 : perte d'une déconsigne rappelée puis abandonnée, libellé de régie vide, saisies
  invalides ignorées en silence.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 875 |
| Lignes de commentaire | 28 |
| Fonctions | 48 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 173 |
| Complexité max (fonction) | 19 (`grpnb_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests `replay` (FACOPT-T01 à T08) depuis l'écran `Facture` en option boisson, jeu
`facturation_boisson` ; dump de `Fiches_ligcons`.

## Rework

7 étapes (FACOPT-001 à 007) : documentation, code mort, portée de `mabsaisie`, helpers de
création de consignes et de contrôles, `LitConsigne` commun avec `artopt`, séparation
traitement/GUI. 5 anomalies (A01 à A05).
