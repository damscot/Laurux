# Serveur — Dépendances

> Source : `.src/Serveur.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Serveur.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Docs`, `ReplaceFam`, `convBStr`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Stock/Tarifs/Impart.class` | `Pass` |
| `.src/Gestion/Stock/Tarifs/MajEqu.module` | `Pass` |
| `.src/Gestion/Stock/Tarifs/MajFbtarif2.class` | `Pass` |
| `.src/Gestion/Stock/Tarifs/MajTarifM.class` | `Pass` |
| `.src/Gestion/Stock/Tarifs/MajTarifP.class` | `Pass` |
| `.src/Gestion/Tables/Articles.class` | `Pass` |
| `.src/Gestion/Tables/FClient.class` | `Pass` |
| `.src/Gestion/Tables/FFournisseur.class` | `Pass` |
| `.src/Gestion/Tables/Famille.class` | `Pass` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |
| `Variables` | `Schmprix` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_ContactC`, `Fiches_ContactF`, `Fiches_Fam`, `Fiches_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`Docs`, `ReplaceFam`, `convBStr`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Portée réductible** : `deps.py` signale `ReplaceFam` et `convBStr`, mais **pas `Docs`**, qui n'a
  pourtant aucun appelant (grep `Serveur.Docs` et `\bDocs(` : seules des chaînes `"Docs"` et
  `Maj_Dssr("Docs")` existent). Faux négatif dû à la règle « nom cité en chaîne littérale ». Les
  trois fonctions sont du **code mort**.
- **Bloc mort** : aucun appelant ne passe `Origine = "Stock"`.
- **Tables** : toutes en dur (`Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Comptes`,
  `Fiches_ContactF`, `Fiches_Cli`, `Fiches_ContactC`), lecture seule.
- **Dépendance cachée** : le consommateur des fichiers `<Variables.Schmprix>/*_Serveur.txt` est un
  programme externe (aucun lecteur dans `.src`). Le format est un contrat hors dépôt.
- **Garde côté appelant** : les 44 appels sont précédés de `Variables.Sprix And Variables.Sexport
  And Variables.SMajArt|SMajFour|SMajCli` ; `Variables` lit ces drapeaux une seule fois (initialiseurs
  de module), une modification dans `Prefs` n'est donc prise en compte qu'au redémarrage (à confirmer).
- Aucun appel dynamique, aucune dépendance circulaire. `Serveur` ne dépend que de `Utils.db` et
  `Variables.Schmprix` : il peut être reworké en premier ; SERVEUR-008 modifie les 9 appelants et
  doit passer après leurs propres reworks de structure (ou dans le même lot).
