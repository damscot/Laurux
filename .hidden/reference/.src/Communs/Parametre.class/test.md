# Parametre — Tests

> Source : `.src/Communs/Parametre.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de saisie : tests `replay` comparant le **dump normalisé** de `Fiches_Parametres`,
`Fiches_Societes`, `Art_Tipp` et `Fiches_Docactif`, plus les lignes `Exec_SQL` du log (nombre
d'`UPDATE` émis). Après la séparation traitement/GUI (PARAMETRE-005/006), les fonctions SQL
deviennent testables en `gbtest`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PARAMETRE-T01 | replay | Ouverture et fermeture sans modification | `Laurux01.sql`, option `N` ; Menu25 ; **Quitter** (Btn Tag 3) | dump `Fiches_Parametres` identique ; 2 séries d'`UPDATE` dans le log (double enregistrement figé) ; verrou pris puis libéré dans `Fiches_Docactif` | `tests/ouverture_fermeture/` | implémenté |
| PARAMETRE-T02 | replay | Modification de chaque champ | saisie de nouvelles valeurs (dates, comptes, journaux, numéros, devise, frais, ticket) ; **Enregistrer** | dump `Fiches_Parametres` (30 + 7 colonnes) ; `dnart` tronqué à 15 | `tests/saisie_complete/` | implémenté |
| PARAMETRE-T03 | replay | Champs obligatoires vides | vider successivement chaque champ obligatoire (dont `datefedec`) ; **Enregistrer** puis fermer | `Message.Error` et aucune écriture ; fermeture bloquée ; `datefedec` vide **accepté** (A02 figée) | `tests/obligatoires/` | implémenté |
| PARAMETRE-T04 | replay | Comptes et TVA inexistants | `cptfrais`, `tvafrais`, comptes de résultat inexistants ; réponse **Non** puis **Oui** | questions affichées, `FComptes`/`FTvav` ouverts, aucune écriture tant que `b = 1` | `tests/comptes_inexistants/` | implémenté (partiel : compte de frais ; TVA et comptes de résultat sur perte de focus non rejouables) |
| PARAMETRE-T05 | replay | Journaux | journal inexistant ; journal de mauvais type pour chaque champ ; `Jod` = `Jreport` | messages attendus ; aucune écriture | `tests/journaux/` | à faire : messages émis depuis jrnal_LostFocus (Message.Question/Warning) jamais fenêtre active au rejeu (code 3) |
| PARAMETRE-T06 | replay | Périodes `mc`/`mc2` | « 13.2024 », « 02.2024 », vide | `b` et focus (`mcdt`), valeur normalisée | `tests/periodes/` | implémenté |
| PARAMETRE-T07 | replay | Préfixes 411/401 | `dnclient` = « 512000 », `dnfournisseur` = « 601000 » ; Ctrl+M et double-clic de déverrouillage | figer : aucun avertissement si les handlers ne sont pas déclenchés (A07) | `tests/prefixes_tiers/` | à faire : Ctrl+M et double-clic non rejoués ; Dnclient/Dnfournisseur en lecture seule |
| PARAMETRE-T08 | replay | Option boisson (B) | base avec colonnes `modfichier` ; `/Soc<XX>/bois` = True ; saisie consignes, `nvign` « 123 », `ident`, `caution` | dump `Fiches_Parametres` et `Fiches_Societes` ; `nvign` sur 25 chiffres | `tests/option_boisson/` | implémenté |
| PARAMETRE-T09 | replay | Option carburant (P) | `/Soc<XX>/pp` = True ; `Art_Tipp` avec 2 lignes ; ajout d'un article, article inexistant ; **Valtip** | dump `Art_Tipp` **après déconnexion** (transaction non validée, A01) et avant (même connexion) | `tests/option_carburant/` | implémenté (sans ajout de ligne SaiTableau ni seconde connexion) |
| PARAMETRE-T10 | replay | Caisse active | `/Soc<XX>/Caisse` = True, `jrnal4` vide | refus d'enregistrement | `tests/caisse_journal/` | implémenté |
| PARAMETRE-T11 | replay | Verrou concurrent | ligne `Parametres/0` déjà présente dans `Fiches_Docactif` (autre utilisateur) ; Menu25 | message de `DocActif`, fenêtre ouverte malgré tout (A03 figée) ; libération forcée à la fermeture | `tests/verrou_concurrent/` | implémenté |
| PARAMETRE-T12 | gbtest | `Verif_Compte`, `Veriftva`, `mcdt` (après PARAMETRE-006) | comptes existants/inexistants de `Laurux01.sql` ; codes TVA ; périodes | booléens et chaînes de référence | `tests/verifications/` | implémenté (gb.test : Verif_Compte, mcdt valides ; Veriftva privée) |

## Détail des tests

- **Données** : `Laurux01.sql` dans MariaDB Docker ; jeux dérivés pour les options B/P créés en
  exécutant `modfichier.fichierboisson`/`fichiercarbu` sur une base de test (ou par script SQL
  équivalent extrait du clone non modifié), puis `Laurux.conf` avec `bois`/`pp`.
- **Normalisation** : dump trié de `Fiches_Parametres` sans la colonne `conf` (comparée à part),
  `Fiches_Docactif` sans `process_id`/`host_id`/`machine_id` (volatils).
- **Transaction de `Valtip_Click`** : T09 vérifie l'état visible par une **seconde** connexion
  (non validé) puis après fermeture de l'application.
- **Non testable automatiquement** : aide HTML (`Doc.Open`), son (jamais joué).
- **Implémentation (phase 2)** : scénarios `.hidden/Tests/Communs/assets/parametre_<nom>/` (`ouverture_fermeture`,
  `saisie_complete`, `obligatoires`, `comptes_inexistants`, `periodes`, `option_boisson`, `option_carburant`,
  `caisse_journal`, `verrou_concurrent`) et module gb.test `.src/Tests/Communs/ParametreTest.test` (T12). Jeux de
  données : `parametre_option_boisson`, `parametre_option_carburant`, `parametre_caisse` (options activées par les
  préférences globales `Fiches_Parametres.conf`, appliquées au démarrage) et `parametre_verrou_concurrent`.
- **Limites de rejeu constatées** : une boîte `Message.*` ouverte depuis un `LostFocus` n'est jamais la fenêtre active
  (rejeu bloqué) ; le changement d'onglet vers « métiers » donne le focus à `cptfrais`, qui doit être renseigné avec un
  compte existant avant tout autre champ ; les champs de date ne peuvent pas être vidés (`dte.G` conservé).
- **Comportements figés notables** : T03 `Form_Close` affiche deux fois `Message.Error` ; T04 compte de frais
  inexistant enregistré malgré « Non » (b remis à 0 par `cpts_LostFocus`) ; T06 période « 13.2024 » enregistrée « .. » ;
  T09 transaction de `Valtip_Click` validée implicitement par le `LOCK TABLES` de `DocActif.Free_Lock`.

