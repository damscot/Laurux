-- Jeu de données IMPCLIENT-T06 : plus de compte collectif client 41* (411000 n'est plus collectif) ;
-- seul 401000 reste collectif.
UPDATE Fiches_Comptes SET coll = 0 WHERE compte_cc = 411000;
