# Générateur du jeu mvtdepots_shared/stock.sql et des scénarios mvtdepots_* (MVTDEPOTS-T01, T02, T04 à T06).
# Usage : python3 gen_mvtdepots.py (conserve la cadence des meta.json existants), puis runner retime (scénarios
# neufs), runner harness apply, runner replay --expected.
import json, os
A = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # .hidden/Tests/Gestion/assets
S = A + '/mvtdepots_shared'
os.makedirs(S, exist_ok=True)
open(S + '/stock.sql', 'w').write(
    "-- Jeu MVTDEPOTS : article 001 stocké (stock magasin 10), dépôt 02 avec 5 de 001, dépôt 03 « Depot 2 » sans stock.\n"
    "UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10 WHERE art_code = '001';\n"
    "INSERT INTO Fiches_Depots VALUES ('03','Depot 2','','','','');\n"
    "INSERT INTO Fiches_StkDepots (coded, codea, qte) VALUES ('02','001',5);\n")

ENTREE, BS, SUPPR = "16777220", "16777219", "16777223"
MENU = ("Fmenu.Menu269_Click", "Click=True@Menu269#Fmenu#Menu66#Menu77#Menu267#Menu269#")
OK = ("FMessage.FMessage_KeyPress", "Keypress=%s@FMessage#FMessage#" % ENTREE)
VALIDER = ("MvtDepots.Button3_Click", "Click=True@Button3#MvtDepots#Frame3#Button3#")

def saisie(champ, cadre, texte, gest, efface=0):
    p = "%s#MvtDepots#%s#%s#" % (champ, cadre, champ)
    out = [(1.0, "MvtDepots.%s_GotFocus" % ('Code' if gest == 'Code' else 'Dep'), "Focus=@" + p)]
    for k in [SUPPR] * efface + [BS] * efface + list(texte) + [ENTREE]:
        out.append((0.05 if len(out) > 1 else 0.1, "MvtDepots.%s_KeyPress" % gest, "Keypress=%s@%s" % (k, p)))
    return out
def depart(c):
    return saisie('Code', 'Frame1', c, 'Code')
def arrivee(c):
    return saisie('Code2', 'Frame1', c, 'Code2')
def article(c):
    return saisie('Cart', 'Frame3', c, 'Dep')
def qte(q):
    return saisie('Qte', 'Frame3', q, 'Dep', 1)

def ev(t, h, a):
    return "06/15/2018 10:%02d:%06.3f;Info;GUI;laurux;test;test;1;%s;%s" % (int(t // 60), t % 60, h, a)
def scen(nom, idt, objet, desc, evts, extra=None):
    d = A + '/mvtdepots_' + nom
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
    meta = {"id": idt, "objet": objet, "classe": "MvtDepots", "description": desc, "dataset": "mvtdepots_shared/stock",
            "date": "2018-06-15 10:00:00", "args": [], "societe": "01", "timeout": 20, "conf": {"/Soc01/Depots": "-1"},
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

scen('magasin_vers_depot', 'MVTDEPOTS-T01', 'Transfert magasin vers dépôt',
     "Départ 01, arrivée 02, article 001, qté 2, Valider. Attendu : art_qte 10 -> 8 ; StkDepots 02 : 5 -> 7 ; ligne (01, 001, -2) créée ; 2 lignes Sdepots (S 01, E 02) « Mvt du dépôt 01 vers dépôt 02 ».",
     [depart('01'), arrivee('02'), article('001'), qte('2'), VALIDER])
scen('depot_vers_magasin', 'MVTDEPOTS-T02', 'Transfert dépôt vers magasin',
     "Départ 02 (stock 5 de 001), arrivée 01, article 001 (recherche par db.Exec), qté 2, Valider. Attendu : art_qte 10 -> 12 ; ligne (01, 001, 2) créée ; ligne de stock 02 supprimée après mise à jour (MVTDEPOTS-A01 figée) ; 2 lignes Sdepots.",
     [depart('02'), arrivee('01'), article('001'), qte('2'), VALIDER])
scen('article_inconnu', 'MVTDEPOTS-T04', 'Article introuvable',
     "Départ 01, arrivée 02, article 999 : « Cette réfèrence n'existe pas » (Entrée) ; qté 2, Valider. Attendu : transfert exécuté quand même (MVTDEPOTS-A04 figée) : lignes StkDepots (02, 999, 2) et (01, 999, -2), 2 lignes Sdepots ; Fiches_Art inchangée.",
     [depart('01'), arrivee('02'), article('999'), OK, qte('2'), VALIDER])
scen('code_barres', 'MVTDEPOTS-T05', 'Code-barres au magasin',
     "Départ 01, arrivée 02, code-barres 2148413200001 de l'article 001 : la recherche par code-barres n'est jamais atteinte (MVTDEPOTS-A03 figée) : « Cette réfèrence n'existe pas » (Entrée). Base inchangée.",
     [depart('01'), arrivee('02'), article('2148413200001'), OK], {"compare_sql_log": "ordered"})
scen('cumul', 'MVTDEPOTS-T06', 'Doublon dans la saisie, cumul',
     "Départ 01, arrivée 02 : 001 qté 2 Valider, puis 001 qté 3 Valider, « déjà été saisit » bouton 1 « 1 » Cumuler (Entrée, MvtDepots.class Maj_Colrcp). Attendu : mouvements des deux saisies en base (art_qte 10 -> 5, StkDepots 02 : 10, ligne 01 : -5, 4 lignes Sdepots).",
     [depart('01'), arrivee('02'), article('001'), qte('2'), VALIDER, article('001'), qte('3'), VALIDER, OK])
