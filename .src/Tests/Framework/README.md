# Framework de tests de non-régression (phase 2 du rework)

Décisions : `.hidden/reference/PLAN.md` §4.0. Les modules gb.test vivent dans `.src/Tests/<lot>/`
(compilés avec le projet), leurs données dans `.hidden/Tests/<lot>/assets/` (hors de `.src` : ni l'IDE ni l'archive
`Laurux` ne les chargent) ; les fichiers générés (`list.md`, `results.json`, sorties des rejeux) vont dans
`output/tests/` (non versionné) ; `.hidden/reference/` ne contient que la documentation.

## Arborescence

```
.src/Tests/
  Framework/
    runner.py            pilote : base Docker, harnais, gb.test, record/replay/compare
    TestKit.module       aide gb.test : valeurs attendues « golden » (TestKit.Check), état global de test
    Laurux-test.conf     configuration Laurux de test (base 127.0.0.1:13306, Maj=0, Tips=0, son=0)
    harness_files.txt    fichiers du harnais (diff vs 6b6b9dfc → harness.patch, appliqué au clone ref)
    harness.patch        généré par « runner.py harness make »
    dump_mask.json       colonnes volatiles masquées dans le dump normalisé
    bin/                 enveloppes mysql/mysqldump (port de la base de test), en tête du PATH de test
  <lot>/
    <Classe>Test.test    module gb.test
    assets/<nom>/        données d'un test : expected.txt (gb.test) ou scénario GUI :
                         scenario.log, meta.json, expected/{dump.sql, sql.log, console.txt, exit_code}
```

## Prérequis

- Docker ; paquets hôte : `mariadb-client`, `xvfb`, `faketime`, `xdotool` (rejeu des frappes et des clics
  sur labels, `Utils.De.SendKeys`).
- Clone de référence : `/home/damscot/Laurux` (ou `LAURUX_REF=…`), au commit `6b6b9dfc` + harnais.

## Utilisation

```bash
R=.src/Tests/Framework/runner.py
python3 $R db up                        # base MariaDB 10.11 de test (.hidden/Docker/docker-compose.test.yml)
python3 $R harness apply                # applique le harnais au clone ref et y copie .src/Tests
python3 $R build                        # gbc3 + archives ~/.cache/laurux-tests/{rework,ref}/Laurux

python3 $R gbtest --record              # gb.test dans ref, enregistre les valeurs attendues, les recopie ici
python3 $R gbtest                       # gb.test dans rework (code 0 = succès)

python3 $R record Gestion/facture_simple --dataset facturation_base --date "2026-01-15 10:00:00"
                                        # scénario joué à la main dans ref (écran réel), puis attendus par rejeu
python3 $R replay Communs/demarrage_quitter --expected   # (ré)écrit les attendus depuis ref
python3 $R compare Communs/demarrage_quitter              # rejeu rework comparé aux attendus (dump + SQL)
python3 $R compare Communs/demarrage_quitter --live       # comparé à un rejeu ref fait à l'instant
python3 $R report                       # rapport sans exécution : fusionne output/tests/runs/* en list.md, results.json, TODO.md

python3 .src/Tests/Framework/sandbox.py create 1   # bac à sable n°1 (copies des clones, base 13307)
python3 .src/Tests/Framework/sandbox.py collect 1  # recopie ici les tests et docs produits dans le bac
```

Règles : un test = un processus ; méthodes gb.test `T<nn>_<objet>` (ID `<CLASSE>-T<nn>` du test.md) ;
scénarios avec `meta.json` (`id`, `classe`, `dataset`, `date`) ; échec attendu par `TestKit.CheckXFail`
(gb.test) ou `"xfail"` dans `meta.json` (replay).

## Déterminisme

