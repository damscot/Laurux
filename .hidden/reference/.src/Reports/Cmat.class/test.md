# Cmat — Tests

> Source : `.src/Reports/Cmat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit de rendu PDF sans base : test `gbtest` qui instancie `New Cmat("Portrait", "mm", "A4")`
(avec `SetCompression(False)`), appelle les méthodes avec des valeurs fixes et compare le texte
`pdftotext -layout` et le flux non compressé (`/CreationDate`, date et `User.Name` du pied
masqués). Attendus produits dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CMAT-T01 | gbtest | `Entete`, `Level1`, `Level2`, `Footer` sur 2 pages | 3 matériels, prix « 1234,50 » | texte et flux de référence ; « Page 1/2 », « Page 2/2 » | `tests/cmat_liste/` | à faire |
| CMAT-T02 | replay | Liste réelle des matériels | scénarios EDMAT-T01, EDMAT-T02 sur le jeu `editions_articles` (matériels vendus et en stock) | texte PDF identique entre les deux clones ; dump identique | `tests/cmat_edmat/` | à faire |

## Détail des tests

- **Données** : aucune base pour T01 ; T02 utilise le jeu `editions_articles` (une dizaine de
  matériels, 3 marques), voir [EdArt1/test.md](../../Gestion/Impressions/EdArt1.class/test.md).
- `Ligne`/`Ligne2` (code mort) ne sont pas testés.
- **Couverture visée** : 100 % des méthodes vivantes.
