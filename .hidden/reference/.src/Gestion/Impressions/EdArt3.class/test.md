# EdArt3 — Tests

> Source : `.src/Gestion/Impressions/EdArt3.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition (modal) : tests `replay` depuis Gestion > Impression des tables > Tarif > Type
client. Le PDF `~/tmp/Tarif1.pdf` est capturé (`/Soc01/caisse/CmdVis`), converti par
`pdftotext -layout` et normalisé (dates, utilisateur) ; on compare aussi les lignes `Exec_SQL`, et le
dump de la base doit rester identique. Valeurs attendues produites dans le clone **Laurux non
modifié** (anomalies comprises).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDART3-T01 | replay | Tarif d'un type client avec coefficients | type `T1` (coefficients pour 2 familles sur 3), tri par code, **Imprimer** | titre « Type = T1 … » ; coefficient du type pour les familles concernées, `art_coef` sinon ; PV HT = `art_pvht` (A01 figée) ; une requête `Fiches_CoeffTypec` par article | `tests/edart3_type_coef/` | à faire |
| EDART3-T02 | replay | Saut de page | même type, plage complète (> 1 page) | pages suivantes titrées « tarif interne » (A02 figée) | `tests/edart3_saut_page/` | à faire |
| EDART3-T03 | replay | Mode photo | `Phot` coché, articles avec et sans photo valide | `Level7bis`/`Level6bis`, photo et ligne de séparation | `tests/edart3_photo/` | à faire |
| EDART3-T04 | replay | Les 3 autres tris et le prix consommateur | `RadioButton2..4`, `/Soc01/Pvcons` vrai | ordre des lignes, lignes `Level10` | `tests/edart3_tris/` | à faire |
| EDART3-T05 | replay | Contrôle du type client | `Cdt` inconnu (Entrée) ; type sans coefficient `T2` (Entrée) ; `Cdt` vide puis **Imprimer** | `Balloon` ; `Message.Warning` et champs vidés ; « Veuillez saisir un type client SVP ! » | `tests/edart3_type_controle/` | à faire |
| EDART3-T06 | replay | Liste des types | `ToggleButton7`, clic sur une ligne | `Cdt`/`LibelType` remplis (ordre de la liste = ordre physique, sans `ORDER BY`) | `tests/edart3_liste_types/` | à faire |
| EDART3-T07 | replay | Type non validé | `Cdt` = code inconnu tapé sans Entrée, puis **Imprimer** | impression lancée avec `art_coef` partout (A03 figée) | `tests/edart3_type_non_valide/` | à faire |
| EDART3-T08 | replay | Saisie et listes communes avec `EdArt1` | scénarios EDART1-T07 à T10 rejoués sur cet écran | mêmes résultats qu'`EdArt1` (focus, `Bsel`, fermeture) | `tests/edart3_saisie/` | à faire |

## Détail des tests

- **Données** : jeu dérivé `editions_articles` décrit dans
  [EdArt1/test.md](../EdArt1.class/test.md#détail-des-tests) : 2 types client, coefficients
  `Fiches_CoeffTypec` pour un seul type et pour une partie des familles, articles avec `art_prvt`
  différent de `art_pvht / art_coef` (pour rendre visible l'écrasement A01), photos présentes et
  absentes dans `/Soc01/Photart`.
- **Comparaison** : texte PDF normalisé ; `Exec_SQL` informatif (un rework qui charge les
  coefficients en une requête change ces lignes, pas le PDF) ; dump BDD identique.
- **Non testable automatiquement** : son, `Balloon` (vérifié par le log de l'événement seulement),
  aide F1.
