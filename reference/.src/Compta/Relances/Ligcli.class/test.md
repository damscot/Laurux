# Ligcli — Tests

> Source : `.src/Compta/Relances/Ligcli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Formulaire embarqué testé via `FEditrel`. Données : `Laurux01.sql` complété de clients 411 avec
écritures échues non lettrées (au moins un client avec deux pages d'écritures, un client à solde
créditeur, un client sans courriel). Comparaisons : dump de `Fiches_relances` et de
`Fiches_Mvt.relance`, texte extrait du PDF (`pdftotext`) pour les éditions.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LIGCLI-T01 | replay | Construction des lignes | `FEditrel` : générer à la date du jour | une ligne par compte ; solde, niveau de lettre proposé | `tests/construction/` | à faire |
| LIGCLI-T02 | replay | Navigation clavier/souris | flèches haut/bas, clic sur une ligne | extrait affiché (`visext`) du bon client | `tests/navigation/` | à faire |
| LIGCLI-T03 | replay | Désélection d'un client | décocher `Checkselec` d'un client | dump `Fiches_relances` : écritures du client supprimées | `tests/deselection/` | à faire |
| LIGCLI-T04 | replay | Édition individuelle, lettre de niveau 2 | `Radiolet`, lettre 2, `Buttonedit` | texte PDF de référence ; `Fiches_Mvt.relance` mis à jour | `tests/edition_lettre/` | à faire |
| LIGCLI-T05 | replay | Édition individuelle, relevé, solde créditeur | `RadioRel`, client créditeur | texte PDF (solde non négativé, comportement figé) | `tests/edition_releve/` | à faire |
| LIGCLI-T06 | replay | Saut de page | client avec plus de 40 écritures | PDF de 2 pages, en-têtes répétés | `tests/saut_page/` | à faire |
| LIGCLI-T07 | replay | Client sans compte `Fiches_Comptes` | compte 411 présent dans `Fiches_Mvt` et `Fiches_Cli` seulement | comportement actuel figé (erreur à la construction) | `tests/sans_compte/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié. Le PDF est comparé par son
  texte (`pdftotext -layout`), la date du jour masquée.
- **Non testable automatiquement** : l'envoi par courriel (`Checkmail`, `EnvMail.Envoi2`) — à
  rejouer manuellement ou avec un serveur SMTP factice.
- T03 et T01 servent aussi à confirmer si l'affectation de `selection` lève `Click`
  (`FEditrel.Checktout_Click`).
