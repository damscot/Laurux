# ConsultArt — Tests

> Source : `.src/Gestion/Tables/ConsultArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de consultation **sans écriture en base** : le dump de la base doit rester inchangé dans tous
les scénarios ; on compare surtout les **requêtes `Exec_SQL` du log** (texte exact, bloquant pour
les reworks déclarés « sans changement SQL ») et les valeurs affichées journalisées par le rejeu.
Jeu de données : `Laurux01.sql` + jeu dérivé (articles stockés / non stockés / épuisés / suspendus,
familles avec et sans compte de TVA, une famille dont le code TVA n'existe pas, commandes
fournisseurs sur un article, remises quantitatives).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CONSULTART-T01 | replay | Ouverture | `Fmenu` → consultation des articles ; `/Soc01/Poids = 1` puis 0 | requête de liste initiale (log) ; champs vides ; poids visible ou non | `tests/ouverture/` | implémenté (Gestion/consultart_ouverture ; variante /Soc01/Poids non couverte) |
| CONSULTART-T02 | replay | Filtres et tris | radios 1 à 6, clic puis double clic sur chaque en-tête (`CO`, `Inte`, `FO`, `FA`), choix `CB1` (Equivalent, Barre, Fournisseur), tri descendant des suspendus | texte SQL de chaque requête (deux requêtes par clic de radio) ; colonne famille vide en descendant/suspendus (A03 figée) | `tests/filtres_tris/` | implémenté partiel (Gestion/consultart_filtres_tris : radios et CB1 ; clics et doubles clics d'en-tête sur TextBox non rejouables) |
| CONSULTART-T03 | replay | Fiche résumée | clic sur un article stocké avec commandes fournisseurs et remises ; famille sans compte de TVA ; famille avec code TVA inexistant | champs affichés ; avertissements ; message « famille n'existe pas » pour le code TVA manquant (A04 figée) | `tests/fiche_resumee/` | implémenté (Gestion/consultart_fiche_resumee, jeu etiqart_shared/etiqart_base ; Gestion/consultart_fiche_familles, jeu consultart_familles : code TVA inexistant (A04 figée) et compte de TVA absent) |
| CONSULTART-T04 | replay | Recherche par code-barre | `*<code-barre>` + Entrée après un article stocké, puis après un article non stocké | quantité en commande cumulée et quantité 0 (A02 figées) | `tests/code_barre/` | implémenté (Gestion/consultart_code_barre ; code-barre absent de Fiches_CdBarre : Maj_Zones sur NULL figé) |
| CONSULTART-T05 | replay | Recherche incrémentale | frappes dans `CO`, `Inte` (contient), `FO`, `FA`, `CB1`, Retour arrière ; saisie d'un `"` et d'un `%` | texte SQL des requêtes ; erreur SQL sur `"` (A01 figée) | `tests/recherche_frappe/` | implémenté (Gestion/consultart_recherche_frappe ; Gestion/consultart_recherche_guillemet : requête invalide, erreur interceptée sans message, A01 figée) |
| CONSULTART-T06 | replay | Grille et état global | défilement de la grille (couleurs épuisé / stocké / non stocké / suspendu), puis ouverture d'un autre écran utilisant `Utils.Base` sans fermer la consultation, retour et défilement | couleurs des cellules (capture de l'état de la grille par le rejeu) ; contenu affiché après l'autre écran (A05 figée) ; variante SQLite pour la valeur de `art_stocke` | `tests/grille_etat_global/` | à faire : couleurs des cellules non lues par le rejeu ; état global Utils.rs1 à scénariser |
| CONSULTART-T07 | gbtest | Texte SQL de la liste | après CONSULTART-004 : `RequeteListe` pour chaque combinaison (6 filtres × asc/desc/contient × 6 colonnes de tri) | texte identique à celui journalisé par le clone non modifié (`Exec_SQL`) | `tests/requete_liste/` | à faire : extraction RequeteListe (CONSULTART-004) non faite |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (log `Exec_SQL`, valeurs
  des champs journalisées par le rejeu) ; dump de base inchangé vérifié à chaque test.
- **Rendu** : la coloration des cellules n'est observable qu'à travers l'état des cellules lu par le
  harnais (pas de comparaison d'image) ; si le rejeu ne permet pas de lire `Background`/`Foreground`
  des cellules, T06 se limite au contenu (à confirmer en phase 2).
- **Rejeu dynamique** : `Colarts_Click` est appelé par `ReplayObserver` via `Object.Call` ; il garde
  son nom et sa portée `Public`.
