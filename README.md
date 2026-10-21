# Laurux
Laurux est un PGI français gérant la comptabilité, les points de ventes et une gestion complète.

Plus de renseignements sur le site http://www.laurux.fr

Laurux est distribué sous la licence GPL

## Utilisation en ligne de commande

```bash
# Build (depuis la racine du dépôt)
gbc3 -agt          # compile les .class/.module -> .gambas/   (aussi: make)
gba3 -o Laurux     # lie le binaire                             (aussi: make)

# Lancer
./Laurux            # application complète
./Laurux -p         # mode Point de Vente (caisse)
./Laurux --devel    # mode développement (breakpoints sans Recursive/Replay Observer)
./Laurux -l         # log console+fichier
```

Toolchain requis : `gambas3` (≥ 3.19 installé ici : `gbc3`, `gba3`, `gambas3`).
Le `Makefile` écrit `sha1.txt` et `branch.txt` (version affichée dans l'About) puis les restaure.

**`make` masque les erreurs de compilation** (`gbc3 -agt >/dev/null 2>&1`). Lance `gbc3 -agt`
à la main pour voir les vraies erreurs. Drapeaux : `-a` compile tout, `-g` debug, `-t` extrait
les `.pot` i18n dans `.lang/`.

### Arguments de ligne de commande

| Flag | Long | Effet |
|---|---|---|
| `-c` | `--config` | fichier de configuration (défaut `~/.config/gambas3/Laurux.conf`) |
| `-p` | `--pos` | démarre en mode **caisse** (`Cmenu`) au lieu de `Fmenu` |
| `-l` | `--log` | active le log fichier (`~/tmp/Debug/Laurux.log`) |
| `-r` | `--replay` | rejoue un journal d'événements GUI enregistré |
| `-d` | `--debug` | niveaux de log `"console,fichier"`, ex. `-d 8,8` (avec `--logfile <chemin>`) |
| — | `--devel` | mode dev : boucle `Wait 60` au lieu de `Wait Next` (breakpoints réactifs) |
| `-s` | `--societe` | démarre sur une société donnée (ex. `01`) |
| `-t` | `--test` | **lance le test interne** (`all` ou liste de classes) et renvoie le statut |
| — | `--restore` | restaure un dump `.sql` au démarrage (debug) |
| — | `--version-full` | affiche version + branche + sha1 et quitte |
