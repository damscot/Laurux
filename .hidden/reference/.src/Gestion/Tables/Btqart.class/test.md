# Btqart — Tests

> Source : `.src/Gestion/Tables/Btqart.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran ouvert par `Fmenu` (Menu184) : tests **replay** dans le clone Laurux non modifié, avec un
`HOME` isolé (les fichiers `Prd.csv`/`Photo.csv` y sont écrits) et une commande **`wput` factice**
placée en tête du `PATH` (script qui journalise ses arguments et son répertoire courant, et renvoie
un code de sortie choisi). On compare le contenu de `Prd.csv`, `Photo.csv`, le journal de `wput` et
le dump de `Art_Saisis`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| BTQART-T01 | replay | Ouverture | `Laurux01.sql` ; paramètres `/Soc01/Identifiant`, `Adradminart`, `Adradminphot`, `Mdpadmin` renseignés | `Art_Saisis` recréée vide ; `Prd.csv`/`Photo.csv` vides ; champs de connexion remplis | `tests/ouverture/` | implémenté |
| BTQART-T02 | replay | Saisie d'articles | code existant (Entrée → `Enregistrer`), code déjà saisi, code inexistant ; article dont la famille est absente de `Fiches_Fam` (jeu dérivé) | lignes de `Prd.csv` ; messages « déjà saisi » / « n'existe pas » ; erreur d'exécution figée pour la famille absente (A04) | `tests/saisie_articles/` | implémenté |
| BTQART-T03 | replay | Sélection par liste | F2 → `TriArticles`, choix d'un article ; annulation | article ajouté (via `Bsel`/`Bval`) ; rien si annulation | `tests/selection_liste/` | implémenté (annulation) ; à faire : choix d'un article dans TriArticles (grille TriGen construite après la pose des observateurs, non rejouable) ; F2 non rejouable (ToggleButton1 utilisé) |
| BTQART-T04 | replay | Touches sur `Enregistrer` | Tab, Entrée, Espace sur `Button4` après un enregistrement | nombre d'appels de `Button4_Click` et messages (A06 figée) | `tests/touches_enregistrer/` | implémenté (touche Tab) ; Entrée et Espace sur Button4 non retenus (l'Espace rejoué a ouvert TriArticles, comportement non expliqué) |
| BTQART-T05 | replay | Envoi | case `Photo` cochée sur deux articles (un chemin avec espace) ; `wput` factice code 0 puis code 1 ; répertoire courant ≠ `HOME` ; paramètres incomplets | arguments de `wput` journalisés (chemin relatif `Prd.csv`, identifiants en clair : A01/A02 figées), message « Transfert terminé » même en échec (A03), `Art_Saisis` recréée, fichiers tronqués ; message d'erreur si paramètres incomplets | `tests/envoi_ftp/` | implémenté |
| BTQART-T06 | gbtest | Ligne CSV | après BTQART-004 : `LigneProduit` sur un article ordinaire et sur une désignation contenant `;` | texte identique à la ligne produite par le clone non modifié (A05 figée) | `tests/ligne_csv/` | à faire : exige l'extraction BTQART-004 (LigneProduit) |

## Détail des tests

- **Implémentation (vague 4)** : jeu partagé `.hidden/Tests/Gestion/assets/btqart_shared/btqart_base.sql` (Art_Saisis avec une ligne périmée, photos de 001 avec espace et 002, article 901 de famille ZZ absente) ; scénarios `Gestion/btqart_ouverture` (T01), `btqart_saisie_articles` et `btqart_famille_absente` (T02, code 125 : `Btqart.Button4_Click.159: Result is not available`, A04), `btqart_selection_liste` (T03), `btqart_touches_enregistrer` (T04), `btqart_envoi_ftp` et `btqart_envoi_incomplet` (T05, wput factice tracé dans `@ftp.trace`). Comparés : `Prd.csv`, `Photo.csv`, `@ftp.trace`, dump (dont `Art_Saisis`).

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (MariaDB jetable,
  `Laurux01.sql` + jeu dérivé `btq.sql` : article avec photo, article à famille inexistante).
- **Isolation** : `HOME` et répertoire courant contrôlés par le runner ; aucun accès réseau
  (`wput` factice).
- **Non testable automatiquement** : le transfert FTP réel et l'import côté boutique.
