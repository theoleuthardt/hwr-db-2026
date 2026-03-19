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

-- ===================================================
-- 1x1 Tabelle ausgeben
-- ===================================================
CREATE OR REPLACE PROCEDURE einmaleins(p_max_zeile IN INTEGER, p_max_spalte IN INTEGER)
    IS
    zeile  INTEGER;
    spalte INTEGER;
BEGIN
    dbms_output.put_line('');
    zeile := 1;
    WHILE zeile <= p_max_zeile
        LOOP
            spalte := 1;
            WHILE spalte <= p_max_spalte
                LOOP
                    dbms_output.put(LPAD(zeile * spalte, 5));
                    spalte := spalte + 1;
                END LOOP;
            dbms_output.put_line('');
            zeile := zeile + 1;
        END LOOP;
END;
/

BEGIN
    einmaleins(20, 20);
END;
/

-- ===================================================
-- Zeitmessung
-- ===================================================
DECLARE
    v_start   TIMESTAMP;
    v_ende    TIMESTAMP;
    v_dauer   INTERVAL DAY TO SECOND(6);
    v_zaehler INTEGER := 1;
    v_buf     VARCHAR2(32000) := '';
BEGIN
    v_start := SYSTIMESTAMP;

    WHILE v_zaehler <= 10000
        LOOP
            v_buf := v_buf ||
                     dbms_random.string('x', 10) || '   ' ||
                     TRUNC(dbms_random.value(1, 99999)) || CHR(10);

            IF MOD(v_zaehler, 100) = 0 THEN
                dbms_output.put_line(v_buf);
                v_buf := '';
            END IF;

            v_zaehler := v_zaehler + 1;
        END LOOP;

    v_ende  := SYSTIMESTAMP;
    v_dauer := v_ende - v_start;

    dbms_output.put_line('-------------------------------');
    dbms_output.put_line('Start:  ' || TO_CHAR(v_start, 'HH24:MI:SS.FF3'));
    dbms_output.put_line('Ende:   ' || TO_CHAR(v_ende,  'HH24:MI:SS.FF3'));
    dbms_output.put_line('Dauer:  ' || v_dauer);
END;
/