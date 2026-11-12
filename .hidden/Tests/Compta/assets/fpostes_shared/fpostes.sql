-- FPostes (FPOSTES-T02, T03) : postes A01 et B02, le poste B02 est utilisé par une répartition analytique.
INSERT INTO Fiches_Postes (code, intitulep) VALUES ('A01', 'Atelier'), ('B02', 'Bureau');
INSERT INTO Fiches_Analytiques (code, compte, pourcent) VALUES ('B02', '602100', 100);
