# Htickets — Tests

> Source : `.src/Reports/Htickets.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit de rendu PDF sans base : tests `gbtest` qui instancient
`New Htickets("Portrait", "mm", "A4")` (avec `SetCompression(False)`) et comparent le texte
`pdftotext -layout` et le flux non compressé (`/CreationDate` masquée), normalisés par
`check_output.py`. Attendus produits dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| HTICKETS-T01 | gbtest | `Entete`, `Entete2` (10 lignes, `PosX` variable), `Level4` (5 lignes) | `PosX` = 40 puis 0 | flux identique quel que soit `PosX` ; texte de référence | `tests/htickets_ticket/` | implémenté (gb.test HticketsTest.T01Ticket, PosX 40 et 0) |
| HTICKETS-T02 | gbtest | Ticket long (A01) | `Entete2` × 10 puis 70 `Level4` de `PosY` = 56 à 401 | nombre de pages et positions de référence (une page par ligne au-delà de ~287 mm, comportement figé) | `tests/htickets_long/` | implémenté (gb.test HticketsTest.T02TicketLong, 24 pages figées) |
| HTICKETS-T03 | replay | Réimpression réelle | scénarios ARCHIVESTCK-T06, ARCHIVESTCK-T07 (voir leur `test.md`) | texte PDF identique entre les deux clones ; dump identique (hors table de travail des taux de TVA) | `tests/htickets_archives/` | implémenté (gb.test HticketsTest.T03Archives : tickets 1000061 multi-taux + ligne C et 1000062 BH/BC du jeu Archivages/archivestck_shared/tickets_consult, en-tête société, lignes et Total TTC ; le calcul des taux de TVA de l'écran reste testé par ArchivesTck T06/T07) |

## Détail des tests

- **Données** : aucune base pour T01/T02 ; T03 utilise les tickets archivés du jeu des archives
  ([ArchivesTck/test.md](../../Archivages/ArchivesTck.class/test.md)), dont un ticket long pour
  observer A01 dans l'écran.
- **Couverture visée** : 100 % des méthodes vivantes (`Footer` supprimé n'est pas testé).
