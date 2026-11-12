# Serveur — Tests

> Source : `.src/Serveur.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module sans GUI : tests `gbtest` avec une base MariaDB jetable (`Laurux01.sql` ou jeu dérivé) et un
répertoire d'échange temporaire affecté à `Variables.Schmprix` (variable `Public` du module
`Variables`). Le résultat comparé est le **contenu octet par octet** des fichiers
`*_Serveur.txt`, qui constitue un contrat avec le programme externe.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SERVEUR-T01 | gbtest | `Pass("Art", …)` | article existant de `Laurux01.sql` (champs `Null`, décimaux, désignation avec accents) en `C` et `M` ; `S` avec `code2`/`code3` | `Art_Serveur.txt` : deux lignes de 67 champs (doublon `art_ect`) puis `S;code;code2;code3;` | `tests/pass_article/` | implémenté |
| SERVEUR-T02 | gbtest | `Pass("Fam", …)` | famille existante en `M` puis `S` | ligne sans `;` final ; `S;code;` | `tests/pass_famille/` | implémenté |
| SERVEUR-T03 | gbtest | `Pass("Four"/"Cli", …)` | fournisseur et client existants (avec et sans ligne `Fiches_Comptes`) | lignes de référence (doublon `cli_typec`, `lettrable` vide sans compte) | `tests/pass_tiers/` | implémenté |
| SERVEUR-T04 | gbtest | `Pass("ContactF"/"ContactC", …)` | contact existant (`code`, `num`) en `M`, puis `S` | lignes de référence | `tests/pass_contacts/` | implémenté |
| SERVEUR-T05 | gbtest | Origines sans SQL | `EQ`, `CB`, `Rpl1`, `Rpl2`, `Etiq` (`P`, `G`), `Stock` | une ligne par appel au format du tableau d'architecture.md | `tests/pass_simples/` | implémenté |
| SERVEUR-T06 | gbtest | Ajout en fin de fichier | fichier préexistant de 3 lignes ; fichier sans saut de ligne final ; fichier absent | lignes ajoutées sans écraser l'existant ; cas sans saut de ligne figé | `tests/pass_ajout/` | implémenté |
| SERVEUR-T07 | gbtest | Cas d'erreur | code article inexistant ; `Variables.Schmprix` vers un répertoire absent ; champ contenant `;` et un retour à la ligne | erreur levée (message figé) ; ligne cassée figée (SERVEUR-A01/A02) | `tests/pass_erreurs/` | implémenté |
| SERVEUR-T08 | replay | Intégration écran | `Articles` : création, modification, suppression d'un article, d'un code-barres et d'une référence liée avec `/Soc01/Sprix`, `Sexport`, `SMajArt` actifs | contenu des fichiers `Art_`, `CB_`, `Rpl1_`, `Rpl2_Serveur.txt` ; aucun fichier si une préférence est inactive | `tests/integration_articles/` | implémenté (partiel : scénarios serveur_integration_articles et serveur_integration_inactive, conf Sprix/Sexport/SMajArt/Schmprix, fichiers tmp/*_Serveur.txt ; création et suppression d'article couvertes ; modification, code-barre et références liées non couverts : saisie dans les ComboBox Cbarre/Rpl1 non rejouable, fiche non chargée par Code + Entrée) |

## Détail des tests

- **Valeurs attendues** : produites en exécutant les mêmes appels dans le clone **Laurux non
  modifié** (fichiers copiés dans `tests/<nom>/expected/`). Les champs `Float`/`Date` dépendent de
  la locale : les tests fixent `LANG=fr_FR.UTF-8`.
- **Comparaison** : `check_output.py` compare les fichiers octet par octet (y compris saut de ligne
  final et encodage).
- **Code mort** (`Docs`, `ReplaceFam`, `convBStr`) : non testé ; sa suppression (SERVEUR-002) est
  vérifiée par `gbc3` et par un grep sans appelant.
- **Non testable** : la lecture par le programme externe (hors dépôt).

### Implémentation (phase 2, 2026-11-11)

- gb.test `.src/Tests/Communs/ServeurTest.test` (T01 à T07), jeu `.hidden/Tests/Communs/assets/ServeurTest/serveur_tiers.sql` (article accentué
  SRV1, article SRV2 dont la désignation contient « ; » et un retour à la ligne, client 411900 sans compte,
  contacts). `Variables.Schmprix` = répertoire temporaire par test ; contenu complet des fichiers vérifié.
- Constats : ligne Art de 68 champs (doublon `art_ect`, `;` final) ; article inexistant → « Result is not
  available » et fichier créé vide ; répertoire absent → « Stream is closed » (handle de module réutilisé) ;
  fichier sans saut de ligne final : la ligne ajoutée est collée à la dernière.

### Implémentation (vague 2 bis, 2026-11-12 : clés conf / fichiers de meta.json)

- Scénario `serveur_integration_articles` : `conf` `/Soc01/Sprix`, `Sexport`, `SMajArt` = 1 et `/Soc01/Schmprix` =
  `~/tmp` (répertoire du HOME de test, créé par `Start.Main`) ; Articles : création de SRV9 (désignation TEST, code
  fournisseur X1 + Entrée, qui appelle `CtrlArt` et met `nouveau` à 1 ; Enregistrer, « Oui ») puis Supprimer
  (« Oui »). `fichiers` : `tmp/Art_Serveur.txt` = ligne `C;SRV9;…` (68 champs) puis `S;SRV9;;X1;` ;
  `CB_`, `Rpl1_`, `Rpl2_Serveur.txt` absents.
- Scénario `serveur_integration_inactive` : même parcours, préférences absentes (seul `Schmprix` défini) : aucun
  fichier `*_Serveur.txt`, mêmes INSERT/DELETE dans sql.log.
- Non couverts : modification (Code + Entrée ne charge pas la fiche : `ArtLF` n'appelle `Maj_Zones` que si
  `nouveau` = 0, valeur posée seulement par `AfficheArt` depuis la grille ou par `CtrlArt`), code-barre et
  références liées (après saisie dans la ComboBox `Cbarre` + Entrée, la boîte de création n'apparaît plus au rejeu,
  code 3).
- Constat (candidat anomalie) : Code d'un article existant + Entrée sans chargement de la fiche, puis Enregistrer :
  `EnrgArt` met à jour l'article avec les champs vides (désignation, famille, fournisseur… à NULL) — observé avec
  l'article 001 de Laurux01 lors de la mise au point (scénario non conservé).
