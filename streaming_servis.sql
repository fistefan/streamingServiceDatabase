-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2019 at 09:32 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `streaming_servis`
--

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

CREATE TABLE `album` (
  `id_albuma` int(11) NOT NULL,
  `naziv_albuma` varchar(100) DEFAULT NULL,
  `datum_izdavanja` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `album`
--

INSERT INTO `album` (`id_albuma`, `naziv_albuma`, `datum_izdavanja`) VALUES
(1, 'Album1', '2019-01-16 00:00:00'),
(2, 'Album2', '2018-12-27 00:00:00'),
(3, 'Album3', '2019-01-15 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `izvodac`
--

CREATE TABLE `izvodac` (
  `id_izvodaca` int(11) NOT NULL,
  `naziv_izvodaca` varchar(50) NOT NULL,
  `datum` date DEFAULT NULL,
  `drzava` varchar(60) DEFAULT NULL,
  `opis` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `izvodac`
--

INSERT INTO `izvodac` (`id_izvodaca`, `naziv_izvodaca`, `datum`, `drzava`, `opis`) VALUES
(1, 'Izvodac1', '2019-01-02', 'Drzava1', 'Opis1'),
(2, 'Izvodac 2', '2018-11-07', 'Drzava2', 'Opis2');

-- --------------------------------------------------------

--
-- Table structure for table `korisnik`
--

CREATE TABLE `korisnik` (
  `korisnicko_ime` varchar(20) NOT NULL,
  `email` varchar(200) NOT NULL,
  `lozinka` varchar(50) NOT NULL,
  `ime` varchar(50) NOT NULL,
  `prezime` varchar(50) DEFAULT NULL,
  `dob` smallint(6) NOT NULL,
  `datum_registracije` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_pretplate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `korisnik`
--

INSERT INTO `korisnik` (`korisnicko_ime`, `email`, `lozinka`, `ime`, `prezime`, `dob`, `datum_registracije`, `id_pretplate`) VALUES
('korisnik1', 'korisnik1@gmail.com', 'korisnik1', 'Ime1', 'Prezime1', 25, '2019-01-12 22:41:59', 2),
('korisnik2', 'korisnik2@gmail.com', 'korisnik2', 'Ime2', 'Prezime2', 29, '2019-01-13 13:35:27', 1),
('korisnik3', 'korisnik3@gmail.com', 'korisnik3', 'Kor3', 'Kor3', 27, '2019-01-13 13:36:07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pjesma`
--

CREATE TABLE `pjesma` (
  `id_pjesme` int(11) NOT NULL,
  `naziv_pjesme` varchar(100) NOT NULL,
  `duljina` time NOT NULL,
  `tekst_pjesme` text,
  `id_albuma` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pjesma`
--

INSERT INTO `pjesma` (`id_pjesme`, `naziv_pjesme`, `duljina`, `tekst_pjesme`, `id_albuma`) VALUES
(1, 'Pjesma1', '00:03:35', 'Tekst1', 1),
(2, 'Pjesma2', '00:02:35', 'Tekst2', 1),
(3, 'Pjesma3', '00:04:35', 'Tekst3', 2),
(4, 'Pjesma4', '00:02:22', 'Tekst4', 1),
(5, 'Pjesma5', '00:04:23', 'Tekst5', 2),
(6, 'Pjesma6', '00:05:12', 'Tekst6', 2),
(7, 'Pjesma7', '00:03:05', 'Tekst7', 1),
(8, 'Pjesma8', '00:03:12', 'Tekst8', 1),
(9, 'Pjesma9', '00:02:55', 'Tekst9', 1),
(10, 'Pjesma10', '00:02:57', 'Tekst10', 1),
(11, 'Pjesma11', '00:03:45', 'Tekst11', 3),
(12, 'Pjesma12', '00:03:22', 'Tekst12', NULL),
(13, 'Pjesma13', '00:04:05', 'Tekst13', 2),
(14, 'Pjesma14', '00:04:24', 'Tekst14', 2),
(15, 'Pjesma15', '00:04:00', 'Tekst15', NULL),
(16, 'Pjesma16', '00:03:18', 'Tekst16', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pjesma_izvodac`
--

CREATE TABLE `pjesma_izvodac` (
  `id_pjesme` int(11) NOT NULL,
  `id_izvodaca` int(11) NOT NULL,
  `id_izvodaca2` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pjesma_izvodac`
--

INSERT INTO `pjesma_izvodac` (`id_pjesme`, `id_izvodaca`, `id_izvodaca2`) VALUES
(1, 1, NULL),
(2, 1, NULL),
(11, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `pjesma_playlista`
--

CREATE TABLE `pjesma_playlista` (
  `id_playliste` int(11) NOT NULL,
  `id_pjesme` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pjesma_playlista`
--

INSERT INTO `pjesma_playlista` (`id_playliste`, `id_pjesme`) VALUES
(11, 2),
(11, 4),
(11, 8),
(11, 9),
(11, 15);

--
-- Triggers `pjesma_playlista`
--
DELIMITER $$
CREATE TRIGGER `azuriranje_trajanja_playliste` AFTER INSERT ON `pjesma_playlista` FOR EACH ROW BEGIN
DECLARE vremena time;
SELECT sum(duljina) INTO vremena from pjesma,pjesma_playlista,playlista WHERE pjesma.id_pjesme=pjesma_playlista.id_pjesme AND playlista.id_playliste=pjesma_playlista.id_playliste AND pjesma_playlista.id_playliste=NEW.id_playliste;
UPDATE playlista SET trajanje=vremena WHERE playlista.id_playliste=NEW.id_playliste;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pjesma_zanr`
--

CREATE TABLE `pjesma_zanr` (
  `id_pjesme` int(11) NOT NULL,
  `id_zanra` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pjesma_zanr`
--

INSERT INTO `pjesma_zanr` (`id_pjesme`, `id_zanra`) VALUES
(1, 11),
(2, 7),
(2, 13),
(6, 11),
(7, 11),
(16, 13);

--
-- Triggers `pjesma_zanr`
--
DELIMITER $$
CREATE TRIGGER `provjera_broja_zanrova` BEFORE INSERT ON `pjesma_zanr` FOR EACH ROW BEGIN
DECLARE broj_zanrova SMALLINT;
select count(*) INTO broj_zanrova from pjesma_zanr where pjesma_zanr.id_pjesme=NEW.id_pjesme;
IF broj_zanrova>3 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pjesma ne moze pripadati u vise od 3 zanra.';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `playlista`
--

CREATE TABLE `playlista` (
  `id_playliste` int(11) NOT NULL,
  `naziv_playliste` varchar(100) NOT NULL,
  `trajanje` time DEFAULT NULL,
  `korisnicko_ime` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `playlista`
--

INSERT INTO `playlista` (`id_playliste`, `naziv_playliste`, `trajanje`, `korisnicko_ime`) VALUES
(11, 'p1', '00:14:24', 'korisnik1');

--
-- Triggers `playlista`
--
DELIMITER $$
CREATE TRIGGER `provjera_pretplate_prije_kreiranja_playliste` BEFORE INSERT ON `playlista` FOR EACH ROW BEGIN
DECLARE tip int;
SELECT id_pretplate INTO tip FROM korisnik WHERE korisnik.korisnicko_ime=NEW.korisnicko_ime;

IF tip=1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Besplatni korisnik ne moze kreirati playlistu.';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pratitelji`
--

CREATE TABLE `pratitelji` (
  `korisnicko_ime_pratitelja` varchar(20) NOT NULL,
  `korisnicko_ime_pracenika` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pratitelji`
--

INSERT INTO `pratitelji` (`korisnicko_ime_pratitelja`, `korisnicko_ime_pracenika`) VALUES
('korisnik2', 'korisnik1'),
('korisnik3', 'korisnik1'),
('korisnik1', 'korisnik2'),
('korisnik1', 'korisnik3');

--
-- Triggers `pratitelji`
--
DELIMITER $$
CREATE TRIGGER `provjera_pracenja` BEFORE INSERT ON `pratitelji` FOR EACH ROW BEGIN
IF new.korisnicko_ime_pratitelja=new.korisnicko_ime_pracenika THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Korisnik ne moze pratiti sam sebe.';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tip_pretplate`
--

CREATE TABLE `tip_pretplate` (
  `id_pretplate` int(11) NOT NULL,
  `naziv_pretplate` varchar(30) NOT NULL,
  `trajanje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tip_pretplate`
--

INSERT INTO `tip_pretplate` (`id_pretplate`, `naziv_pretplate`, `trajanje`) VALUES
(1, 'Free', 0),
(2, 'Premium', 30);

-- --------------------------------------------------------

--
-- Table structure for table `zanr`
--

CREATE TABLE `zanr` (
  `id_zanra` int(11) NOT NULL,
  `naziv_zanra` varchar(50) NOT NULL,
  `opis_zanra` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `zanr`
--

INSERT INTO `zanr` (`id_zanra`, `naziv_zanra`, `opis_zanra`) VALUES
(1, 'Afrobeat', 'Afrobeat is a music genre which involves the combination of elements of West African musical styles such as fuji music and highlife with American funk and jazz influences, with a focus on chanted vocals, complex intersecting rhythms, and percussion.'),
(2, 'Avant-garde', 'Avant-garde music is music that is considered to be at the forefront of experimentation or innovation in its field, with the term \"avant-garde\" implying a critique of existing aesthetic conventions, rejection of the status quo in favor of unique or original elements, and the idea of deliberately challenging or alienating audiences.'),
(3, 'Blues', 'Blues is a music genre and musical form which was originated in the Deep South of the United States around the 1870s by African Americans from roots in African musical traditions, African-American work songs, spirituals, and the folk music of white Americans of European heritage. Blues incorporated spirituals, work songs, field hollers, shouts, chants, and rhymed simple narrative ballads. The blues form, ubiquitous in jazz, rhythm and blues and rock and roll, is characterized by the call-and-response pattern, the blues scale and specific chord progressions, of which the twelve-bar blues is the most common. Blue notes (or \"worried notes\"), usually thirds or fifths flattened in pitch, are also an essential part of the sound. Blues shuffles or walking bass reinforce the trance-like rhythm and form a repetitive effect known as the groove. '),
(4, 'Caribbean', 'Caribbean music genres are diverse. They are each syntheses of African, European, Indian and Indigenous influences, largely created by descendants of African slaves (see Afro-Caribbean music), along with contributions from other communities (such as Indo-Caribbean music). Some of the styles to gain wide popularity outside the Caribbean include, bachata, merenque, palo, mombo, denbo, baithak gana, bouyon, cadence-lypso, calypso, chutney, chutney-soca, compas, dancehall, jing ping, parang, pichakaree, punta, ragga, reggae, reggaeton, salsa, soca, and zouk. Caribbean is also related to Central American and South American music. '),
(5, 'Country', 'Country music, also known as country and western (or simply country), and hillbilly music, is a genre of popular music that originated in the southern United States in the early 1920s. It takes its roots from genres such as folk music (especially Appalachian folk and Western music) and blues. Country music often consists of ballads and dance tunes with generally simple forms, folk lyrics, and harmonies accompanied by mostly string instruments such as banjos, electric and acoustic guitars, steel guitars (such as pedal steels and dobros), and fiddles as well as harmonicas. Blues modes have been used extensively throughout its recorded history. '),
(6, 'Electronic', 'Electronic music is music that employs electronic musical instruments, digital instruments and circuitry-based music technology. In general, a distinction can be made between sound produced using electromechanical means (electroacoustic music), and that produced using electronics only. Electromechanical instruments include mechanical elements, such as strings, hammers, and so on, and electric elements, such as magnetic pickups, power amplifiers and loudspeakers. Examples of electromechanical sound producing devices include the telharmonium, Hammond organ, and the electric guitar, which are typically made loud enough for performers and audiences to hear with an instrument amplifier and speaker cabinet. Pure electronic instruments do not have vibrating strings, hammers, or other sound-producing mechanisms. Devices such as the theremin, synthesizer, and computer can produce electronic sounds. '),
(7, 'Folk', 'Folk music includes traditional folk music and the genre that evolved from it during the 20th-century folk revival. Some types of folk music may be called world music. Traditional folk music has been defined in several ways: as music transmitted orally, music with unknown composers, or music performed by custom over a long period of time. It has been contrasted with commercial and classical styles. The term originated in the 19th century, but folk music extends beyond that. '),
(8, 'Hip hop', 'Hip hop music, also called hip-hop or rap music, is a music genre developed in the United States by inner-city African Americans in the 1970s which consists of a stylized rhythmic music that commonly accompanies rapping, a rhythmic and rhyming speech that is chanted. It developed as part of hip hop culture, a subculture defined by four key stylistic elements: MCing/rapping, DJing/scratching with turntables, break dancing, and graffiti writing. Other elements include sampling beats or bass lines from records (or synthesized beats and sounds), and rhythmic beatboxing. While often used to refer solely to rapping, \"hip hop\" more properly denotes the practice of the entire subculture. The term hip hop music is sometimes used synonymously with the term rap music, though rapping is not a required component of hip hop music; the genre may also incorporate other elements of hip hop culture, including DJing, turntablism, scratching, beatboxing, and instrumental tracks. '),
(9, 'Jazz', 'Jazz is a music genre that originated in the African-American communities of New Orleans, United States, in the late 19th and early 20th centuries, and developed from roots in blues and ragtime. Jazz is seen by many as \"America s classical music\". Since the 1920s Jazz Age, jazz has become recognized as a major form of musical expression. It then emerged in the form of independent traditional and popular musical styles, all linked by the common bonds of African-American and European-American musical parentage with a performance orientation. Jazz is characterized by swing and blue notes, call and response vocals, polyrhythms and improvisation. Jazz has roots in West African cultural and musical expression, and in African-American music traditions including blues and ragtime, as well as European military band music. Intellectuals around the world have hailed jazz as \"one of America s original art forms\". '),
(10, 'Latin', 'Latin music (Portuguese and Spanish: música latina) is a genre used by the music industry as a catch-all term for music that comes from Spanish- and Portuguese-speaking areas of the world, namely Ibero America and Iberian Peninsula, as well as music sung in either language.In the United States, the music industry defines Latin music as any recording sung mostly in Spanish regardless of its genre or the artist s nationality. The Recording Industry Association of America (RIAA) and Billboard magazine use this definition of Latin music to track sales of Spanish-language records in the US. Spain, Brazil, Mexico and the United States are the largest Latin music markets in the world.'),
(11, 'Pop', 'Pop music is a genre of popular music that originated in its modern form in the United States and United Kingdom during the mid-1950s. The terms \"popular music\" and \"pop music\" are often used interchangeably, although the former describes all music that is popular and includes many diverse styles. \"Pop\" and \"rock\" were roughly synonymous terms until the late 1960s, when they became increasingly differentiated from each other. '),
(12, 'R&B', 'Rhythm and blues, commonly abbreviated as R&B, is a genre of popular music that originated in African American communities in the 1940s. The term was originally used by record companies to describe recordings marketed predominantly to urban African Americans, at a time when \"urbane, rocking, jazz based music with a heavy, insistent beat\" was becoming more popular. In the commercial rhythm and blues music typical of the 1950s through the 1970s, the bands usually consisted of piano, one or two guitars, bass, drums, one or more saxophones, and sometimes background vocalists. R&B lyrical themes often encapsulate the African-American experience of pain and the quest for freedom and joy, as well as triumphs and failures in terms of relationships, economics, and aspirations. '),
(13, 'Rock', 'Rock music is a broad genre of popular music that originated as \"rock and roll\" in the United States in the early 1950s, and developed into a range of different styles in the 1960s and later, particularly in the United Kingdom and in the United States. It has its roots in 1940s and 1950s rock and roll, a style which drew heavily on the genres of blues, rhythm and blues, and from country music. Rock music also drew strongly on a number of other genres such as electric blues and folk, and incorporated influences from jazz, classical and other musical styles. Musically, rock has centered on the electric guitar, usually as part of a rock group with electric bass, drums, and one or more singers. Typically, rock is song-based music usually with a 4/4 time signature using a verse–chorus form, but the genre has become extremely diverse. Like pop music, lyrics often stress romantic love but also address a wide variety of other themes that are frequently social or political. ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`id_albuma`);

--
-- Indexes for table `izvodac`
--
ALTER TABLE `izvodac`
  ADD PRIMARY KEY (`id_izvodaca`);

--
-- Indexes for table `korisnik`
--
ALTER TABLE `korisnik`
  ADD PRIMARY KEY (`korisnicko_ime`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_pretplate` (`id_pretplate`);

--
-- Indexes for table `pjesma`
--
ALTER TABLE `pjesma`
  ADD PRIMARY KEY (`id_pjesme`),
  ADD KEY `id_albuma` (`id_albuma`);

--
-- Indexes for table `pjesma_izvodac`
--
ALTER TABLE `pjesma_izvodac`
  ADD PRIMARY KEY (`id_pjesme`,`id_izvodaca`),
  ADD KEY `id_izvodaca` (`id_izvodaca`),
  ADD KEY `id_izvodaca2` (`id_izvodaca2`);

--
-- Indexes for table `pjesma_playlista`
--
ALTER TABLE `pjesma_playlista`
  ADD PRIMARY KEY (`id_playliste`,`id_pjesme`),
  ADD KEY `id_pjesme` (`id_pjesme`);

--
-- Indexes for table `pjesma_zanr`
--
ALTER TABLE `pjesma_zanr`
  ADD PRIMARY KEY (`id_pjesme`,`id_zanra`),
  ADD KEY `id_zanra` (`id_zanra`);

--
-- Indexes for table `playlista`
--
ALTER TABLE `playlista`
  ADD PRIMARY KEY (`id_playliste`),
  ADD KEY `korisnicko_ime` (`korisnicko_ime`);

--
-- Indexes for table `pratitelji`
--
ALTER TABLE `pratitelji`
  ADD PRIMARY KEY (`korisnicko_ime_pracenika`,`korisnicko_ime_pratitelja`),
  ADD KEY `korisnicko_ime_pratitelja` (`korisnicko_ime_pratitelja`);

--
-- Indexes for table `tip_pretplate`
--
ALTER TABLE `tip_pretplate`
  ADD PRIMARY KEY (`id_pretplate`);

--
-- Indexes for table `zanr`
--
ALTER TABLE `zanr`
  ADD PRIMARY KEY (`id_zanra`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `album`
--
ALTER TABLE `album`
  MODIFY `id_albuma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `izvodac`
--
ALTER TABLE `izvodac`
  MODIFY `id_izvodaca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pjesma`
--
ALTER TABLE `pjesma`
  MODIFY `id_pjesme` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `playlista`
--
ALTER TABLE `playlista`
  MODIFY `id_playliste` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tip_pretplate`
--
ALTER TABLE `tip_pretplate`
  MODIFY `id_pretplate` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `zanr`
--
ALTER TABLE `zanr`
  MODIFY `id_zanra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `korisnik`
--
ALTER TABLE `korisnik`
  ADD CONSTRAINT `korisnik_ibfk_1` FOREIGN KEY (`id_pretplate`) REFERENCES `tip_pretplate` (`id_pretplate`);

--
-- Constraints for table `pjesma`
--
ALTER TABLE `pjesma`
  ADD CONSTRAINT `pjesma_ibfk_1` FOREIGN KEY (`id_albuma`) REFERENCES `album` (`id_albuma`);

--
-- Constraints for table `pjesma_izvodac`
--
ALTER TABLE `pjesma_izvodac`
  ADD CONSTRAINT `pjesma_izvodac_ibfk_1` FOREIGN KEY (`id_pjesme`) REFERENCES `pjesma` (`id_pjesme`),
  ADD CONSTRAINT `pjesma_izvodac_ibfk_2` FOREIGN KEY (`id_izvodaca`) REFERENCES `izvodac` (`id_izvodaca`),
  ADD CONSTRAINT `pjesma_izvodac_ibfk_3` FOREIGN KEY (`id_izvodaca2`) REFERENCES `izvodac` (`id_izvodaca`);

--
-- Constraints for table `pjesma_playlista`
--
ALTER TABLE `pjesma_playlista`
  ADD CONSTRAINT `pjesma_playlista_ibfk_1` FOREIGN KEY (`id_playliste`) REFERENCES `playlista` (`id_playliste`) ON DELETE CASCADE,
  ADD CONSTRAINT `pjesma_playlista_ibfk_2` FOREIGN KEY (`id_pjesme`) REFERENCES `pjesma` (`id_pjesme`);

--
-- Constraints for table `pjesma_zanr`
--
ALTER TABLE `pjesma_zanr`
  ADD CONSTRAINT `pjesma_zanr_ibfk_1` FOREIGN KEY (`id_pjesme`) REFERENCES `pjesma` (`id_pjesme`),
  ADD CONSTRAINT `pjesma_zanr_ibfk_2` FOREIGN KEY (`id_zanra`) REFERENCES `zanr` (`id_zanra`);

--
-- Constraints for table `playlista`
--
ALTER TABLE `playlista`
  ADD CONSTRAINT `playlista_ibfk_1` FOREIGN KEY (`korisnicko_ime`) REFERENCES `korisnik` (`korisnicko_ime`);

--
-- Constraints for table `pratitelji`
--
ALTER TABLE `pratitelji`
  ADD CONSTRAINT `pratitelji_ibfk_1` FOREIGN KEY (`korisnicko_ime_pratitelja`) REFERENCES `korisnik` (`korisnicko_ime`),
  ADD CONSTRAINT `pratitelji_ibfk_2` FOREIGN KEY (`korisnicko_ime_pracenika`) REFERENCES `korisnik` (`korisnicko_ime`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
