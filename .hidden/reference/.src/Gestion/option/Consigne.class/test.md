# Consigne — Tests

> Source : `.src/Gestion/option/Consigne.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de calcul avec accès SQL, sans GUI : tests `gbtest` sur une base MariaDB jetable, plus un
replay d'intégration de la réception. Les valeurs attendues sont produites dans le clone **Laurux
non modifié** (tests de caractérisation).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CONSIGNE-T01 | gbtest | `consigne_montant` | code existant (prix 1,50) × 0, 1, 12 ; code absent ; code `""` | `LTaxe` type `Consigne`, `Mnt` 0 / 1,50 / 18 / 0 / 0 | `tests/consigne_montant/` | à faire |
| CONSIGNE-T02 | gbtest | `consigne_montant` quantité non entière | `qte` passé en Float 2,5 (comme `Achat.EnrConsigne`) | figer la valeur actuelle (conversion Integer) | `tests/consigne_qte_float/` | à faire |
| CONSIGNE-T03 | gbtest | `recuppalette` / `recupcol` | `nlge` = `3` (Integer) et `"003"` (String) ; ligne absente ; bloc absent | nombre lu, `nbpal`/`nbcol` affectés, 0 si absent | `tests/recup_palette_colis/` | à faire |
| CONSIGNE-T04 | gbtest | Propriété `consigne` | `New Consigne(10, 24)` puis `cdepal`/`nbpal`, `cdecol`/`nbcol`, `cdeunit` (3 combinaisons, codes vides) | `consigne.TotNHT.G` de référence | `tests/consigne_total/` | à faire |
| CONSIGNE-T05 | gbtest | Constructeur à 13 arguments | arguments d'`Achat.class:214` (prix, qte, `Arr_0001`, `""`, régie, volume, degré, `""`, 3 codes + 2 nombres) | `Mnt`, `Qte`, `code`, `volume`, `degre`, `cdepal`, `nbpal`… | `tests/constructeur_achat/` | à faire |
| CONSIGNE-T06 | replay | Réception d'articles consignés (option B ou T) | `Achat` : réception de 2 articles boissons avec palettes/colis ; enregistrement ; validation `ValidBR1` avec comptabilisation | dump `Fiches_ligcons`, `Fiches_ligregie`, `Fiches_Mvt*` (ligne `consfou`) | `tests/reception_consignes/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` ne contient ni les tables `Fiches_consigne`/`Fiches_ligcons` ni les
  colonnes `art_cons*` : jeu dérivé `option_boisson` = `Laurux01.sql` + exécution de
  `modfichier.fichierboisson` (activation de l'option dans `Prefs`, ou SQL équivalent extrait du
  module) + 3 consignes (`P`, `C`, `B`), 1 régie, 2 articles boissons, paramètre `consfou`.
  `Laurux.conf` du test : `/Soc01/bois = True` (option `B`) puis `/Soc01/pp = True` (option `T`)
  pour figer CALCULDROIT1-A01.
- **gbtest** : `New Consigne(…)` n'a pas besoin d'affichage ; seul `calculdroit1.LecDra` peut lever
  une erreur (régie absente) : les cas sans régie passent `dra = ""`.
- **Comparaison** : T01-T05 comparent `Mnt` avec une tolérance de 1e-9 ; T06 compare le dump
  normalisé (les identifiants `Fiches_ligcons.code` auto-incrémentés sont exclus du diff).
- **Non testable isolément** : l'alimentation de `AutresObj` par `Achat` (couverte par T06).
