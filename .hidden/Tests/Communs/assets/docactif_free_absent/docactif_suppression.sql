-- DocActif (DOCACTIF-T09) : déclencheur sur Fiches_Parametres (UPdate fait par Parametre.Button2_Click à la
-- fermeture, avant Free_Lock) qui, une seule fois par connexion (@docactif_fait), supprime le verrou Parametres/0 (verrou absent au moment de Free_Lock).
-- Simule ainsi, avec l'identité réelle du conteneur, un verrou du même poste pris par un autre process.
DELIMITER //
CREATE TRIGGER test_docactif_suppression AFTER UPDATE ON Fiches_Parametres FOR EACH ROW
BEGIN
  IF @docactif_fait IS NULL THEN
    SET @docactif_fait = 1;
    DELETE FROM Fiches_Docactif WHERE doc_type = 'Parametres' AND doc_num = '0';
  END IF;
END//
DELIMITER ;
