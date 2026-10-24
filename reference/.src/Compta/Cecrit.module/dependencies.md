# Cecrit — Dépendances

> Source : `.src/Compta/Cecrit.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Cecrit.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Ecrit_Data`, `Tris2`, `Debe1`, `Debe2`, `Debe3`, `Debe4`, `Debn1`, `Debn2`, `Debn3`, `Debn4`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Utils` | `Base`, `rs1` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Ecrit_Data`, `Tris2`, `Debe1`, `Debe2`, `Debe3`, `Debe4`, `Debn1`, `Debn2`, `Debn3`, `Debn4`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** : `grep -rn "Cecrit" .src` ne renvoie que le module lui-même. Pas d'appel
  dynamique (`Object.Call`, chaîne littérale) trouvé.
- Les noms `Tris2`, `Debn1`…`Debn4` existent aussi comme méthodes locales dans
  `Affichages/TriEcritures2.class` (l. 19-54), `Gestion/Etiquettes/Eticli.class:151`,
  `Gestion/Mails/Emailing.class:199`, `Gestion/Mails/EmailingCarte.class:109` : ce sont des
  homonymes sans lien. Leur présence ne doit pas faire croire à un usage du module.
- Tables : aucune en dur ; la table est passée en paramètre par l'appelant (inexistant).
- Contrainte d'ordre : aucune. La suppression (CECRIT-001) est indépendante des autres reworks,
  mais doit précéder un éventuel rework d'`Utils.Base` (UTILS-005), pour ne pas maintenir un
  appelant mort.
