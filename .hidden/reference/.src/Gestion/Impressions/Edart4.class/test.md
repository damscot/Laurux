# Edart4 — Tests

> Source : `.src/Gestion/Impressions/Edart4.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` depuis Tarif > Client. Le PDF `~/tmp/tarif.pdf` (gb.report via `Printer`) est
capturé (`/Soc01/caisse/CmdVis`), converti par `pdftotext -layout`, normalisé (date du titre) ;
comparaison du texte et des `Exec_SQL` (informatif) ; dump BDD identique. Valeurs attendues
produites dans le clone **non modifié**. ⚠️ Les requêtes d'articles n'ont pas d'`ORDER BY` : l'ordre
dépend du moteur ; le jeu de données insère les articles dans l'ordre des codes pour stabiliser
le résultat.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDART4-T01 | replay | Tarif d'un client | `Butclig`, client à tarif particulier, toutes familles, **Imprimer** | en-tête société + adresse client, bandeaux familles/sous-familles, HT/TVA/TTC calculés par `TarArt` | `tests/edart4_client/` | à faire : client choisi par `TriCpt` (fenêtre modale de sélection) non synthétisé ; sans client ni type, `TarArt._new:77` lève « Null object » dès qu'une famille a des coefficients `Fiches_CoeffTypec` (candidat anomalie) |
| EDART4-T02 | replay | Tarif par type client | `Buttypc`, choix d'un type, **Imprimer** | prix du type (coefficients `Fiches_CoeffTypec`) | `tests/edart4_type/` | implémenté (`Gestion/edart4_type` : PDF gb.report comparé tel quel, `pdftotext` vide) |
| EDART4-T03 | replay | Liste des types | `Buttypc`, clic sur une ligne ; Échap | `Textyp` rempli ; liste masquée | `tests/edart4_liste_types/` | implémenté par `Gestion/edart4_type` et `Gestion/edart4_saisie` (clic sur une ligne) ; Échap non rejoué |
| EDART4-T04 | replay | Options | `Checkneg`, `Checksdp`, `Checlogo`, `Phot` cochés tour à tour | lignes négociées seules ; saut de page par famille ; logo ; colonne photo (erreur si photo absente : à figer) | `tests/edart4_options/` | implémenté en partie (`Gestion/edart4_options` : Checkneg, Checksdp, Checlogo avec `/Soc01/Logo`) ; à faire : `Phot` |
| EDART4-T05 | replay | Option boisson | `/Soc01/bois` vrai (`$soption = "B"`), articles avec droits | colonnes « droits » et « S.S », TTC incluant les droits | `tests/edart4_boisson/` | à faire : option boisson (`Utils.Option` = B) et droits non préparés dans le jeu |
| EDART4-T06 | replay | Sélection partielle de familles et plages | désélection d'une famille ; plages fournisseur et article par `TriCpt`/`TriArticles` | familles et articles filtrés ; articles suspendus exclus | `tests/edart4_selection/` | à faire : désélection dans `TreeView1` et `TriCpt`/`TriArticles` (fenêtres modales) non synthétisées |
| EDART4-T07 | replay | Saisie clavier | frappe d'un code dans `Art` puis Entrée et flèche haut | champ inchangé si la frappe est annulée (A01 figée) ; navigation | `tests/edart4_saisie/` | implémenté (`Gestion/edart4_saisie` : frappe annulée, A01 figée ; flèche haut non rejouée) |
| EDART4-T08 | replay | Client puis type | `Butclig` puis tentative de saisie du type | `Textyp` désactivé (A03 figée) | `tests/edart4_client_type/` | à faire : passe par `TriCpt` (comme T01) |

## Détail des tests

- **Implémentation (phase 2, vague 5)** : jeu partagé `.hidden/Tests/Gestion/assets/edart1_shared/editions_articles.sql` ; scénarios `.hidden/Tests/Gestion/assets/edart4_*` ; fenêtre `EdArt4` (nom écrit dans `Fmenu`). L'édition gb.report donne un texte `pdftotext` vide : le fichier `tmp/tarif.pdf` est comparé tel quel (`fichiers`), avec `sql.log` ordonné. Sans `/Soc01/Logo`, `Checlogo` provoque une erreur fatale dans `entete:394` (`Image.Load` d'un chemin vide) : le scénario d'options fournit un logo.

- **Données** : jeu `editions_articles` ([EdArt1/test.md](../EdArt1.class/test.md#détail-des-tests)) :
  familles à sous-familles (`/Soc01/ipr` à 2 niveaux), un client avec tarif particulier
  (`Fiches_Tarcli`) et prix négociés, deux types client, codes TVA dans `Fiches_Tvaav`, articles
  suspendus, une société dans `Fiches_Societes`, logo et photos présents.
- **Dépendance** : les prix proviennent de `TarArt` : les écarts de ce test se lisent avec
  TARART-T12 (même scénario côté `TarArt`).
- **Non testable automatiquement** : couleur du focus, rendu visuel des images (seul le texte est
  comparé).
