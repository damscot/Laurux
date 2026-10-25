# FClientcarte — Synthèse

> Source : `.src/Caisse/FClientcarte.class` · Synthèse des autres documents.

## Rôle

Écran de gestion des **cartes de fidélité** (`Fiches_Carte`) : liste filtrable et triable, fiche
(identité, téléphones, dates de validité, règle d'attribution des points, code-barres interne
`299999` + code + clé EAN), observations et historique des tickets de caisse de la carte.
Ouvert par `Fmenu.Menu238_Click` (auto-instance) et par `Tricartes` (F4 depuis la caisse).

## Points clés

- Copie ancienne et partielle de `FClient` (489 lignes communes sur 863, ratio 0,27) ; code postal
  et code-barres identiques à `FFournisseur` (ratio 1,00 sur `aff_cp`, `ChkCp`, `Colcp_*`,
  `Calc_barre`).
- Pas de socle `FicheTiers` complet (ni contacts, ni mails, ni GED, ni étiquettes) : seuls les
  services transverses (filtre, en-têtes de tri, CP, code-barres) sont partageables.
- SQL directement dans les handlers ; boutons du groupe `Btn`, champs du groupe `Cmpt` (tags).
- Fonction la plus complexe : `Cmpt_KeyPress` (CC 28, navigation par tag).
- Code mort : `Ref`, `aff_cp`, `ChkCp`, handlers inactifs `Cb_GotFocus`/`Cb_LostFocus`, handlers
  `Colcp_*` inatteignables, 5 variables jamais lues.

## Dépendances principales

- Utilise : `Utils` (`Base`/`rs1`, `Calcode`, `Remplace`, `Cdate_*`, `cpoint`, `Find_cbarre`),
  `Cbase` (`TabCarte`, `TabCpostaux`), `Enrgcp.Ecp`, `Tricp`, `Variables` (code postal).
- Utilisé par : `Fmenu`, `Tricartes` ; `Tricp` écrit des membres inexistants de la classe.
- Tables : `Fiches_Carte` (lecture/écriture), `Fiches_Cpostaux`, `Fiches_HisEntTickets`,
  `Fiches_HisLigTickets` (noms en dur).

## Risques

- **A01** : chaque modification d'une carte **inverse les téléphones domicile et bureau**
  (`FClientcarte.class:597`).
- **A02** : sélection du code postal cassée (retour écrit dans `FClient`, `Variables.Bsel` périmé ;
  second chemin → erreur « Unknown symbol 'Bsel' » dans `Tricp.class:140`).
- **A03** : les points saisis à la création perdent leurs décimales (texte `"1,50"` dans un
  `decimal`).
- A04 (prochain code lexical, concurrence avec la caisse), A05 (filtre concaténé dans le SQL), A06
  (lecture sans `Available`), A07 (suppression sans contrôle de l'historique).
- `Utils.rs1` est global : un écran ouvert par-dessus qui appelle `Utils.Base` casse la liste.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 863 |
| Lignes de commentaire | 47 |
| Fonctions | 65 |
| Fonctions Public | 65 |
| Complexité cyclomatique totale | 216 |
| Complexité max (fonction) | 28 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests (FCLIENTCARTE-T01 à T10) : 9 `replay` (création, modification, suppression, code-barres,
dates, tri/filtre, code postal, historique, navigation) et 1 `gbtest` sur le calcul du code-barres
après extraction. Jeu `cartes_base` partagé avec Tricartes et EmailingCarte ; aucun clic dans
`Histo` (pas de `Histo_Click`).

## Rework

12 étapes sans changement de comportement (FCLIENTCARTE-001 à 012) : documentation, code mort,
factorisation des en-têtes de tri et de `Deb2`/`Deb3`, table de navigation pour `Cmpt_KeyPress`,
suppression d'un `Find_cbarre` inutile, réduction de portée de 11 membres, séparation SQL/GUI,
`ProchainCodeCarte` partagé avec `Caisse`, helper code-barres partagé avec `FFournisseur`,
`Cbase` pour l'historique. 7 anomalies (FCLIENTCARTE-A01 à A07) soumises à validation.
