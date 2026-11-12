-- Jeu de données EPURFOUR-T01 : références fournisseur renseignées (art_cfour vide dans Laurux01.sql).
UPDATE Fiches_Art SET art_cfour = CONCAT('REF-', art_code);
