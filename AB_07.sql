create or replace package ZEIT as
    procedure Strt(ID varchar);
    procedure Calc(ID varchar);
    procedure Print(ID varchar);
end;
/
create or replace package body ZEIT as
    procedure Strt(ID varchar)
        is
    begin
        S_LEUTHARDT23.ACTION_LOG_SET(ID);
    end;
    procedure Calc(ID varchar)
        is
    begin
        for i in 1..10000 loop
                insert into TBig values (i, DBMS_RANDOM.VALUE(0, 10000), DBMS_RANDOM.STRING('A', 40));
            end loop;
        S_LEUTHARDT23.ACTION_LOG_CALC(ID);
    end;
    procedure Print(ID varchar)
        is
    begin
        S_LEUTHARDT23.ACTION_LOG_SHOW(ID);
    end;
end ZEIT;
/

-- Test
begin
    ZEIT.Strt('T1');
    ZEIT.Calc('T1');
    ZEIT.Print('T1');
    rollback;
end;
/