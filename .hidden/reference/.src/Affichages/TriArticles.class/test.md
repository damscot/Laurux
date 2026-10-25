# TriArticles — Tests

> Source : `.src/Affichages/TriArticles.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de sélection : scénarios `replay` capturés dans le clone **Laurux non modifié**, depuis
des écrans appelants simples (`Etiqart`, `EdStk`, `Changefour`, `Prodcomposes`, `Materiel`). Base
`Laurux01.sql` + jeu dérivé `articles_selection` : ≥ 3 pages d'articles, fournisseurs, familles et
centrales renseignés, articles stockés/non stockés à quantité nulle/positive, articles matériels,
mains d'œuvre. Comparaison : valeur reprise par l'appelant, dump normalisé quand l'appelant
enregistre, lignes `Exec_SQL` à titre informatif.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIARTICLES-T01 | replay | Sélection simple | `Etiqart` : ouverture de la sélection, clic sur un article | code repris par l'appelant (`Bsel = True`, `Bval` = code) | `tests/selection_simple/` | à faire |
| TRIARTICLES-T02 | replay | Annulation | ouverture, Échap ; puis ouverture, F2 dans `CB2` | `Bsel = False`, `Bval = Null` chez l'appelant (remise à zéro à l'ouverture) | `tests/annulation/` | à faire |
| TRIARTICLES-T03 | replay | Filtre fournisseur | `Changefour` (option `Fournisseur`) : `Button1`, choix d'un fournisseur dans `Colist`, sélection | liste filtrée `art_four = …` ; requêtes de référence (doublon `Update` figé) | `tests/filtre_fournisseur/` | à faire |
| TRIARTICLES-T04 | replay | Filtres famille et centrale | `CB2` → `Famille` puis `Centrale`, choix dans `Colist` | filtres `art_fam`/`art_centrale` appliqués | `tests/filtre_famille_centrale/` | à faire |
| TRIARTICLES-T05 | replay | Disponible / stocké | `Calcstock` (`Bstocke = True`) puis `EdStk` : cocher `Disponible` | filtres `art_stocke = 1 and art_qte > 0` / `((art_stocke = 0 and art_qte = 0) or art_qte > 0)` | `tests/disponible/` | à faire |
| TRIARTICLES-T06 | replay | Matériel | option société `Materiel` active, ouverture depuis `Materiel` (`Mat = True`, `Dispo` = bouton radio) | case `Materiel` visible et cochée ; filtre `art_mat = 1` | `tests/materiel/` | à faire |
| TRIARTICLES-T07 | replay | Colonne variable `CB1` | choix `Barre`, `Casier`, `Four.` | 3ᵉ colonne correspondante ; liste reconstruite (filtres saisis perdus, figé) | `tests/colonne_cb1/` | à faire |
| TRIARTICLES-T08 | replay | Main d'œuvre | `Prodcomposes` : sélection d'une MO (`"mo_code"`) | code MO repris ; `CB1` désactivé ; composant ajouté (dump comme PRODCOMPOSES-T03) | `tests/main_oeuvre/` | à faire |
| TRIARTICLES-T09 | replay | Code avec guillemet (A01) | fournisseur dont le code contient `"` | figer l'erreur SQL actuelle | `tests/code_guillemet/` | à faire |
| TRIARTICLES-T10 | replay | Sélection initiale (A02) | `Achat` avec un fournisseur courant (`Selection` renseigné) | figer : `CB2` rempli, `Fnom` vide | `tests/selection_initiale/` | à faire |
| TRIARTICLES-T11 | gbtest | `FiltreArticles` (après TRIARTICLES-006) | combinaisons org/code/stock/dispo/mat/tri | texte de filtre identique au clone non modifié | `tests/filtre_articles/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; A01 et A02 figées.
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` **avant** la création des contrôles de
  `TriGen` : la grille et les filtres de la liste ne sont pas instrumentés. Vérifier en phase 2 si
  `ReplayObserver` rejoue les clics de `Coltri` (sinon : instrumentation à ajouter, changement à
  valider, ou pilotage par script de clics). `Colist_Click` est rejoué par `Object.Call` (doit
  rester `Public`).
- **Géométrie** : la taille de page de `TriGen` dépend de la hauteur de `Panel2` : fixer police et
  facteur d'échelle.
- **Mutualisation** : T01/T02 servent de base à tous les scénarios des 29 appelants qui
  sélectionnent un article ; T08 avec `Prodcomposes`, T06 avec `Materiel`.
