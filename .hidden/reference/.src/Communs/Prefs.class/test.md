# Prefs — Tests

> Source : `.src/Communs/Prefs.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de préférences : l'essentiel des tests est en `replay`. Le résultat comparé est
**le fichier `Laurux.conf` normalisé** (sections et clés triées, mots de passe chiffrés comparés
tels quels) et, pour le mode global, la colonne `Fiches_Parametres.conf` (même normalisation après
extraction). Les fichiers d'entrée sont générés à partir du tableau des clés
d'[architecture.md](architecture.md) ; ils servent aussi d'entrée aux tests des 122 fichiers
lecteurs. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PREFS-T01 | replay | Ouverture/fermeture sur configuration minimale | `Laurux.conf` réduit à `[dbase]` + `/Soc` ; menu Préférences (Menu110) ; **Quitter** | `Laurux.conf` normalisé : 160 clés écrites avec leurs défauts, dont `ServerLogIP=127.0.0.1`, `ServerLogPort=6556`, `ipr=[5]` | `tests/ouverture_minimale/` | à faire |
| PREFS-T02 | replay | Aller-retour complet sans modification | `Laurux.conf` complet (les 163 clés renseignées, `gen_input.py`) ; ouvrir, quitter | fichier identique à l'entrée, sauf effets figés : `CodeMO` tronqué (A02), `Kgl` inchangé (A03), doublons sans effet | `tests/aller_retour/` | à faire |
| PREFS-T03 | replay | Saisie onglet par onglet | conf de T02 ; modification d'un contrôle de chaque type (CheckBox, TextBox, ComboBox, RadioButton, ValueBox, FontChooser) par onglet | clés modifiées attendues, autres clés inchangées | `tests/saisie_onglets/` | à faire |
| PREFS-T04 | replay | Mots de passe chiffrés | `Admin` coché, `Mdp2`, `MdpStmp`, `MdpFTP`, `MdpFTP3` saisis | valeurs chiffrées `hexdblKey` identiques à la référence ; relecture déchiffrée à l'ouverture suivante | `tests/mots_de_passe/` | à faire |
| PREFS-T05 | replay | Création du global (Menu329, aucun `conf`) | `Laurux01.sql` (`conf` NULL) ; Menu329 → **Continuer** ; cocher `AdminG`, modifier 3 clés G+L ; quitter | dump `Fiches_Parametres.conf` normalisé (clés G+L et G uniquement) ; `Laurux.conf` local surchargé | `tests/global_creation/` | à faire |
| PREFS-T06 | replay | Surcharge au démarrage | `conf` contenant 5 clés différentes du local + 1 clé absente du local ; lancement | `Laurux.conf` local après démarrage : les 6 clés prennent la valeur globale | `tests/global_surcharge/` | à faire |
| PREFS-T07 | replay | Saisie locale d'une clé globale | global de T06 ; Prefs locale, modifier une clé G+L couverte par le global ; quitter | la valeur globale est rétablie (comportement actuel, A08) | `tests/global_ecrase_local/` | à faire |
| PREFS-T08 | replay | Suppression du global | global de T06 ; Menu329 → **Supprimer** → **OK** | `conf` NULL ; `Laurux.conf` local inchangé ; fichier temporaire supprimé | `tests/global_suppression/` | à faire |
| PREFS-T09 | replay | Familles d'articles | `nbfam` = 8, `ipr` = [2,5,8] ; puis `Textfam` = 3 ; puis valeur 25 (refusée) | cases cochées et `ipr` écrit ; cas `ipr` contenant 0 (figer l'erreur actuelle) | `tests/familles/` | à faire |
| PREFS-T10 | replay | `CodeMO` et `Codetva` | `MO` coché ; choix « 12 - 35,00 » ; fermer, rouvrir, fermer | `CodeMO` = « 12 » puis « 1 » (troncature A02 figée) ; `Codetva` = 1ᵉʳ caractère | `tests/codes_mo_tva/` | à faire |
| PREFS-T11 | replay | Visibilités conditionnelles | bascule de `Tva550`, `MO`, `Exp`/`Imp`, `Libdevis`, `TxtF`, `Sms`, `Sauvauto`/`Envoiftp`, `CheckBox2`, `Impetiq` = « 2- Zebra » à l'ouverture | état `Visible` des contrôles relevé par le replay (dont `Label27` affiché à tort, A05) | `tests/visibilites/` | à faire |
| PREFS-T12 | replay | Sélecteurs de répertoire | chaque bouton `Bchemin*`, `Svs*`, `Phot` : choix puis annulation | texte du champ (annulation → `User.Home` ; `Svs3` → `Chmexport`, A04) | `tests/selecteurs/` | à faire |
| PREFS-T13 | replay | Menus de Fmenu après fermeture | `Exp`, `Btq`, `Materiel`, `Caisse` cochés puis décochés | visibilité des menus de Fmenu (appels `Menu*showhide`) | `tests/menus_fmenu/` | à faire |
| PREFS-T14 | replay | Options métiers pp/bois | base `Laurux01.sql` ; cocher `pp` puis `bois` | dump de **structure** (colonnes ajoutées par `modfichier`) et `Laurux.conf` | `tests/options_metier/` | à faire |
| PREFS-T15 | replay | Log distant par défaut (intégration) | conf de T01 après fermeture ; relance avec journal SQL actif | création du `NetHandler` vers 127.0.0.1:6556 (voir DB_CONNECTION-T02), figé tel quel (A01) | `tests/serverlog_defaut/` | à faire |
| PREFS-T16 | gbtest | `ApplyGlobal` / `ReadGlobal` | deux `Settings` construits dans le test ; `conf` vide, NULL, et rempli dans la base de test | clés recopiées, sauvegarde effectuée, `Null` si `conf` vide (nécessite d'instancier la fenêtre sans l'afficher : à confirmer sous gb.test, sinon après PREFS-006) | `tests/fusion_globale/` | à faire |
| PREFS-T17 | gbtest | Listes SQL (après PREFS-006) | `Laurux01.sql` | contenus de `ListeEcheances`, `ListeTypesClient`, `ListeCodesTva`, `ListeTauxMo` | `tests/listes/` | à faire |

## Détail des tests

- **Génération des entrées** : `gen_input.py` lit le tableau des clés d'`architecture.md` (colonne
  clé, type de contrôle, défaut) et produit les `Laurux.conf` de T01/T02/T03 et le blob `conf` de
  T06 (valeurs typées : booléens, chemins, textes accentués, tableaux `ipr`).
- **Normalisation** (`check_output.py`) : tri des sections et des clés, suppression des lignes
  volatiles (`/dbase/Password` chiffré par session si applicable, chemins `Temp$`), comparaison
  exacte du reste. Pour le blob, extraction via `SELECT conf` puis même normalisation.
- **Données** : `Laurux01.sql` dans MariaDB Docker ; le global de T06 est injecté par
  `UPDATE Fiches_Parametres SET conf = …` avant lancement.
- **Non testable automatiquement** : rendu des logos (`dwgImage*`), dialogues de fichiers (le
  replay injecte le chemin, à confirmer avec le harnais), synthèse vocale (`Button1_Click`,
  dépend de `pico2wave`), contrôle de clé SMS (`api_LostFocus`, appel HTTP externe : à simuler par
  un `curl` factice dans le `PATH` du test), aide HTML (`Button3_Click`).
- **Mots de passe** : les valeurs chiffrées dépendent seulement de la clé « Laurux » : comparaison
  exacte possible.
- **Couverture visée** : tous les chemins de `Form_Open`/`form_close` dans les deux modes ;
  `Mdp_KeyPress`/`Mdp_LF` sont inatteignables (A07) et restent non couverts.
