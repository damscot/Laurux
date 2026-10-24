# Ligext — Tests

> Source : `.src/Compta/Relances/Ligext.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Formulaire embarqué, testé à travers l'écran `FEditrel` (menu Relances › Préparation des
relances). On compare le dump de `Fiches_relances` (table de travail) après chaque action.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LIGEXT-T01 | replay | Affichage d'un extrait | `FEditrel` : générer à la date du jour, sélectionner un client | lignes d'extrait affichées ; cases cochées = lignes présentes dans `Fiches_relances` | `tests/affichage/` | à faire |
| LIGEXT-T02 | replay | Décocher puis recocher une ligne | une écriture du client sélectionné | dump `Fiches_relances` : ligne supprimée puis réinsérée (`intitule` = nom seul, `niveau` = relance brute) | `tests/coche_ligne/` | à faire |
| LIGEXT-T03 | replay | « Tout cocher » (`CheckBox2`) | décocher deux lignes, cocher `CheckBox2` puis le décocher | dump `Fiches_relances` après chaque étape (fige l'effet réel de `selection_Write`) | `tests/selection_globale/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MariaDB, `Laurux01.sql`
  complété d'écritures 411 non lettrées échues).
- T03 sert aussi à établir si l'affectation de `CheckBox1.Value` lève `Click` (point « à confirmer »
  d'architecture.md) : si la table ne change pas, `selection` n'écrit rien en base.
- Les colonnes volatiles de `Fiches_relances` (aucune) ne nécessitent pas de masquage.
