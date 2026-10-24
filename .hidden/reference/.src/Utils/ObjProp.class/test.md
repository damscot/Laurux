# ObjProp — Tests

> Source : `.src/Utils/ObjProp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

La logique d'`ObjProp` est testable en `gbtest` : `AppProp` s'applique à n'importe quel objet
ayant les propriétés visées (une petite classe de test avec `Text`, `Alignment`, `Tag`), et le
fichier de paramètres est redirigé en fixant `HOME` vers un répertoire de test.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| OBJPROP-T01 | gbtest | Constructeur | clé `String`, `ResultField`, `Integer` | `name`, `NomControl`, `TypeClass` ; message d'erreur pour l'entier (capturé) | `tests/constructeur/` | à faire |
| OBJPROP-T02 | gbtest | `AddChamp`/`ModChamp`/`AppProp` | valeurs simples et tableaux (`["Fiches_Art", "art_code"]`) ; modification et ajout | propriétés de l'objet cible | `tests/champs/` | à faire |
| OBJPROP-T03 | gbtest | `frmt` via `AppProp` | `"0.00"`, `"0.000"`, `"0.00%"`, `"dd.mm.yyyy"` sur textes `"1.5"`, `"3,14159"`, `"01/02/2024"`, `"abc"` | textes formatés ; `"#Error"` | `tests/formats/` | à faire |
| OBJPROP-T04 | gbtest | `Param` lecture | fichier `Laurux-AutoParams-01.conf` de référence ; `New ObjProp(Null, "Fen/Ctrl", ObjProp.Param)` | `Choirech`, `historique` | `tests/param_lecture/` | à faire |
| OBJPROP-T05 | gbtest | `EcriParam` historique | 12 saisies dont doublons, saisie vide | contenu du fichier `.conf` et de `historique` (10 éléments) | `tests/param_historique/` | à faire |
| OBJPROP-T06 | gbtest | Propriété `filter` | `filter = <TextReg>` (avec GUI) | `Text`, `Tag`, `Alignment`, `Tooltip` de la `TextReg` | `tests/filter/` | à faire |
| OBJPROP-T07 | replay | Écrans génériques | `TriArticles` (tri, filtres), `Achat` (lignes `SaiTableau`) | dump des colonnes et contrôles créés | `tests/ecrans_generiques/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées dans le clone Laurux non modifié ; `Start.Societe = "01"`.
- **Données** : T04 fournit un `.conf` réel (copie anonymisée d'un poste) ; T05 part d'un fichier
  absent.
- **GUI** : T06 instancie une `TextReg` (nécessite `gb.gui`, `xvfb-run` à confirmer).
- **Cas non testable** : `Message.Error` du constructeur s'affiche en boîte modale ; T01 ne le
  couvre qu'avec un harnais qui intercepte les messages, sinon le cas est exclu et documenté.
