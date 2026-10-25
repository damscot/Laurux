# Gsm — Synthèse

> Source : `.src/Gestion/SMS/Gsm.class` · Synthèse des autres documents.

## Rôle

Écran d'envoi d'un SMS unitaire à un portable, avec choix optionnel d'un texte prédéfini
(`Fiches_Sms`). Ouvert par `Fmenu` (SMS › Envoi unique), `FClient`, `FFournisseur` et `OptFac`
avec le numéro du tiers. Envoi selon `/Soc<XX>/Support` : clé GSM (`gammu`), API HTTP Spot-Hit
ou API HTTP Hosteur (support caché), par `Shell` + `curl`, sortie relue dans `~/tmp/sms.txt`.

## Points clés

- 9 fonctions, toutes handlers ou `_New` (aucune portée réductible).
- `Button2_Click` (CC 14) construit les commandes par concaténation ; `TextLabel1_GotFocus`
  (CC 14) contrôle les crédits Spot-Hit (code identique dans Emailing, Psms, Prefs).
- `TextLabel1_GotFocus` est probablement jamais levé (focus d'un `TextLabel`) : à confirmer.
- Condition d'envoi sur un libellé statique : un SMS vide peut partir.

## Dépendances principales

- Utilise : `Start.LocalSettings` (`/Support`, `/Api`, `/Type`, `/Expediteur`, `/Hidentifiant`,
  `/Hmdp`, configuration mail), `Utils.db`, `Cbase` (`TabSms`), `Doc`.
- Externes : `gammu` + modem GSM, `curl`, API Spot-Hit et Hosteur.
- Utilisé par : `Fmenu`, `FClient`, `FFournisseur`, `OptFac`.

## Risques

- **Injection de commande** par le texte ou le numéro (A01).
- **Identifiants en clair** : clé Spot-Hit, mot de passe Hosteur dans l'URL HTTP, sur la ligne de
  commande, dans `Laurux.conf` et imprimés par `Print` (A02).
- Support Hosteur mal formé et sans retour (A03) ; pas d'encodage d'URL (A04) ; contrôle de
  crédit douteux et dépendant de la configuration mail (A05) ; SMS vide possible (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 198 |
| Lignes de commentaire | 18 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 52 |
| Complexité max (fonction) | 14 (`TextLabel1_GotFocus`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 scénarios `replay` (GSM-T01 à T08) avec faux `gammu`/`curl` dans un `HOME` isolé : ouverture
depuis une fiche, choix d'un texte, envoi par chaque support, caractères spéciaux (preuve
d'injection), saisies vides, table absente. Non testable sans matériel ni service réel : modem
GSM, délivrance Spot-Hit/Hosteur.

## Rework

6 étapes sans changement de comportement (GSM-001 à 006) : documentation, code mort, réduction
de complexité, fonction pure de construction des commandes, module SMS commun (avec Emailing,
Psms, Prefs), lecture des textes partagée avec Sms. 6 anomalies (GSM-A01 à A06), dont 2 de
sécurité.
