# Cbase — Architecture

> Source : `.src/Utils/Cbase.module`

## Vue d'ensemble

`Cbase` traduit un **nom logique de table** (`"TabArt"`) en **nom physique** (`"Fiches_Art"`). C'est la
couche d'indirection imposée par AGENTS.md pour toute requête : `"SELECT … FROM " &
Cbase.Table("TabArt") & " WHERE …"`. Le module contient une seule fonction, `Table`, faite d'un
`Select Case` de 121 cas (119 clés distinctes).

Nature : **calcul pur**, sans accès à la base ni état.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Table` | 3-374 | Public | 122 | 248 | 190 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Table(Prog As String) As String`** [portée : nécessaire, 190 fichiers appelants] [nature :
  calcul]. Renvoie le nom physique associé à `Prog` ; une clé inconnue renvoie **`""`** sans erreur ni
  trace. La comparaison est sensible à la casse.
  - **Clés en double** : `TabParam` (l. 8 et 47) et `TabTypec` (l. 230 et 236) ; la seconde
    occurrence est inatteignable (code mort, sans effet).
  - **Clés identité** (le nom physique est la clé) : `Totalisation`, `Ecrs`.
  - **Correspondances non triviales** : `TabTxmo` → `Fiches_Txtmo`, `TabTvav` → `Fiches_Tvaav`,
    `TabTvac` → `Fiches_Tvaac`, `TabTcli` → `Fiches_TarTypcli`, `TabCtcli` → `Fiches_CoeffTypec`,
    `TabCliVtl` → `Fiches_Cli_Vtl`, `TabDocGed` → `Docs_Ged`, `TabMailCli` → `Mails_Cli`…
  - **Tables cibles absentes de `db_control.csv`** : `Art_Saisis`, `Ecrs`, `Fiches_Inv`, `Fiches_InvT`,
    `Fiches_Stat`, `Totalisation`. Ce sont des tables de travail créées à la volée par leurs
    utilisateurs (`CREATE TABLE` trouvés pour `TabArtSaisis`, `Ecrs`, `TabStat`, `Totalisation`) ou
    par `LauruxMaj` (`Fiches_Inv`, l. 3052, à confirmer).
  - **Clés définies jamais utilisées** (grep `Cbase.Table("…")`, aucun appel avec une clé
    calculée) : `TabCdFour`, `TabDocTag`, `TabIdentite`, `TabLibelFac`, `TabMvtA1`…`TabMvtA5`,
    `TabMvtM1`…`TabMvtM5`, `TabTag`.
  - **Clés utilisées mais non définies** (renvoient `""`) : `TabBanques` (`Glcr.class:40`, sous `Try` :
    la liste des banques reste vide), `TabCdocs` (`FClient.class:1653`) et `TabFdocs`
    (`FFournisseur.class:1562`) : `DELETE FROM  WHERE code = …` en erreur SQL, masquée par le
    `Catch` de `DB_Connection.Exec` (message seulement si `backtrace`), `TabCPTdocs` (cité en
    commentaire dans `LGed.class:3`). Voir CBASE-A01.

## État global utilisé

Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer le `Select Case` par une `Collection` statique construite une fois (`_init` ou
  initialisation paresseuse) : `Table = $map[Prog]`, avec `""` pour une clé absente (même résultat,
  même sensibilité à la casse si la `Collection` est créée en mode binaire `gb.Binary`). Gain : CC
  ~121 → 2, lisibilité (une ligne par table), recherche en temps constant.
- Supprimer les deux doublons inatteignables.

### Commonalisation avec d'autres fichiers

- De nombreux fichiers écrivent encore les noms physiques en dur (`Tab = "Fiches_Comptes"` dans
  [Csolde](../Csolde.module/architecture.md), `Fiches_Ligcom`/`Fiches_Identite` dans
  [Utils](../Utils.module/architecture.md), `LauruxMaj`…). Le passage à `Cbase.Table` relève du
  rework de chaque fichier ; la table de correspondance de `Cbase` doit rester la référence.
- `TabIdentite` existe mais `Utils.Fill_Civilite` écrit `Fiches_Identite` en dur.

### Réduction de portée

- Sans objet : une seule fonction, nécessairement Public.

### Séparation traitement / GUI

- Sans objet (calcul pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les tables de travail (`Totalisation`, `Ecrs`, `Art_Saisis`, `Fiches_Stat`, `Fiches_Inv*`) pourraient
  être déclarées dans `db_control.csv` (ou devenir des tables temporaires) pour que `DB_Sanity` les
  contrôle.
- Les tables `Fiches_Banques`, `Docs_Clients`/`Docs_Fournisseurs` (anciennes tables de documents
  visées par `TabCdocs`/`TabFdocs`) n'existent plus : la purge des documents d'un tiers supprimé
  devrait passer par `Docs_Ged` (voir `LGed`).
