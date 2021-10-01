
BEGIN
DECLARE tip int;
SELECT id_pretplate INTO tip FROM korisnik WHERE korisnik.korisnicko_ime=NEW.korisnicko_ime;

IF tip=1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Besplatni korisnik ne moze kreirati playlistu.';
END IF;
END


CREATE DEFINER=`root`@`localhost` TRIGGER `provjera` 
BEFORE INSERT ON `playlista` 
FOR EACH ROW 
BEGIN
	DECLARE tip int; 
	SELECT id_pretplate INTO tip FROM korisnik WHERE korisnik.korisnicko_ime=NEW.korisnicko_ime;
	IF tip=1 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Besplatni korisnik ne moze kreirati playlistu.';
	END IF;
END;


----------------------------------------


CREATE TRIGGER `provjera pracenja` BEFORE INSERT ON `pratitelji`
FOR EACH ROW BEGIN
IF new.korisnicko_ime_pratitelja=new.korisnicko_ime_pracenika THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Korisnik ne moze pratiti sam sebe.';
END IF;
END


----------------------------------------

BEGIN
DECLARE broj_zanrova SMALLINT;
select count(*) INTO broj_zanrova from pjesma_zanr where pjesma_zanr.id_pjesme=NEW.id_pjesme;
IF broj_zanrova>3 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pjesma ne moze pripadati u vise od 3 zanra.';
END IF;
END

---------------------------------------

BEGIN
DECLARE vremena time;
SELECT sum(duljina) INTO vremena from pjesma,pjesma_playlista,playlista WHERE pjesma.id_pjesme=pjesma_playlista.id_pjesme AND playlista.id_playliste=pjesma_playlista.id_playliste AND pjesma_playlista.id_playliste=NEW.id_playliste;
UPDATE playlista SET trajanje=vremena WHERE playlista.id_playliste=NEW.id_playliste;
END