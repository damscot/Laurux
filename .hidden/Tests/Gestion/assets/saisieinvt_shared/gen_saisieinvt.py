# Générateur du jeu saisieinvt_shared/invt.sql et des scénarios saisieinvt_* (SAISIEINVT-T02 à T06, T10 à T14).
# Usage : python3 gen_saisieinvt.py (conserve la cadence des meta.json existants), puis runner retime (scénarios
# neufs), runner harness apply, runner replay --expected.
import json, os
A = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # .hidden/Tests/Gestion/assets
S = A + '/saisieinvt_shared'
os.makedirs(S, exist_ok=True)
open(S + '/invt.sql', 'w').write(
    "-- Jeu SAISIEINVT : inventaire tournant du 01/06/2018 en cours. Lignes : 1 = 003 (stock 0, non compté),\n"
    "-- 2 = 001 (stock 10, compté 12), 3 = 002 (stock 7, non compté). 003 a le code équivalent EQ3, 001 la référence\n"
    "-- centrale RC1 ; 004 stocké absent de l'inventaire.\n"
    "UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10 WHERE art_code = '001';\n"
    "UPDATE Fiches_Art SET art_stocke = 1, art_qte = 7 WHERE art_code = '002';\n"
    "UPDATE Fiches_Art SET art_stocke = 1, art_qte = 0, art_cequ = 'EQ3' WHERE art_code = '003';\n"
    "UPDATE Fiches_Art SET art_refcentrale = 'RC1', art_centrale = '01' WHERE art_code = '001';\n"
    "CREATE TEMPORARY TABLE tmp_saisieinvt AS SELECT * FROM Fiches_Art WHERE art_code = '002';\n"
    "UPDATE tmp_saisieinvt SET art_code = '004', art_design = 'Produit hors inventaire', art_cbarre = '', art_cequ = '';\n"
    "INSERT INTO Fiches_Art SELECT * FROM tmp_saisieinvt;\n"
    "DROP TEMPORARY TABLE tmp_saisieinvt;\n"
    "DROP TABLE IF EXISTS Fiches_InvT;\n"
    "CREATE TABLE Fiches_InvT (inv_nlig char(9) NOT NULL, inv_code char(15), inv_qtestock decimal(12,2),\n"
    " inv_qtecomptee decimal(12,2), inv_date date, inv_comptee tinyint, inv_valid int, inv_design varchar(50),\n"
    " inv_casier char(8), lind int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lind)) ENGINE=InnoDB;\n"
    "INSERT INTO Fiches_InvT (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_valid, inv_design, inv_casier) VALUES\n"
    "('1', '003', 0.00, 0.00, '2018-06-01', 0, NULL, 'produit 20.00', ''),\n"
    "('2', '001', 10.00, 12.00, '2018-06-01', 1, NULL, 'Produit 2.10', ''),\n"
    "('3', '002', 7.00, 0.00, '2018-06-01', 0, NULL, 'Produit 7.00', '');\n")

ENTREE, TAB, BS, SUPPR = "16777220", "16777217", "16777219", "16777223"
W = "SaisieinvT"
MENU = ("Fmenu.Menu96_Click", "Click=True@Menu96#Fmenu#Menu66#Menu77#Menu94#Menu96#")
OK = ("FMessage.FMessage_KeyPress", "Keypress=%s@FMessage#FMessage#" % ENTREE)
DEUX = [(1.0, "FMessage.FMessage_KeyPress", "Keypress=%s@FMessage#FMessage#" % TAB), (0.1, "FMessage.FMessage_KeyPress", "Keypress= @FMessage#FMessage#")]
VALIDER = ("SaisieInvT.Btn_Click", "Click=True@Button1#%s#Panel1#Button1#" % W)
IMPORT = ("SaisieInvT.Btn_Click", "Click=True@Button3#%s#Button3#" % W)
CA = ("SaisieInvT.Ca_Click", "Click=True@Ca#%s#Frame3#Ca#" % W)

def saisie(champ, texte, gest, efface=0):
    p = "%s#%s#Panel1#%s#" % (champ, W, champ)
    out = [(1.0, "SaisieInvT.%s_GotFocus" % gest, "Focus=@" + p)]
    for k in [SUPPR] * efface + [BS] * efface + list(texte) + [ENTREE]:
        out.append((0.05 if len(out) > 1 else 0.1, "SaisieInvT.%s_KeyPress" % gest, "Keypress=%s@%s" % (k, p)))
    return out
def ligne(n):
    return saisie('Nseq', n, 'Rcpt', 2)
def code(c, efface=0):
    return saisie('Cart', c, 'Rcpt', efface)
def qte(q):
    return saisie('Qtecomptee', q, 'Qtecomptee', 4)

