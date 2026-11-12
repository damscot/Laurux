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
| PRGM-T01 | replay | Mot de passe administrateur | `/Admin = 1`, `MdpPrefs` chiffré connu ; mauvais mot de passe puis bon (Entrée, puis Tab) | `Message.Error` puis panneau `HBox1` masqué | `tests/mot_de_passe/` | implémenté |
| PRGM-T02 | replay | Dispatch vers les écrans | les 22 noms de type « écran » du tableau d'architecture.md (`Impclient`, `Calcsolde`, `CalcRem`, `Expcontact`, `Impcpostaux`, `Pmp`, `Dcfour`, `Tbord`, `eff`, `eft`, `efb`, `Impdep`, `Edsdep`, `Raz`, `RazEcr`, `RazClos`, `Blocsoc`, `ImptartypeC`, `CompArt`, `ImportStk`, `Equilibrage`, `Deblockbl`) | classe de la fenêtre ouverte ; dump base inchangé | `tests/dispatch_ecrans/` | implémenté |
| PRGM-T03 | replay | `RazDocactif` | `Laurux01.sql` + jeu dérivé avec 3 verrous dans `Fiches_Docactif` | `Fiches_Docactif` vide ; `Message.Info` | `tests/raz_docactif/` | implémenté |
| PRGM-T04 | replay | `CalcSha1` avec et sans suffixe | `CalcSha1`, `CalcSha1 1`, `CalcSha1 9` (table inexistante) | colonne `control` de `Fiches_Mvt`/`Fiches_Mvt1` dans le dump ; message d'erreur SQL pour `9` (A04 figée) | `tests/calcsha1/` | implémenté |
| PRGM-T05 | replay | `MajEqu` | jeu dérivé `Fiches_Cequ` avec une chaîne d'équivalences A→B→C | dump `Fiches_Cequ` ; `Message.Warning` | `tests/majequ/` | implémenté |
| PRGM-T06 | replay | Scripts destructeurs (déclenchement) | `RecupN`, `Epurfour`, `Papmp` (Oui), `HistoCom`, `RenumBl`, `RenMvt`, `Renech` (avec `~/Dtech.txt`), `RecupDech`, `RenAN`, `Exprub` (Oui) | dump identique à celui du test propre de chaque script ; message de fin ; erreur SQL pour `RenAN` (A06 figée) | `tests/scripts/` | implémenté (partiel : Renech à faire, il lit ~/Dtech.txt que le HOME de test vide ne contient pas ; RecupN, Epurfour, Papmp couverts par les scénarios Utils recupn_*, epurfour_effacement, papmp_*) |
| PRGM-T07 | replay | Nom inconnu, casse différente, champ vide | `inconnu`, `raz`, `""` | fermeture sans effet ; comportement du champ vide figé (A05) | `tests/nom_inconnu/` | implémenté |
| PRGM-T08 | replay | `Fsoc` | `Fsoc` | erreur d'exécution figée (A03) ou ouverture, selon la capture | `tests/fsoc/` | implémenté |
| PRGM-T09 | gbtest | Découpage de la commande (après PRGM-004) | `"CalcSha1 1"`, `"Raz"`, `""`, `"a  b"` | tableau nom + arguments | `tests/decoupage/` | à faire : exige l'extraction PRGM-004 (phase 3) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié, base restaurée depuis
  `Laurux01.sql` ou un jeu dérivé ; `HOME` de test isolé (scripts écrivant dans `~`, `~/tmp`).
- **Ordre** : un script par exécution (base restaurée entre chaque) pour que les dumps soient
  indépendants.
- **Non testable automatiquement** : la frappe dans `Prg` quand `HBox1` le recouvre (A01) se vérifie
  à la main ; le son d'erreur.

## Implémentation (phase 2)

Scénarios sous `.hidden/Tests/Communs/assets/` (Appel programme : `Fmenu#Menu66#Menu144#Menu282`) :

- T01 `prgm_mot_de_passe` : `/Admin` et `MdpPrefs` posés par les Préférences locales (Menu110, case `Admin`,
  `Mdp2`) dans le même rejeu ; mauvais mot de passe (FMessage), bon mot de passe + Tab, puis « CalcSha1 ». Le
  masquage de `HBox1` n'est pas observé directement : les FMessage attendus/absents font échouer le rejeu sinon.
- T02 `prgm_dispatch_ecrans_1` à `_8` : 22 écrans, 3 par scénario (délai de 20 s), fermés par `Close` ; le rejeu
  échoue si la fenêtre attendue n'est pas active. Aucune écriture en base.
- T03 `prgm_raz_docactif` (jeu `docactif_trois`) ; T04 `prgm_calcsha1` (jeu `sha1calc_ecritures` réutilisé :
  « CalcSha1 » puis « CalcSha1 3 », Mvt3 au lieu de Mvt1) et `prgm_calcsha1_table_absente` (« CalcSha1 9 ») ;
  T05 `prgm_majequ` (jeu `prgm_majequ`) ; T06 `prgm_scripts_histocom`, `_renumbl`, `_renmvt` (jeu
  `prgm_renmvt`), `_recupdech`, `_renan`, `_exprub` ; T07 `prgm_nom_inconnu` ; T08 `prgm_fsoc`.
- Erreurs fatales figées (`code_sortie` 125) : RazDocactif et HistoCom (`Me.Close` puis second `Me.Close`
  l. 114 sur l'auto-instance détruite : « Invalid object », candidat anomalie), CalcSha1 9 et RenAN (table
  absente), champ vide (`Arga[0]` « Out of bounds », A05), Fsoc (« Not enough arguments », A03).
- RenMvt : le DELETE vise `numero = '005'` pour l'écriture 1005 (Mid$ sans le 1er chiffre) : les lignes
  d'origine restent dans `Fiches_Mvt` (figé, candidat anomalie).
- Fichiers produits dans le HOME (`~/tmp/Dtech.txt`, `~/Bcr.txt`, `~/Bcrcpt.txt`) : non comparés.
