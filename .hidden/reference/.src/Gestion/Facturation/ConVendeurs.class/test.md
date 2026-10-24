# ConVendeurs — Tests

> Source : `.src/Gestion/Facturation/ConVendeurs.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` depuis le menu Gestion › Facturation › Saisie des documents, avec
`/Soc01/Vendeurs` = 1 et `/Soc01/CodeVendeur` vide dans le `Laurux.conf` du test. Comparaisons :
`Laurux.conf` (clé `CodeVendeur`), journal de rejeu (messages), dump de la base (inchangé).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CONVENDEURS-T01 | replay | Connexion réussie | vendeur `1`, bon mot de passe, `Connecter` | `CodeVendeur = "1 <nom>"`, saisie de documents ouverte | `tests/connexion_ok/` | à faire |
| CONVENDEURS-T02 | replay | Mot de passe erroné / vide / vendeur vide | trois tentatives | trois messages d'erreur, `CodeVendeur` inchangé | `tests/connexion_refusee/` | à faire |
| CONVENDEURS-T03 | replay | Code vendeur sur 2 caractères | vendeur `12`, son mot de passe | figer le comportement actuel (recherche sur `1`, A02) | `tests/code_deux_car/` | à faire |
| CONVENDEURS-T04 | replay | Déconnexion | `Déconnecter` depuis Menu42 puis depuis F5 de `Facture` | `CodeVendeur` vidé ; fenêtre visible ou non selon le chemin (A03 figée) | `tests/deconnexion/` | à faire |
| CONVENDEURS-T05 | replay | Changement de vendeur en saisie (F5) | `Facture`, F5, connexion | figer l'ouverture d'une seconde saisie (A04) | `tests/changement_f5/` | à faire |
| CONVENDEURS-T06 | replay | Menu « Saisie des factures entretien » | `/Materiel` = 1, vendeurs actifs, pas de vendeur connecté | figer l'erreur « Type mismatch » (A01) | `tests/menu_entretien/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié ; le `Laurux.conf` de test est
  isolé (`HOME` dédié, cf. contraintes du harnais Docker).
- **Données** : `Laurux01.sql` n'a aucun vendeur. Jeu dérivé `vendeurs` : deux lignes
  `Fiches_Vendeurs` (`code` = `1` et `12`), mots de passe chiffrés avec
  `hexdblKey.crypt("en", "secret", "Laurux")` (valeur à produire dans le clone non modifié).
- T05 et T06 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
- Le déchiffrement `hexdblKey` relève des tests du module `hexdblKey` (lot Utils).