def ev(t, h, a):
    return "06/15/2018 10:%02d:%06.3f;Info;GUI;laurux;test;test;1;%s;%s" % (int(t // 60), t % 60, h, a)
def scen(nom, idt, objet, desc, evts, extra=None, dataset="saisieinvt_shared/invt"):
    d = A + '/saisieinvt_' + nom
    os.makedirs(d, exist_ok=True)
    t = 4.0
    out = [ev(t, *MENU)]
    for e in evts:
        if isinstance(e, list):
            for (dt, h, a) in e:
                t += dt
                out.append(ev(t, h, a))
        else:
            t += 1.0
            out.append(ev(t, *e))
    open(d + '/scenario.log', 'w').write("\n".join(out) + "\n")
    meta = {"id": idt, "objet": objet, "classe": "SaisieInvT", "description": desc, "dataset": dataset,
            "date": "2018-06-15 10:00:00", "args": [], "societe": "01", "timeout": 20,
            "cadence": {"frappe": 50, "focus": 100, "traitement": 1000, "fenetre": 1000}}
    if extra:
        meta.update(extra)
    p = d + '/meta.json'
    if os.path.exists(p):
        old = json.load(open(p))
        if "cadence" in old:
            meta["cadence"] = old["cadence"]
    json.dump(meta, open(p, 'w'), indent=1, ensure_ascii=False)
    open(p, 'a').write("\n")
def fichier(nom, texte):
    open(A + '/saisieinvt_' + nom + '/inventaire.txt', 'w').write(texte)

scen('saisie_numero', 'SAISIEINVT-T02', 'Saisie par numéro de ligne',
     "Saisie par n° (défaut) : ligne 3 (002), qté 6, Entrée, Valider. Attendu : ligne 3 inv_qtecomptee 6, inv_comptee 1 ; passage automatique à la ligne 4 : « Ce numéro de ligne n'existe pas » (Entrée).",
     [ligne('3'), qte('6'), VALIDER, OK])
scen('saisie_code', 'SAISIEINVT-T03', 'Saisie par code, code équivalent, référence centrale',
     "Code article : 002 qté 5 Valider ; EQ3 (art_cequ de 003) qté 4 Valider ; RC1 (art_refcentrale de 001, déjà compté 12) qté 1 Valider, « déjà été saisit » bouton 1 cumuler (Entrée). Attendu : 002 = 5, 003 = 4, 001 = 13, toutes comptées. Le code-barres « *code » (Wait 0.2, REPLAYOBSERVER-A18) n'est pas joué.",
     [CA, code('002'), qte('5'), VALIDER, code('EQ3'), qte('4'), VALIDER, code('RC1'), qte('1'), VALIDER, OK])
scen('saisie_invalide', 'SAISIEINVT-T04', 'Code inconnu, article hors inventaire',
     "Code article : 999 : « Ce code n'existe pas » (Entrée) ; 004 (stocké, absent de Fiches_InvT) : « absent du fichier inventaire » (Entrée). Base inchangée.",
     [CA, code('999'), OK, code('004', 3), OK], {"compare_sql_log": "ordered"})
scen('doublon_cumul', 'SAISIEINVT-T05', 'Ressaisie : cumuler',
     "Ligne 2 (001 déjà compté 12) qté 3 Valider : « déjà été saisit » bouton 1 « 1 » cumuler (Entrée). Attendu : inv_qtecomptee 15 (l'UPDATE à 3 précède celui à 15, Valigne).",
     [ligne('2'), qte('3'), VALIDER, OK])
scen('doublon_remplace', 'SAISIEINVT-T06', 'Ressaisie : remplacer',
     "Ligne 2 (001 déjà compté 12) qté 3 Valider : « déjà été saisit » bouton 2 « 2 » remplacer (Tab, Espace). Attendu : inv_qtecomptee 3.",
     [ligne('2'), qte('3'), VALIDER] + [DEUX])
scen('quantites', 'SAISIEINVT-T10', 'Quantité décimale à virgule',
     "Ligne 3 (002, art_dec 0) qté « 2,5 » Entrée (cpoint puis Cdec), Valider ; ligne 4 inexistante (Entrée). Attendu : inv_qtecomptee de la ligne 3 selon la normalisation figée.",
     [ligne('3'), qte('2,5'), VALIDER, OK])
scen('import_ok', 'SAISIEINVT-T11', 'Import portable nominal',
     "~/Portable/inventaire.txt « 002;6 » et « 003;2,5 » (entrees) : Importer (Button3). Attendu : lignes 3 (6) et 1 (2.5) comptées ; « 2 produits ont été importés » (Entrée) ; aucun rejet (~/tmp/Inv.txt sans ligne de rejet, éditeur non ouvert).",
     [IMPORT, OK], {"entrees": {"inventaire.txt": "~/Portable/inventaire.txt"}, "fichiers": ["tmp/Inv.txt", "@ouvrir.trace"]})
fichier('import_ok', "002;6\n003;2,5\n")
scen('import_rejets', 'SAISIEINVT-T12', 'Import avec rejets et quantité vide',
     "~/Portable/inventaire.txt : « 002; » (quantité vide, cle <> 0 figé A10), « 999;2 » (code inconnu), « 001;1 » (déjà compté), « sans separateur » : Importer. Attendu : rejets écrits dans ~/tmp/Inv.txt, éditeur ouvert (Editeur.Prog_Editeur), message de fin (Entrée).",
     [IMPORT, OK], {"entrees": {"inventaire.txt": "~/Portable/inventaire.txt"}, "fichiers": ["tmp/Inv.txt", "@ouvrir.trace"]})
fichier('import_rejets', "002;\n999;2\n001;1\nsans separateur\n")
scen('import_absent', 'SAISIEINVT-T13', 'Import, fichier absent',
     "Pas de ~/Portable/inventaire.txt : Importer. Erreur non gérée (Eof sur un fichier non ouvert, SAISIEINVT-A09 figée).",
     [IMPORT], {"fichiers": ["tmp/Inv.txt"], "code_sortie": 125,
                "xfail": "erreur non gérée : Eof(hFil) sur le fichier non ouvert (Try Open, Import_Portable), boîte d'erreur Gambas fatale",
                "xfail_attendu": "message « fichier absent », aucune mise à jour (A09)"})
scen('sans_inventaire', 'SAISIEINVT-T14', 'Sans inventaire tournant',
     "Jeu validinvt_shared/invt_absent (pas de Fiches_InvT) : ouverture : « Il n'existe aucun inventaire » (Entrée) puis fermeture (Me.Close dans _New).",
     [OK], {"compare_sql_log": "ordered"}, dataset="validinvt_shared/invt_absent")

# SAISIEINVT-T15 : article supprimé après génération (jeux dérivés de invt.sql).
base = open(S + '/invt.sql').read()
open(S + '/invt_sans_001.sql', 'w').write(base.replace("-- Jeu SAISIEINVT :", "-- Jeu SAISIEINVT-T15 (001, ligne 2 comptée, supprimé de Fiches_Art après génération) :", 1)
                                          + "DELETE FROM Fiches_Art WHERE art_code = '001';\n")
open(S + '/invt_sans_002.sql', 'w').write(base.replace("-- Jeu SAISIEINVT :", "-- Jeu SAISIEINVT-T15 (002, ligne 3 non comptée, supprimé de Fiches_Art après génération) :", 1)
                                          + "DELETE FROM Fiches_Art WHERE art_code = '002';\n")
scen('art_supprime_ouverture', 'SAISIEINVT-T15', 'Article compté supprimé après génération',
     "Jeu invt_sans_001 : ouverture ; Saisie_Inv lit Fiches_Art sans Available pour la ligne comptée 2 (SAISIEINVT-A04 figée, SaisieInvT.class:74) : erreur relevée (code de sortie figé).",
     [], {"compare_sql_log": "ordered", "code_sortie": 125,
          "xfail": "erreur fatale « Result is not available » (SaisieinvT.Saisie_Inv.73 depuis _New), boîte d'erreur Gambas",
          "xfail_attendu": "ligne affichée sans désignation ou message, écran utilisable (A04)"}, dataset="saisieinvt_shared/invt_sans_001")
scen('art_supprime_ligne', 'SAISIEINVT-T15', 'Saisie d\'une ligne dont l\'article est supprimé',
     "Jeu invt_sans_002 : saisie de la ligne 3 (002 supprimé) : Nseq_LostFocus lit Fiches_Art sans Available (SAISIEINVT-A04 figée, SaisieInvT.class:179) : erreur relevée (code de sortie figé).",
     [ligne('3')], {"compare_sql_log": "ordered", "code_sortie": 125,
                    "xfail": "erreur fatale « Result is not available » (SaisieinvT.Nseq_LostFocus.179 depuis Rcpt_KeyPress), boîte d'erreur Gambas",
                    "xfail_attendu": "message « article absent », aucune mise à jour (A04)"}, dataset="saisieinvt_shared/invt_sans_002")

# SAISIEINVT-T10 (suite) : art_dec 2 (002) et 3 (003).
open(S + '/invt_dec.sql', 'w').write(base.replace("-- Jeu SAISIEINVT :", "-- Jeu SAISIEINVT-T10 (art_dec 2 pour 002, 3 pour 003) :", 1)
                                     + "UPDATE Fiches_Art SET art_dec = '2' WHERE art_code = '002';\nUPDATE Fiches_Art SET art_dec = '3' WHERE art_code = '003';\n")
scen('quantites_dec', 'SAISIEINVT-T10', 'Quantités selon art_dec 2 et 3',
     "Jeu invt_dec : ligne 1 (003, art_dec 3) qté « 1.2345 » Valider (passage auto ligne 2) ; ligne 3 (002, art_dec 2) qté « 2,555 » Valider, ligne 4 inexistante (Entrée). Attendu : quantités normalisées par Cdec (figées).",
     [ligne('1'), qte('1.2345'), VALIDER, ligne('3'), qte('2,555'), VALIDER, OK], dataset="saisieinvt_shared/invt_dec")
