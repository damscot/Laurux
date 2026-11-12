-- Jeu de données TypeClient (TYPECLIENT-T01, T02), appliqué après Laurux01.sql (types 01, 02, 03) :
-- un quatrième type dont le code contient une apostrophe.
INSERT INTO Fiches_Typec (code, libelle) VALUES ('A''', 'Code apostrophe');
