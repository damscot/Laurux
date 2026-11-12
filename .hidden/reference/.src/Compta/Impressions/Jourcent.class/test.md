# Jourcent — Tests

> Source : `.src/Compta/Impressions/Jourcent.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests **replay** de l'écran « Impression des journaux centralisateurs ». Critères :
texte du PDF `~/tmp/jourcent.pdf` (`pdftotext -layout`, pied de page normalisé) et dump de la
base (table `centralisation`, recréée vide après chaque journal imprimé).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| JOURCENT-T01 | replay | Centralisation de tous les journaux | jeu dérivé commun (Balance), journaux 01-99, exercice en cours | texte PDF de référence (une page par journal ayant des écritures) | `tests/centralisation_tous/` | implémenté |
| JOURCENT-T02 | replay | Collectifs 401/411 | journal VE avec collectif 411 et détail 411xxx, journal AC avec collectif 401 | collectifs cumulés, libellé « Clients » pour les deux (A02 figée), détail 401/411 ignoré | `tests/collectifs/` | implémenté |
| JOURCENT-T03 | replay | Collectif d'un autre préfixe | collectif `453` après une ligne 706 | montants du 706 précédent cumulés sous le 453 (A01 figée) | `tests/collectif_453/` | implémenté |
| JOURCENT-T04 | replay | Journal OD | écritures OD | OD centralisé (écart avec `JournauxM`, A04 figée) | `tests/journal_od/` | implémenté |
| JOURCENT-T05 | replay | Édition provisoire | fin de période > `dtepc` | mention « ( Edition provisoire ) » | `tests/provisoire/` | à faire : mention « Edition provisoire » visible seulement dans le PDF (sortie PDF non comparée) |
| JOURCENT-T06 | replay | Saut de page | journal avec 60 comptes | en-tête complet répété, Y = 38 puis 44 | `tests/saut_de_page/` | à faire : saut de page visible seulement dans le PDF (sortie PDF non comparée) |
| JOURCENT-T07 | replay | Aucune écriture | journaux sans écriture dans la période | PDF vide généré, message « Aucune écriture pour cette demande » | `tests/aucune_ecriture/` | implémenté |
| JOURCENT-T08 | replay | Intitulé de collectif avec apostrophe | collectif 411 intitulé « Clients d'Anjou », deux lignes | erreur SQL sur l'`UPDATE` concaténé (A02 figée) | `tests/apostrophe/` | implémenté |
| JOURCENT-T09 | replay | Curseur | impression terminée | curseur `Mouse.Custom` (A03 figée) | `tests/curseur/` | à faire : curseur de souris non observable par le rejeu |
| JOURCENT-T10 | replay | Choix d'exercice et contrôles de date | `N1`…`N5`, dates hors bornes | identiques à JOURNAUX-T02/T03 | `tests/exercice_dates/` | implémenté |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié**, base
  Docker du jeu dérivé commun aux éditions comptables (voir [Balance](../Balance.class/test.md)) (voir JOURNAUXM) ; `Laurux.conf` de test.
- **Normalisation** : date et utilisateur du pied de page (`BasPage`), ou `faketime` + `USER`
  figés.
- **Code mort** : `Button2_Click`, `Centralisation`, `Donnees0..3` ne sont pas atteignables par
  l'IHM ; aucun test (leur suppression est couverte par T01-T10).
- **Date système** : `_New`/`Ex1` dépendent de `Now` : horloge figée (`faketime`).
- **Non testable automatiquement** : visualiseur PDF, aide, sons.
- **Scénarios (vague 3)** : `.hidden/Tests/Compta/assets/jourcent_<nom>/` — `centralisation_tous` (T01, jeu
  `extrait_shared/extrait_base`), `collectifs` (T02), `collectif_453` (T03), `journal_od` (T04),
  `aucune_ecriture` (T07, Laurux01), `apostrophe` (T08, `code_sortie` 125 : erreur SQL de l'UPDATE concaténé,
  l. 757), `exercice_dates` (T10, N-1 puis date hors bornes). Jeux propres : `jourcent_<nom>/jourcent_<nom>.sql`.
  Critères comparés : `sql.log` (INSERT/UPDATE de la table `centralisation`), dump, `@ouvrir.trace` (ouverture du
  PDF) ; le texte du PDF n'est pas comparé.
