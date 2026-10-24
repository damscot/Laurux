# Btqart — Synthèse

> Source : `.src/Gestion/Tables/Btqart.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Maj boutique » (menu `Fmenu`) : l'utilisateur saisit ou sélectionne des articles, chacun
est écrit comme une ligne CSV dans `~/Prd.csv` (et sa photo dans `~/Photo.csv`), puis « Envoyer »
transfère ces fichiers vers la boutique en ligne par FTP avec la commande externe `wput`.

## Points clés

- 235 lignes, 12 fonctions `Public`, CC max 17 (`Button2_Click`).
- Table de travail `Art_Saisis` (clé `code`) recréée à chaque ouverture et après chaque envoi ; la
  clé primaire sert de contrôle de doublon.
- Fichiers ouverts en écriture (troncature) dans le constructeur, handles `Static`.
- Paramètres de connexion lus dans `Laurux.conf` (`/Soc<XX>/Identifiant`, `Adradminart`,
  `Adradminphot`, `Mdpadmin`), saisis dans `Prefs`, mot de passe en clair.
- Code mort : `ChkInput` ; variables de couleur inutilisées.

## Dépendances principales

- Utilise : `Utils.db` (`Exec`, `Engine`), `Cbase` (`TabArtSaisis`, `TabArt`, `TabTvav`, `TabFam`),
  `TriArticles` (sélection, retour par `Bsel`/`Bval`), `Doc`, commande `wput`.
- Utilisé par : `Fmenu` (Menu184).

## Risques

- **BTQART-A01** : `wput Prd.csv` utilise un chemin relatif alors que le fichier est dans `HOME`.
- **A02** : identifiants FTP en clair sur la ligne de commande, chemins non quotés.
- **A03** : échec de `wput` non détecté, sélection effacée quand même.
- **A04** : famille ou TVA absente → erreur d'exécution non interceptée.
- **A05** : CSV sans échappement ; **A06** : toute touche sur « Enregistrer » relance la saisie.
- Table de travail partagée entre postes.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 153 |
| Lignes de commentaire | 35 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 53 |
| Complexité max (fonction) | 17 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests prévus : 5 `replay` avec `HOME` isolé et `wput` factice (ouverture, saisie, sélection par
liste, touches, envoi) et 1 `gbtest` sur la ligne CSV extraite (BTQART-004). Valeurs attendues
capturées dans le clone non modifié.

## Rework

5 étapes sans changement de comportement (BTQART-001 à 005) : documentation, code mort, helper de
remise à zéro, extraction de la ligne CSV et de l'ajout d'article, réduction de portée. 6 anomalies
(A01 à A06) soumises à validation.
