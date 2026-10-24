# Prgm — Tests

> Source : `.src/Communs/Prgm.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de lancement : chaque scénario part de `Fmenu` (« Gestion > Outils > Appel programme »),
saisit un nom dans `Prg` et valide. Le résultat comparé est la fenêtre ouverte (log) et, pour les
scripts qui écrivent, le dump normalisé de la base. Les scripts destructeurs ont leurs propres
tests de caractérisation (RECUPN, EPURFOUR, PAPMP, HISTOCOM, RENUMBL…) : ici on vérifie seulement
que le **bon** script est déclenché.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PRGM-T01 | replay | Mot de passe administrateur | `/Admin = 1`, `MdpPrefs` chiffré connu ; mauvais mot de passe puis bon (Entrée, puis Tab) | `Message.Error` puis panneau `HBox1` masqué | `tests/mot_de_passe/` | à faire |
| PRGM-T02 | replay | Dispatch vers les écrans | les 22 noms de type « écran » du tableau d'architecture.md (`Impclient`, `Calcsolde`, `CalcRem`, `Expcontact`, `Impcpostaux`, `Pmp`, `Dcfour`, `Tbord`, `eff`, `eft`, `efb`, `Impdep`, `Edsdep`, `Raz`, `RazEcr`, `RazClos`, `Blocsoc`, `ImptartypeC`, `CompArt`, `ImportStk`, `Equilibrage`, `Deblockbl`) | classe de la fenêtre ouverte ; dump base inchangé | `tests/dispatch_ecrans/` | à faire |
| PRGM-T03 | replay | `RazDocactif` | `Laurux01.sql` + jeu dérivé avec 3 verrous dans `Fiches_Docactif` | `Fiches_Docactif` vide ; `Message.Info` | `tests/raz_docactif/` | à faire |
| PRGM-T04 | replay | `CalcSha1` avec et sans suffixe | `CalcSha1`, `CalcSha1 1`, `CalcSha1 9` (table inexistante) | colonne `control` de `Fiches_Mvt`/`Fiches_Mvt1` dans le dump ; message d'erreur SQL pour `9` (A04 figée) | `tests/calcsha1/` | à faire |
| PRGM-T05 | replay | `MajEqu` | jeu dérivé `Fiches_Cequ` avec une chaîne d'équivalences A→B→C | dump `Fiches_Cequ` ; `Message.Warning` | `tests/majequ/` | à faire |
| PRGM-T06 | replay | Scripts destructeurs (déclenchement) | `RecupN`, `Epurfour`, `Papmp` (Oui), `HistoCom`, `RenumBl`, `RenMvt`, `Renech` (avec `~/Dtech.txt`), `RecupDech`, `RenAN`, `Exprub` (Oui) | dump identique à celui du test propre de chaque script ; message de fin ; erreur SQL pour `RenAN` (A06 figée) | `tests/scripts/` | à faire |
| PRGM-T07 | replay | Nom inconnu, casse différente, champ vide | `inconnu`, `raz`, `""` | fermeture sans effet ; comportement du champ vide figé (A05) | `tests/nom_inconnu/` | à faire |
| PRGM-T08 | replay | `Fsoc` | `Fsoc` | erreur d'exécution figée (A03) ou ouverture, selon la capture | `tests/fsoc/` | à faire |
| PRGM-T09 | gbtest | Découpage de la commande (après PRGM-004) | `"CalcSha1 1"`, `"Raz"`, `""`, `"a  b"` | tableau nom + arguments | `tests/decoupage/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié, base restaurée depuis
  `Laurux01.sql` ou un jeu dérivé ; `HOME` de test isolé (scripts écrivant dans `~`, `~/tmp`).
- **Ordre** : un script par exécution (base restaurée entre chaque) pour que les dumps soient
  indépendants.
- **Non testable automatiquement** : la frappe dans `Prg` quand `HBox1` le recouvre (A01) se vérifie
  à la main ; le son d'erreur.
