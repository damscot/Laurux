# Cmenu — Synthèse

> Source : `.src/Caisse/Cmenu.class` · Synthèse des autres documents.

## Rôle

Fenêtre d'accueil du point de vente (« Accueil Laurux-Pos ») : fenêtre principale en mode
`./Laurux -p` (créée par `Start.Lancement`), ou ouverte depuis `Fmenu.Menu332` en mode Gestion.
Elle ouvre la connexion à la base (mode `-p`), puis propose la connexion de la caisse
(`Ouverture`), la saisie du fond de caisse (`Fondcaisse`), la saisie caisse (`New Caisse`) et la
déconnexion, réalisée à la fermeture de la fenêtre (`form_close`).

## Points clés

- **Module complexe** (cycle ouverture/fermeture de caisse) : la déconnexion met à jour
  `Fiches_Caisses` (`dtefm`, `connecte = 0`, `vdr_code`), supprime `~/Caisse<n>.lock` et vide
  `/Soc<XX>/caisse/Ncai`.
- Accès administrateur : `Alt+P` → `Preferences`, `Alt+L` → `DB_Log`, protégés par le mot de
  passe d'un vendeur `admin` si `/caisse/admin2` est actif.
- Connexion à la base dupliquée de `Fmenu`, sans garde MySQL pour `SET NAMES`/`ALTER DATABASE`.
- Écran instrumenté une fois par `Utils.Observers(Me)` : rejouable.
- Fonction la plus complexe : `_new` (CC 16), puis `form_close` (CC 12).

## Dépendances principales

- Appelants : `Start` (mode `-p`) et `Fmenu.Menu332_Click`.
- Utilise : `Ouverture`, `Fondcaisse`, `Caisse`, `Preferences`, `Attrib`, `DB_Log`,
  `LauruxConf` (auto-instances pour la plupart), `Utils.db`, `hexdblKey`, `Start.$tcai`.
- Tables : `Fiches_Caisses`, `Fiches_Societes`, `Fiches_Vendeurs`, `Fiches_ClientCaisse` (en dur).

## Risques

- Titre écrit sur l'auto-instance de `Fmenu` (instance cachée créée, FMENU-A13 / CMENU-A01).
- Mode `-p` probablement inutilisable sous SQLite (`SET NAMES` non gardé, CMENU-A02).
- Caisse école : `Quit 1` prématuré, déconnexion incomplète ; « Non » bloque toute déconnexion
  ultérieure (CMENU-A04).
- `Alt+L` protégé ouvre `Preferences` au lieu du journal (CMENU-A03) ; lecture de `Cai!ecole`
  sans `Available` (CMENU-A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 325 |
| Lignes de commentaire | 20 |
| Fonctions | 25 |
| Fonctions Public | 25 |
| Complexité cyclomatique totale | 107 |
| Complexité max (fonction) | 16 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

14 scénarios `replay` (CMENU-T01 à T14) : ouverture `-p` et erreurs de connexion, connexion
refusée/acceptée, actions sans caisse, déconnexion (oui, non, école), accès administrateur,
ouverture depuis `Fmenu`, `F12`, SQLite. **Liste à faire valider par l'utilisateur avant la
phase 2** (module complexe). Jeu de données dérivé `caisse_base` (caisses, vendeurs, client caisse).

## Rework

11 étapes sans changement de comportement (CMENU-001 à 011) : documentation, code mort,
`Cbase.Table`, découpage de `_new` et de `form_close`, helper des touches, séparation
traitement/GUI (déconnexion, contrôles, mot de passe administrateur), commonalisations
(`SurvolBoutons`, `LVendeur`, `CompteClientCaisse`), réduction de portée de 8 membres. 5 anomalies (CMENU-A01 à A05)
soumises à validation.
