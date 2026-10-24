# textfamille — Tests

> Source : `.src/Utils/textfamille.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Contrôle graphique : tests **gbtest sous affichage virtuel** (Xvfb, à confirmer) avec un
`Laurux.conf` de test fixant `ipr`, et un replay via un écran utilisateur.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TEXTFAMILLE-T01 | gbtest | Construction | `ipr = [1, 3, 5]` | 3 zones, `MaxLength` 1/2/2 | `tests/construction/` | à faire |
| TEXTFAMILLE-T02 | gbtest | `text` écriture/lecture | `"A0102"`, `"A01"`, `"A"`, `""`, `"A0102XYZ"` | zones et relecture de référence | `tests/text/` | à faire |
| TEXTFAMILLE-T03 | gbtest | Niveau vide intermédiaire | zone 1 vide, zone 2 `"01"` | figer le résultat de `Trim$` | `tests/niveau_vide/` | à faire |
| TEXTFAMILLE-T04 | gbtest | `Clear` | zones remplies | `text = ""` | `tests/clear/` | à faire |
| TEXTFAMILLE-T05 | replay | Saisie dans Articles | fiche article : saisie famille niveau par niveau (Tab), validation | `art_fam` enregistré (dump `Fiches_Art`) | `tests/replay_articles/` | à faire |
| TEXTFAMILLE-T06 | replay | `ipr` absent | ouverture de la fiche article sans `ipr` | figer `Message.Error` + arrêt | `tests/ipr_absent/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié**.
- **Données** : aucune base pour T01-T04 ; `Laurux01.sql` pour T05-T06.
- **Non testable en gb.test** : `Quit` (T06 en replay), couleurs de focus.
