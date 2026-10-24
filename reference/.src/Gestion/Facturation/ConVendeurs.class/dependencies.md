# ConVendeurs — Dépendances

> Source : `.src/Gestion/Facturation/ConVendeurs.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Facturation/ConVendeurs.class` — classe, formulaire associé `ConVendeurs.form`
- Handlers GUI détectés : 5

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Gestion/Facturation/Facture.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Facture` | `<type>` |
| `Start` | `LocalSettings`, `Societe`, `son` |
| `Utils` | `db` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

`Fiches_Vendeurs`

### Membres Public sans usage externe détecté (portée réductible ?)

`Mdp_Vendeurs`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelants :
  - `Fmenu.Menu42_Click` : `New ConVendeurs` + `ShowModal` ([Fmenu.class:941-942](../../../../../.src/Communs/Fmenu.class#L941-L942)) ;
  - `Fmenu.Menu193_Click` : `New ConVendeurs(True)` ([Fmenu.class:1788](../../../../../.src/Communs/Fmenu.class#L1788)) — **erreur
    d'exécution** : `_new` n'a aucun paramètre, l'argument est donc transmis au constructeur de
    `Form` (parent optionnel) → « Type mismatch: wanted Control, got Boolean instead » (vérifié
    sur un projet minimal Gambas 3, `gbc3`/`gbx3`). `deps.py` ne contrôle pas l'arité des
    `New` (seulement des appels de méthodes) : faux négatif à signaler ;
  - `Facture` touche F5 : `ConVendeurs.ShowModal()` sur l'auto-instance ([Facture.class:889](../../../../../.src/Gestion/Facturation/Facture.class#L889)).
- Dépendance circulaire `ConVendeurs` → `Facture` (`New Facture(False)`) → `ConVendeurs` (F5) :
  à reworker en tenant compte de `Facture` (documenté en parallèle).
- `Start.LocalSettings["/Soc<XX>/CodeVendeur"]` est un contrat implicite avec `Fmenu` et
  `Facture` (format « code nom », nom extrait par `Mid$(…, 3)`).
- Table `Fiches_Vendeurs` via `Cbase.Table("TabVendeurs")` (clé existante).
- Commonalisation possible avec `Caisse/Ouverture` et `Caisse/Svendeur` (sélection de vendeur) :
  à ordonner en phase 3 avec le lot Caisse.
