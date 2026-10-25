# Ouverture — Tests

> Source : `.src/Caisse/Ouverture.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe (ouverture de caisse)** : la liste des scénarios ci-dessous est **à faire
> valider par l'utilisateur avant la phase 2** (PLAN.md §0 et §4.5).

Écran GUI : scénarios `replay` lancés par `./Laurux -p`, menu « Connexion caisse » de `Cmenu`.
`Utils.Observers(Me)` est appelé une seule fois dans `_new` : rejouable. Les sélections se font
dans des `ComboBox` (pas de grille : aucun `replay_missing`). Comparaisons : dump de la base
(`Fiches_Caisses` : `connecte`, `vdr_code` ; `dteov` masquée), `Laurux.conf` (`Ncai`), contenu
de `~/Caisse<n>.lock`, messages du journal.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| OUVERTURE-T01 | replay | Listes à l'ouverture | `caisse_base`, poste = hôte de test | `Caissiere` : `""` + vendeurs ; `Combobox1` : `"  "` + caisses du poste seulement | `tests/listes/` | à faire |
| OUVERTURE-T02 | replay | Choix d'une caisse | caisse `1` (`fndc` 150,00, `dtefm` connue) ; puis ligne vide | fond et date affichés ; ligne vide : figer le message d'erreur (A03) | `tests/choix_caisse/` | à faire |
| OUVERTURE-T03 | replay | Connexion réussie | caisse `1`, vendeur `1`, bon mot de passe, « Connecter » ; `choixtouches` 0 puis 1 | `connecte = 1`, `vdr_code = "1"`, verrou `"<libellé>O"`, `Ncai = "1;1 "`, `Start.$tcai` `0`/`1` | `tests/connexion_ok/` | à faire |
| OUVERTURE-T04 | replay | Refus de connexion | mot de passe vide ; faux ; vendeur vide ; caisse vide | messages attendus (vendeur vide → « Mot de passe erroné », A05 figée) ; base inchangée | `tests/connexion_refusee/` | à faire |
| OUVERTURE-T05 | replay | Caisse déjà connectée | verrou `~/Caisse1.lock` présent | message « déjà connectée », base et `Ncai` inchangés, écran ouvert | `tests/caisse_deja_connectee/` | à faire |
| OUVERTURE-T06 | replay | Vendeur déjà utilisé | verrou `~/Caisse2.lock` contenant le vendeur `1` | message `TestCai`, focus vendeur, base inchangée | `tests/vendeur_occupe/` | à faire |
| OUVERTURE-T07 | replay | Codes sur deux caractères | caisse `10`, vendeur `12` | figer : caisse `1` mise à jour, `TestCai` sur `1` (A01, A02) | `tests/codes_deux_car/` | à faire |
| OUVERTURE-T08 | replay | Touche sur « Connecter » | focus sur le bouton, touche `Tab` | figer : tentative de connexion (A04) | `tests/touche_bouton/` | à faire |
| OUVERTURE-T09 | replay | Clavier virtuel | `/caisse/tactile` = 1 ; « Clavier », saisie, « Fermer » | mot de passe saisi via `Clavier`, connexion comme T03 ; figer : clavier toujours affiché après connexion (A07) | `tests/clavier_virtuel/` | à faire |
| OUVERTURE-T10 | replay | Base SQLite | `Laurux01.sqlite` + `caisse_base`, vendeur `1` | figer le résultat de `code = "1 "` (A02) | `tests/sqlite/` | à faire |
| OUVERTURE-T11 | gbtest | `Rvdr` | caisse avec `vdr_code` connu ; caisse sans vendeur ; caisse absente | nom ; `""` ; `""` | `tests/rvdr/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié**, `HOME` dédié par test
  (verrous et `Laurux.conf`).
- **Données** : jeu dérivé `caisse_base` (voir CMENU) ; T06 et T05 préparent les fichiers verrou
  avant le lancement ; T07 ajoute une caisse `10` et un vendeur `12`.
- **T11** : tant que `Rvdr` est sur la classe `Form`, l'appel depuis gb.test instancie
  l'écran (GUI requise) ; le test devient un pur `gbtest` après OUVERTURE-003 (déplacement dans un
  module). Base MariaDB Docker requise.
- **Non testable automatiquement** : survol des boutons, sons.
- T02, T04, T07, T08 et T10 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
