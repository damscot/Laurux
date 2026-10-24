# ImpSage — Synthèse

> Source : `.src/Compta/Utils/ImpSage.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre « Import écritures Sage » (Comptabilité > Outils) : import de deux fichiers Sage à
positions fixes, `clients.pnc` (tiers) et `ecritures.pnm` (écritures), avec création des clients
et fournisseurs inconnus, correspondance de codes dans `Corsage`, création automatique des comptes
généraux manquants et import des écritures avec lignes collectif et mise à jour des soldes.

## Points clés

- Copie adaptée d'`ImpJdv` : 7 fonctions identiques ou quasi, vestiges Kugar, `Maj_Client` et
  `Maj_Parametres` morts.
- Numérotation des tiers par `Compteur`/`Compteurf` (identique à `Impclient.Compteur`).
- Journaux Sage convertis par une table en dur (`ACH`→60, `VTE`→70, …).
- `Controle` sans effet (fichier jamais affecté) ; `ControleS` crée les comptes manquants.
- `ComptaS` : CC 50, nouveau numéro d'écriture à chaque changement de pièce.

## Dépendances principales

- Appelant unique : `Fmenu.Menu286_Click`.
- Utilise `Utils.db`, `Utils.cpoint/PointBase`, `Cclients.Level2S`, `Visualiseur`, `Editeur`, `Doc`,
  `Start.LocalSettings` (`/Soc<XX>/Chemin-import`), commande `mysqldump`.
- Tables : `Corsage`, `Fiches_Cli`, `Fiches_Four`, `Fiches_Comptes`, `Fiches_Mvt`,
  `Fiches_Parametres`, `Nvcompte`.

## Risques

- **Grave** : un code Sage déjà connu écrase le compteur de client ; le tiers inconnu suivant est
  rattaché à un client existant (IMPSAGE-A01).
- Fournisseurs testés dans la table clients (A02) ; double insertion des lignes de tiers dont le
  code dépasse `411099`/`401099`, soit la plupart (A03, à confirmer).
- Écritures sans intitulé, compteur de rejets inopérant, pas de transaction (A04) ; comptes créés
  silencieusement (A05) ; code Sage tronqué dans `Corsage` (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 699 |
| Lignes de commentaire | 59 |
| Fonctions | 24 |
| Fonctions Public | 24 |
| Complexité cyclomatique totale | 172 |
| Complexité max (fonction) | 50 (`ComptaS`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests prévus : 8 `replay` (fichiers `.pnc`/`.pnm` de référence, diff de `Corsage`,
`Fiches_Cli`, `Fiches_Four`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`) dont plusieurs
de caractérisation, et 2 `gbtest` sur les helpers `ProchainCodeTiers` et `LigneSage` après
extraction.

## Rework

10 étapes (IMPSAGE-001 à 010) : documentation, code mort, réduction de portée de 15 fonctions,
`Utils.DumpBase`, `ProchainCodeTiers` partagé avec `Impclient`/`Facture`, module commun avec
`ImpJdv`, fusion des blocs tiers, découpage `LigneSage`, `Cbase.Table`, séparation
traitement/GUI. 8 anomalies (IMPSAGE-A01 à A08) soumises à validation utilisateur.
