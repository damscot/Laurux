# FRestore — Dépendances

> Source : `.src/Communs/FRestore.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/FRestore.class` — classe, formulaire associé `FRestore.form`
- Handlers GUI détectés : 7

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Close`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `Mmysql` | `Init`, `Process_List` |
| `Recup` | `Utilisateur` |
| `Start` | `LocalSettings`, `Musique`, `UnLock`, `son` |
| `Syntheses` | `Message` |
| `Utils` | `Clear_DataBase`, `Create_DataBase`, `Exit`, `Fill_DataBase`, `db`, `fermeTunnel` |

### Tables SQL référencées

`Fiches_Docactif`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Process_Read`, `Verif_Version`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** : `Fmenu.class:280` (choix « Restaurer une sauvegarde » après une erreur
  de démarrage), `Fmenu.class:832`/`836` (`Menu65_Click`, protégé par `MDP` si `/Soc<XX>/Admin`).
- **Portée réductible confirmée** : `Process_Read` (aucun appel : code mort), `Verif_Version`
  (appel interne l. 144 seulement).
- **Tables** : `Fiches_Docactif` via `Cbase.Table("TabActif")` (l'heuristique la résout bien),
  `Fiches_Parametres` en dur. La restauration remplace **toute** la base `Utils.db.Name`
  (`DROP`/`CREATE DATABASE` + import) : le replay doit comparer le dump complet.
- **Commandes externes** non vues par deps.py : `mysql` (l. 68 et via `Utils.*_DataBase`), `ls`,
  `mysqladmin` et `gksu`/`kdesu` (via `Mmysql`), `sed` (via `Fill_DataBase`).
- **Fichier partagé** `~/tmp/resultat` : écrit ici, par `Mmysql.Process_List` et lu par
  `Button4_Click` ; `~/tmp` est créé par `Start.module:159`.
- **Couplage avec `FSauve`** : formats de fichiers (`<base>.sql`, `<base>.sql.gz`, `Laurux.conf`)
  produits par `FSauve`. `SauvesAuto` laisse aussi `<base>.sql` (dernière sauvegarde, restaurable) mais
  ses archives par jour `<base><jour>.sql.gz` ne sont **pas** restaurables sans renommage.
- **Ordre de rework** : après `Utils` (UTILS-014), `Mmysql`, `Expbase` (helper de chemin) et
  `Majversion` (RecupVersionApp) ; en même temps que `FSauve` (helpers d'écran communs).
