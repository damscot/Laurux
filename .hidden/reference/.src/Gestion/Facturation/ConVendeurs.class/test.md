# ConVendeurs — Tests

> Source : `.src/Gestion/Facturation/ConVendeurs.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` depuis le menu Gestion › Facturation › Saisie des documents, avec
`/Soc01/Vendeurs` = 1 et `/Soc01/CodeVendeur` vide dans le `Laurux.conf` du test. Comparaisons :
`Laurux.conf` (clé `CodeVendeur`), journal de rejeu (messages), dump de la base (inchangé).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CONVENDEURS-T01 | replay | Connexion réussie | vendeur `1`, bon mot de passe, `Connecter` | `CodeVendeur = "1 <nom>"`, saisie de documents ouverte | `tests/connexion_ok/` | implémenté (`Gestion/convendeurs_connexion_ok`) |
| CONVENDEURS-T02 | replay | Mot de passe erroné / vide / vendeur vide | trois tentatives | trois messages d'erreur, `CodeVendeur` inchangé | `tests/connexion_refusee/` | implémenté (`Gestion/convendeurs_connexion_refusee`) |
| CONVENDEURS-T03 | replay | Code vendeur sur 2 caractères | vendeur `12`, son mot de passe | figer le comportement actuel (recherche sur `1`, A02) | `tests/code_deux_car/` | implémenté (`Gestion/convendeurs_code_deux_car`) |
| CONVENDEURS-T04 | replay | Déconnexion | `Déconnecter` depuis Menu42 puis depuis F5 de `Facture` | `CodeVendeur` vidé ; fenêtre visible ou non selon le chemin (A03 figée) | `tests/deconnexion/` | implémenté pour Menu42 (`Gestion/convendeurs_deconnexion`) ; à faire : chemin F5 de `Facture` (touche F5 non rejouable, écran complexe) |
| CONVENDEURS-T05 | replay | Changement de vendeur en saisie (F5) | `Facture`, F5, connexion | figer l'ouverture d'une seconde saisie (A04) | `tests/changement_f5/` | à faire : touche F5 non rejouable, passe par `Facture` (écran complexe) |
| CONVENDEURS-T06 | replay | Menu « Saisie des factures entretien » | `/Materiel` = 1, vendeurs actifs, pas de vendeur connecté | figer l'erreur « Type mismatch » (A01) | `tests/menu_entretien/` | implémenté (`Gestion/convendeurs_menu_entretien`, code 125) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié ; le `Laurux.conf` de test est
  isolé (`HOME` dédié, cf. contraintes du harnais Docker).
- **Données** : `Laurux01.sql` n'a aucun vendeur. Jeu dérivé `vendeurs` : deux lignes
  `Fiches_Vendeurs` (`code` = `1` et `12`), mots de passe chiffrés avec
  `hexdblKey.crypt("en", "secret", "Laurux")` (valeur à produire dans le clone non modifié).
- T05 et T06 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
- Le déchiffrement `hexdblKey` relève des tests du module `hexdblKey` (lot Utils).

- **Assets** (`.hidden/Tests/Gestion/assets/`) : jeu `convendeurs_shared/vendeurs.sql` (vendeur `1` DUPONT mdp
  « secret » = `32091B0D1D01`, vendeur `12` MARTIN mdp « martin » = `2C0D0A0B111B`) ; `/Soc01/Vendeurs` = 1 par la
  clé `conf` du meta.json ; `Laurux.conf` comparé (`@Laurux.conf`). `CodeVendeur` n'est écrit sur disque qu'à la
  fermeture de `Fmenu` (`LocalSettings.Save` dans `Fmenu.Form_Close`) : chaque scénario se termine par
  `Close=0@Fmenu#Fmenu#`.
- T01/T03 ouvrent `Facture` puis la ferment sans saisie. T02 fige aussi le message d'erreur levé par le choix de
  l'entrée vide de la liste (`Caissiere_Click` sans test `Available`, rattrapé par `Catch`).
