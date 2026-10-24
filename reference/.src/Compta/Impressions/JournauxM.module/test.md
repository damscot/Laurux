# JournauxM — Tests

> Source : `.src/Compta/Impressions/JournauxM.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Le module n'est appelable que depuis l'écran `Journaux` (il lit `Journaux.Mouse`) et produit un PDF
ouvert dans le visualiseur : tous les tests sont des **replays** de l'écran « Impression des
journaux » (menu Compta, `Fmenu.Menu32_Click`). Critères : (1) le **texte du PDF**
(`pdftotext -layout ~/tmp/Journaux.pdf`) normalisé, (2) le **dump** de la base, table
`centralisation` comprise.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| JOURNAUXM-T01 | replay | Journal de ventes (`VE`) | journal VE avec lignes 411 collectif + détail, libellés « Fac… »/« Avo… », `numdoc` | texte PDF de référence (libellés « Facture <numdoc> ») ; page de centralisation ; dump `centralisation` | `tests/journal_ventes/` | à faire |
| JOURNAUXM-T02 | replay | Journal de banque | compte de trésorerie (`comptr_cc <> 0`) dont l'intitulé diffère de celui de la ligne | intitulé du plan comptable imprimé ; centralisation | `tests/journal_banque/` | à faire |
| JOURNAUXM-T03 | replay | Journal `OD` | écritures OD avec collectif | aucune page de centralisation ; table `centralisation` vide | `tests/journal_od/` | à faire |
| JOURNAUXM-T04 | replay | Édition provisoire / définitive | même période, `dtepc` avant puis après la date de fin | mention « ( Edition provisoire ) » et `numero`, sinon `numerodef` | `tests/provisoire_definitive/` | à faire |
| JOURNAUXM-T05 | replay | Totaux | case « Impressions des totaux » cochée, journaux 01 à 99 | lignes « Total journal » et page « Totaux impressions » | `tests/totaux/` | à faire |
| JOURNAUXM-T06 | replay | Sauts de page | journal de 120 lignes et 60 comptes centralisés | pagination « Page N° » et en-têtes répétés | `tests/sauts_de_page/` | à faire |
| JOURNAUXM-T07 | replay | Compte absent du plan comptable | écriture sur un compte supprimé de `Fiches_Comptes` | message d'erreur ; pas de PDF ; curseur resté en attente (A01 figée) ; impression suivante : totaux faussés | `tests/compte_absent/` | à faire |
| JOURNAUXM-T08 | replay | Aucun journal | bornes `98`-`99` sans journal | message « Aucune ecriture pour cette demande » | `tests/aucun_journal/` | à faire |
| JOURNAUXM-T09 | replay | Dernier jour avec heure non nulle | écriture datée `<fin> 10:00:00` | ligne absente (A02 figée, à confirmer) | `tests/heure_non_nulle/` | à faire |
| JOURNAUXM-T10 | replay | Base SQLite | T01 sur `Laurux01.sqlite` dérivée | figer le résultat (A02 : journaux vides attendus, à confirmer) | `tests/sqlite/` | à faire |
| JOURNAUXM-T11 | replay | Collectif d'un autre préfixe | collectif `421` après un collectif `411` dans le même journal | libellé « Collectif clients » repris (A04 figée) | `tests/collectif_autre/` | à faire |
| JOURNAUXM-T12 | replay | Performance | 20 000 écritures sur 5 journaux | durée et nombre de requêtes de référence (`gbx3 -p`, log `Exec_SQL`) | `tests/perf_journaux/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié** (base
  Docker importée du jeu de test, `Laurux.conf` de test via `-c`), rejeu sur les deux clones,
  comparaison du texte PDF et du dump normalisé.
- **Normalisation du PDF** : supprimer la date d'impression et le nom d'utilisateur du pied de
  page (`Page N° x - jj/mm/aaaa - Impression demandée par <user>`), ou figer `faketime` et
  `USER`. Le binaire PDF n'est pas comparé (métadonnées de création).
- **Données** : `Laurux01.sql` ne contient **aucune écriture** (`Fiches_Mvt*` vides) : un jeu
  dérivé jeu dérivé commun (Balance) est à construire (journaux `VE`, `AC`, `BQ`, `OD` ; comptes
  401/411/453 collectifs et détaillés, compte de trésorerie, écritures validées et non validées,
  pièces multi-lignes, `numerodef` renseigné ou non, une écriture sur compte absent).
- **Couverture** : branche « après clôture » (`Cloture = True`) non atteignable (code mort,
  JOURNAUXM-003).
- **Non testable automatiquement** : l'ouverture du visualiseur PDF (à neutraliser dans le
  runner).
