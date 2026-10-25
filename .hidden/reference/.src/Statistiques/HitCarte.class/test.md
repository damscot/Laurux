# HitCarte — Tests

> Source : `.src/Statistiques/HitCarte.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de paramétrage : tests `replay` lancés depuis le menu (Statistiques > Hit-parade des cartes).
Le résultat se compare par le **dump de la table de travail `Total`** (elle reste en base), les lignes
`Exec_SQL` du log et, pour l'affichage, par les tests de [`VisHitCartes`](../VisHitCartes.class/test.md)
qui s'enchaînent. Les valeurs attendues sont produites dans le clone **Laurux non modifié** (anomalies
comprises). L'écran appelle `Utils.Observers(Me)` une seule fois : rejouable.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| HITCARTE-T01 | replay | Hit-parade par défaut | `statistiques_ventes` ; dates par défaut, **Traitement** | dump de `Total` (une ligne par carte connue, points cumulés, visites) ; `VisHitCartes` ouvert (10 lignes, tri par points) | `tests/hitcarte_defaut/` | à faire |
| HITCARTE-T02 | replay | Période restreinte et borne de fin | `dteN0`/`dteN1` sur un mois ; tickets du dernier jour à 12:00 | tickets du dernier jour exclus (A03 figée) | `tests/hitcarte_periode/` | à faire |
| HITCARTE-T03 | replay | Tri et nombre | `RadioButton4` (20), `RadioButton2` (visites), **Traitement** | `VisHitCartes` reçoit `Tot = 20`, `tri = "V"` (ordre par visites) | `tests/hitcarte_tri/` | à faire |
| HITCARTE-T04 | replay | Cartes inconnues et tickets supprimés | tickets avec carte absente de `Fiches_Carte`, tickets `suppr = 1` avec carte | cartes inconnues ignorées ; tickets supprimés comptés (A02 figée) | `tests/hitcarte_cas_limites/` | à faire |
| HITCARTE-T05 | replay | Aucune donnée | période sans ticket à carte | message « Aucune donnée pour cette période ! », `Total` vide | `tests/hitcarte_vide/` | à faire |
| HITCARTE-T06 | replay | Saisie des dates | `dteN0` = `0101`, `dteN1` antérieure à `dteN0` (Entrée) ; dates vides puis **Traitement** | texte normalisé ; avertissement ; message « Veuillez saisir une date SVP ! » si les deux dates sont vides | `tests/hitcarte_dates/` | à faire |
| HITCARTE-T07 | gbtest | Calcul (après HITCARTE-004) | `RemplitHitParade(d0, d1)` sur le jeu de T01 | contenu de `Total` identique à T01 | `tests/hitcarte_calcul/` | à faire |

## Détail des tests

- **Exécution en série** : la table `Total` est partagée avec `TBord`, `Stat*` et `Statcai` ; ces
  replays ne tournent pas en parallèle sur la même base.

- **Données** : jeu commun `statistiques_ventes` (voir [`TBord/test.md`](../TBord.class/test.md)) : cartes
  `Fiches_Carte` (une dizaine, dont une jamais utilisée), tickets archivés `Fiches_HisEntTickets` avec
  `carte` renseignée ou nulle, `points` non nuls, un ticket `suppr = 1`, un ticket dont la carte
  n'existe pas, plus de 20 cartes actives pour voir l'effet de `Tot`.
- **Horloge** : `dteN1` par défaut vaut aujourd'hui ; fixer l'horloge (`faketime`).
- **Enchaînement** : `VisHitCartes` est ouvert en non modal depuis un écran modal ; le scénario ferme
  `VisHitCartes` (**Quitter**) avant `HitCarte`.
- **Non testable automatiquement** : son (`Music.Play`), couleur du champ actif (`SetEditColor`).
