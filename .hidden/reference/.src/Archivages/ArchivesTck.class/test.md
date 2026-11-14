# ArchivesTck — Tests

> Source : `.src/Archivages/ArchivesTck.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de consultation instrumenté (`Utils.Observers` dans `_New`) : tests `replay`. Le contenu de la
grille et du détail est relevé par le rejeu ; la réimpression est comparée par le texte du PDF
(`pdftotext ~/tmp/Hticket.pdf`) et le dump de la table de travail `Tottva`. Valeurs attendues
produites dans le clone **Laurux non modifié** (anomalies A01 à A03 figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ARCHIVESTCK-T01 | replay | Ouverture | jeu `tickets_archives` ; ouverture de l'écran | 1re page triée par numéro décroissant (contenu de `Coltk`) | `tests/archivestck_ouverture/` | implémenté |
| ARCHIVESTCK-T02 | replay | Tri et filtre par colonne | focus puis frappe dans `Nm`, `Mt`, `Ca`, `Ve`, `Cli` ; double-clic pour inverser | lignes filtrées et ordre attendu par cas | `tests/archivestck_tri_filtre/` | implémenté (frappes ; double-clic non rejouable) |
| ARCHIVESTCK-T03 | replay | Filtre par date | frappe `01.02.2025`, puis `2025.02.01 10:` dans `Date` | motif `LDate.DateFilterDB` et lignes affichées | `tests/archivestck_filtre_date/` | implémenté |
| ARCHIVESTCK-T04 | replay | Pagination | 3 pages de tickets ; molette, `Descendre`, `Remonter`, Page suiv./préc., flèches en bord | première ligne affichée après chaque action | `tests/archivestck_pagination/` | implémenté (Descendre/Remonter ; molette et flèches non rejouables) |
| ARCHIVESTCK-T05 | replay | Détail d'un ticket | clic sur une ligne (`Coltk_Click`), puis « Fermer » | contenu de `Detk`, `Label3`/`Label5`/`Label7` (A05 figée) | `tests/archivestck_detail/` | implémenté (requêtes ; contenu de Detk non comparé) |
| ARCHIVESTCK-T06 | replay | Réimpression mono-taux | ticket à un seul taux de TVA ; détail puis « Imprimer » | texte du PDF ; dump de `Tottva` | `tests/archivestck_impression_1taux/` | implémenté |
| ARCHIVESTCK-T07 | replay | Réimpression multi-taux | ticket 20 % / 5,5 % / 20 % (taux qui réapparaît), avec une ligne `C` | texte du PDF et `Tottva` figés (A01 à A03) | `tests/archivestck_impression_multitaux/` | implémenté |
| ARCHIVESTCK-T08 | replay | Ticket avec totaux `BC`/`BH` et ticket supprimé | ticket avec lignes `BC`/`BH` ; ticket `suppr = 1` | pied sans recalcul ; ligne barrée dans la liste | `tests/archivestck_bc_suppr/` | implémenté (ticket BC/BH ; rendu barré du ticket supprimé non comparé) |
| ARCHIVESTCK-T09 | replay | Saisie d'un guillemet | `"` tapé dans `Nm` | comportement figé (erreur SQL attrapée, liste inchangée ; A06) | `tests/archivestck_guillemet/` | implémenté |
| ARCHIVESTCK-T10 | replay | Numéro en doublon | deux tickets de même `numero` ; clic sur l'un | lignes des deux tickets dans `Detk` (A08 figée) | `tests/archivestck_doublon/` | implémenté (erreur fatale figée, code 125 : clé « Key already used » dans Detk) |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `tickets_archives.sql` (partagé avec `RAZHISTOTK-T*`) :
  ~60 tickets répartis sur 3 caisses et 3 vendeurs, clients en compte et anonymes, modes de
  règlement variés, lignes `A`, `S`, `C`, `L`, `T`, `M`, `BC`, `BH`, un ticket `suppr = 1`, un
  doublon de numéro, et `Fiches_Societes` renseignée.
- **Horloge** : sans effet sur la liste ; figée pour la date d'édition éventuelle du PDF.
- **Rejeu** : `Coltk_Click` est appelé par `Object.Call` (doit rester `Public`) ; ne pas cliquer dans
  `Detk` (`replay_missing`). `Visualiseur.Prog` doit être neutralisé (visionneuse factice) ; le
  répertoire `~/tmp` doit exister.
- **Comparaison** : contenu des grilles relevé par le rejeu ; `pdftotext` normalisé (sans date de
  création) ; dump de `Tottva` ; dump de la base inchangé hors `Tottva`.
- **Non testable automatiquement** : l'interférence entre postes sur `Tottva` (A04) demande deux
  sessions simultanées (scénario manuel).
- **Assets (phase 2)** : `.hidden/Tests/Archivages/assets/archivestck_*/`, jeu `archivestck_shared/tickets_consult.sql` (65 en-têtes, page de 19 lignes). Comparaison : sql.log ordonné (consultations), `edition.txt` (pdftotext) et `Tottva` du dump pour T06 à T08.
