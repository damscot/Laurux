# Serveur — Synthèse

> Source : `.src/Serveur.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Export de modifications vers un « serveur de mise à jour » externe (anciennement Thelia) par
**fichiers texte** : chaque création, modification ou suppression d'article, famille, fournisseur,
client, contact, équivalence, code-barres, référence liée ou étiquette ajoute une ligne
`;`-séparée dans `<Variables.Schmprix>/<Origine>_Serveur.txt`. Il n'y a aucun échange
inter-processus actif ; aucun fichier n'est relu par Laurux.

## Points clés

- Une seule fonction utile, `Pass` (CC 90, 44 appels depuis 9 fichiers), composée de 12 blocs
  quasi identiques : ouverture, positionnement en fin par lecture complète, `Print`, `Close`.
- SQL en lecture seule, tables en dur (`Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Cli`,
  `Fiches_Comptes`, `Fiches_ContactF`, `Fiches_ContactC`).
- Le format des lignes (ordre des colonnes, doublons `art_ect`/`cli_typec`, absence de `;` final
  pour `Fam`) est un **contrat externe** à préserver octet par octet.
- Export activé par les préférences société `Sprix`, `Sexport`, `SMajArt`/`SMajFour`/`SMajCli`,
  testées par les appelants.
- Code mort : `Docs` (et son fichier jamais fermé), `ReplaceFam`, `convBStr`, bloc `Stock`.

## Dépendances principales

- Utilise : `Utils.db`, `Variables.Schmprix`.
- Utilisé par : `Articles`, `FClient`, `FFournisseur`, `Famille`, `Impart`, `MajTarifM`, `MajTarifP`,
  `MajFbtarif2`, `MajEqu`.

## Risques

- Aucune vérification `rResult.Available` : un code absent fait échouer l'écran appelant
  (SERVEUR-A01) ; pas de cas `S` pour les clients.
- Champs non échappés (`;`, retours à la ligne) : lignes cassées pour le consommateur (SERVEUR-A02).
- Échec d'ouverture ignoré puis erreur sur `Eof` si le répertoire est absent (SERVEUR-A03).
- Dépendance à un programme externe non présent dans le dépôt : impossible de valider la lecture.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 295 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 143 |
| Complexité max (fonction) | 90 (`Pass`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests prévus (SERVEUR-T01 à T08) : 7 `gbtest` sur base jetable et répertoire temporaire
(une origine ou un cas d'erreur par test, comparaison octet par octet des fichiers produits) et
1 `replay` d'intégration depuis l'écran `Articles`.

## Rework

8 étapes sans changement de comportement (SERVEUR-001 à 008) : documentation du contrat,
suppression du code mort, variables de module en locales, helper d'écriture, lignes construites par
listes de colonnes (CC 90 → ≤ 15), `Cbase.Table`, extraction d'une fonction pure de formatage, garde
`Serveur.Actif` partagée par les 9 appelants. 3 anomalies (SERVEUR-A01 à A03).
