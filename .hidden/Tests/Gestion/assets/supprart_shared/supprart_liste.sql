-- Jeu SUPPRART : liste Artsup existante (article 001).
CREATE TABLE Artsup (art_code Char(15) NOT NULL, art_design Char(50), PRIMARY KEY (art_code)) ENGINE = InnoDB;
INSERT INTO Artsup (art_code, art_design) VALUES ('001', 'Produit 2.10');
