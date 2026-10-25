# commande1 — Synthèse

> Source : `.src/Gestion/Stock/commande1.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Entrée des articles » (Gestion › Achats/Réceptions) : commandes fournisseurs, bons de
réception, réception d'une commande (avec reliquat, numéros de série, vignettes en option
boissons), enregistrement des tarifs de vente et lancement de la validation des factures
(`ValidBR1`). Hôte des objets `Achat` (grille), `GesTar` (onglet tarifs) et `artopt` (options).

## Points clés

- États `Sans`/`CreaCommande`/`EnCommande`/`Reception`/`Validee` ; le bouton `rececp` change de
  rôle selon l'état ; `rececp_Click` (CC 29) concentre réception et validation.
- Fenêtre de sélection construite par code (radios + `TriGen`).
- **Transaction partagée** : `Begin` ici, `Commit` dans `Achat.EnrAch` en plein flux, tarifs
  (`GesTar`) hors transaction, `Commit` final sans `Begin`.
- Appelé sur l'auto-instance (`Fmenu`) ou avec un document (`ValidBR1`, `Stockmvt`).
- **Module complexe** : scénarios de test à valider par l'utilisateur avant la phase 2.

## Dépendances principales

- `Achat`, `GesTar`, `artopt`, `TriGen`, `TriCpt`, `DateTar`, `ValidBR1` (circulaire),
  `LGed`, `DocActif`, `VerifDate`, `Visualiseur`, `Utils.db` (requêtes préparées pour `GesTar`).

## Risques

- `SupTarTemp` en boucle sur le seul article courant (A01, avec GESTAR-A01).
- Clé de document écrasée à l'ouverture externe (A02, à confirmer).
- `GesTar` détaché après la première annulation (A03, à confirmer).
- Atomicité des enregistrements (A04, rework conjoint `Achat`/`GesTar`).
- Tags GED par SQL concaténé (A05) ; fermeture réentrante (A06) ; division par `art_txconv`
  (A07) ; écran non instrumenté pour le rejeu (A08).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 849 |
| Lignes de commentaire | 15 |
| Fonctions | 50 |
| Fonctions Public | 43 |
| Complexité cyclomatique totale | 219 |
| Complexité max (fonction) | 29 (`rececp_Click`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

14 tests `replay` (COMMANDE1-T01 à T14, liste à valider), complémentaires d'ACHAT-T01 à T14 et
des tests de `GesTar` : sélection, réception, reliquat, validation avec/sans écriture,
suppression, session à deux documents, abandon des numéros de série, vignette, ouverture externe,
GED, fermeture, infos de stock, numéros perdus.

## Rework

9 étapes (COMMANDE1-001 à 009) : documentation, code de débogage, découpage de `rececp_Click`,
réduction de portée, séparations calcul/affichage, `LGed.Archive`, fenêtres modales et vignette
communes, séquence d'enregistrement factorisée. 8 anomalies (A01 à A08) soumises à validation.
