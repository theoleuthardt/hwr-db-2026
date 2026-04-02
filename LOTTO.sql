BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE s_leuthardt23.kunden CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TYPE s_leuthardt23.LOS FORCE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE OR REPLACE TYPE s_leuthardt23.LOS AS OBJECT (
                                                       z1 INT,
                                                       z2 INT,
                                                       z3 INT,
                                                       CONSTRUCTOR FUNCTION LOS RETURN SELF AS RESULT
                                                   );
/

CREATE OR REPLACE TYPE BODY s_leuthardt23.LOS AS
    CONSTRUCTOR FUNCTION LOS RETURN SELF AS RESULT IS
    BEGIN
        SELF.z1 := TRUNC(DBMS_RANDOM.VALUE(1, 7));
        LOOP
            SELF.z2 := TRUNC(DBMS_RANDOM.VALUE(1, 7));
            EXIT WHEN SELF.z2 != SELF.z1;
        END LOOP;
        LOOP
            SELF.z3 := TRUNC(DBMS_RANDOM.VALUE(1, 7));
            EXIT WHEN SELF.z3 != SELF.z1 AND SELF.z3 != SELF.z2;
        END LOOP;
        RETURN;
    END;
END;
/

CREATE TABLE s_leuthardt23.kunden (
                                      kunden_id INT           PRIMARY KEY,
                                      name      VARCHAR2(100),
                                      tipp_1    INT           CHECK (tipp_1 BETWEEN 1 AND 6),
                                      tipp_2    INT           CHECK (tipp_2 BETWEEN 1 AND 6),
                                      tipp_3    INT           CHECK (tipp_3 BETWEEN 1 AND 6),
                                      belohnung VARCHAR2(255) DEFAULT '0 Euro'
);

CREATE OR REPLACE PACKAGE s_leuthardt23.lotto_pkg AS
    PROCEDURE fill;
    PROCEDURE jackpot;
    PROCEDURE run;
END lotto_pkg;
/

CREATE OR REPLACE PACKAGE BODY s_leuthardt23.lotto_pkg AS

    PROCEDURE fill IS
        v_los s_leuthardt23.LOS;
    BEGIN
        DELETE FROM s_leuthardt23.kunden;

        v_los := s_leuthardt23.LOS();
        INSERT INTO s_leuthardt23.kunden (kunden_id, name, tipp_1, tipp_2, tipp_3)
        VALUES (1, 'Josh', v_los.z1, v_los.z2, v_los.z3);

        v_los := s_leuthardt23.LOS();
        INSERT INTO s_leuthardt23.kunden (kunden_id, name, tipp_1, tipp_2, tipp_3)
        VALUES (2, 'Maja', v_los.z1, v_los.z2, v_los.z3);

        v_los := s_leuthardt23.LOS();
        INSERT INTO s_leuthardt23.kunden (kunden_id, name, tipp_1, tipp_2, tipp_3)
        VALUES (3, 'Chrissi', v_los.z1, v_los.z2, v_los.z3);

        v_los := s_leuthardt23.LOS();
        INSERT INTO s_leuthardt23.kunden (kunden_id, name, tipp_1, tipp_2, tipp_3)
        VALUES (4, 'Theo', v_los.z1, v_los.z2, v_los.z3);

        COMMIT;
    END fill;

    PROCEDURE jackpot IS
        v_los          s_leuthardt23.LOS := s_leuthardt23.LOS();
        treffer_anzahl INT;
        gewinn_text    VARCHAR2(255);
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Gezogene Zahlen: ' || v_los.z1 || ', ' || v_los.z2 || ', ' || v_los.z3);
        DBMS_OUTPUT.PUT_LINE('------------------------');

        FOR kunde IN (SELECT * FROM s_leuthardt23.kunden) LOOP

                treffer_anzahl := 0;
                IF kunde.tipp_1 IN (v_los.z1, v_los.z2, v_los.z3)
                THEN treffer_anzahl := treffer_anzahl + 1;
                END IF;
                IF kunde.tipp_2 IN (v_los.z1, v_los.z2, v_los.z3)
                THEN treffer_anzahl := treffer_anzahl + 1;
                END IF;
                IF kunde.tipp_3 IN (v_los.z1, v_los.z2, v_los.z3)
                THEN treffer_anzahl := treffer_anzahl + 1;
                END IF;

                CASE treffer_anzahl
                    WHEN 1 THEN gewinn_text := '1 Euro';
                    WHEN 2 THEN gewinn_text := '100 Euro';
                    WHEN 3 THEN gewinn_text := '1000 Euro und ein Bonus Bier';
                    ELSE        gewinn_text := '0 Euro';
                    END CASE;

                UPDATE s_leuthardt23.kunden
                SET    belohnung = gewinn_text
                WHERE  kunden_id = kunde.kunden_id;

                DBMS_OUTPUT.PUT_LINE(kunde.name || ': ' || treffer_anzahl || ' Treffer -> ' || gewinn_text);

            END LOOP;
        COMMIT;
    END jackpot;

    PROCEDURE run IS
    BEGIN
        fill();
        jackpot();
    END run;

END lotto_pkg;
/

BEGIN
    s_leuthardt23.lotto_pkg.run();
END;
/

SELECT * FROM s_leuthardt23.kunden;