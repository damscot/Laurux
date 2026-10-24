# Dup — Dépendances

> Source : `.src/Compta/Utils/Dup.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Dup.class` — classe, formulaire associé `Dup.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Fsoc.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `LauruxConf` | `Createbase` |
| `Start` | `LocalSettings`, `Musique` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_AdrlivC`, `Fiches_Art`, `Fiches_CdBarre`, `Fiches_Cli`, `Fiches_Commentaires`, `Fiches_Comptes`, `Fiches_ContactC`, `Fiches_ContactF`, `Fiches_Cpostaux`, `Fiches_Echeances`, `Fiches_Etiquettes`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Journaux`, `Fiches_Mo`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Tvaac`, `Fiches_Tvaav`, `Fiches_Txt_Relances`, `Fiches_Txtmo`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.class:1399` et `1403` (`Menu150_Click`, menu « Duplication de société »),
  `Fsoc.class:403` et `407` (choix 6), en `ShowModal` sur l'auto-instance ; protégées par `MDP` si
  `/Soc<XX>/Admin`.
- **Tables hors `Cbase`** : `deps.py` les trouve (chaînes littérales), mais elles sont utilisées
  avec un préfixe de base (`Laurux<YY>.Fiches_…`) : requêtes **inter-bases** non visibles comme
  telles.
- **Commande externe** : `mysql` (client en ligne de commande), avec `/dbase/Host`, login et mot de
  passe ; port et tunnel SSH ignorés. Fichier écrit : `~/bases.txt`.
- `LauruxConf.Createbase(Nbase.Text, False)` : crée la base cible depuis la base de défaut (voir
  [LauruxConf](../../../Communs/LauruxConf.class/architecture.md)).
- Aucun appel dynamique ; aucune dépendance circulaire.
- **Ordre de rework** : après la création de `Utils.BasesLaurux` (LAURUXCONF-005) pour DUP-003.
