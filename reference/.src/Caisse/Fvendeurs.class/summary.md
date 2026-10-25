# Fvendeurs — Synthèse

> Source : `.src/Caisse/Fvendeurs.class` · Synthèse des autres documents.

## Rôle

Écran de gestion de la table des vendeurs/caissières (`Fiches_Vendeurs` : code, nom, mot de
passe chiffré, administrateur), ouvert depuis le menu Gestion (`Fmenu.Menu206` modal,
`Fmenu.Menu287` non modal) sur son auto-instance.

## Points clés

- Même gabarit d'écran de table que `Fcaisses` (liste + groupe `Cais` + groupe `Btn`).
- Mot de passe chiffré par `hexdblKey` (clé fixe), transporté dans une colonne de largeur 1 et
  déchiffré dans la zone de saisie au clic.
- Contrat `admin = -1` lu par `Cmenu` pour protéger les préférences de caisse.

## Dépendances principales

- Appelant : `Fmenu` (`Menu206_Click`, `Menu287_Click`).
- Utilise : `Utils.db`, `Utils.SetEditColor`, `hexdblKey`.
- Table : `Fiches_Vendeurs`, lue par `Ouverture`, `Svendeur`, `Cmenu`, `Caisse`, `ConVendeurs`.

## Risques

- Suppression de la ligne sélectionnée au lieu du code saisi, SQL par concaténation, erreur non
  interceptée sans sélection (FVENDEURS-A01).
- Enregistrement par n'importe quelle touche sur le bouton (A02) ; liste masquée par Échap (A03).
- Mots de passe lisibles par tout utilisateur de l'écran, code vendeur non contrôlé (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 163 |
| Lignes de commentaire | 31 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 9 (`Cais_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 scénarios `replay` (FVENDEURS-T01 à T06) : création, refus, modification, suppression,
clavier, ouverture par les deux menus.

## Rework

6 étapes sans changement de comportement (FVENDEURS-001 à 006) : documentation, code mort,
séparation traitement/GUI, helper `LVendeur`, gabarit d'écran de table commun avec `Fcaisses`,
réduction de portée de 5 fonctions. 4 anomalies (FVENDEURS-A01 à A04).
