# DateTar — Tests

> Source : `.src/Gestion/Entrées/DateTar.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran : tests `replay` depuis l'écran d'achat (bouton « Tarif par date »). `EnrTouTar` est
exercé par le démarrage de Laurux (`Fmenu`) avec des tarifs temporaires échus. Tables
comparées : `Fiches_TarTemp`, `Fiches_Art`, `Fiches_Tarcli`, `Fiches_TarTypcli`. Valeurs
attendues produites dans le clone **Laurux non modifié** (anomalies figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DATETAR-T01 | replay | Liste et sélection | fournisseur F1 (3 articles en tarif temporaire), puis fournisseur vide ; sélection multiple, double-clic, désélection | contenu des deux listes (relevé par le replay) | `tests/liste_selection/` | implémenté (gb.test `DateTarTest.T01ListeSelection` ; écran instancié sans affichage, l'écran d'achat qui l'ouvre étant complexe) |
| DATETAR-T02 | replay | Planification | 2 articles à droite, date `01.12.2026`, Enregistrer | `Fiches_TarTemp.dtmaj/date` des 2 articles ; erreur d'indice en fin de boucle (DATETAR-A01 figée) | `tests/planification/` | implémenté (gb.test `T02Planification` : pas d'erreur d'indice constatée, A01 non reproduite ; toutes les lignes `Fiches_TarTemp` des articles choisis, y compris `temp_sup`, mises à jour) |
| DATETAR-T03 | replay | Suppression | 1 article à droite, Suppression, Oui | lignes `Fiches_TarTemp` de l'article supprimées ; état de la transaction après l'erreur (A01) | `tests/suppression/` | implémenté (gb.test `DateTarTest.T03Suppression` : Message.Delete « Oui » par un Timer du module ; lignes de 001 supprimées et validées (le Rollback qui suit ne les rétablit pas) ; pas d'erreur d'indice constatée, A01 non reproduite) |
| DATETAR-T04 | replay | Ordre de sélection | articles passés à droite dans l'ordre inverse de la liste, Enregistrer | articles réellement modifiés (DATETAR-A02 figée) | `tests/ordre_selection/` | implémenté (gb.test `T04OrdreSelection` : seul 003 modifié pour la sélection [003, 001], A02 figée) |
| DATETAR-T05 | replay | Application au démarrage | `Fiches_TarTemp` échus (`dtmaj = 1`, date passée) : article A1 avec tarifs général + client + type (dont un `temp_sup`) ; lancement de Laurux | `Fiches_Art` (prix, coef), `Fiches_Tarcli`, `Fiches_TarTypcli` ; `Fiches_TarTemp` vidé pour A1 | `tests/demarrage/` | implémenté (gb.test `T05Demarrage` : `DateTar.EnrTouTar` appelé directement avec la requête de `Fmenu` triée) |
| DATETAR-T06 | replay | Démarrage sans tarif général | A2 avec seulement un tarif client échu | `art_pvht`/`art_pvttc` recalculés avec le coefficient client (DATETAR-A04 figée) | `tests/demarrage_sans_general/` | implémenté (gb.test `T06DemarrageSansGeneral` : `art_pvht` = 8 × 1,7 coefficient client, A04 figée) |
| DATETAR-T07 | replay | Code TVA inexistant | A3 dont `art_tva` n'existe pas dans `Fiches_Tvaav` | message d'erreur, rollback : aucune table modifiée (DATETAR-A06 figée) | `tests/demarrage_tva/` | à faire : le Catch d'EnrTouTar ouvre Message.Error (bloquant en gb.test) ; scénario de démarrage possible (boîte ouverte dans Fmenu.Form_Open avant le rejeu : START-A09) |
| DATETAR-T08 | replay | Recherche par date | date égale à celle de 2 tarifs planifiés ; Recherche | articles passés à droite | `tests/recherche_date/` | implémenté (gb.test `T08RechercheDate`) |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `tarifs_temp.sql` (articles A1-A3, 2 fournisseurs,
  lignes `Fiches_TarTemp` des trois `temp_type`, dates passées et futures).
- **Horloge** : `Fmenu` compare `date` à `Now` → `faketime` à une date fixe.
- **gb.test possible** pour `EnrTouTar` après DATETAR-003/006 (méthode statique, `ProgBar`
  optionnelle) : mêmes données que T05-T07, base MariaDB Docker.
- **Non testable** : la fenêtre de confirmation de suppression est rejouée, pas son rendu.
- **Implémentation (phase 2, vague 5)** : `.src/Tests/Gestion/DateTarTest.test`, jeu partagé
  `.hidden/Tests/Gestion/assets/datetar_shared/tarifs_temp.sql` (articles 001-003 de Laurux01, fournisseur 401001, et A4
  ajouté, fournisseur 401002 ; tarifs temporaires des trois `temp_type`, planifiés au 01.12.2026 ou non, un `temp_sup`).
  L'écran est créé par `New DateTar(Null, "<fournisseur>")` (1er argument = parent du Form, comme dans
  `commande1.class:858`) ; listes lues par `Controls["ListFour"/"ListArt"]`, date fixée par `Controls["date"].dte.G`.
  T05/T06 préparent les tarifs échus par SQL dans le test puis appellent `DateTar.EnrTouTar`.
