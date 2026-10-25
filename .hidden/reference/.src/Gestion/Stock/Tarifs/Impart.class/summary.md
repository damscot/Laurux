# Impart — Synthèse

> Source : `.src/Gestion/Stock/Tarifs/Impart.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Import et Maj articles » : importe un fichier de tarif fournisseur (séparé ou à largeur
fixe) selon une définition éditée par `ImpartParam`, pour mettre à jour ou créer des articles,
écrire la future base tarif, ou mettre à jour codes équivalents, codes-barres, zones diverses,
centrale et références fournisseur. Comptes rendus dans `~/tmp/Artnew.txt` et `Artmaj.txt`.

## Points clés

- **Module complexe** : scénarios de test à faire valider par l'utilisateur avant la phase 2.
- `Import` : CC 186, ~45 variables de module `String`, `INSERT` de 58 colonnes, aucune transaction.
- Deux `Select Case` 1-31 quasi identiques (mode séparé / largeur fixe) ; définition relue à
  chaque ligne de fichier.
- Code mort : `Controle`, `InitCode`, `TrC`, `Calc_Marge`, nombreuses variables ;
  `Button4_MouseDown` inatteignable.

## Dépendances principales

- Utilisé par : `Fmenu.Menu186_Click`.
- Utilise : `MajEqu`, `CPrix.Cascade`, `Utils` (`Next_Code`, `cpoint`, `Observers`…), `Editeur`,
  `EtiqRecpt`, `Serveur.Pass` ; données de `ImpartParam`, `Fiches_Parametres.dnart`.

## Risques

- **Boucle infinie** si la définition est saisie au clavier (A01, application figée).
- Contrôle de référence fondé sur le code fournisseur (A02) ; arguments inversés vers `MajEqu`
  (A04) ; état résiduel entre lignes (A06) ; ligne courte → erreur (A07).
- Créations perdues silencieusement (doublons, `dnart` non mis à jour, A08) ; champs importés
  ignorés (A09) ; PV TTC jamais arrondi (A05) ; `~/tmp` requis (A10).
- SQL concaténé, pas de conversion d'encodage (A13) ; observateurs doublés (A12).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1647 |
| Lignes de commentaire | 93 |
| Fonctions | 48 |
| Fonctions Public | 48 |
| Complexité cyclomatique totale | 548 |
| Complexité max (fonction) | 186 (`Import`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

15 replays : maj des prix (séparé, fixe, net), création, future base, options, codes équivalents,
zones diverses, centrale, et caractérisation des anomalies (définition au clavier, ligne courte,
second import, fichiers absents, encodage, SQLite).

## Rework

8 étapes (IMPART-001 à 008) : documentation, code mort, réduction de portée de 18 fonctions,
découpage d'`Import` et `AffecteChamp`, `LImpDef` commun avec `ImpartParam`, définition lue une
fois, `ArrondiPvTTC`/`EtiqMaj`/`Serveur.Actif`, séparation des options GUI. 13 anomalies.
