# EdReg — Tests

> Source : `.src/Gestion/Impressions/EdReg.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

État gb.report sans écran propre : il est testé par **replay de `SaiReg`** (boutons « édition »),
avec comparaison du texte extrait de `~/tmp/Bordereau.pdf` (`pdftotext -layout`, date du jour
masquée ou horloge figée) et des lignes `Exec_SQL` du log. La base n'est pas modifiée par
l'édition elle-même. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDREG-T01 | replay | Édition des règlements ajoutés | `SaiReg` : mode chèque, 2 règlements saisis ; `editions` | texte du PDF : 2 lignes, nombre, total, société, mode | `tests/edition_ajout/` | implémenté (gb.test EdRegTest.T01EditionAjout : état construit sans SaiReg) |
| EDREG-T02 | replay | Édition de tous les règlements | idem + 1 règlement supprimé ; `editionb`, numéro de bordereau saisi dans l'`InputBox` | 2 lignes (supprimé exclu), « Bordereau n° … » | `tests/edition_tous/` | à faire : passe par SaiReg (écran complexe) ; InputBox modale en gb.test |
| EDREG-T03 | replay | Bordereau sans numéro | `editionb`, `InputBox` annulée | pas de ligne « Bordereau n° » | `tests/sans_numero/` | à faire : passe par SaiReg (écran complexe) ; InputBox modale en gb.test |
| EDREG-T04 | replay | Multi-société | base avec deux lignes `Fiches_Societes`, société courante = la seconde | raison sociale de la **première** (A01 figée) | `tests/multi_societe/` | implémenté (gb.test EdRegTest.T04MultiSociete) |
| EDREG-T05 | replay | Couleur du thème | `/Coul/…` avec une composante < 16 | couleur de bande (vérification visuelle ou extraction `pdfimages`/`mutool`) : A02 figée | `tests/couleur_theme/` | à faire : couleur de bande, vérification graphique |

## Détail des tests

- **Données** : jeu `facturation_base` (voir [ObjFac](../../Facturation/ObjFac.class/test.md))
  avec clients, mode de règlement (`Fiches_Reglements`) et compte de banque ; une seconde société
  pour T04.
- **Comparaison** : `pdftotext -layout` du PDF, après suppression de la date d'édition (ou
  `faketime`) et du nom d'utilisateur (`User.Name`), et lignes `Exec_SQL` (une seule requête :
  `SELECT * FROM Fiches_Societes`).
- **Non testable automatiquement** : rendu exact des polices italiques alternées (seul le texte
  est comparé) ; T05 demande une vérification graphique.
- **Implémentation (vague 5)** : module `.src/Tests/Gestion/EdRegTest.test` ; l'état est instancié directement
  (`New EdReg(VarEcr, EdReg.ajout, règlement 05 de Laurux01)`) au lieu du rejeu de SaiReg (écran complexe exclu).
  Libellés lus dans l'ordre du .report (`Children`, ReportControl n'a pas de `Name`), date du jour et utilisateur
  remplacés par des repères ; lignes par `dte_Data`…`montant_Data`. Un index hors liste laisse les données de
  la ligne précédente (`trouve` renvoie -1). T04 : jeu `edreg_shared/edreg_deux_societes.sql`, société
  courante 02, raison sociale « SARL Premiere » (première ligne) affichée (A01). Le PDF n'est pas produit.
- La génération passe par `Printer` (gb.qt) : exécution sous Xvfb.
