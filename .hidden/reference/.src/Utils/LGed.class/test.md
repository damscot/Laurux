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
| LGED-T01 | gbtest | `String2Array` / `Array2String` | `"a,b,,a, c"`, `["x,y", "", "x"]` | tableaux/chaînes figés | `tests/tags_conversion/` | implémenté |
| LGED-T02 | gbtest (BDD) | `_New` chargement | `New LGed(Null, 1)` | champs et tags de `ged.sql` | `tests/chargement/` | implémenté |
| LGED-T03 | gbtest (BDD) | `Search`/`Exist` | 4 combinaisons compte/origine vides ou non | `lind` trouvé ou `Null`/`False` | `tests/recherche/` | implémenté |
| LGED-T04 | gbtest (BDD) | `AddTag`/`AddTags`/`DelTag`/`DelAllTag` | tag nouveau, tag existant, document non enregistré (`lind = 0`) | lignes `Fiches_Tag`/`Docs_Tag` ; cas tag déjà présent : erreur figée | `tests/tags_bdd/` | implémenté |
| LGED-T05 | gbtest (BDD) | `EpurationTags`/`EpurationDocs` | `ged.sql` avec ligne pendante | lignes supprimées et compteur (anomalie A03 figée) | `tests/epuration/` | implémenté |
| LGED-T06 | gbtest (BDD) | `PDFDupli` | nouveau document Clients et document existant | fichier copié à l'URL attendue ; ligne `Docs_Ged` ; tags vidés | `tests/pdfdupli/` | implémenté |
| LGED-T07 | gbtest | `Default_URL` / `Get_Default_Extension` | 5 types × origine vide/non vide × nom fourni ou non, MIME variés | URL figée (tags avec espace : anomalie A04 figée) | `tests/default_url/` | implémenté |
| LGED-T08 | gbtest | `Get_Mime` | fichier PDF, fichier texte, chemin avec espace | MIME ou `Null` (anomalie figée) | `tests/mime/` | implémenté |
| LGED-T09 | gbtest (BDD) | `Supprime` | document existant, `Epur` vrai/faux | lignes supprimées, fichier conservé | `tests/supprime/` | implémenté |
| LGED-T10 | replay | Fiche : création manuelle | menu GED « nouveau document » (`Fmenu`) : type Autres, code, Copier un fichier, URL par défaut, tags, Enregistrer ; `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` + fichier | ligne et fichier créés | `tests/replay_creation/` | à faire : « Copier » ouvre un sélecteur de fichiers (LBox) et le fichier produit n’est pas capturé par le runner |
| LGED-T11 | replay | Fiche : modification d'URL | `GedR` → Éditer → nouvelle URL locale → Enregistrer | fichier déplacé, `url` modifiée | `tests/replay_move/` | à faire : déplacement de fichier non vérifiable (le runner ne compare que dump + SQL, User.Home non isolé) |
| LGED-T12 | replay | Fiche : date modifiée (anomalie A01) | Éditer → changer la date → Enregistrer | `Docs_Ged.date` **inchangée** (figé) | `tests/replay_date/` | implémenté (gb.test LGedTest.T12DateModifiee : fiche du document 1 instanciée sans affichage (GedR › Éditer l'ouvre en ShowModal), date saisie dans `fdte`, `Enregistrer_Click` : `Docs_Ged.date` et `DTE` inchangés, A01 confirmée et figée) |
| LGED-T13 | replay | Archivage depuis la saisie comptable | `Saisecrit` : écriture 401 + 445 + 6xx, fiche GED ouverte, Enregistrer | document Comptabilité, montants TTC/HT, tags des comptes | `tests/replay_saisecrit/` | à faire : scénario Saisecrit complet non synthétisé dans ce lot |
| LGED-T14 | replay | Suppression depuis la fiche | Éditer → Supprimer → Oui | lignes supprimées, fichier conservé | `tests/replay_suppression/` | implémenté (gb.test LGedTest.T14SuppressionFiche : `Supprimer_Click`, Message.Question « Oui » par un Timer du module ; document 1 et ses liaisons supprimés, tags conservés (pas d'épuration), fichier conservé, fiche détruite ; `form_Close` → `Ouvrir` n'est pas déclenché sur une fiche jamais affichée : visualiseur non appelé dans ce mode, non vérifié) |
| LGED-T15 | gbtest | `Get_Mime` sur URL distante | `{http,https}://laurux_ged_test.fr/mime_file_test.{pdf,txt,html}` (faux `curl`, aucun réseau), nom inconnu sur cet hôte, hôte injoignable, `file:///` d'une copie locale, `file://<hôte>/…` | type MIME par URL ; `Null` pour la forme `file://<hôte>/` | `assets/LGedTest` | implémenté (2026-11-14 ; documents de test dans `.src/Tests/Framework/ged/`) |

## Détail des tests

- **Valeurs attendues** : générées dans le clone non modifié (gbtest : sortie `id;valeur` et dump
  des tables GED ; replay : capture du log puis rejeu et diff des dumps). Les colonnes `lind` et
  `date` (création) sont masquées dans les dumps ; les noms de fichiers contenant `LDate(Now).FT`
  sont normalisés par `check_output.py`.
- **Non testable automatiquement** : scan (`xsane`, `scanimage`, `convert`) et visualisation
  (`Visualiseur.Prog`) : tests manuels documentés ; `Get_Mime` sur URL http (réseau).
- **SQLite** : non couvert (le SQL de la classe n'y fonctionne pas, voir LGED-A05).
- T04 fige l'erreur de collection si elle se produit dans le clone non modifié.
- **Phase 2 (implémentation)** : module `.src/Tests/Utils/LGedTest.test` (T01-T09), valeurs attendues
  `.hidden/Tests/Utils/assets/LGedTest/expected.txt`, jeu `.hidden/Tests/Utils/assets/gedr_shared/ged.sql` (4 documents :
  le 4ᵉ, sans tag, sert à `EpurationDocs` ; dates en 2020). Champs privés relus par `form_Open()` puis
  `Controls[...]`. Fichiers créés sous `$HOME` (HOME de test) : `User.Home` désigne le vrai répertoire de
  l'utilisateur et n'est pas isolé par le runner. Constats : A02 non reproduite (AddTag d'un tag déjà porté
  renvoie le lind sans erreur, figé) ; A03 et A06 confirmées (figées).
