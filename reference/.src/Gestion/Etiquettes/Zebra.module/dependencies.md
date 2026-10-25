# Zebra — Dépendances

> Source : `.src/Gestion/Etiquettes/Zebra.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/Zebra.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Etiquettes/Etigond.class` | `Gondole1` |
| `.src/Gestion/Etiquettes/EtiqPromo.class` | `Gondole1` |
| `.src/Gestion/Etiquettes/Etiqart.class` | `Gondole1` |
| `.src/Gestion/Etiquettes/Etiqcasier.class` | `Gondole1` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Utils` | `Remplace` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Les 5 appels détectés (`Etigond:987/989`, `EtiqPromo:287`, `Etiqart:951`, `Etiqcasier:939`)
  sont **tous inatteignables** : ils sont gardés par `ConnZbr = True`, et `ConnZbr` n'est vrai
  qu'après `Connect`, méthode `unused` dans les quatre écrans (vérifié par
  `grep -rn 'Connect()' .src/Gestion/Etiquettes`). `deps.py` ne propage pas cette mort par
  condition : `Gondole1` n'apparaît pas en `unused_transitive`.
- Dans `EtiqPromo:287`, l'argument `Code` désigne le **TextBox** `Code` (code promotion) et non un
  code article : le contrôle serait converti en chaîne au moment de l'appel (« Type mismatch »
  probable). Sans effet aujourd'hui puisque la branche est morte (voir ETIQPROMO-A05).
- Le nom `Zebra` est aussi celui d'une CheckBox (commentée) et d'un handler `Zebra_Click` dans
  `Prefs.class` (l. 417, 961) : homonymie sans conflit.
- Dépendance externe : réseau TCP vers l'imprimante (port 9100), via `Socket` (gb.net) ouvert par
  l'appelant.
- Ordre de rework : avec DYMO-001 (même lot) ; la décision ZEBRA-A01 conditionne les reworks
  « Connect » des quatre écrans appelants.
