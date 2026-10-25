# TriFac — Tests

> Source : `.src/Affichages/TriFac.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Liste de sélection modale (lecture seule de `Fiches_HistoFac`) : scénarios `replay` lancés depuis
`Facture` (bouton avoir à partir d'une facture existante). La comparaison porte sur le dump
normalisé après enregistrement de l'avoir et, à titre informatif, sur les lignes `Exec_SQL`
(requêtes `LIMIT` produites par `Deb*`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIFAC-T01 | replay | Sélection d'une facture pour avoir | `Facture` : nouveau document, code client saisi, bouton avoir (`Button26`), clic sur une facture, enregistrement de l'avoir | lignes de l'avoir reprises de la facture choisie (`Fiches_Bl`, `Fiches_Ligbl`) | `tests/selection_avoir/` | à faire |
| TRIFAC-T02 | replay | Tri et filtre par en-tête | clic sur `NO`, `CO`, `NM`, `MT`, `MTC` ; saisie `12` puis retour arrière ; `DA` : saisie `0101` puis `01012025` | contenu de la grille ; requêtes de référence (tri `abs(lpad())` pour `CO`, alphabétique sinon) | `tests/tri_filtre/` | à faire |
| TRIFAC-T03 | replay | Double-clic et pagination | double-clic sur `NO` puis `DA` ; PageDown ×2, PageUp, molette, boutons `Descendre`/`Remonter`, flèche bas en dernière ligne | figer l'ordre non inversé et le filtre utilisé en pagination (A01, A02) | `tests/pagination/` | à faire |
| TRIFAC-T04 | replay | Fermeture sans choix | 1) Échap dans la grille ; 2) après une sélection réussie, nouvel avoir, Échap dans l'en-tête `NM` | 1) aucun chargement ; 2) figer le rechargement de l'ancienne facture (A04) | `tests/fermeture/` | à faire |
| TRIFAC-T05 | gbtest | `RequeteFactures` (après TRIFAC-009) | tri `numfac`/`cdclifac`/`datefac`, `Dat` 0/1, filtre vide/`12`/motif date, sens, page 0 et 2 | texte SQL identique à celui journalisé par le clone non modifié | `tests/requete_factures/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; les anomalies A01 à A05
  sont figées (tests de caractérisation).
- **Données** : `Laurux01.sql` ne contient aucune facture. Jeu dérivé `factures_base` (commun avec
  `TriFac2` et `Facture`) : ≥ 3 pages de `Fiches_HistoFac` (au moins 60 factures, plusieurs clients,
  numéros de longueurs différentes pour le tri `lpad`, dates sur deux années) et leurs lignes
  `Fiches_HistoLigfac`.
- **Instrumentation** : `TriFac` n'appelle pas `Utils.Observers(Me)` ; les clics et frappes dans la
  liste ne sont **pas journalisés**, donc T01 à T04 ne sont pas rejouables en l'état. Décision de
  phase 2 : instrumenter l'écran dans les deux clones (ajout de `Utils.Observers(Me)` dans `_New`,
  sans effet fonctionnel), ou se limiter à T05 et aux replays de `Facture` qui ne passent pas par la
  liste.
- **Rejeu** : `ColFac_Click` est appelé par `Object.Call` (doit rester `Public`).
- **Pagination** : `lg` dépend de la hauteur de la grille (résolution, polices) : fixer la géométrie
  entre capture et rejeu, sinon les `LIMIT` diffèrent.
- **SQLite** : rejouer T02 sur `Laurux01.sqlite` pour vérifier la traduction de `lpad` par
  `DB_Connection`.
