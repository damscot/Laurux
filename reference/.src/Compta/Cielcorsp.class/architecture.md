# Cielcorsp — Architecture

> Source : `.src/Compta/Cielcorsp.class`

## Vue d'ensemble

Écran de saisie de la **table de correspondance des comptes clients/fournisseurs Ciel → Laurux**
(`Ciel_Lrx` : `Cciel` clé, `Clrx`, `Intitule`), utilisée par l'import d'écritures Ciel
([`Cielimp`](../Cielimp.class/architecture.md)) et l'import FEC (`Compta/Utils/impfec.class`).
Ouvert en modal par `Fmenu.Menu180_Click` et `impfec.Buttoncpt_Click`.

À l'ouverture, `Utils.Ciel()` crée au besoin les tables `Ciel_Lrx`, `Ciel_Lrx_Jo` et la colonne
`Fiches_Parametres.imp_ciel` (DDL hors `LauruxMaj`, voir UTILS). La liste `ListeCompte` affiche
les correspondances existantes. L'utilisateur saisit un compte Laurux (`CptLrx`, liste F1 des
comptes clients ou fournisseurs selon `RadioButton1/2`) et un compte Ciel (`CptCiel`), puis
« Ajouter » ; `Suppr` ou un double-clic suppriment la correspondance (le double-clic la recopie
d'abord dans les zones de saisie pour modification).

**Duplication** : [`Cielcorspj`](../Cielcorspj.class/architecture.md) (journaux) est une copie
de cet écran à 89 % (178 lignes de code identiques sur 199 hors commentaires) ; seules changent
la table (`Ciel_Lrx_Jo`), la source de la liste (`Fiches_Journaux`), les libellés et le contrôle
de doublon.

Nature globale : **mixte** (SQL dans les handlers).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `rcpt` | var | Private |  | Result | 27 |
| `Intit` | var | Private |  | String | 28 |
| `B` | var | Private |  | Integer | 29 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 31-64 | Public | 3 | 31 | 0 | méthode spéciale |
| `Button1_Click` | 69-107 | Public | 6 | 36 | 0 | handler GUI |
| `Colcpt_KeyPress` | 112-132 | Public | 6 | 17 | 0 | handler GUI |
| `Colcpt_Click` | 137-144 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 146-164 | Public | 5 | 12 | 0 | handler GUI |
| `btn_KeyPress` | 166-172 | Public | 4 | 5 | 0 | handler GUI |
| `Button2_Click` | 177-217 | Public | 10 | 38 | 0 | portée réductible ? |
| `Cpt_man` | 222-248 | Public | 4 | 24 | 0 | portée réductible ? |
| `ChkInput` | 250-258 | Public | 6 | 7 | 0 | portée réductible ? |
| `Listecompte_KeyPress` | 263-270 | Public | 2 | 6 | 0 | handler GUI |
| `Listecompte_Activate` | 272-279 | Public | 1 | 6 | 0 | handler GUI |
| `Compte_delete` | 281-288 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button3_Click` | 293-297 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : mixte]. Centre (deux fois), son, observateurs,
  `Utils.Ciel()`, `Chainage` (CptLrx → CptCiel → Button2), colonnes de `ListeCompte`,
  `SELECT * FROM Ciel_Lrx` → liste. Variables `params` et `Tab` partiellement inutiles.
- **`Button1_Click()`** [portée : nécessaire, appelé par `Btn_Click` (Tag 1) et F1]
  [nature : mixte]. Bascule l'affichage de la liste `Colcpt` des comptes de type `C` ou `F`
  (`SELECT * FROM Fiches_Comptes where type_cc = &1 order by cast(compte_cc AS char)`).
- **`Colcpt_KeyPress()`** [handler] [nature : GUI]. Entrée → sélection ; F1 → `Button1_Click` ;
  Échap/F2 → masque la liste.
- **`Colcpt_Click()`** [handler] [nature : GUI]. Recopie le compte dans `CptLrx`.
- **`Btn_Click()`** [handler du groupe `Btn`] [nature : GUI]. Aiguillage par `Last.Tag` :
  1 → `Button1_Click`, 2 → `Button2_Click`, 3 → `Button3_Click`, 4 → fermer. Les boutons
  `Button2`, `Button3`, `Button4` sont dans le groupe `Btn` : leurs méthodes `Button2_Click` et
  `Button3_Click` ne sont **pas** levées par l'événement mais appelées ici ; ce ne sont pas des
  handlers morts (signalement `deps.py` antérieur à vérifier : faux positif).
- **`btn_KeyPress()`** [handler du groupe] [nature : GUI]. Entrée sur le bouton Tag 2 →
  `Button2_Click`.
- **`Button2_Click()`** (CC 10) [portée : nécessaire] [nature : mixte]. `Cpt_man` (contrôle du
  compte Laurux), compte Ciel obligatoire, contrôle de doublon dans la liste (même Ciel **ou**
  même Laurux), puis en base (`SELECT * FROM Ciel_Lrx where Cciel = &1`), `INSERT INTO Ciel_Lrx
  (Cciel, Clrx, Intitule)`, ajout à la liste, remise à blanc. Dépend du membre `B` (0 = compte
  valide) positionné par `Cpt_man`.
- **`Cpt_man()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Comptes where
  compte_cc = &1` ; mémorise l'intitulé (`Intit`) ou affiche un avertissement et met `B = 1`.
- **`ChkInput()`** [portée : réductible, **code mort**] [nature : GUI]. Filtre de touches
  numériques jamais appelé (les homonymes de `Tricartes`, `Etiquettes`… sont locaux).
- **`Listecompte_KeyPress()`** [handler] [nature : mixte]. `Suppr` → `Compte_delete` + retrait
  de la ligne.
- **`Listecompte_Activate()`** [handler] [nature : mixte]. Double-clic : recopie les codes dans
  les zones de saisie **et supprime immédiatement** la correspondance (en base et dans la liste).
- **`Compte_delete()`** [portée : réductible] [nature : calcul]. `DELETE FROM Ciel_Lrx WHERE
  Cciel = &1` sur la ligne courante.
- **`Button3_Click()`** [portée : nécessaire, appelé par `Btn_Click`] [nature : GUI].
  `Doc.Open("Cielimport")`.

## État global utilisé

- `Utils.db`, `Utils.Ciel`, `Utils.Observers`, `Start.Musique`, `Start.son`.
- Membres d'instance `rcpt` (résultat réutilisé par trois fonctions), `Intit`, `B`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `ChkInput`, le second `Me.Center`, `params` (CIELCORSP-002).
- `rcpt` → résultats locaux.
- `Cpt_man` renvoie un booléen au lieu de positionner le membre `B`.

### Commonalisation avec d'autres fichiers

- **`Cielcorsp` ↔ `Cielcorspj`** : 89 % de code identique. Proposition : module
  `CielCorresp` paramétré (table de correspondance, requête de liste, requête de contrôle,
  contrôle de doublon Laurux oui/non, libellés) appelé par les deux écrans, qui gardent leurs
  handlers et leur `.form` (CIELCORSP-003, même étape que CIELCORSPJ-003).
- `Utils.Ciel()` et le bloc DDL de `Cielimp.Btn_Click` créent les mêmes tables avec des
  longueurs différentes (voir CIELIMP-A07).
- `Doc.Open("Cielimport")` répété dans les trois écrans Ciel.

### Réduction de portée

- `Cpt_man`, `Compte_delete` → `Private` ; `ChkInput` supprimé.
- `Button2_Click`, `Button3_Click`, `Button1_Click` restent `Public` (appelés par le groupe et
  potentiellement rejoués par `ReplayObserver`).

### Séparation traitement / GUI

- `AjouteCorrespondance(sCiel, sLrx, sIntitule) As String` (contrôle base + `INSERT`, renvoie le
  message d'erreur) et `ControleCompteLaurux(sCode) As String` (intitulé ou `""`), sans accès aux
  contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Tables `Ciel_Lrx`/`Ciel_Lrx_Jo` créées hors `LauruxMaj` et absentes de `db_control.csv` :
  les intégrer au schéma de référence (migration dédiée) avec une longueur `Cciel` unique.
- Une seule table de correspondance avec une colonne `type` (compte/journal).
