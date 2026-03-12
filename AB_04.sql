DECLARE
    v_datum    VARCHAR2(20);
    v_uhrzeit  VARCHAR2(10);
    v_gesamt   VARCHAR2(30);
    v_zufallsdatum DATE;
BEGIN
    v_zufallsdatum := TO_DATE('01.01.2000', 'DD.MM.YYYY')
                      + TRUNC(DBMS_RANDOM.VALUE(0, 11322));
    v_zufallsdatum := v_zufallsdatum
                      + DBMS_RANDOM.VALUE(0, 1);

    v_datum   := TO_CHAR(v_zufallsdatum, 'DD.MM.YYYY');
    v_uhrzeit := TO_CHAR(v_zufallsdatum, 'HH24:MI:SS');
    v_gesamt  := TO_CHAR(v_zufallsdatum, 'DD.MM.YYYY HH24:MI:SS');

    DBMS_OUTPUT.PUT_LINE('Datum   : ' || v_datum);
    DBMS_OUTPUT.PUT_LINE('Uhrzeit : ' || v_uhrzeit);
    DBMS_OUTPUT.PUT_LINE('Gesamt  : ' || v_gesamt);
END;