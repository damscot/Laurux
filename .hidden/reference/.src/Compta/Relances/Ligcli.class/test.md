# Ligcli — Tests

> Source : `.src/Compta/Relances/Ligcli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Formulaire embarqué testé via `FEditrel`. Données : `Laurux01.sql` complété de clients 411 avec
écritures échues non lettrées (au moins un client avec deux pages d'écritures, un client à solde
créditeur, un client sans courriel). Comparaisons : dump de `Fiches_relances` et de
`Fiches_Mvt.relance`, texte extrait du PDF (`pdftotext`) pour les éditions.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LIGCLI-T01 | replay | Construction des lignes | `FEditrel` : générer à la date du jour | une ligne par compte ; solde, niveau de lettre proposé | `tests/construction/` | implémenté |
| LIGCLI-T02 | replay | Navigation clavier/souris | flèches haut/bas, clic sur une ligne | extrait affiché (`visext`) du bon client | `tests/navigation/` | à faire : flèches non rejouées et extrait (`visext`) sans effet en base |
| LIGCLI-T03 | replay | Désélection d'un client | décocher `Checkselec` d'un client | dump `Fiches_relances` : écritures du client supprimées | `tests/deselection/` | implémenté |
| LIGCLI-T04 | replay | Édition individuelle, lettre de niveau 2 | `Radiolet`, lettre 2, `Buttonedit` | texte PDF de référence ; `Fiches_Mvt.relance` mis à jour | `tests/edition_lettre/` | implémenté (relance écrite = niveau de Fiches_relances, pas la lettre choisie : candidat anomalie) |
| LIGCLI-T05 | replay | Édition individuelle, relevé, solde créditeur | `RadioRel`, client créditeur | texte PDF (solde non négativé, comportement figé) | `tests/edition_releve/` | à faire : jeu avec client créditeur à créer (non commencé, vague 4) |
| LIGCLI-T06 | replay | Saut de page | client avec plus de 40 écritures | PDF de 2 pages, en-têtes répétés | `tests/saut_page/` | à faire : jeu de plus de 40 écritures à créer (non commencé, vague 4) |
| LIGCLI-T07 | replay | Client sans compte `Fiches_Comptes` | compte 411 présent dans `Fiches_Mvt` et `Fiches_Cli` seulement | comportement actuel figé (erreur à la construction) | `tests/sans_compte/` | à faire : non commencé (vague 4) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié. Le PDF est comparé par son
  texte (`pdftotext -layout`), la date du jour masquée.
- **Non testable automatiquement** : l'envoi par courriel (`Checkmail`, `EnvMail.Envoi2`) — à
  rejouer manuellement ou avec un serveur SMTP factice.
- T03 et T01 servent aussi à confirmer si l'affectation de `selection` lève `Click`
  (`FEditrel.Checktout_Click`).
- **Implémentation (phase 2, vague 4)** : jeu `Compta/feditrel_shared/feditrel_relances_prete` (lecture seule) ;
  scénarios `.hidden/Tests/Compta/assets/ligcli_<nom>/` depuis Relances › Préparation (`Menu49`, `FEditrel`).
  Les contrôles d'une ligne Ligcli se ciblent par `<Ctrl>#FEditrel#ScrollView1#Ligcli#<Ctrl>#` : le rejeu prend
  le **premier** enfant nommé `Ligcli` (411001) ; les lignes suivantes ne sont pas ciblables. T01 `construction`
  (lecture seule, sql.log comparé), T03 `deselection` (Checkselec = 0 → DELETE), T04 `edition_lettre`
  (Combolettre index 1 puis Buttonedit ; texte du PDF par pdftotext ; observé dans ref : lettre de niveau 2
  imprimée mais `Fiches_Mvt.relance` = 1, valeur lue dans `Fiches_relances.niveau`, Ligcli.class:268/298).
