# TextReg — Tests

> Source : `.src/Utils/TextReg.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`TextReg` est un contrôle : ses comportements se testent soit en `gbtest` avec `gb.gui` (contrôle
créé dans une fenêtre cachée, affectation de propriétés, lecture de `Text`/`Value` ; `xvfb-run` en
Docker, à confirmer), soit en `replay` sur des écrans réels pour la saisie clavier, les fenêtres
de recherche et d'historique. Le fichier `Laurux-AutoParams-01.conf` est redirigé par `HOME`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TEXTREG-T01 | gbtest | `EstNum` : `Text`/`Value`/`nbdec` | `Text = "1.5"`, `"1,5"`, `"abc"`, `""` ; `nbdec` `""`, `"0"`, `"2"`, `"3"` ; `Value = 3.14159` | `Text`, `Value` | `tests/numerique/` | à faire |
| TEXTREG-T02 | gbtest | `EstDate`/`EstDateTime` | `Text = "1/2/24"`, `"01022024"`, `"31/12/2024 23:59"` | `Text` (format `LDate.L`/`.LT`), `dte` | `tests/dates/` | à faire |
| TEXTREG-T03 | gbtest | Changement de `Type` | Text → Num → Date → Text → Date ; `reg` forcé puis changement de type | texte, regex effective ; figer l'erreur `dte = Null` (A03) | `tests/changement_type/` | à faire |
| TEXTREG-T04 | replay | Filtre regex à la frappe | `GesTar` : saisie de lettres dans un champ numérique, `.` décimal ; `Saisecrit` : compte avec lettres | texte affiché après chaque frappe | `tests/regex_frappe/` | à faire |
| TEXTREG-T05 | replay | Perte de focus | `commande1` : quantité `"2,5"` puis Tab ; date `"3/4"` puis Tab | texte normalisé ; contenu de `Laurux-AutoParams-01.conf` | `tests/perte_focus/` | à faire |
| TEXTREG-T06 | replay | Recherche en base | `Facture` champ client (`champs("Fiches_Cli", …)`) : `CTRL+Haut`, saisie « DU », Bas, Entrée ; `lke = commence_par` sur `cart` | valeur choisie ; lignes de la grille | `tests/recherche/` | à faire |
| TEXTREG-T07 | replay | Historique | `SaiReg` : 3 saisies successives puis `CTRL+Bas`, Tab | lignes affichées (vides comprises, OBJPROP-A01) et valeur recopiée | `tests/historique/` | à faire |
| TEXTREG-T08 | replay | Échap, bouton effacer, double-clic/F2 calendrier | `Pointage` (dates) | texte restauré / vidé ; date choisie | `tests/echap_effacer/` | à faire |
| TEXTREG-T09 | replay | Mode scanner | `Achat` (colonne article, `scanner`/`activescan` posés par `ObjProp.AddChamp`) : saisie simulée d'un code-barre (Maj + touches) sous X11 | Retour envoyé (figer le comportement Wayland, A01) | `tests/scanner/` | à faire |
| TEXTREG-T10 | gbtest | `frm()` / `LitNombre` (après TEXTREG-007) | `nbdec` 0 à 4 ; textes numériques | formats et valeurs | `tests/fonctions_pures/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées dans le clone Laurux non modifié (même scénario, même locale
  `fr_FR.UTF-8`, même `Laurux.conf`).
- **Données** : `Laurux01.sql` (clients, articles, comptes) suffit pour T06 ; T07 part d'un fichier
  `Laurux-AutoParams-01.conf` absent puis existant.
- **Non testable automatiquement** : le calendrier `LDateC` (dialogue) est piloté par le harnais
  de replay ; le mode scanner sous Wayland (`ydotool`) n'est pas reproductible en Docker et reste
  manuel.
- **Couverture** : `butb_keypress` (CC 31) est couvert par T06-T08 ; les accesseurs par T01-T03.
