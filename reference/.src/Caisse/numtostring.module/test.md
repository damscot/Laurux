# numtostring — Tests

> Source : `.src/Caisse/numtostring.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Préfixe des identifiants : `NUMTOSTRING_CAISSE` (le nom `NUMTOSTRING` appartient à
`Utils/Numtostring.module`).

Le module n'est pas chargé par le projet (collision de noms, NUMTOSTRING_CAISSE-A01) : un test
gb.test qui appelle `numtostring.nbtostring` dans Laurux atteint le module `Utils`. La
caractérisation de `nbtostring` se fait donc dans un **projet Gambas minimal** qui ne contient que
ce module (copie à l'identique, nom inchangé), lancé avec la locale `fr_FR.UTF-8` ; les valeurs
attendues sont produites à partir du fichier du clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| NUMTOSTRING_CAISSE-T01 | gbtest | Collision de compilation | `gbc3 -agt` puis `strings .gambas/NUMTOSTRING` dans le clone | le binaire contient `Num2Text`, pas `nbtostring` (constat figé ; échoue dès que A01 est corrigée) | `tests/collision_compilation/` | à faire |
| NUMTOSTRING_CAISSE-T02 | gbtest | `nbtostring` 1 et 2 chiffres (projet minimal) | 0 à 99, `"00"`, `"01"`, `"05"` | chaînes de référence (« vingt un », « soixante onze », `""` pour `"0"`/`"01"`) | `tests/nombres_0_99/` | à faire |
| NUMTOSTRING_CAISSE-T03 | gbtest | Centaines et milliers (projet minimal) | 100, 101, 180, 200, 999, 1000, 1001, 2000, 12345, 80000, 200000, 999999 | chaînes de référence (« deux cents mille » figé) | `tests/centaines_milliers/` | à faire |
| NUMTOSTRING_CAISSE-T04 | gbtest | Bornes et entrées invalides (projet minimal) | 7 à 10 chiffres, `""`, `"12,5"`, `"abc"` | `""` ou erreur de conversion figée | `tests/bornes/` | à faire |
| NUMTOSTRING_CAISSE-T05 | gbtest | Dépendance à la locale (projet minimal) | T03 rejoué en locale `C` | sorties figées (différentes de T03, à confirmer) | `tests/locale_c/` | à faire |
| NUMTOSTRING_CAISSE-T06 | replay | Impression de chèque en caisse | caisse `-p`, règlement par chèque de 123,45, « Oui » à l'impression du chèque (imprimante simulée) | erreur « Unknown symbol » figée (scénario partagé avec les tests de `Caisse`) | `tests/impression_cheque_caisse/` | à faire |

## Détail des tests

- **Projet minimal** : `tests/_projet_minimal/` (`.project` avec ce seul module et un module de
  test) ; aucun fichier source de Laurux n'est modifié en phase 2.
- **T06** : l'imprimante de caisse (`#Sport`) doit être redirigée vers un fichier ; si le rejeu
  ne permet pas de répondre à la question, le cas est documenté comme test manuel.
- **Couverture visée** : 100 % de `nbtostring`, `Calc_unite`, `Calc_Dizaine` dans le projet
  minimal ; 0 % dans Laurux tant que A01 n'est pas tranchée (le code n'y est pas exécutable).