- Base restaurée avant chaque rejeu (`Laurux01.sql` + jeu de données des assets du test, 0,2 s ; voir TESTING.md « Jeux de données »).
- `faketime -f "@<date>"` : la date part de la valeur du scénario et avance normalement.
- `HOME` temporaire, `LANG=fr_FR.UTF-8`, `SDL_AUDIODRIVER=dummy` (pas de carte son sous Xvfb).
- Archive exécutable nommée `Laurux` pour les deux clones (`Application.Name` identique).
- `sql_mode` du serveur : `NO_ENGINE_SUBSTITUTION`, valeur que `Fmenu` impose lui-même au démarrage.
- Dump : schéma (sans `AUTO_INCREMENT=`) puis données, tables et lignes triées ; colonnes de
  `dump_mask.json` masquées. Le SQL comparé est la suite des requêtes `Exec_SQL` du journal (sans horodatage,
  pid ni pile d'appels).

## Amélioration pour plus tard

Limites constatées pendant la phase 2 (vagues 1 à 7) et évolutions possibles. Rien de ce qui suit n'est implémenté :
chaque évolution du framework est à valider par l'utilisateur (relecture ligne à ligne, AGENTS.md règle 17 bis). Les
défauts sont détaillés dans `.hidden/reference/.src/Utils/ReplayObserver.class/rework.md` (REPLAYOBSERVER-Axx) et
`.hidden/reference/.src/Start.module/rework.md` (START-Axx). Le tableau « Effet » indique les tests restés « à faire ».

### Boîtes `Message.*` et fenêtres modales

Une fenêtre modale (`Message.*`, `ShowModal`, `ShowDialog`) ouvre une boucle d'événements imbriquée : le code
appelant ne reprend la main qu'à sa fermeture, mais les minuteurs (`Timer`) continuent de tourner.

| Problème | Effet | Évolution possible |
|---|---|---|
| gb.test : une boîte `Message.*` bloque le test (personne ne répond) | ~60 tests « Message bloquant en gb.test » | Aide `TestKit` : annoncer avant l'action la réponse attendue (`TestKit.Repondre("FMessage", bouton, texte attendu)`) ; un minuteur de TestKit repère la fenêtre dans `Windows` (`Object.Type(hWin) = "FMessage"`), relève son texte (comparé dans `expected.txt`) et clique le bouton (`Value = True`, clic différé : mémoriser la dernière boîte traitée). Technique validée à la main en vague 7 (TresorTest, EmailingTest). |
| gb.test : une fenêtre de sélection en `ShowModal` (TriCpt, Tricp, LDateC, Rechcons…) bloque le test | sélections de compte, client, date, consigne | Même aide générique : `TestKit.SurFenetre("TriCpt", action)` ; l'action pose `Bsel`/`Bval`, appelle `ColTri_MajSel(code)` ou ferme la fenêtre. Validé à la main en vague 7 (LDateCTest, MaterielModalTest, EdMat/Changefour/FClientcarte/Edart4ModalTest). |
| Rejeu : à la fermeture d'une fenêtre modale, l'appel du minuteur qui l'avait ouverte reprend et désactive sa chaîne de minuteurs (`rReplayTimer.Enabled = False`) et réécrit `Ev` avec l'heure de l'événement d'ouverture (`Start.ReplayTimer_Timer`) | REPLAYOBSERVER-A08 (cadence faussée), A15 (fermeture d'un `ShowModal`), probablement A18 (`Wait`, envoi SMTP dans un gestionnaire rejoué) | Garder l'horodatage du dernier événement rejoué dans une variable du module, ne plus le réécrire au retour ; un seul minuteur ré-armé à chaque événement plutôt qu'une chaîne récursive. |
| Rejeu : `Replay_Event` exige que la fenêtre de l'événement soit la fenêtre active ; après un `Show` non modal, un clic dans Fmenu sort en code 3 | FVENDEURS-T06 et écrans ouverts sans `ShowModal` | Chercher la fenêtre par son nom dans `Windows` (comme lorsqu'aucune fenêtre n'est active) et l'activer avant l'action. |
| Rejeu : une boîte ouverte avant le démarrage du rejeu (Catch de `Form_Open`, `GotFocus` pendant `Form_Show`) n'est pas rejouable | FMENU-T14/T20, REPLAYOBSERVER-A19, START-A09 | Démarrer le minuteur de rejeu avant l'ouverture de la fenêtre principale. |
| Rejeu : faux positif, code 0 alors que des boîtes d'erreur restent ouvertes | START-A11 | Sortir en code d'échec si des fenêtres `FMessage` sont encore ouvertes à la fin du journal. |

### Clavier

| Problème | Effet | Évolution possible |
|---|---|---|
| gb.test : `Key.Code` / `Key.Text` ne sont lisibles que dans un vrai événement clavier ; un traitement écrit dans un gestionnaire `*_KeyPress` est inatteignable | F2/F5/F11/F12, Échap, Entrée sur grilles, filtres saisis (ImpartParam, Mvtex, Facturergbl, EdFam, Edcom, Saisiedecons…) | gb.test avec fenêtre affichée sous Xvfb et `Desktop.SendKeys` (frappe réelle, comme le rejeu) via une aide `TestKit.Frappe(controle, touches)` ; à terme, extraction du traitement hors du gestionnaire (phase 4). |
| Rejeu : `Replay_Keypress` ne traduit que BackSpace, Delete, Return, Tab (« Replay Key unsupported ») | Échap, F1-F12, flèches, +/- | Table de correspondance `Key.*` → séquences `SendKeys` (`[Escape]`, `[F2]`, `[Up]`…). |
| Rejeu : caractères accentués et « @ » (journal coupé sur « @ »), « [ » interprété par `SendKeys` | REPLAYOBSERVER-A12, A13 | Encoder la valeur dans le journal (échappement ou base64) et échapper les crochets avant `SendKeys`. |
| Rejeu : Keypress « + »/« - » sur une ColumnView dans un `ShowModal` sans effet (code 0) | ImpartParam T03/T04 | À analyser avec la correction des fenêtres modales. |

### Souris et contrôles

| Problème | Effet | Évolution possible |
|---|---|---|
| Rejeu : `Replay_Click` pose seulement `Value` : pas de `MouseDown`/`MouseUp`, pas de clic droit ni de double-clic ; `Last` non positionné | tris VisStat* (RadioButton_MouseDown), doubles clics d'en-tête, `Last.Tag` (Carch, Cmo, SetColors) | Lever l'événement par `Object.Raise(ctx, "MouseDown")`… ou simuler la souris réelle (xdotool, déjà utilisé pour les Label). |
| Rejeu : clic sur une TextBox → « Unknown symbol 'Value' in class 'TextBox' » ; bouton d'un TextReg / ButtonBox non rejoué | contournés par `Focus` | Branches dédiées dans `Replay_Click`. |
| Rejeu : GridView sans `_Click`, TreeView (`Activate`), ColumnView multi-sélection, DateChooser, ListEditor, glisser-déposer | REPLAYOBSERVER-A14, A16, A17 ; Agenda, GedR, journauxSetting | Lever les événements réels (`Object.Raise(ctx, "Activate")`, `Select`) plutôt que d'appeler `<fenêtre>.<nom>_Click`. |
| gb.test : sans affichage, l'événement `Data` d'une grille n'est pas levé ; couleurs de cellule non relisibles | ConsultArt T06, Ccomptes (contourné : grille affichée sous Xvfb) | Aide `TestKit.Afficher(fenêtre)` et relevé des cellules par l'événement Data. |
| Techniques gb.test déjà validées | — | `Object.Raise(grille, "Select" / "ColumnClick", [n])` ; ColumnView : `Key = cle` puis `MoveTo(cle)` ; remettre le curseur interne après un parcours. À documenter dans TESTING.md. |

### Sélecteurs de fichier, de répertoire et de couleur

| Problème | Effet | Évolution possible |
|---|---|---|
| `Dialog.OpenFile`, `Dialog.SelectDirectory`, `Dialog.SelectColor` sont des dialogues natifs : ils n'apparaissent pas dans `Windows`, ni le rejeu ni un minuteur gb.test ne peuvent les piloter | Prefs T04/T12, FSetFormat, Changefam, Emailing T05/T06, ExportA47 (Svs2), RubImp (BcrSelect)… | Stub de dialogue : lire la réponse dans une variable d'environnement de test (`LAURUX_TEST_DIALOG_<TYPE>=<chemin|couleur|annuler>`) — impossible sans toucher au code applicatif, donc à réserver à une fonction commune `Utils.ChoisirFichier()` extraite en phase 4 ; en attendant, forcer les dialogues Gambas (gb.form) au lieu des natifs, si le composant le permet (à vérifier), pour les piloter comme une fenêtre modale. Le FileChooser intégré aux écrans est déjà rejouable (frappe du nom). |

### Environnement d'exécution

| Problème | Effet | Évolution possible |
|---|---|---|
| Le rejeu s'exécute dans la racine du clone : un fichier écrit en chemin relatif (`curl … > monip`) salit le dépôt | MONIP-T01/T02 (scénario mis de côté) | Lancer le rejeu avec le HOME de test comme répertoire courant (`Run_Scenario`). |
| gb.test : `Application.Name` vaut le nom du répertoire du clone (`ref`, `rework`) et non `Laurux` | noms de fichiers produits (`rework_log.csv`, DB_Log) | Lancer les modules gb.test depuis l'archive `Laurux` (comme le rejeu) ou normaliser le nom dans TestKit. |
| gb.test : pas de date figée par module (`gbtest --date` non mémorisé) | lettrages, échéances, listes dépendant de `Now` (Ligcli T02, Listextcpt) | Clé `date` par module (fichier `<Module>.meta.json` ou constante lue par `TestKit.Begin`). |
| Base SQLite non prise en charge | ~20 tests SQLite | Variante du runner avec `Laurux01.sqlite` restauré par test. |
| Mesure de performance (`gbx3 -p`) non outillée | tests de performance (Cbase, Utils, Sha1Calc, DB_Connection) | Commande `runner profile` : durée et profil comparés à une valeur de référence avec tolérance. |
| Comparaison limitée au dump, au SQL et aux fichiers listés : ni affichage (grilles, TextBox, menus, ordre des focus) ni console | tests « affiché seulement » | Journal d'état d'écran optionnel en fin de rejeu (valeurs des contrôles de la fenêtre active). |

### Robustesse sous charge (10 bacs en parallèle)

| Problème | Effet | Évolution possible |
|---|---|---|
| Cadence rejouée à l'identique : une boîte qui s'ouvre plus tard que l'événement suivant le fait échouer (code 3) | REPLAYOBSERVER-A08 ; écarts allongés à la main | Attendre l'apparition de la fenêtre cible de l'événement (avec délai maximal) au lieu d'un délai fixe. |
| Erreur fatale parfois non détectée : code 124 au lieu de 125 | relances nécessaires | Détection de la boîte d'erreur fatale par le harnais avant le délai global. |
| Scénarios de 12 à 20 s dépassant 20 s sous charge | relances ; durées à accorder | Délai proportionnel à la charge, ou mesure de durée en CPU plutôt qu'en temps écoulé. |

### Runner

| Problème | Évolution possible |
|---|---|
| `replay --expected` avec joker régénère aussi les attendus d'autres classes | Confirmation ou liste affichée avant d'écrire les attendus. |
| `gbtest Lot/Module` ne sélectionne rien (seul `<Module>*` fonctionne) | Accepter le chemin `Lot/Module`. |
| `sandbox.py collect` ne voit ni un fichier déplacé (date conservée) ni une suppression ; deux bacs qui modifient le même fichier : le dernier collecté gagne | Collecte par `git status` du bac (ajouts, modifications, suppressions) et fusion à trois points des fichiers modifiés dans plusieurs bacs. |
