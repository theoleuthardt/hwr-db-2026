/*
    Autor:   Theo Leuthardt
*/

/* ********* Beispiel einer einfachen DB ************* */

drop table Z;
create table Z
(
    Stern VARCHAR2(16),
    Masse INTEGER
);

select * from Z;

insert into Z values ('Sirius',      2);
insert into Z values ('Sonne',       1);
insert into Z values ('Aldebaran',   1);
insert into Z values ('Algol',       4);
insert into Z values ('Mizar',       4);
insert into Z values ('Wega',        2);
insert into Z values ('Lenok',       7);
insert into Z values ('Antares',    12);
insert into Z values ('Rigel',      17);
insert into Z values ('Betelgeuse', 19);
insert into Z values ('WR 102ka',  175);
insert into Z values ('Altair',      2);

commit;

select Stern, Masse from Z order by Masse, Stern;

/*
    Projekt Taxi
	beide Varianten abarbeiten
*/

DELETE FROM Firma;
DELETE FROM Auto;
INSERT INTO Firma VALUES ('Maxi-Taxi', 350, 'DE1234');
INSERT INTO Firma VALUES ('Luxi-Taxi', 90, 'DE2345');
INSERT INTO Firma VALUES ('Fixi-Taxi', 120, 'FR1234');
INSERT INTO Auto VALUES ('BAZ-1718', 'VW', 2011);
INSERT INTO Auto VALUES ('BMP-1718', 'Skoda', 2015);
INSERT INTO Auto VALUES ('BKA-4253', 'Mercedes', 2000);
INSERT INTO Auto VALUES ('BAZ-9876', 'BMW', 2011);
INSERT INTO Auto VALUES ('BAZ-6789', 'VW', 2011);

DROP TABLE betreibt;
CREATE TABLE betreibt
(
FName VARCHAR2(10), /* Spalten können dieselben Namen haben */
KFZZeichen VARCHAR2(10) /* wie in ursprünglichen Tabellen */
);

commit;



select KFZZeichen, Modell, Baujahr
from Auto
where Baujahr >= 2013 --  filter-Predikat
;

/* Alle Firmen und dazu gehörige Autos auflisten */
select f.FNAME Firma, f.AnzahlMA Anzahl, a.KFZZEICHEN KFZ, a.Modell Modell, a.Baujahr BJ
from Firma f, Auto a
where f.FNAME = a.FNAME --  access-Predikat
order by 5;

/* Alle VW-Autos anzeigen */
select a.KFZZEICHEN, a.Baujahr
from Auto a
where a.Modell = 'VW'
;

/* Alle VW-Autos der Frima Maxi-Taxi anzeigen */
select f.FNAME, a.KFZZEICHEN, a.Baujahr
from Auto a, Firma f
where a.FNAME = f.FNAME AND a.Modell = 'VW' and f.FNAME = 'Maxi-Taxi'
;  -- access-Predikat     filter-Predikat     filter-Predikat

/*
    Relationale Darstellung der Entität "Patient"
    PK = PatID ist zu unterstreichen !
    
    Patient = { [ Name:Text, Krankheit:Text, PatID:Integer ] }

    Relationale Darstellung der Relation (Beziehung) "betreut"
    PK = PatID PersID ist zu unterstreichen !
    
    betreut = { [ PatID:Integer, PersID:Integer, Datum:Date, Uhrzeit:Time ] }
*/

/* Uni-DB */
select *
from PROFESSOREN p, ASSISTENTEN a
where p.PERSNR=a.BOSS;