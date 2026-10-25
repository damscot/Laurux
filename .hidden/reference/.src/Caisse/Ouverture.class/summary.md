# Ouverture — Synthèse

> Source : `.src/Caisse/Ouverture.class` · Synthèse des autres documents.

## Rôle

Écran « Identification caisse » : connecte une caisse du poste à un vendeur après contrôle de son
mot de passe. Ouvert en modal par `Cmenu` (auto-instance), piloté aussi par le clavier virtuel
`Clavier`. La connexion crée `~/Caisse<n>.lock`, écrit `/Soc<XX>/caisse/Ncai`, fixe
`Start.$tcai` et met à jour `Fiches_Caisses` (`dteov`, `connecte = 1`, `vdr_code`).

## Points clés

- **Module complexe** : moitié « ouverture » du cycle de caisse (fermeture dans `Cmenu`, ticket Z
  dans `Moulinage`).
- `Rvdr(caisse)` (nom du vendeur connecté) est appelée par `Fondcaisse` sur l'auto-instance, ce
  qui construit une fenêtre `Ouverture` cachée.
- Code caisse lu sur 1 caractère, code vendeur sur 1 ou 2 caractères selon l'endroit.
- `Rcai` et `Org` : code mort ; `$clav` jamais utilisé.
- Fonction la plus complexe : `Button1_Click` (CC 19).

## Dépendances principales

- Appelants : `Cmenu` (`ShowModal`), `Clavier` (`Mdp`, `Button1_Click`), `Fondcaisse` (`Rvdr`).
- Utilise : `TestCaisses.TestCai`, `hexdblKey`, `Utils.db`, `Start.LocalSettings`, `Start.$tcai`.
- Tables : `Fiches_Caisses`, `Fiches_Vendeurs`.

## Risques

- Caisses de code ≥ 10 confondues avec la caisse du premier chiffre (OUVERTURE-A01).
- Code vendeur tronqué de façon incohérente, problème probable sous SQLite (OUVERTURE-A02).
- Erreur technique sur la ligne vide de la liste des caisses (A03) ; toute touche sur
  « Connecter » lance la connexion (A04) ; message « vendeur vide » jamais affiché (A05) ;
  connexion contrôlée par un verrou propre au compte Unix (A06, à confirmer) ; clavier virtuel
  fermé sur la mauvaise instance (A07).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 212 |
| Lignes de commentaire | 5 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 19 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 scénarios `replay` (OUVERTURE-T01 à T10 : listes, choix de caisse, connexion réussie ou
refusée, caisse déjà connectée, vendeur occupé, codes sur deux caractères, touche sur le bouton,
clavier virtuel, SQLite) et 1 `gbtest` (`Rvdr`, T11). **Liste à faire valider par l'utilisateur
avant la phase 2** (module complexe).

## Rework

10 étapes sans changement de comportement (OUVERTURE-001 à 010) : documentation, code mort
(`Rcai`, `Org`, `$clav`), déplacement de `Rvdr` dans un module, simplification de
`Button1_Click` et du drapeau `b`, séparation traitement/GUI, commonalisations (`LVendeur`,
`CaisseEtat`, `SurvolBoutons`), réduction de portée. 7 anomalies (OUVERTURE-A01 à A07).
