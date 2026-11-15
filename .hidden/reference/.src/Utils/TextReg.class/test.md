# TextReg — Tests

> Source : `.src/Utils/TextReg.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`TextReg` est un contrôle : ses comportements se testent soit en `gbtest` avec `gb.gui` (contrôle
créé dans une fenêtre cachée, affectation de propriétés, lecture de `Text`/`Value` ; `xvfb-run` en
Docker, à confirmer), soit en `replay` sur des écrans réels pour la saisie clavier, les fenêtres
de recherche et d'historique. Le fichier `Laurux-AutoParams-01.conf` est redirigé par `HOME`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TEXTREG-T01 | gbtest | `EstNum` : `Text`/`Value`/`nbdec` | `Text = "1.5"`, `"1,5"`, `"abc"`, `""` ; `nbdec` `""`, `"0"`, `"2"`, `"3"` ; `Value = 3.14159` | `Text`, `Value` | `tests/numerique/` | implémenté |
| TEXTREG-T02 | gbtest | `EstDate`/`EstDateTime` | `Text = "1/2/24"`, `"01022024"`, `"31/12/2024 23:59"` | `Text` (format `LDate.L`/`.LT`), `dte` | `tests/dates/` | implémenté ("01022024" exclu : Message.Error de LDate ; "" exclu : date du jour) |
| TEXTREG-T03 | gbtest | Changement de `Type` | Text → Num → Date → Text → Date ; `reg` forcé puis changement de type | texte, regex effective ; figer l'erreur `dte = Null` (A03) | `tests/changement_type/` | implémenté |
| TEXTREG-T04 | replay | Filtre regex à la frappe | `GesTar` : saisie de lettres dans un champ numérique, `.` décimal ; `Saisecrit` : compte avec lettres | texte affiché après chaque frappe | `tests/regex_frappe/` | implémenté (scénario `Utils/textreg_regex_frappe` sur Pointage au lieu de GesTar/Saisecrit : date et solde frappés avec lettres et point décimal) |
| TEXTREG-T05 | replay | Perte de focus | `commande1` : quantité `"2,5"` puis Tab ; date `"3/4"` puis Tab | texte normalisé ; contenu de `Laurux-AutoParams-01.conf` | `tests/perte_focus/` | implémenté (scénario `Utils/textreg_perte_focus` sur Pointage au lieu de commande1 : Entrée au lieu de Tab ; Laurux-AutoParams-01.conf non comparé) |
| TEXTREG-T06 | replay | Recherche en base | `Facture` champ client (`champs("Fiches_Cli", …)`) : `CTRL+Haut`, saisie « DU », Bas, Entrée ; `lke = commence_par` sur `cart` | valeur choisie ; lignes de la grille | `tests/recherche/` | à faire : passe par Facture (écran complexe) ; CTRL+Haut (modificateur) non rejouable (Replay_Keypress n'envoie ni Ctrl ni flèches) ; gb.test impossible (butb_keypress lit Key) |
| TEXTREG-T07 | replay | Historique | `SaiReg` : 3 saisies successives puis `CTRL+Bas`, Tab | lignes affichées (vides comprises, OBJPROP-A01) et valeur recopiée | `tests/historique/` | à faire : passe par SaiReg (écran complexe) ; CTRL+Bas non rejouable ; gb.test impossible (butb_keypress lit Key) |
| TEXTREG-T08 | replay | Échap, bouton effacer, double-clic/F2 calendrier | `Pointage` (dates) | texte restauré / vidé ; date choisie | `tests/echap_effacer/` | à faire : Échap (touche non rejouable, « Replay Key unsupported ») et calendrier LDateC (double-clic/F2, fenêtre modale) ; partie « bouton effacer » implémentée en gb.test `TextRegTest.T08Effacer` (butb_click appelé directement : le harnais ignore un Click sur un TextReg) |
| TEXTREG-T09 | replay | Mode scanner | `Achat` (colonne article, `scanner`/`activescan` posés par `ObjProp.AddChamp`) : saisie simulée d'un code-barre (Maj + touches) sous X11 | Retour envoyé (figer le comportement Wayland, A01) | `tests/scanner/` | à faire : mode scanner (Maj + touches, Wayland) non reproductible |
| TEXTREG-T10 | gbtest | `frm()` / `LitNombre` (après TEXTREG-007) | `nbdec` 0 à 4 ; textes numériques | formats et valeurs | `tests/fonctions_pures/` | à faire : après TEXTREG-007 (frm/LitNombre privés) |

## Détail des tests

- **Valeurs attendues** : générées dans le clone Laurux non modifié (même scénario, même locale
  `fr_FR.UTF-8`, même `Laurux.conf`).
- **Données** : `Laurux01.sql` (clients, articles, comptes) suffit pour T06 ; T07 part d'un fichier
  `Laurux-AutoParams-01.conf` absent puis existant.
- **Non testable automatiquement** : le calendrier `LDateC` (dialogue) est piloté par le harnais
  de replay ; le mode scanner sous Wayland (`ydotool`) n'est pas reproductible en Docker et reste
  manuel.
- **Couverture** : `butb_keypress` (CC 31) est couvert par T06-T08 ; les accesseurs par T01-T03.
- **Implémentation (phase 2)** : `.src/Tests/Utils/TextRegTest.test` (contrôle dans une `Window` cachée sous Xvfb). Constat : `Text = "1 000"` sans `nbdec` affiche `1` mais `Value` vaut 1000.
- T04/T05 (vague 7) : scénarios `.hidden/Tests/Utils/assets/textreg_regex_frappe/` et `textreg_perte_focus/` (jeu
  `Compta/pointage_shared/pointage_rappro`, réutilisé) : Rapprochement, compte 512000, rappel du relevé 2 ; les valeurs
  filtrées/normalisées se lisent dans l'`UPdate` de `Fiches_Rappro` (« 2a7/0b2/2018 » → 2018-02-27, « 1x2.5z » →
  12.50 ; « 3/4 » → 2018-04-03, « 6/3/18 » → 2018-03-06, « 2,5 » → 2.50).
