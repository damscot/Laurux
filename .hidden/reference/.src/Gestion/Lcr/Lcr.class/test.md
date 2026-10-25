# Lcr — Tests

> Source : `.src/Gestion/Lcr/Lcr.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe** (chaîne LCR menant au fichier bancaire de `Bordrx`) : la liste des
> scénarios ci-dessous est **à faire valider par l'utilisateur avant la phase 2** (périmètre,
> jeux de données, cas d'erreur à figer).

Écran GUI. `Utils.Observers(Me)` n'est pas appelé : les replays supposent l'ajout de cet appel dans
les **deux** clones (LCR-A08) ou un pilotage direct par le harnais. Jeu de données dérivé de
`Laurux01.sql` : 3 clients avec RIB et adresses complètes/incomplètes, 4 traites dans
`Fiches_Traites`, 6 LCR dans `Fiches_Lcr` (acceptées, écartées, banque 0 et 1, bordereau 0 et 2).
Dates figées par `faketime` (titres et pieds de page des PDF).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LCR-T01 | replay | Ouverture, filtres et tris | ouverture ; radios `A`, `E`, `T` ; focus sur chaque en-tête | lignes `Exec_SQL` (`banque = 0`, `bordereau`, `order by`) | `tests/liste_filtres/` | à faire |
| LCR-T02 | replay | Consultation | clic sur une ligne | fiche remplie (`lind = &1`) | `tests/consultation/` | à faire |
| LCR-T03 | replay | Création | « Créer », code client via saisie, dates, n° facture, montant, acceptée, Valider | dump `Fiches_Lcr` (banque 0, bordereau 0, code entrée 0) | `tests/creation/` | à faire |
| LCR-T04 | replay | Modification | sélection, changement d'échéance et « écartée », Valider | dump `Fiches_Lcr` | `tests/modification/` | à faire |
| LCR-T05 | replay | Suppression | sélection, Supprimer, Oui ; puis Supprimer sans sélection | dump `Fiches_Lcr` ; erreur figée sans sélection | `tests/suppression/` | à faire |
| LCR-T06 | replay | Import des traites, purge acceptée | « Importer », réponse « Oui » à la purge | dump `Fiches_Lcr` (+4), `Fiches_Traites` vide ; `~/Traites.pdf` par `pdftotext` (chevauchement figé) | `tests/import_purge/` | à faire |
| LCR-T07 | replay | Import des traites, purge refusée puis réimport | « Importer », « Non », « Importer » | doublons dans `Fiches_Lcr` (LCR-A02 figée) | `tests/import_doublons/` | à faire |
| LCR-T08 | replay | Import sans traite | `Fiches_Traites` vide, « Importer » | message « Aucune traite… », base inchangée | `tests/import_vide/` | à faire |
| LCR-T09 | replay | Impression de liste | radios `T`, `A`, `E` puis « Imprimer » | `~/Lcr.pdf` par `pdftotext` (toutes les LCR pour `T`, LCR-A05 figée) | `tests/impression_liste/` | à faire |
| LCR-T10 | replay | Recherche de compte | bouton de recherche (`Button7`), choix d'un client | code et nom remplis (`TriCpt`) | `tests/recherche_compte/` | à faire |
| LCR-T11 | replay | SQLite : création et import | T03 et T06 sur `Laurux01.sqlite` | erreur SQL `value`/`TRUNCATE` figée (LCR-A03) | `tests/sqlite/` | à faire |

## Détail des tests

- Valeurs attendues capturées dans le clone **Laurux non modifié** : dump normalisé de
  `Fiches_Lcr` (colonne `lind` conservée : elle sert de lien avec la grille) et `Fiches_Traites`,
  PDF comparés après `pdftotext -layout` avec date et utilisateur figés.
- `Imp_Traites` dépend de la clé de réglage `/Soc/Lcr` (sans code société) : le `Laurux.conf` de
  test ne la définit pas (cas de production) ; un test complémentaire avec `/Soc/Lcr=1` peut figer
  l'absence de purge.
- Les formats de montant (`"12,50"` / `"12.50"`) sont couverts par CLCR-T05 ; les LCR du jeu de
  données utilisent le format produit par `EcrAuto` (`Format(tot, "0.00")`, virgule en locale fr).
- Non testable automatiquement : `Doc.Open` (navigateur), `Visualiseur.Prog` (visionneuse PDF :
  le harnais la neutralise et récupère le fichier).
