# Caisse — Synthèse

> Source : `.src/Caisse/Caisse.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de point de vente (PDV/POS, `./Laurux -p`, ouvert par `Cmenu` via `New Caisse`) : saisie
des articles d'un ticket, remises, avoirs, crédits, 12 modes de règlement, fidélité, hors vente,
acomptes, tickets en attente, bons de caisse et règlement de BL/factures, impression (ESC/POS série
ou PDF), facturettes, tickets X/Z, tiroir, afficheur et balance.

## Points clés

- 8 734 lignes, 242 fonctions (dont ~150 handlers), CC totale 2 102, max 77 (`Art_man`) :
  fichier legacy, reworks minimaux seulement (AGENTS.md règle 21).
- Le ticket vit dans le contrôle `LigTk` (13 colonnes, ~30 types de ligne), les règlements dans
  `ColumnView1` ; `Aff_bastk` construit le bas de ticket (TVA via la table partagée `Tottva`),
  `Enrg_Tk` (CC 72) enregistre tout : `Fiches_EntTicketz`, `Fiches_LigTicketz`, avoirs, acomptes,
  totaux de caisse, BL du client en compte (`Moulinage.Generation_BL`), chaînage SHA1.
- La bande Z délègue à `Moulinage.Livre_caisse` l'archivage (`Fiches_HisEntTickets`), la
  comptabilisation et la facturation des BL réglés en caisse (`Fiches_Bl.numtick`).
- Aucune transaction ; stock mouvementé avant l'enregistrement ; montants en chaînes.
- 19 groupes fonctionnels documentés (G01-G19) ; flux des règlements détaillé dans architecture.md.

## Dépendances principales

- Utilise : `Utils.db`, `Cbase`, `ArtPromo`, `Moulinage`, `Sha1Calc`, `DocActif`, `Impression`,
  `Cfacture`, `EnvMail`, `TriCpt`, `TriArticles`, `TriFacture`, `Tricartes`, `Svendeur`, `FCalc`,
  `Fondcaisse`, `hexdblKey`, `numtostring`.
- Utilisé par : `Cmenu` (ouverture) ; accès par le nom de classe (auto-instance) depuis
  `Svendeur`, `Cfacture`, `Attrib` ; retours `Bsel`/`Bval` par `Object.SetProperty`.
- Tables : tickets du jour, caisses, paramètres, articles/stock/dépôts, avoirs, acomptes, BL,
  clients/comptes, cartes, touches, TVA ; ~7 tables nommées en dur.

## Risques

- **Chèques** : `numtostring.nbtostring` absente du module compilé → impression du chèque en
  erreur (A01).
- **Remises quantitatives** jamais appliquées (tableau `Rms` à une dimension, vérifié, A02).
- **Caisse à dépôt** : `Maj_QteDep` lit une colonne inexistante → validation interrompue (A03).
- **Auto-instance** : changement de vendeur sans effet (A04), mise en page A4 jamais utilisée
  (A05), client divers des facturettes (A06, A07).
- TVA d'entête fausse avec plusieurs taux (A18), table `Tottva` partagée entre caisses et non
  SQLite (A17), bande Z « série » marquée faite sans clôture (A15), archives PDF erronées (A16),
  dépassement d'encours accepté sans mot de passe (A13), stock mouvementé sans ticket enregistré
  (A29).
- Matériel (TPE, imprimante ticket, tiroir, afficheur, balance) non testable automatiquement.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 7303 |
| Lignes de commentaire | 397 |
| Fonctions | 242 |
| Fonctions Public | 240 |
| Complexité cyclomatique totale | 2102 |
| Complexité max (fonction) | 77 (`Art_man`) |
| Variables globales | 0 |
| Variables Public | 7 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

25 tests proposés (CAISSE-T01 à T25), **à faire valider par l'utilisateur avant la phase 2** :
24 `replay` (vente, lignes particulières, remises, règlements multiples, avoirs, acomptes, crédit,
hors vente, attente, bon de caisse, règlement de BL, fidélité, X/Z, facturettes, mot de passe,
modes d'impression, écran tactile, stock, rétrocession, promotion, SQLite, vendeur, performance,
périphériques série simulés) et 1 `gbtest` sur les fonctions pures extraites. Jeu dérivé
`jeu_caisse.sql` indispensable (`Laurux01.sql` ne contient aucune donnée de caisse). Rejeu limité
pour les touches `ImageButton` (Clav2/Clav3) et les grilles `LigTk`/`ColumnView1` sans `_Click`.

## Rework

18 étapes sans changement de comportement (CAISSE-001 à 018) : documentation (cycle du ticket,
types de ligne, raccourcis), code mort (6 fonctions, branches internes), commonalisations
(promotion du jour, arrondi, tables `Cbase`, numéro de carte, clavier virtuel), factorisation des
dix aiguillages de modes de paiement et des fins de validation, séparation traitement/GUI dans
`Enrg_Tk`, le stock, l'encours et l'impression, réduction de portée. 31 anomalies (CAISSE-A01 à
A31) soumises à validation utilisateur.
