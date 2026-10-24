# Prefs — Synthèse

> Source : `.src/Communs/Prefs.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre des préférences (11 onglets). Elle lit et écrit 163 clés de `Settings` : le fichier local
`Laurux.conf` (`Start.LocalSettings`) ou, en mode global expérimental, un fichier temporaire
stocké dans le blob `Fiches_Parametres.conf`. Elle porte la mécanique de **surcharge globale**
(`ReadGlobal` + `ApplyGlobal`) appelée par Fmenu au démarrage.

## Points clés

- Surcharge : le blob `conf` est écrit dans `Temp$("global_Laurux.conf")`, puis chaque clé globale
  est recopiée dans le local (le global gagne toujours) et le local est sauvegardé. Cela se produit
  au démarrage, à l'ouverture et à la fermeture de la fenêtre locale, et après l'édition du global.
- Clés : 105 locales seulement, 55 locales et globales, 2 globales seulement (`AdminG`,
  `MdpPrefsG`), 1 lue jamais écrite (`Kgl`). Tableau exhaustif (contrôle, défaut, lecteurs) en fin
  d'architecture.md : c'est la référence des fichiers `Laurux.conf` de test.
- Chaque fermeture enregistre (pas d'annulation) et met à jour les menus de Fmenu.
- `Form_Open` : CC 186, 303 lignes de `Try contrôle = cursettings[…]`.
- Mots de passe chiffrés par `hexdblKey.crypt(…, "Laurux")`.
- Cocher les options pp/bois modifie immédiatement le **schéma** de la base (`modfichier`).

## Dépendances principales

- Appelant unique : `Fmenu` (Menu110 local, Menu329 global, démarrage) ; dépendance circulaire via
  `Fmenu.Menu*showhide`.
- Utilise : `Utils.db`, `Cbase`, `hexdblKey`, `modfichier`, `Doc`, tables `Fiches_Parametres`,
  `Fiches_Tvaav`, `Fiches_Txtmo`, `Fiches_Echeances`, `Fiches_Typec`.
- Dépendance par configuration : 122 fichiers lisent les clés écrites ici (`DB_Connection`,
  `Variables`, `Start`, `Facture`, `ObjFac`, `Cdocuments*`, `EnvMail`, `SauvesAuto`, `LGed`…).

## Risques

- **`ServerLogIP` = 127.0.0.1 par défaut, persisté à la première fermeture** : active un
  `NetHandler` dans `DB_Connection` et peut bloquer le démarrage (PREFS-A01, DB_CONNECTION-A06).
- `CodeMO` tronqué d'un caractère à chaque aller-retour quand le code est relu sans « - » (A02).
- Saisies locales de clés globales écrasées sans avertissement (A08) ; suppression du global sans
  retour arrière sur les postes (A11).
- `IpZebra` saisi mais jamais lu par les classes d'étiquettes ; 12 autres clés orphelines (A06).
- Contrôle de mot de passe interne mort (A07), `Kgl` jamais enregistré (A03), `Svs3_Click` (A04),
  libellé Zebra erroné (A05), clé SMS passée à un `Shell` (A09).
- Répartition des arguments de `New Prefs(Start.GlobalSettings, Null, True)` à confirmer.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1121 |
| Lignes de commentaire | 76 |
| Fonctions | 68 |
| Fonctions Public | 67 |
| Complexité cyclomatique totale | 374 |
| Complexité max (fonction) | 186 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

17 tests (PREFS-T01 à T17) : 15 `replay` comparant le `Laurux.conf` normalisé et le blob `conf`
(configuration minimale, aller-retour complet des 163 clés, saisies par onglet, mots de passe,
création/surcharge/écrasement/suppression du global, familles, codes MO/TVA, visibilités,
sélecteurs, menus Fmenu, options métiers, intégration log distant) et 2 `gbtest` (fusion globale,
listes SQL après séparation). Les fichiers de configuration générés servent aussi aux tests des
lecteurs de clés.

## Rework

14 étapes sans changement de comportement (PREFS-001 à 014) : documentation, code mort (`gbx3 -V`,
doublons, `Copie_Click`), table de description des clés pour `Form_Open`/`form_close` (CC 186 →
≤ 30), séparation du SQL (listes, écriture du blob), factorisation des sélecteurs et bascules,
réduction de portée de 9 fonctions, fusion globale testable, valeurs de création communes avec
`Fmenu` et `LauruxConf`. 11 anomalies (PREFS-A01 à A11) soumises à validation utilisateur.
