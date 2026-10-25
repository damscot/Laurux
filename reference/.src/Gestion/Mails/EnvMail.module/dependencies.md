# EnvMail — Dépendances

> Source : `.src/Gestion/Mails/EnvMail.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Mails/EnvMail.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Envoi2b`, `Envoi5`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `Envoi` |
| `.src/Compta/Impressions/ExportA47.class` | `Envoi2` |
| `.src/Compta/Relances/Ligcli.class` | `Envoi2` |
| `.src/Compta/Utils/ExportJdv.class` | `Envoi2`, `Envoi3` |
| `.src/Gestion/Entrées/Achat.class` | `Envoi2` |
| `.src/Gestion/Lcr/Bordrx.class` | `Envoi2` |
| `.src/Gestion/Mails/Emailing.class` | `Envoi`, `Extension` |
| `.src/Gestion/Mails/EmailingCarte.class` | `Envoi`, `Extension` |
| `.src/Gestion/Tables/FClient.class` | `Envoi2` |
| `.src/Gestion/Tables/FFournisseur.class` | `Envoi2` |
| `.src/Gestion/option/ObjFacB.class` | `Envoi`, `Envoi2` |
| `.src/Utils/Exports-Imports/Expbase.class` | `Envoi2` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Societe` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Envoi2b`, `Envoi5`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** (`grep -rn "EnvMail\." .src`) : la liste AUTO est complète. Seul usage
  commenté : `FEditrel.class:603`.
- **Arité** : `ExportJdv.class:1000` appelle `Envoi3` avec 5 arguments pour 4 → « Too many
  arguments » à l'exécution (vérifié sur un projet minimal), intercepté par le `Catch` de
  `ExportJdv.export`. `Envoi3` n'a donc aucun appel qui aboutisse. Anomalie portée ici
  (ENVMAIL-A01) ; à rapprocher de la documentation d'`ExportJdv` (architecture.md, `export()`),
  qui présente cet appel comme fonctionnel.
- **Code mort confirmé** : `Envoi2b`, `Envoi5` (aucune occurrence hors du module).
- **Paramètre jamais fourni** : `Envoi2(…, piece3)` — aucun des 11 appels ne passe un 6ᵉ argument.
- **Valeur de retour d'`Envoi`** ignorée par ses 6 appels.
- **`Settings` contre `Start.LocalSettings`** : `deps.py` ne voit pas l'objet `Settings` natif
  (lignes 26, 141, 176) ; il ne s'agit pas du module `Start`.
- **Dépendances externes non vues par `deps.py`** : composant `gb.net.smtp` (`SmtpClient`),
  programmes `thunderbird`, `icedove`, `evolution`, `kmail` (à déclarer dans DEPENDANCES.md),
  `hexdblKey.Crypt`.
- **Contrat implicite avec les appelants d'`Envoi`** : `chemin` = répertoire, `FileN` = nom ;
  non respecté par `Emailing` et `EmailingCarte` (voir leurs anomalies A02).
- **Ordre de rework** : après `hexdblKey` ; avant `Emailing`, `EmailingCarte` (contrat de
  pièce jointe) et `ExportJdv` (A01). Toute modification de signature `Public` impose la mise à
  jour simultanée des 12 fichiers appelants.
- Aucun appel dynamique, aucune table SQL.
