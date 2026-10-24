# journauxSetting — Tests

> Source : `.src/Compta/Impressions/journauxSetting.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Boîte modale GUI : tests **replay** ouverts depuis l'écran `Journaux`. Critère principal : les
clés `/ExportJournal01/…` du `Laurux.conf` de test après validation (et le contenu de
`Journaux.ListBox1` au retour).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| JOURNAUXSETTING-T01 | replay | Configuration complète | double-clic sur les 12 champs dans l'ordre, Valider | `Entete0..11` = `0..11`, `Titre0..11` = libellés, `Entete12..15`/`Titre12..15` = `" "` | `tests/config_complete/` | à faire |
| JOURNAUXSETTING-T02 | replay | Configuration partielle réordonnée | « Date de l'écriture », « Compte », « Debit », Valider | `Entete0..2` = `4`, `1`, `7` ; positions 3..15 à `" "` ; `Journaux.ListBox1` affiche les 3 titres | `tests/config_partielle/` | à faire |
| JOURNAUXSETTING-T03 | replay | Doublon | double-clic deux fois sur « Compte » | avertissement « colonne déjà utilisée », une seule ligne | `tests/doublon/` | à faire |
| JOURNAUXSETTING-T04 | replay | Retrait et liste vide | retirer toutes les lignes de `ListBox2`, Valider | configuration précédente inchangée (A01 figée) | `tests/liste_vide/` | à faire |
| JOURNAUXSETTING-T05 | replay | Glisser-déposer | glisser « Compte » de `ListBox2` vers `ListBox1` | « Compte » en double dans `ListBox1`, toujours présent dans `ListBox2` (A02 figée) | `tests/glisser_deposer/` | à faire |
| JOURNAUXSETTING-T06 | replay | Annuler | modifications puis Annuler | `Laurux.conf` inchangé | `tests/annuler/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié** avec un
  `Laurux.conf` de test (`-c`), société `01`, puis comparaison des sections `[ExportJournal01]`
  (ordre des clés normalisé).
- **Données** : aucune donnée de base nécessaire (`Laurux01.sql` suffit pour ouvrir `Journaux`).
- **Glisser-déposer** : le rejeu des événements `Drag`/`Drop` par `ReplayObserver` est à
  vérifier en phase 2 ; à défaut, T05 reste manuel.
