DECLARE
    v_masse NUMBER;
    v_stern VARCHAR2(10);
BEGIN
    v_stern := 'Wega';
    SELECT Masse INTO v_masse FROM Z WHERE Stern = v_stern;

    IF MOD(v_masse, 2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Die Masse von ' || v_stern || ' (' || v_masse || ' Sonnenmassen) ist eine gerade Zahl.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Die Masse von ' || v_stern || ' (' || v_masse || ' Sonnenmassen) ist eine ungerade Zahl.');
    END IF;
END;
/

-- ==================================================
-- Aufgabe: WeekdayFromNumber
-- Tabelle Y (NUM, BEZEICHNUNG): Wochentag in BEZEICHNUNG schreiben
-- ==================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Y';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
CREATE TABLE Y
(
    Num         INTEGER,
    Bezeichnung VARCHAR2(20)
);

INSERT INTO Y (Num) VALUES (1);
INSERT INTO Y (Num) VALUES (2);
INSERT INTO Y (Num) VALUES (3);
INSERT INTO Y (Num) VALUES (4);
INSERT INTO Y (Num) VALUES (5);
INSERT INTO Y (Num) VALUES (6);
INSERT INTO Y (Num) VALUES (7);
INSERT INTO Y (Num) VALUES (0);
INSERT INTO Y (Num) VALUES (42);
COMMIT;

CREATE OR REPLACE FUNCTION WeekdayFromNumber(param INTEGER) RETURN VARCHAR2
IS
    x VARCHAR2(20);
BEGIN
    CASE param
        WHEN 1 THEN x := 'Montag';
        WHEN 2 THEN x := 'Dienstag';
        WHEN 3 THEN x := 'Mittwoch';
        WHEN 4 THEN x := 'Donnerstag';
        WHEN 5 THEN x := 'Freitag';
        WHEN 6 THEN x := 'Samstag';
        WHEN 7 THEN x := 'Sonntag';
        ELSE x := 'Unbekannte Zahl';
    END CASE;
    RETURN x;
END;
/

-- Test
SELECT WeekdayFromNumber(4) FROM dual;
SELECT Num, WeekdayFromNumber(Num) FROM Y;

-- Bezeichnung in Tabelle Y setzen
UPDATE Y SET Bezeichnung = WeekdayFromNumber(Num);
COMMIT;

SELECT * FROM Y;

-- ==================================================
-- Beispiel: Heutigen Wochentag per PL/SQL-Block ausgeben
-- ==================================================
DECLARE
    v_tag_nr INTEGER;
    v_name   VARCHAR2(20);
BEGIN
    -- TO_CHAR mit 'D' liefert Tagesnummer (1=Montag bei NLS_TERRITORY=GERMANY)
    v_tag_nr := TO_NUMBER(TO_CHAR(SYSDATE, 'D'));
    v_name   := WeekdayFromNumber(v_tag_nr);
    DBMS_OUTPUT.PUT_LINE('Heute ist ' || v_name || ' (Tag-Nr: ' || v_tag_nr || ')');
END;
/