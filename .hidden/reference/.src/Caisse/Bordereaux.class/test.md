# Bordereaux — Tests

> Source : `.src/Caisse/Bordereaux.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran en lecture seule : la sortie à comparer est le **PDF** (texte extrait par `pdftotext`,
horloge figée car le titre et le nom de fichier contiennent la date du jour) ; le dump de la base
doit rester **inchangé**. L'écran n'appelle pas `Utils.Observers(Me)` : il n'est pas journalisé, donc
pas rejouable en l'état (même décision de phase 2 que pour `Moulinage` : instrumentation dans les
deux clones avant capture, ou pilotage après BORDEREAUX-004 par un test appelant
`Imp_Bordereaux(types, numeros)`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| BORDEREAUX-T01 | replay | Bordereau « Tous » | jeu `caisse_base` : chèques et cartes sur 2 caisses et 2 jours ; `Tous`, `Imptk` coché, Imprimer | PDF `Bordereau_<date>.pdf` : cartes puis chèques, totaux par type (largeurs 90/50 figées), dump inchangé | `tests/bordereau_tous/` | à faire |
| BORDEREAUX-T02 | replay | Chèques seuls, sans numéros | `Cheques`, `Imptk` décoché | `Bordereau_Cheques_<date>.pdf`, intitulés sans « Ticket N° » | `tests/bordereau_cheques/` | à faire |
| BORDEREAUX-T03 | replay | Cartes seules | `Cartes` | `Bordereau_Cartes_<date>.pdf` | `tests/bordereau_cartes/` | à faire |
| BORDEREAUX-T04 | replay | Aucune donnée | base sans ligne `U`/`V` | `Message.Info` « Il n'existe pas de donnée… », aucun PDF | `tests/bordereau_vide/` | à faire |
| BORDEREAUX-T05 | replay | Pagination | 80 chèques | sauts de page à `PosY >= 240`, en-tête répété (premier à `PosY = 0`) | `tests/bordereau_pages/` | à faire |
| BORDEREAUX-T06 | replay | Tickets supprimés / en erreur | ticket supprimé et ticket `statut = E` réglés par chèque | lignes présentes dans le bordereau (A01 figée) | `tests/bordereau_tickets_supprimes/` | à faire |
| BORDEREAUX-T07 | replay | En-tête société | société avec logo (`/glogo`) puis sans ; SIRET local | en-tête PDF de référence | `tests/bordereau_entete/` | à faire |

## Détail des tests

- **Valeurs attendues** : PDF produits dans le clone **Laurux non modifié** (`faketime`, locale
  `fr_FR.UTF-8`, `HOME` jetable), puis texte extrait ; la comparaison porte sur le texte et le
  nombre de pages, pas sur les octets (dates de création internes du PDF).
- **Données** : jeu `caisse_base` (voir [Moulinage](../Moulinage.class/test.md)) ; T06 ajoute un
  ticket supprimé et un ticket en erreur avec règlement par chèque.
- **Non testable** : `Visualiseur.Prog` (ouverture du lecteur PDF, à neutraliser par la
  configuration de test), `Music.Play`, `Doc.Open`.
- **Couverture visée** : 100 % de `Imp_Bordereaux` et `Imp_Entete` (branches radio, `Imptk`,
  changement de type, pagination, logo).
