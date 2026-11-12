# EcrM — Tests

> Source : `.src/Compta/Impressions/EcrM.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition sans écriture métier (seule la table de travail `centralisation` est recréée).
Résultat principal : `~/tmp/Journaux.pdf`, comparé après `pdftotext -layout` et normalisation
(date d'édition du pied de page `BasPage2`, nom de l'utilisateur) ; lignes `Exec_SQL` du log en
complément.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECRM-T01 | replay | Ouverture, exercice en cours | ouverture sous `faketime` | dates `DteN0`/`Dten1` affichées ; requête `Fiches_Parametres` | `tests/ouverture/` | implémenté (requête Fiches_Parametres ; dates affichées non comparées) |
| ECRM-T02 | replay | Choix d'exercice | clics `E1`, `N1` … `N5` | bornes affichées pour chaque exercice ; table interrogée `Fiches_MvtM<n>` à l'impression | `tests/exercices/` | implémenté (lecture Fiches_MvtM1 à l'impression N1 ; dates affichées non comparées) |
| ECRM-T03 | replay | Impression « Toutes », tri date | jeu `MvtM` ; « Imprimer » | texte PDF normalisé ; statuts M/S ; traits de séparation par numéro | `tests/pdf_toutes/` | implémenté (requêtes, table centralisation, ouverture du PDF ; texte PDF non comparé) |
| ECRM-T04 | replay | Filtres Modifiées / Supprimées | clic `Modifiee` puis `Supprimee`, tri numéro | texte PDF normalisé ; clause `supprimee` dans `Exec_SQL` | `tests/pdf_filtres/` | implémenté (clauses supprimee ; texte PDF non comparé) |
| ECRM-T05 | replay | Multipage | > 60 lignes `Supprimees` | en-tête « modifiées » après saut de page (A03 figée), « Page N° 0 » en page 1 (A05 figée) | `tests/pdf_multipage/` | à faire : sortie PDF non comparée (en-têtes de page) |
| ECRM-T06 | replay | Compte inexistant | ligne `MvtM` sur un compte absent de `Fiches_Comptes` | `Message.Error` « Le compte … n'existe pas » ; pas de PDF | `tests/compte_absent/` | implémenté |
| ECRM-T07 | replay | Aucune ligne | période vide | `Message.Warning` « Aucune écriture pour cette sélection ! » | `tests/selection_vide/` | implémenté |
| ECRM-T08 | replay | Saisie de dates | `DteN0` = date hors exercice + Entrée ; `Dten1` = « 3112 » + Entrée | avertissement sur `DteN0` ; `Dten1` non normalisé, requête avec la saisie brute (A01 figée) | `tests/saisie_dates/` | à faire : Message.Warning ouvert depuis LostFocus non rejouable (fenêtre active, code 3) |
| ECRM-T09 | replay | `datem` nul | lignes 411 et 512 avec `datem` NULL | ligne 411 absente (blanc), ligne 512 : comportement figé (erreur ou date vide, A04) | `tests/datem_nul/` | à faire |
| ECRM-T10 | replay | Édition provisoire | date de fin > `dtepc` | qualificatif « Edition provisoire » non imprimé mais numéros `numero` utilisés | `tests/provisoire/` | à faire : sortie PDF non comparée (qualificatif « Edition provisoire ») |
| ECRM-T11 | gbtest | `Bornes_Exercice` (après ECRM-008) | `Fiches_Parametres` de test, indices 0 à 5 | dates `.L` identiques à T02 | `tests/bornes_exercice/` | à faire : extraction ECRM-008 non réalisée |
| ECRM-T12 | gbtest | `Date_Hors_Periode` (après ECRM-008) | dates avant, dans, après la période | -1 / 0 / 1 | `tests/hors_periode/` | à faire : extraction ECRM-008 non réalisée |
| ECRM-T13 | replay | Curseur et formulaire `Journaux` | impression, puis inspection des fenêtres | auto-instance `Journaux` créée (A02 figée) | `tests/curseur_journaux/` | à faire : inspection des fenêtres (auto-instance Journaux) non observable par le rejeu |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié**, `faketime`
  à date fixe, `/Soc01/caisse/CmdVis` pointant vers une commande de copie du PDF ; rejeu sur les
  deux clones ; comparaison des textes normalisés et du dump (la table `centralisation` est
  exclue du dump normalisé, table de travail).
- **Données** : `Laurux01.sql` ne contient **aucune écriture** : base = jeu dérivé commun aux éditions
  comptables décrit dans [Balance/test.md](../Balance.class/test.md#détail-des-tests), complété par : `jeu_mvtm.sql` : lignes dans `Fiches_MvtM` et `Fiches_MvtM1`
  (modifiées `supprimee` NULL/0, supprimées 1), comptes 401/411/453/512, libellés « Fac… »,
  « Avo… », `datem` NULL sur quelques lignes, un compte absent de `Fiches_Comptes`.
- **SQLite** : T03 rejoué sur `Laurux01.sqlite` (clause `COLLATE NOCASE` injectée par
  `DB_Connection`, ordre de tri à vérifier).
- **Non testable automatiquement** : son (`Music.Play`), rendu graphique, aide (`Doc.Open`).

- **Phase 2 (agent 3, vague 3)** : scénarios `.hidden/Tests/Compta/assets/ecrm_<nom>/` (`ouverture`, `exercices`,
  `pdf_toutes`, `pdf_filtres`, `compte_absent`, `selection_vide`), jeu partagé `ecrm_shared/ecrm_mvtm.sql`
  (Fiches_MvtM 2018 modifiées/supprimées, Fiches_MvtM1 2017) et jeu `ecrm_compte_absent/ecrm_compte_absent.sql`.
  Ouverture du PDF vérifiée par `@ouvrir.trace` ; le texte du PDF n'est pas comparé. Observé : avec la date
  figée au 2018-06-15, l'ouverture retient la période 01.01.2018-31.12.2018 (chemin `Exo` de `Ex1`).
