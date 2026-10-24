# hexdblKey — Dépendances

> Source : `.src/Utils/hexdblKey.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/hexdblKey.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `Crypt` |
| `.src/Caisse/Cmenu.class` | `Crypt` |
| `.src/Caisse/Fvendeurs.class` | `Crypt` |
| `.src/Caisse/Ouverture.class` | `Crypt` |
| `.src/Communs/Fblocsoc.class` | `Crypt` |
| `.src/Communs/LauruxConf.class` | `Crypt` |
| `.src/Communs/MDP.class` | `Crypt` |
| `.src/Communs/Prefs.class` | `Crypt` |
| `.src/Communs/Prgm.class` | `Crypt` |
| `.src/Communs/SauvesAuto.module` | `Crypt` |
| `.src/Gestion/Facturation/ConVendeurs.class` | `Crypt` |
| `.src/Gestion/Facturation/FacturefmA.class` | `Crypt` |
| `.src/Gestion/Mails/EnvMail.module` | `Crypt` |
| `.src/Gestion/Site.module` | `Crypt` |
| `.src/Gestion/Tables/FClient.class` | `Crypt` |
| `.src/Utils/Utils.module` | `Crypt` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Grep `hexdblKey\.crypt` (insensible à la casse) : 38 appels dans 16 fichiers — `Caisse/Caisse`,
  `Caisse/Cmenu`, `Caisse/Fvendeurs`, `Caisse/Ouverture`, `Communs/Fblocsoc`, `Communs/LauruxConf`
  (10), `Communs/MDP`, `Communs/Prefs` (13), `Communs/Prgm`, `Communs/SauvesAuto`,
  `Gestion/Facturation/ConVendeurs`, `Gestion/Facturation/FacturefmA`, `Gestion/Mails/EnvMail`,
  `Gestion/Site`, `Gestion/Tables/FClient`, `Utils/Utils` (`glb`).
- Clés passées : `"Laurux"` (29), `"LauruX2012"` (6, mots de passe SSH), clés dérivées des données
  (3 : code client/fournisseur dans `FacturefmA:550`, `FClient:1742`, nombre aléatoire dans `Site`).
- **Compatibilité ascendante obligatoire** : les chaînes déjà stockées dans les `Laurux.conf` des
  utilisateurs doivent rester déchiffrables à l'identique.
- Aucune dépendance sortante, aucun cycle : rework indépendant.
