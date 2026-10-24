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
| BTQART-T01 | replay | Ouverture | `Laurux01.sql` ; paramètres `/Soc01/Identifiant`, `Adradminart`, `Adradminphot`, `Mdpadmin` renseignés | `Art_Saisis` recréée vide ; `Prd.csv`/`Photo.csv` vides ; champs de connexion remplis | `tests/ouverture/` | à faire |
| BTQART-T02 | replay | Saisie d'articles | code existant (Entrée → `Enregistrer`), code déjà saisi, code inexistant ; article dont la famille est absente de `Fiches_Fam` (jeu dérivé) | lignes de `Prd.csv` ; messages « déjà saisi » / « n'existe pas » ; erreur d'exécution figée pour la famille absente (A04) | `tests/saisie_articles/` | à faire |
| BTQART-T03 | replay | Sélection par liste | F2 → `TriArticles`, choix d'un article ; annulation | article ajouté (via `Bsel`/`Bval`) ; rien si annulation | `tests/selection_liste/` | à faire |
| BTQART-T04 | replay | Touches sur `Enregistrer` | Tab, Entrée, Espace sur `Button4` après un enregistrement | nombre d'appels de `Button4_Click` et messages (A06 figée) | `tests/touches_enregistrer/` | à faire |
| BTQART-T05 | replay | Envoi | case `Photo` cochée sur deux articles (un chemin avec espace) ; `wput` factice code 0 puis code 1 ; répertoire courant ≠ `HOME` ; paramètres incomplets | arguments de `wput` journalisés (chemin relatif `Prd.csv`, identifiants en clair : A01/A02 figées), message « Transfert terminé » même en échec (A03), `Art_Saisis` recréée, fichiers tronqués ; message d'erreur si paramètres incomplets | `tests/envoi_ftp/` | à faire |
| BTQART-T06 | gbtest | Ligne CSV | après BTQART-004 : `LigneProduit` sur un article ordinaire et sur une désignation contenant `;` | texte identique à la ligne produite par le clone non modifié (A05 figée) | `tests/ligne_csv/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (MariaDB jetable,
  `Laurux01.sql` + jeu dérivé `btq.sql` : article avec photo, article à famille inexistante).
- **Isolation** : `HOME` et répertoire courant contrôlés par le runner ; aucun accès réseau
  (`wput` factice).
- **Non testable automatiquement** : le transfert FTP réel et l'import côté boutique.
