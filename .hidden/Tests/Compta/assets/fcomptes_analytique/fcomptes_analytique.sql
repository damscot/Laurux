-- Jeu de données FComptes T07 (agent 5, phase 2) : postes analytiques et option /Soc01/Analytique (blob conf global).
INSERT INTO Fiches_Postes (code,intitulep) VALUES ('01','Atelier'),('02','Magasin');
UPDATE Fiches_Parametres SET conf = '[Soc01]\nAnalytique=True\n';
