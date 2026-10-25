# Svendeur — Dépendances

> Source : `.src/Caisse/Svendeur.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Svendeur.class` — classe, formulaire associé `Svendeur.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Caisse` | `$Vendeur` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `$cai`, `son` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Vendeurs`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelant unique : `Caisse` (auto-instance `Svendeur.showmodal()`, [Caisse.class:919](../../../../.src/Caisse/Caisse.class#L919) et [Caisse.class:975](../../../../.src/Caisse/Caisse.class#L975)),
  seulement si le ticket n'a encore aucune ligne.
- Écritures `Caisse.$Vendeur` (lignes 46, 48, 56) et `Start.$Cai` (ligne 45) : présentes dans le
  bloc ci-dessus depuis la mise à jour de `deps.py` (absentes du `deps.json` initial). Elles créent
  un cycle `Caisse` ↔ `Svendeur` ; `Caisse.$Vendeur` doit rester `Public` (CAISSE-A04).
- `Caisse.$Vendeur` n'est pas `Static` : l'écriture vise l'auto-instance de `Caisse` alors que la
  saisie ouverte est créée par `New Caisse` dans `Cmenu.Button11_Click` (SVENDEUR-A01). Aucun
  `Caisse.Show`/`Caisse.ShowModal` sur l'auto-instance n'existe dans le projet (vérifié).
- Ordre de rework : avec `Caisse` (correction de A01, gros fichier legacy : modification minimale
  et ciblée) et après le helper `LVendeur`.
