-- POSTER PROJEKT
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE s_leuthardt23.P_KUNDEN CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS
    THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE s_leuthardt23.P_PREISE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS
    THEN NULL;
END;
/

CREATE TABLE s_leuthardt23.P_PREISE (
    Anzahl  INTEGER,
    EPreis  NUMBER(5, 2)
);

CREATE TABLE s_leuthardt23.P_KUNDEN (
    Anzahl  INTEGER,
    Betrag  NUMBER(10, 2),
    KName   VARCHAR2(100)
);

INSERT INTO s_leuthardt23.P_PREISE (Anzahl, EPreis) VALUES (1,   0.4);
INSERT INTO s_leuthardt23.P_PREISE (Anzahl, EPreis) VALUES (10,  0.3);
INSERT INTO s_leuthardt23.P_PREISE (Anzahl, EPreis) VALUES (50,  0.2);
INSERT INTO s_leuthardt23.P_PREISE (Anzahl, EPreis) VALUES (100, 0.1);
COMMIT;

CREATE OR REPLACE PACKAGE s_leuthardt23.Poster AS
    PROCEDURE Init;
    FUNCTION  FindEPreis(p_Anzahl IN INTEGER)
        RETURN NUMBER;
END Poster;
/

CREATE OR REPLACE PACKAGE BODY s_leuthardt23.Poster AS

    TYPE t_PreisArray IS TABLE OF NUMBER(5, 2) INDEX BY PLS_INTEGER;

    v_Preise t_PreisArray;

    PROCEDURE Init IS
    BEGIN
        FOR r IN (SELECT Anzahl, EPreis
                  FROM   s_leuthardt23.P_PREISE) LOOP
            v_Preise(r.Anzahl) := r.EPreis;
        END LOOP;
        RETURN;
    END Init;

    FUNCTION FindEPreis(p_Anzahl IN INTEGER) RETURN NUMBER IS
        v_Result NUMBER(5, 2);
    BEGIN
        v_Result := 0;
        IF v_Preise.EXISTS(p_Anzahl) THEN
            v_Result := v_Preise(p_Anzahl);
        END IF;
        RETURN v_Result;
    END FindEPreis;

END Poster;
/

BEGIN
    s_leuthardt23.Poster.Init();
    DBMS_OUTPUT.PUT_LINE('Anzahl |  EPreis | Gesamtpreis');
    DBMS_OUTPUT.PUT_LINE('-------|---------|------------');
    DBMS_OUTPUT.PUT_LINE('     1 | ' || TO_CHAR(s_leuthardt23.Poster.FindEPreis(1),   '0.00') || '   | ' || TO_CHAR(1   * s_leuthardt23.Poster.FindEPreis(1),   '990.00'));
    DBMS_OUTPUT.PUT_LINE('    10 | ' || TO_CHAR(s_leuthardt23.Poster.FindEPreis(10),  '0.00') || '   | ' || TO_CHAR(10  * s_leuthardt23.Poster.FindEPreis(10),  '990.00'));
    DBMS_OUTPUT.PUT_LINE('    50 | ' || TO_CHAR(s_leuthardt23.Poster.FindEPreis(50),  '0.00') || '   | ' || TO_CHAR(50  * s_leuthardt23.Poster.FindEPreis(50),  '990.00'));
    DBMS_OUTPUT.PUT_LINE('   100 | ' || TO_CHAR(s_leuthardt23.Poster.FindEPreis(100), '0.00') || '   | ' || TO_CHAR(100 * s_leuthardt23.Poster.FindEPreis(100), '990.00'));
    DBMS_OUTPUT.PUT_LINE('    99 | ' || TO_CHAR(s_leuthardt23.Poster.FindEPreis(99),  '0.00') || '   | ' || TO_CHAR(99  * s_leuthardt23.Poster.FindEPreis(99),  '990.00'));
END;
/

-- SELECT * FROM s_leuthardt23.P_PREISE;