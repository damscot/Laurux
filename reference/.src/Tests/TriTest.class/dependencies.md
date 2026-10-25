# TriTest — Dépendances

> Source : `.src/Tests/TriTest.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Tests/TriTest.class` — classe, formulaire associé `TriTest.form`
- Handlers GUI détectés : 3
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `TriGen` | `<type>`, `ExtraSel` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Dépendance croisée avec [`TriGen`](../../Affichages/TriGen.class/dependencies.md)** : TriTest est
  le banc d'essai de TriGen (décision utilisateur). Toute modification de l'API de TriGen
  (`_new`, `ExtraSel`, `Close`, événement `MajSel`, protocole `Bsel`/`Bval`) doit mettre à jour
  TriTest dans le même commit, et inversement les tests de TriTest servent de non-régression à TriGen.
- Signal `jamais_reference` : **attendu**, ce formulaire est lancé à la main (IDE) ; ce n'est pas un
  candidat à la suppression. Point d'entrée à définir en phase 2 (option de test de `./Laurux`, ou
  lancement depuis un module gb.test avec affichage).
- Handlers : `ColTri_MajSel` est levé par l'objet `tr` (`As "ColTri"`), `form_Close` et
  `CheckBox1_Click` par le formulaire.
