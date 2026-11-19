import json, sys, os
from datetime import datetime, timedelta
A = "/home/damscot/.cache/laurux-sandbox/sb10/rework/.hidden/Tests/Caisse/assets"
C = {"frappe": 50, "focus": 100, "traitement": 1000, "fenetre": 1000}
B2 = "Click=True@Button2#Cmenu#HBox1#Frame1#VBox2#Button2#"
ENT = "Keypress=16777220@FMessage#FMessage#"
TAB = "Keypress=16777217@FMessage#FMessage#"
SP = "Keypress= @FMessage#FMessage#"
def lab(n): return f"Click=True@{n}#Cmenu#HBox1#Frame1#{n}#"
MDPF = "Focus=@Mdp#Cmenu#HBox1#Frame1#VBox2#Frame8#Mdp#"
def mdp(t): return [f"Keypress={c}@Mdp#Cmenu#HBox1#Frame1#VBox2#Frame8#Mdp#" for c in t] + ["Keypress=16777220@Mdp#Cmenu#HBox1#Frame1#VBox2#Frame8#Mdp#"]
def ev(e):
    w = e.split("@")[1].split("#")[1]
    return f"{w}.x;{e}"
S = {
 "cmenu_deconnexion_oui": dict(id="CMENU-T07", objet="Déconnexion acceptée",
   description="Mode PDV, jeu caisse_connectee (caisse 1 connectée par le vendeur 1, verrou ~/Caisse1.lock déposé), Ncai = \"1;1 \" : Quitter (Button2), « Oui » (Entrée), Message.Info (Entrée) : connecte = 0, vdr_code = '', dtefm renseigné, verrou supprimé, Ncai vide.",
   dataset="cmenu_shared/caisse_connectee", conf={"/Soc01/caisse/Ncai": "1;1 "}, entrees={"cmenu_shared/Caisse1.lock": "~/Caisse1.lock"},
   fichiers=["@Laurux.conf", "Caisse1.lock"], events=[B2, ENT, ENT]),
 "cmenu_deconnexion_non": dict(id="CMENU-T08", objet="Déconnexion refusée",
   description="Mode PDV, jeu caisse_connectee, verrou ~/Caisse1.lock, Ncai = \"1;1 \" : Quitter (Button2), « Non » (Tab puis Espace) : Stop Event, fenêtre maintenue, base, verrou et Ncai inchangés. Fermeture sans caisse connectée : CMENU-T05 (Ncai vide, aucune question).",
   dataset="cmenu_shared/caisse_connectee", conf={"/Soc01/caisse/Ncai": "1;1 "}, entrees={"cmenu_shared/Caisse1.lock": "~/Caisse1.lock"},
   fichiers=["@Laurux.conf", "Caisse1.lock"], events=[B2, TAB, SP]),
 "cmenu_caisse_ecole": dict(id="CMENU-T09", objet="Déconnexion d'une caisse école",
   description="Mode PDV, jeu caisse_base (caisse 3 école connectée), verrou ~/Caisse3.lock, Ncai = \"3;1 \" : Quitter, « Oui », « Oui » (init_ecole), Message.Warning « TODO pb avec les caisses ecoles » (Entrée) : Quit 1 figé (code de sortie 1, tkz = 1, fndc = 0, connecte = 0, verrou conservé, Ncai conservé ; A04).",
   dataset="cmenu_shared/caisse_base", conf={"/Soc01/caisse/Ncai": "3;1 "}, entrees={"cmenu_shared/Caisse3.lock": "~/Caisse3.lock"},
   fichiers=["Caisse3.lock"], code_sortie=1, events=[B2, ENT, ENT, ENT]),
 "cmenu_caisse_ecole_non": dict(id="CMENU-T09", objet="Déconnexion d'une caisse école, variante « Non »",
   description="Mode PDV, jeu caisse_base, verrou ~/Caisse3.lock, Ncai = \"3;1 \" : Quitter, « Oui » (déconnexion), « Non » (Tab puis Espace) sur la question de la caisse école : Efface = 0, aucune écriture, verrou et Ncai conservés (A04).",
   dataset="cmenu_shared/caisse_base", conf={"/Soc01/caisse/Ncai": "3;1 "}, entrees={"cmenu_shared/Caisse3.lock": "~/Caisse3.lock"},
   fichiers=["@Laurux.conf", "Caisse3.lock"], events=[B2, ENT, TAB, SP]),
 "cmenu_admin_protege": dict(id="CMENU-T10", objet="Accès administrateur protégé (Préférences)",
   description="Mode PDV, jeu caisse_base, admin2 = -1 : clic sur le libellé « Alt + P » (Label2, Alt+P n'est pas rejouable), mot de passe faux « zz » + Entrée : Message.Error (Entrée) ; mot de passe de CHLOE « c234 » + Entrée : Preferences (ShowModal) ouvert, laissé ouvert (REPLAYOBSERVER-A15).",
   dataset="cmenu_shared/caisse_base", conf={"/Soc01/caisse/admin2": -1}, compare_sql_log="ordered",
   events=[lab("Label2"), MDPF] + mdp("zz") + [ENT, MDPF] + ["Keypress=16777219@Mdp#Cmenu#HBox1#Frame1#VBox2#Frame8#Mdp#"]*2 + mdp("c234")),
 "cmenu_admin_protege_log": dict(id="CMENU-T10", objet="Accès administrateur protégé (debug Log)",
   description="Mode PDV, jeu caisse_base, admin2 = -1 : clic sur le libellé « Alt + L » (Label4), mot de passe « c234 » + Entrée : Preferences (ShowModal) ouvert au lieu de DB_Log (A03 figée), laissé ouvert (REPLAYOBSERVER-A15).",
   dataset="cmenu_shared/caisse_base", conf={"/Soc01/caisse/admin2": -1}, compare_sql_log="ordered",
   events=[lab("Label4"), MDPF] + mdp("c234")),
 "cmenu_admin_libre": dict(id="CMENU-T11", objet="Accès administrateur libre",
   description="Mode PDV, jeu caisse_base, admin2 = 0 : libellé « Alt + L » (Label4) : DB_Log ouvert (Show) sans mot de passe. Le libellé « Alt + P » est joué par cmenu_admin_libre_pref (DB_Log devient la fenêtre active : Cmenu n'est plus rejouable ensuite).",
   dataset="cmenu_shared/caisse_base", conf={"/Soc01/caisse/admin2": 0}, compare_sql_log="ordered",
   events=[lab("Label4")]),
 "cmenu_admin_libre_pref": dict(id="CMENU-T11", objet="Accès administrateur libre (Préférences)",
   description="Mode PDV, jeu caisse_base, admin2 = 0 : libellé « Alt + P » (Label2) : Preferences (ShowModal) ouvert sans mot de passe, laissé ouvert (REPLAYOBSERVER-A15).",
   dataset="cmenu_shared/caisse_base", conf={"/Soc01/caisse/admin2": 0}, compare_sql_log="ordered",
   events=[lab("Label2")]),
 "cmenu_admin_sans_admin": dict(id="CMENU-T11", objet="Mot de passe administrateur, aucun administrateur",
   description="Mode PDV, base Laurux01 (aucun vendeur), admin2 = -1 : libellé « Alt + P » (Label2), mot de passe « zz » + Entrée : Message.Warning « Aucun administrateur… » (Entrée), cadre masqué.",
   dataset="", conf={"/Soc01/caisse/admin2": -1}, compare_sql_log="ordered",
   events=[lab("Label2"), MDPF] + mdp("zz") + [ENT]),
 "cmenu_attribution_touches": dict(id="CMENU-T13", objet="Attribution des touches sans caisse connectée",
   description="Mode PDV, base Laurux01, Ncai absent (Start.$tcai nul) : libellé « CTRL + F12 » (Label3 → ControleCai ; F12 n'est pas rejouable) : Message.Warning « Veuillez connecter la caisse… » (Entrée).",
   dataset="", compare_sql_log="ordered", events=[lab("Label3"), ENT]),
 "cmenu_attribution_touches_ok": dict(id="CMENU-T13", objet="Attribution des touches, caisse connectée",
   description="Mode PDV, jeu caisse_connectee, Ncai = \"1;1 \", choixtouches = -1 (Start.$tcai = \"1\") : libellé « CTRL + F12 » (Label3) : Attrib (ShowModal) ouvert, laissé ouvert (REPLAYOBSERVER-A15).",
   dataset="cmenu_shared/caisse_connectee", conf={"/Soc01/caisse/Ncai": "1;1 ", "/Soc01/caisse/choixtouches": -1},
   entrees={"cmenu_shared/Caisse1.lock": "~/Caisse1.lock"}, compare_sql_log="ordered", events=[lab("Label3")]),
 "cmenu_connexion_sans_caisse": dict(id="CMENU-T03", objet="« Connexion caisse » refusée, aucune caisse",
   description="Mode PDV, base Laurux01 (aucune caisse pour le poste) : « Connexion caisse » (Button1) : Message.Warning « Il faut d'abord créer vos caisses… » (Entrée), Ouverture non ouverte. sql.log non comparé : la requête contient System.Host, nom aléatoire du conteneur.",
   dataset="", events=["Click=True@Button1#Cmenu#HBox1#Frame1#VBox2#Button1#", ENT]),
 "cmenu_ouverture_pos": dict(id="CMENU-T01", objet="Ouverture en mode -p (MySQL)",
   description="Mode PDV, jeu caisse_base : Cmenu ouvert (seul SQL : ALTER DATABASE, SET NAMES, SELECT société ; dump inchangé) ; seul événement : libellé « CTRL + F1 = Documentation » (Label1 → Doc.Open, xdg-open factice tracé dans @outils.trace).",
   dataset="cmenu_shared/caisse_base", compare_sql_log="ordered", fichiers=["@outils.trace"], events=[lab("Label1")]),
 "cmenu_depuis_fmenu": dict(id="CMENU-T12", objet="Ouverture depuis Fmenu (Menu332)",
   description="Mode Gestion, jeu caisse_base (caisse activée) : Caisse › Menu332 : Cmenu ouvert (SET NAMES, société). Le second appel (« Une interface de caisse est déjà ouverte! ») n'est pas rejouable : Cmenu devient la fenêtre active, Fmenu n'accepte plus d'événement. Le titre de la fenêtre Gestion (A01) n'est pas comparé.",
   dataset="cmenu_shared/caisse_base", args=[], compare_sql_log="ordered",
   events=["Click=True@Menu332#Fmenu#Menu203#Menu332#"]),
}
only = sys.argv[1:]
for nom, s in S.items():
    if only and nom not in only: continue
    d = os.path.join(A, nom); os.makedirs(d, exist_ok=True)
    m = {"id": s["id"], "objet": s["objet"], "classe": "Cmenu", "description": s["description"], "dataset": s["dataset"],
         "date": "2018-06-15 10:00:00", "args": s.get("args", ["-p"]), "societe": "01", "timeout": 20}
    for k in ("conf", "entrees", "fichiers", "code_sortie", "compare_sql_log"):
        if k in s: m[k] = s[k]
    m["cadence"] = C
    open(os.path.join(d, "meta.json"), "w").write(json.dumps(m, indent=1, ensure_ascii=False) + "\n")
    t = datetime(2018, 6, 15, 10, 0, 4); L = []
    for e in s["events"]:
        L.append(t.strftime("%m/%d/%Y %H:%M:%S.") + f"{t.microsecond//1000:03d};Info;GUI;laurux;test;test;1;{ev(e)}")
        t += timedelta(seconds=1)
    open(os.path.join(d, "scenario.log"), "w").write("\n".join(L) + "\n")
    print(nom)
