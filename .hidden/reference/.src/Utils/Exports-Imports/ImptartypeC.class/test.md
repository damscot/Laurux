# ImptartypeC — Tests

> Source : `.src/Utils/Exports-Imports/ImptartypeC.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPTARTYPEC-T01 | replay | Insertion et mise à jour | type `01` ; fichier 13 colonnes : 2 articles nouveaux, 1 existant | diff `Fiches_TarTypcli` | `tests/upsert_nominal/` | implémenté (`assets/imptartypec_upsert_nominal/`) |
| IMPTARTYPEC-T02 | replay | Coefficient décimal | `1,25` et `1.25` et `abc` | `coef` = 1.25, 1.25, NULL (figé) | `tests/coef_formats/` | implémenté (`assets/imptartypec_coef_formats/`) : 1.25, 1.25, NULL |
| IMPTARTYPEC-T03 | replay | Ligne courte | ligne de 5 colonnes en 2ᵉ position | figer : erreur, seule la 1ʳᵉ ligne importée | `tests/ligne_courte/` | implémenté (`assets/imptartypec_ligne_courte/`) : 001 inséré puis « Out of bounds » non interceptée, `code_sortie` 125 (détection fragile, voir Détail) |
| IMPTARTYPEC-T04 | replay | Remplissage `Coltype` | ouverture de la fenêtre | liste des types de `Fiches_Typec` (log GUI) | `tests/liste_types/` | implémenté partiellement (`assets/imptartypec_liste_types/`) : requête `Fiches_Typec` et sélection de l'index 2 vérifiées ; contenu de la liste (log GUI) non comparé |

## Détail des tests

- Capture dans le clone **Laurux non modifié** via « Appel programme » → `ImptartypeC`.
  Comparaison du dump trié de `Fiches_TarTypcli`.
- Données : `Laurux01.sql` (types clients existants) ; fichiers générés par `gen_input.py`.
- **Implémentation (phase 2)** : scénarios `.hidden/Tests/Utils/assets/imptartypec_{upsert_nominal,coef_formats,ligne_courte,liste_types}/` (fichier `tarif.csv` dans chaque dossier, saisi par chemin relatif à la racine du clone ; jeu `imptartypec_tarifs.sql`), valeurs attendues à produire.
- **Rejeu (2026-11-09)** : le fichier d'entrée est saisi en **chemin absolu** vers le clone rework (`<REWORK>/.hidden/Tests/Utils/assets/<nom>/tarif.csv`) : un chemin relatif est résolu dans l'archive exécutable, qui ne contient pas `.src/Tests`. Le clone rework est monté au même chemin pour les deux rejeux : même fichier. Chemin propre au bac (`/home/damscot/.cache/laurux-sandbox/sb2/rework`) : à réécrire vers la racine du dépôt lors de l'intégration, puis régénérer les attendus. T03 : erreur « Out of bounds » non interceptée, Laurux arrêté par le runner (code 125) ; la détection dépend du découpage de la sortie standard de gbr3 (blocs de 4 Ko) : si la pile `Classe.Méthode.ligne:` est collée à un fragment de la trace du rejeu, `FATAL_RE` (ancré en début de ligne) ne la voit pas et le rejeu finit en délai dépassé (124, observé avec un autre cadencement).
