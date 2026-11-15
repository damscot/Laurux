# Preferences — Tests

> Source : `.src/Caisse/Preferences.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de paramétrage sans base : tests `replay` lancés par `./Laurux -p` puis `Alt+P` (avec
`/Soc01/caisse/admin2` = 0). `Utils.Observers(Me)` est appelé une seule fois dans `_new` :
rejouable. Le critère est le **contenu du `Laurux.conf`** du test après fermeture (section
`[Soc01/caisse]`, clés triées), la base n'étant pas modifiée.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PREFERENCES-T01 | replay | Aller-retour sans modification | `Laurux.conf` avec toutes les clés renseignées ; ouvrir, « Fermer » | fichier identique (hors ordre) ; clés absentes créées avec leurs valeurs par défaut | `tests/aller_retour/` | implémenté (gb.test `PreferencesTest.T01AllerRetour` : _new puis Form_Close appelé directement, clés relues) |
| PREFERENCES-T02 | replay | Conf vide | `Laurux.conf` sans section `caisse` ; ouvrir, fermer | clés créées : `nbf = 1`, `Font = Serif,9`, booléens faux, textes vides | `tests/conf_vide/` | implémenté (gb.test `PreferencesTest.T02ConfVide`) |
| PREFERENCES-T03 | replay | Modification de chaque contrôle | cocher/décocher chaque case, saisir chaque zone, choisir police et imprimante | chaque clé attendue écrite | `tests/modification/` | implémenté (gb.test `PreferencesTest.T03Modification` : cases et zones ; police par FontChooser1.SelectedFont ; Cimp non choisi, liste des imprimantes vide dans le conteneur) |
| PREFERENCES-T04 | replay | Répertoire des tickets Z | `ChmZ` = `/tmp/z` ; bouton, annulation | figer : `ChmZ = $HOME` (A03) | `tests/repertoire_z/` | à faire : BchmZ ouvre Dialog.SelectDirectory (non rejouable, bloquant en gb.test) |
| PREFERENCES-T05 | replay | Impression de facture en caisse | `FACpdf`, `CmdImp`, `Cimp` de caisse renseignés ; facture imprimée depuis `Caisse` | figer : commande lancée avec les valeurs globales (`lpr` par défaut) (A01, IMPRESSION-T02) | `tests/impression_facture/` | à faire : passe par l'écran Caisse (complexe, exclu) |
| PREFERENCES-T06 | gbtest | Table des préférences (après PREFERENCES-003) | `ChargePreferences` sur un `Laurux.conf` de test | collection identique aux valeurs de T01 | `tests/table_preferences/` | à faire : après PREFERENCES-003 (ChargePreferences n'existe pas) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié** (fichier `Laurux.conf`
  du `HOME` de test, normalisé : sections et clés triées).
- **Environnement** : la liste des imprimantes dépend de `lpc status` ; le conteneur de test
  fournit une file CUPS fictive (ou `lpc` absent, liste vide) identique pour les deux clones.
- **Non testable automatiquement** : affichage du logo (`dwgImage`), dialogues de fichiers (sauf
  annulation), `Majversion` et `LauruxConf` (couverts par leurs propres tests).
- T04 et T05 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
- **Phase 2 (vague 7)** : gb.test `.src/Tests/Caisse/PreferencesTest.test` (au lieu du replay par Alt+P, touche Alt non rejouée) ; la valeur d'une clé posée en booléen et réécrite à l'identique par Form_Close reste booléenne (T01 : `True`/`False`), une clé absente est écrite avec la valeur entière du contrôle (`0`/`-1`) ; une zone vide supprime la clé (`ChmZ`, `Cimp`, `CmdVis` absentes en T02).
