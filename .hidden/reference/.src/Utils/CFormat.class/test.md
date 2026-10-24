# CFormat — Tests

> Source : `.src/Utils/CFormat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de calcul pur : tous les tests sont `gbtest` (avec `gb.gui` chargé pour `Font` et `Align`,
sans affichage ; à confirmer en environnement Docker sans serveur X, sinon `xvfb-run`). Les valeurs
attendues sont produites par les mêmes appels dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CFORMAT-T01 | gbtest | `_Get` couleurs | `"Background: &HDDDDDD&; "`, `"Background: 16772737"`, `"Foreground: &H0000FF&"` | `Background`/`Foreground` entiers | `tests/get_couleurs/` | à faire |
| CFORMAT-T02 | gbtest | `_Get` alignement et police | `"Alignment: Left"`, `"alignment: right"`, `"Font: Serif,9"`, `"Alignment: Inconnu"` | valeur `Align.*` ou -1 ; `Font.ToString()` | `tests/get_align_font/` | à faire |
| CFORMAT-T03 | gbtest | `_Get` dimensions et format | formats de `Remisec` (`"Width: 80; Format: 0.000; Alignment: left"`) | `Width` = 80 ; `Format` figé (anomalie A01) | `tests/get_format/` | à faire |
| CFORMAT-T04 | gbtest | `_Get` erreurs | `""`, `Null`, `"Toto: 3"`, `"Background"` (sans `": "`), `";;"` | objet renvoyé et sortie standard capturée | `tests/get_erreurs/` | à faire |
| CFORMAT-T05 | gbtest | `ToString` | objets construits par propriétés (toutes combinaisons définies / -1), alignement hors constantes | chaîne de référence | `tests/tostring/` | à faire |
| CFORMAT-T06 | gbtest | Aller-retour | les chaînes réelles de `Laurux.conf` (`/Coul/*`, `/Soc01/caisse/*`) | `CFormat[s].ToString()` de référence | `tests/aller_retour/` | à faire |
| CFORMAT-T07 | gbtest | `Copy` | avant suppression (CFORMAT-002) | figer le résultat (format perdu) | `tests/copy/` | à faire |

## Détail des tests

- **Données** : T06 lit un `Laurux.conf` de référence (fichier fourni dans `tests/aller_retour/`),
  généré par les valeurs par défaut de `Start.module` puis par quelques modifications dans
  `SetColors`.
- **Sortie standard** : T04 capture les lignes `Error: Bad Format String: …` pour figer le message.
- **Couverture visée** : 100 % des lignes ; T07 est retiré avec la suppression de `Copy`.
