# Parametre — Tests

> Source : `.src/Communs/Parametre.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de saisie : tests `replay` comparant le **dump normalisé** de `Fiches_Parametres`,
`Fiches_Societes`, `Art_Tipp` et `Fiches_Docactif`, plus les lignes `Exec_SQL` du log (nombre
d'`UPDATE` émis). Après la séparation traitement/GUI (PARAMETRE-005/006), les fonctions SQL
deviennent testables en `gbtest`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PARAMETRE-T01 | replay | Ouverture et fermeture sans modification | `Laurux01.sql`, option `N` ; Menu25 ; **Quitter** (Btn Tag 3) | dump `Fiches_Parametres` identique ; 2 séries d'`UPDATE` dans le log (double enregistrement figé) ; verrou pris puis libéré dans `Fiches_Docactif` | `tests/ouverture_fermeture/` | à faire |
| PARAMETRE-T02 | replay | Modification de chaque champ | saisie de nouvelles valeurs (dates, comptes, journaux, numéros, devise, frais, ticket) ; **Enregistrer** | dump `Fiches_Parametres` (30 + 7 colonnes) ; `dnart` tronqué à 15 | `tests/saisie_complete/` | à faire |
| PARAMETRE-T03 | replay | Champs obligatoires vides | vider successivement chaque champ obligatoire (dont `datefedec`) ; **Enregistrer** puis fermer | `Message.Error` et aucune écriture ; fermeture bloquée ; `datefedec` vide **accepté** (A02 figée) | `tests/obligatoires/` | à faire |
| PARAMETRE-T04 | replay | Comptes et TVA inexistants | `cptfrais`, `tvafrais`, comptes de résultat inexistants ; réponse **Non** puis **Oui** | questions affichées, `FComptes`/`FTvav` ouverts, aucune écriture tant que `b = 1` | `tests/comptes_inexistants/` | à faire |
| PARAMETRE-T05 | replay | Journaux | journal inexistant ; journal de mauvais type pour chaque champ ; `Jod` = `Jreport` | messages attendus ; aucune écriture | `tests/journaux/` | à faire |
| PARAMETRE-T06 | replay | Périodes `mc`/`mc2` | « 13.2024 », « 02.2024 », vide | `b` et focus (`mcdt`), valeur normalisée | `tests/periodes/` | à faire |
| PARAMETRE-T07 | replay | Préfixes 411/401 | `dnclient` = « 512000 », `dnfournisseur` = « 601000 » ; Ctrl+M et double-clic de déverrouillage | figer : aucun avertissement si les handlers ne sont pas déclenchés (A07) | `tests/prefixes_tiers/` | à faire |
| PARAMETRE-T08 | replay | Option boisson (B) | base avec colonnes `modfichier` ; `/Soc<XX>/bois` = True ; saisie consignes, `nvign` « 123 », `ident`, `caution` | dump `Fiches_Parametres` et `Fiches_Societes` ; `nvign` sur 25 chiffres | `tests/option_boisson/` | à faire |
| PARAMETRE-T09 | replay | Option carburant (P) | `/Soc<XX>/pp` = True ; `Art_Tipp` avec 2 lignes ; ajout d'un article, article inexistant ; **Valtip** | dump `Art_Tipp` **après déconnexion** (transaction non validée, A01) et avant (même connexion) | `tests/option_carburant/` | à faire |
| PARAMETRE-T10 | replay | Caisse active | `/Soc<XX>/Caisse` = True, `jrnal4` vide | refus d'enregistrement | `tests/caisse_journal/` | à faire |
| PARAMETRE-T11 | replay | Verrou concurrent | ligne `Parametres/0` déjà présente dans `Fiches_Docactif` (autre utilisateur) ; Menu25 | message de `DocActif`, fenêtre ouverte malgré tout (A03 figée) ; libération forcée à la fermeture | `tests/verrou_concurrent/` | à faire |
| PARAMETRE-T12 | gbtest | `Verif_Compte`, `Veriftva`, `mcdt` (après PARAMETRE-006) | comptes existants/inexistants de `Laurux01.sql` ; codes TVA ; périodes | booléens et chaînes de référence | `tests/verifications/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` dans MariaDB Docker ; jeux dérivés pour les options B/P créés en
  exécutant `modfichier.fichierboisson`/`fichiercarbu` sur une base de test (ou par script SQL
  équivalent extrait du clone non modifié), puis `Laurux.conf` avec `bois`/`pp`.
- **Normalisation** : dump trié de `Fiches_Parametres` sans la colonne `conf` (comparée à part),
  `Fiches_Docactif` sans `process_id`/`host_id`/`machine_id` (volatils).
- **Transaction de `Valtip_Click`** : T09 vérifie l'état visible par une **seconde** connexion
  (non validé) puis après fermeture de l'application.
- **Non testable automatiquement** : aide HTML (`Doc.Open`), son (jamais joué).
