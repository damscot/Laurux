# TriTest — Synthèse

> Source : `.src/Tests/TriTest.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

**Banc d'essai manuel de la classe [`TriGen`](../../Affichages/TriGen.class/summary.md)** (liste
filtrable et paginée des fenêtres de sélection). Le formulaire `TriTest.form` (titre « Test de la
Classe TriGen ») crée une `TriGen` sur les articles (`Fiches_Art`) dans `Panel1`, affiche la valeur
choisie dans `TextBox1` et permet d'ajouter un filtre imposé (« en stock ») par `ExtraSel`.
Il a été ajouté avec TriGen (commit `71fff6f2`, « Ajout d'une classe de Tri Générique »).

**Décision utilisateur (lot Reports + Tests)** : ce fichier n'est pas étudié comme un écran
applicatif. Il est vu comme **l'implémentation d'un test de `TriGen`**, à enrichir en phase 2 pour
couvrir les scénarios de `TriGen` (TRIGEN-T01 à T09). L'étude ci-dessous est donc volontairement
allégée.

## Points clés

- Aucun appelant dans le projet (signal `jamais_reference`) : c'est **attendu** pour un banc
  d'essai ; ce n'est pas du code mort à supprimer.
- Couvre aujourd'hui : création en mode `Panel`, colonnes par `Collection` de `ResultField`, couleur
  de fond par colonne SQL `bgcolor`, événement `MajSel` (avec `Stop Event` si rien n'est choisi),
  écriture de `Bsel`/`Bval` par `TriGen` (`Object.SetProperty`), `ExtraSel`.
- `form_Close` imprime `Bsel`/`Bval` sur la sortie standard : sortie exploitable par un test.

## Dépendances principales

- Utilise : `TriGen` (`_new`, `ExtraSel`, événement `MajSel`), `Utils.db`, `Cbase.Table("TabArt")`.
- Utilisé par : personne (lancement manuel depuis l'IDE ; point d'entrée de test à définir en phase 2).

## Risques

- Aucun en production (jamais ouvert par l'application).
- `Bsel`/`Bval` doivent rester `Public` : `TriGen` les écrit par `Object.SetProperty`.
- Le test dépend des données de `Fiches_Art` : jeu de données dérivé nécessaire (`Laurux01.sql` ne
  contient qu'un article).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 43 |
| Lignes de commentaire | 5 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 2 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests prévus (TRITEST-T01 à T03), qui sont en réalité des tests de `TriGen` pilotés par ce
formulaire ; l'enrichissement prévu doit reprendre les scénarios TRIGEN-T01 à T09.

## Rework

3 étapes (TRITEST-001 à 003) : documentation du rôle de banc d'essai, enrichissement en banc de test
de `TriGen` (en lien avec la phase 2), retrait du code commenté. Aucune anomalie.
