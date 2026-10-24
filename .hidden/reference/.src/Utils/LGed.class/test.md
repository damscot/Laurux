# LGed — Tests

> Source : `.src/Utils/LGed.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'API objet (sans fenêtre affichée) est testable en `gbtest` avec la base MariaDB Docker ; la fiche
d'édition et le scan relèvent du `replay`. Jeu de données commun : `Laurux01.sql` + `ged.sql`
(3 documents, 5 tags dont un partagé, une ligne `Docs_Tag` pendante pour A03, fichiers PDF
factices sous `tests/data/ged/`, racines `/Soc01/Factchemin*` pointant vers un répertoire
temporaire dans le `Laurux.conf` du test).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LGED-T01 | gbtest | `String2Array` / `Array2String` | `"a,b,,a, c"`, `["x,y", "", "x"]` | tableaux/chaînes figés | `tests/tags_conversion/` | à faire |
| LGED-T02 | gbtest (BDD) | `_New` chargement | `New LGed(Null, 1)` | champs et tags de `ged.sql` | `tests/chargement/` | à faire |
| LGED-T03 | gbtest (BDD) | `Search`/`Exist` | 4 combinaisons compte/origine vides ou non | `lind` trouvé ou `Null`/`False` | `tests/recherche/` | à faire |
| LGED-T04 | gbtest (BDD) | `AddTag`/`AddTags`/`DelTag`/`DelAllTag` | tag nouveau, tag existant, document non enregistré (`lind = 0`) | lignes `Fiches_Tag`/`Docs_Tag` ; cas tag déjà présent : erreur figée | `tests/tags_bdd/` | à faire |
| LGED-T05 | gbtest (BDD) | `EpurationTags`/`EpurationDocs` | `ged.sql` avec ligne pendante | lignes supprimées et compteur (anomalie A03 figée) | `tests/epuration/` | à faire |
| LGED-T06 | gbtest (BDD) | `PDFDupli` | nouveau document Clients et document existant | fichier copié à l'URL attendue ; ligne `Docs_Ged` ; tags vidés | `tests/pdfdupli/` | à faire |
| LGED-T07 | gbtest | `Default_URL` / `Get_Default_Extension` | 5 types × origine vide/non vide × nom fourni ou non, MIME variés | URL figée (tags avec espace : anomalie A04 figée) | `tests/default_url/` | à faire |
| LGED-T08 | gbtest | `Get_Mime` | fichier PDF, fichier texte, chemin avec espace | MIME ou `Null` (anomalie figée) | `tests/mime/` | à faire |
| LGED-T09 | gbtest (BDD) | `Supprime` | document existant, `Epur` vrai/faux | lignes supprimées, fichier conservé | `tests/supprime/` | à faire |
| LGED-T10 | replay | Fiche : création manuelle | menu GED « nouveau document » (`Fmenu`) : type Autres, code, Copier un fichier, URL par défaut, tags, Enregistrer ; `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` + fichier | ligne et fichier créés | `tests/replay_creation/` | à faire |
| LGED-T11 | replay | Fiche : modification d'URL | `GedR` → Éditer → nouvelle URL locale → Enregistrer | fichier déplacé, `url` modifiée | `tests/replay_move/` | à faire |
| LGED-T12 | replay | Fiche : date modifiée (anomalie A01) | Éditer → changer la date → Enregistrer | `Docs_Ged.date` **inchangée** (figé) | `tests/replay_date/` | à faire |
| LGED-T13 | replay | Archivage depuis la saisie comptable | `Saisecrit` : écriture 401 + 445 + 6xx, fiche GED ouverte, Enregistrer | document Comptabilité, montants TTC/HT, tags des comptes | `tests/replay_saisecrit/` | à faire |
| LGED-T14 | replay | Suppression depuis la fiche | Éditer → Supprimer → Oui | lignes supprimées, fichier conservé | `tests/replay_suppression/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées dans le clone non modifié (gbtest : sortie `id;valeur` et dump
  des tables GED ; replay : capture du log puis rejeu et diff des dumps). Les colonnes `lind` et
  `date` (création) sont masquées dans les dumps ; les noms de fichiers contenant `LDate(Now).FT`
  sont normalisés par `check_output.py`.
- **Non testable automatiquement** : scan (`xsane`, `scanimage`, `convert`) et visualisation
  (`Visualiseur.Prog`) : tests manuels documentés ; `Get_Mime` sur URL http (réseau).
- **SQLite** : non couvert (le SQL de la classe n'y fonctionne pas, voir LGED-A05).
- T04 fige l'erreur de collection si elle se produit dans le clone non modifié.
