PROGRAM main
  VAR
    START : BOOL;
    STOP : BOOL;
    PV_TANK_1 : INT;
    PV_TANK_2 : INT;
    PV_TANK_3 : INT;
    PV_TANK_4 : INT;
    VALVE_X : BOOL;
    VALVE_Y : BOOL;
    VALVE_Z : BOOL;
    VALVE_OUT_XYZ : BOOL;
    MIXER : BOOL;
    VALVE_DRAIN : BOOL;
    SYSTEM_ON : BOOL := FALSE;
    R_CUTOFF_X : BOOL := FALSE;
    R_CUTOFF_Y : BOOL := FALSE;
    R_CUTOFF_Z : BOOL := FALSE;
    STATE : INT := 0;
    TIMER_1 : TON;
    TIMER_MX : TON;
  END_VAR

IF START AND (PV_TANK_4 <= 0) THEN

    SYSTEM_ON := TRUE;

    R_CUTOFF_X := FALSE;
    R_CUTOFF_Y := FALSE;
    R_CUTOFF_Z := FALSE;

    STATE := 1;

END_IF;


IF STOP THEN

    SYSTEM_ON := FALSE;
    STATE := 0;

END_IF;


VALVE_X := FALSE;
VALVE_Y := FALSE;
VALVE_Z := FALSE;

VALVE_OUT_XYZ := FALSE;

MIXER := FALSE;

VALVE_DRAIN := FALSE;


CASE STATE OF

    0:

    1:

        IF NOT R_CUTOFF_X THEN
            VALVE_X := TRUE;
        END_IF;

        IF NOT R_CUTOFF_Y THEN
            VALVE_Y := TRUE;
        END_IF;

        IF NOT R_CUTOFF_Z THEN
            VALVE_Z := TRUE;
        END_IF;

        IF PV_TANK_1 >= 25 THEN
            R_CUTOFF_X := TRUE;
            VALVE_X := FALSE;
        END_IF;

        IF PV_TANK_2 >= 20 THEN
            R_CUTOFF_Y := TRUE;
            VALVE_Y := FALSE;
        END_IF;

        IF PV_TANK_3 >= 30 THEN
            R_CUTOFF_Z := TRUE;
            VALVE_Z := FALSE;
        END_IF;

        IF R_CUTOFF_X AND R_CUTOFF_Y AND R_CUTOFF_Z THEN
            STATE := 2;
        END_IF;

    2:

        VALVE_OUT_XYZ := TRUE;

        TIMER_1(
            IN := TRUE,
            PT := T#10s
        );

        IF TIMER_1.Q THEN
            STATE := 3;
        END_IF;

    3:

        MIXER := TRUE;

        TIMER_MX(
            IN := TRUE,
            PT := T#10s
        );

        IF TIMER_MX.Q THEN
            STATE := 4;
        END_IF;

    4:

        VALVE_DRAIN := TRUE;

        IF PV_TANK_4 <= 0 THEN
            STATE := 5;
        END_IF;

    5:

        SYSTEM_ON := FALSE;
        STATE := 0;

END_CASE;


IF STATE <> 2 THEN
    TIMER_1(
        IN := FALSE,
        PT := T#10s
    );
END_IF;


IF STATE <> 3 THEN
    TIMER_MX(
        IN := FALSE,
        PT := T#10s
    );
END_IF;

END_PROGRAM