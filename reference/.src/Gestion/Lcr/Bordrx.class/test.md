# Bordrx — Tests

> Source : `.src/Gestion/Lcr/Bordrx.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe** (génération du fichier bancaire LCR CFONB et envoi à la banque) : la liste
> des scénarios ci-dessous est **à faire valider par l'utilisateur avant la phase 2**.

Écran rejouable (`Utils.Observers(Me)`). Données d'entrée : état de base produit par
PREPARATION-T06 (bordereaux non envoyés) + un bordereau envoyé, banques avec et sans mail, options
d'adresse `N`/`O`/`C`, fins d'enregistrement vide/`Ws`/`$0D0A$`, clients avec RIB, adresses courtes
et longues. **Le fichier bancaire généré se compare octet par octet** à la référence, dates figées
par `faketime` (date du jour) ; `LANG=fr_FR.UTF-8` imposé (dates extraites de `Str(Date)`).
L'envoi de mail est intercepté (pas d'envoi réel : `EnvMail` redirigé ou client mail factice).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| BORDRX-T01 | replay | Listes | ouverture ; radio `A` ; radio `N` ; clic sur un bordereau | lignes `Exec_SQL` (`etat = 0/1`, `bordereau = &1`) | `tests/listes/` | à faire |
| BORDRX-T02 | replay | Impression du bordereau | sélection, « Imprimer » | PDF `Lcr<soc><n°>.pdf` par `pdftotext` (libellés décalés A08 figés) | `tests/impression/` | à faire |
| BORDRX-T03 | replay | Fichier bancaire, banque sans mail, adresses `N` | sélection, « Envoyer » | fichier `LCR<soc><bq>` **octet par octet** ; `Fiches_Bordereaux.etat = 1` ; message « adresse mail… » | `tests/fichier_sans_mail/` | à faire |
| BORDRX-T04 | replay | Fichier bancaire, adresses `O`, fin `Ws` | idem | fichier CRLF avec enregistrements `1660` | `tests/fichier_adresses_crlf/` | à faire |
| BORDRX-T05 | replay | Option `C` et code entrée 5 ; fin `$0D0A$` | idem | `1660` présents ; suffixe littéral figé (A05) | `tests/fichier_dailly/` | à faire |
| BORDRX-T06 | replay | Banque avec mail | « Envoyer » | fichier écrit, `etat = 1`, erreur l. 383 figée (A01), aucun mail | `tests/envoi_mail/` | à faire |
| BORDRX-T07 | replay | Champs trop longs | SIREN 9 chiffres ou adresse de 35 caractères | erreur « Bad argument » figée, fichier partiel (A04) | `tests/champs_longs/` | à faire |
| BORDRX-T08 | replay | Montants | LCR `"12,50"` et `"12.50"` | montants en centimes ou erreur figée (A03) | `tests/montants/` | à faire |
| BORDRX-T09 | replay | Réinjection | bordereau non envoyé, « Réinjecter », Oui | dump `Fiches_Lcr` (`bordereau = 0`), `Fiches_Bordereaux` | `tests/reinjection/` | à faire |
| BORDRX-T10 | replay | Suppression d'un bordereau envoyé ; refus sur non envoyé | radio `A`, « Supprimer » ; radio `N`, « Supprimer » | dump ; message | `tests/suppression/` | à faire |
| BORDRX-T11 | gbtest | Construction des enregistrements (après BORDRX-004) | jeux banque/LCR de T03-T05 | enregistrements identiques aux fichiers de référence | `tests/enregistrements/` | à faire |

## Détail des tests

- Références produites dans le clone **Laurux non modifié** ; dump normalisé de `Fiches_Bordereaux`
  et `Fiches_Lcr` ; fichier bancaire et PDF copiés depuis le répertoire `/Soc<XX>/Fichiers` du
  `Laurux.conf` de test (répertoire temporaire).
- `check_output.py` compare le fichier bancaire avec `cmp` (aucune normalisation) et vérifie la
  longueur de chaque enregistrement (160 caractères hors suffixe), pour documenter les écarts
  (A05, A06).
- T11 n'existe qu'après la séparation de la construction des enregistrements (BORDRX-004) ; il
  réutilise les fichiers de référence des replays.
- Non testable automatiquement : remise effective à la banque ; envoi réel du mail.
