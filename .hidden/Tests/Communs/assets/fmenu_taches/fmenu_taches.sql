-- FMENU-T06 : tâches de l'utilisateur courant (« laurux » dans le conteneur de test) et d'un autre utilisateur ;
-- /Soc01/Taches activée par les préférences globales (Fiches_Parametres.conf).
INSERT INTO Fiches_Taches (lind, numdoc, nom, poste, numcli, nomcli, texte) VALUES
 (1, 'F0001', 'laurux', 'poste1', '411001', 'Client 1', 'Relancer le client'),
 (2, 'F0002', 'laurux', 'poste1', '411002', 'Client 2', 'Envoyer le devis'),
 (3, 'F0003', 'laurux', 'poste2', '411001', 'Client 1', 'Livrer la commande'),
 (4, 'F0004', 'autre', 'poste3', '411002', 'Client 2', 'Tache d un autre utilisateur');
UPDATE Fiches_Parametres SET conf = '[Soc01]\nTaches=-1\n';
