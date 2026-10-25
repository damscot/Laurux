# TriBl — Tests

> Source : `.src/Affichages/TriBl.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe **morte** (aucun appelant depuis `7101bb39`) : aucun scénario ne peut l'atteindre depuis
l'interface. Le seul test utile vérifie l'absence d'appel avant la suppression.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIBL-T01 | gbtest | Absence de référence (avant TRIBL-A01) | `grep -rnw "TriBl"` sur `.src` hors variable `Tribl` de `Facture` ; recherche de `"TriBl"` en chaîne ; `gbc3 -agt` après suppression | aucune référence ; compilation sans erreur | `tests/absence_reference/` | à faire |

## Détail des tests

- **Pas de replay** : l'écran n'est ouvert par aucun chemin de l'interface (la caisse utilise
  `TriFacture`). Le comportement de règlement des BL en caisse est couvert par `CAISSE-T11` et
  `TRIFACTURE-T01/T02`.
- **T01** est un contrôle de construction (script de phase 2 ou étape de validation de l'anomalie),
  pas un module gb.test au sens strict ; il garantit que la suppression ne casse pas la compilation.
- Si l'utilisateur refuse la suppression, les reworks TRIBL-001 à 004 ne sont pas testables par
  replay ; ils ne seraient validés que par `gbc3 -agt`.
