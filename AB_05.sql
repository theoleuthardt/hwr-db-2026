BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Action_Tab';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
create table Action_Tab
(
    ActID varchar2(12),
    Strt  timestamp,
    Ende  timestamp,
    Dauer Interval Day to second(3)  -- vielleicht zuerst ohne Dauer
);
-- select * from Action_Tab;

create or replace procedure Action_Log_Set(ID varchar)
    is
    t TIMESTAMP := localtimestamp;
begin
    delete from Action_Tab where ActID = ID;
    insert into Action_Tab values (ID, t, NULL, NULL);
end;
--
create or replace procedure Action_Log_Calc(ID varchar)
    is
    t TIMESTAMP := localtimestamp;
begin
    update Action_Tab set Ende = t, Dauer = t - Strt where ActID = ID;
end;
/

create or replace procedure Action_Log_Show(ID varchar)
    is
    v_strt  TIMESTAMP;
    v_ende  TIMESTAMP;
    v_dauer INTERVAL DAY TO SECOND(3);
begin
    select Strt, Ende, Dauer into v_strt, v_ende, v_dauer
    from Action_Tab where ActID = ID;

    DBMS_OUTPUT.PUT_LINE('   ID: ' || ID);
    DBMS_OUTPUT.PUT_LINE('Anfang: ' || TO_CHAR(v_strt, 'DD.MM.YYYY HH24:MI:SS,FF3'));
    DBMS_OUTPUT.PUT_LINE('  Ende: ' || TO_CHAR(v_ende, 'DD.MM.YYYY HH24:MI:SS,FF3'));
    DBMS_OUTPUT.PUT_LINE(' Dauer: ' || TO_CHAR(EXTRACT(HOUR FROM v_dauer), 'FM00') || ':'
        || TO_CHAR(EXTRACT(MINUTE FROM v_dauer), 'FM00') || ':'
        || TO_CHAR(EXTRACT(SECOND FROM v_dauer), 'FM00.000'));
end;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TBig';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
create table TBig
(
    I int,
    R number,
    T varchar2(80)
);

BEGIN
    FOR i IN 1..100000 LOOP
            INSERT INTO TBig VALUES (
                                        i,
                                        DBMS_RANDOM.VALUE(0, 10000),
                                        DBMS_RANDOM.STRING('A', 40)
                                    );
            IF MOD(i, 10000) = 0 THEN COMMIT; END IF;
        END LOOP;
    COMMIT;
END;
/

BEGIN
    Action_Log_Set('upd_tbig');
END;
/
UPDATE TBig SET R = R + 1;
COMMIT;
BEGIN
    Action_Log_Calc('upd_tbig');
    Action_Log_Show('upd_tbig');
END;
/