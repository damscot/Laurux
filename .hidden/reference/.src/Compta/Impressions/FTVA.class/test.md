# FTVA — Tests

> Source : `.src/Compta/Impressions/FTVA.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI sans écriture en base (hors table de travail `Ctrln`) : les tests sont surtout des
**replays** dont le résultat est le PDF `~/tmp/TVA.pdf`, comparé **après `pdftotext -layout` et
normalisation** (date d'édition `dd/mm/yyyy` du pied de page, nom de l'utilisateur), plus les
lignes `Exec_SQL` du log. Les valeurs affichées à l'écran (vues, `TextLabelTTVA`) sont relevées
par le log de replay (à confirmer : capture des propriétés `Text` des contrôles) ou, après
FTVA-010/011, testées en `gbtest` sur les fonctions extraites.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FTVA-T01 | replay | Mode mensuel (défaut) | jeu TVA ; ouverture, `ComboBoxMois` = 03, année courante | requêtes `Exec_SQL` ; totaux vente/achat/TVA à déclarer relevés | `tests/mensuel/` | à faire |
| FTVA-T02 | replay | Mode trimestriel | clic `RadioBtnTrimestre`, Trimestre 1 à 4 | 4 jeux de totaux ; requêtes `month(dte) >= 1..10` | `tests/trimestriel/` | à faire |
| FTVA-T03 | replay | Mode annuel | clic `RadioBtnAnnuel`, année N puis N-1 | totaux ; N-1 vide si les écritures sont en `Fiches_Mvt1` (A02 figée) | `tests/annuel/` | à faire |
| FTVA-T04 | replay | Détail des écritures | `Detail` coché en mensuel | une ligne par écriture ; lignes à 0,00 exclues côté ventes | `tests/detail_ecran/` | à faire |
| FTVA-T05 | replay | Impression mensuelle | T01 puis « Imprimer » | `TVA.pdf` → texte normalisé identique ; table `Ctrln` vide présente dans le dump | `tests/pdf_mensuel/` | à faire |
| FTVA-T06 | replay | Impression détaillée multipage | jeu de > 60 écritures TVA sur un trimestre, `Detail` coché | texte normalisé ; en-têtes répétés, en-tête sans « Sélection du » avant un total (A04 figée), pied de page sur la dernière page seulement | `tests/pdf_multipage/` | à faire |
| FTVA-T07 | replay | Impression annuelle | mode annuel, « Imprimer » | texte normalisé ; libellé « Total pour l'année <AAAA> » | `tests/pdf_annuel/` | à faire |
| FTVA-T08 | replay | Année refusée | `ComboBoxYear` = année courante - 5 | `Message.Warning` « Votre saisie n'est pas valable ! » ; année remise à l'année courante | `tests/annee_refusee/` | à faire |
| FTVA-T09 | replay | Trimestre par défaut (A01) | lancement sous `faketime` au 15/03 et au 15/09 | « Trimestre 4 » affiché dans les deux cas (anomalie figée) | `tests/trimestre_defaut/` | à faire |
| FTVA-T10 | replay | Impression sans interaction (A05) | ouverture puis « Imprimer » immédiat | figer le contenu (mois 0 ou mois courant selon le déclenchement de `ComboBoxMois_Click`) | `tests/impression_directe/` | à faire |
| FTVA-T11 | gbtest | `TvaADeclarer` (après FTVA-010) | couples vente/achat : 0/0, 100/50, 50/100, 1500/-200, -10/-20, 1 234,56/999 | valeurs produites par le clone non modifié (A03 figée) | `tests/tva_a_declarer/` | à faire |
| FTVA-T12 | gbtest | `SoldesTVA` (après FTVA-010) | jeu TVA ; préfixes 4456/4457, détail oui/non | lignes et total identiques à T01/T04 | `tests/soldes_tva/` | à faire |
| FTVA-T13 | replay | SQLite | T01 et T05 sur `Laurux01.sqlite` + jeu TVA | mêmes totaux et même texte PDF que MySQL (sinon écart documenté) | `tests/sqlite/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié** (`-c` vers un
  `Laurux.conf` de test, `/Soc01/caisse/CmdVis` = commande qui copie le PDF dans le répertoire du
  test au lieu de l'ouvrir), puis rejeu sur les deux clones et comparaison des textes normalisés.
- **Normalisation PDF** : `pdftotext -layout`, remplacement de `\d{2}/\d{2}/\d{4}` dans la ligne
  « Page n/N - … - Impression demandée par <user> » et de `<user>` ; aucune autre date n'est
  calculée à l'exécution dans ce PDF (l'année provient de `ComboBoxYear`, à fixer dans le scénario).
- **Données** : `Laurux01.sql` ne contient **aucune écriture** : base = jeu dérivé commun aux éditions
  comptables décrit dans [Balance/test.md](../Balance.class/test.md#détail-des-tests), complété par : `jeu_tva.sql` : comptes `44566`, `445662`, `44571`
  (`type_cc = 'B'`), écritures sur 4 trimestres de l'année courante, montants > 1 000 (séparateur de
  milliers, A03), une écriture à 0,00/0,00, une écriture en `Fiches_Mvt1` (A02).
- **Dates** : le mois, le trimestre et l'année par défaut dépendent de `Now` : tous les replays sont
  lancés sous `faketime` à une date fixe (sauf T09 qui la fait varier).
- **Non testable automatiquement** : rendu visuel du PDF (polices, couleurs), viewer externe.
