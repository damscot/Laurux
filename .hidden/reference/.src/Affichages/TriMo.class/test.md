# TriMo — Tests

> Source : `.src/Affichages/TriMo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIMO-T01 | gbtest | Absence de référence (garde de suppression) | recherche de `New TriMo`, `"TriMo"` et `TriMo.` dans `.src` (hors méthode `Facture.TriMo`) | aucune occurrence ; `gbc3 -agt` vert après suppression | `tests/absence_reference/` | à faire |

## Détail des tests

- **Classe inatteignable** : aucun écran n'ouvre `TriMo`, aucun scénario `replay` n'est possible
  depuis l'application. T01 est un contrôle statique (script lancé par le runner, rangé en
  `gbtest` faute de type dédié) qui protège la suppression proposée (TRIMO-A01).
- La sélection de main d'œuvre réellement utilisée est couverte par TRIARTICLES-T08
  (`Prodcomposes`, `"mo_code"`).
