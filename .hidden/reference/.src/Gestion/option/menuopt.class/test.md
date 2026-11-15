# menuopt — Tests

> Source : `.src/Gestion/option/menuopt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MENUOPT-T01 | replay | Menus selon les options | `/Soc01/bois` et `/Soc01/pp` à 0/1 (4 combinaisons) | entrées présentes, `Menu306` masqué si une option (log des menus) | `tests/menus_options/` | à faire : présence des entrées de menu non comparée (log des menus) ; chemin des menus dynamiques validé par les scénarios Tregie/Tregion |
| MENUOPT-T02 | replay | Ouverture des écrans | chaque entrée de menu | écran ouvert (titre dans le log), aucune écriture | `tests/ouverture_ecrans/` | implémenté (Régie, Tipp régionale, Consignes ; autres entrées non couvertes, voir meta.json) |
| MENUOPT-T03 | replay | Édition de la TIPP | mois 13 puis 03, année courante, OK | refus du mois invalide ; PDF `~/tmp/tipce.pdf` (texte) | `tests/edition_tipp/` | à faire : boîte construite dynamiquement et ouverte en ShowModal par edtipp_click (TextReg « mois » validé au LostFocus) et édition gb.report non rejouées ; en gb.test, edtipp_click bloque (ShowModal), mois_lostfocus lit `Last` (contexte d'événement) et btn_Click ferme `$win` (Null sans la boîte) : pas d'équivalent sans la boîte (vague 7). L'édition elle-même est couverte par EdittippTest (classe Edittipp) |

## Détail des tests

- **Implémentation (phase 2)** : scénario `Gestion/assets/menuopt_ouvertures` ; les menus dynamiques se rejouent par leur nom d'événement (`Fmenu#Menu66#Menu69#Tregie#`, `#tipp#`, `#Tconsigne#`).

- **Données** : base avec le schéma carburant/boisson (`modfichier`), quelques lignes
  `Fiches_region` et BL avec `tipp_ligbl` pour T03.
- **Rejeu** : les menus appartiennent à `Fmenu` ; la fenêtre de `edtipp_click` est construite par
  code sans `Utils.Observers` : à vérifier en phase 2 (sinon scénario manuel).
- **gbtest** : sans objet (aucune logique hors GUI).
