CREATE OR REPLACE PROCEDURE GetRentHistory(
    P_PROPERTYID IN PROPERTY.PROPERTYID%TYPE
) AS
BEGIN
    EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_DATE_FORMAT = ''YYYY-MM-DD''';
    dbms_output.put_line('Property ID: '|| P_PROPERTYID);
    FOR CURSOR IN (SELECT * FROM TENANTSHIP WHERE TENANTSHIP.RENTEDPROPERTYID = P_PROPERTYID)
    LOOP
        DBMS_OUTPUT.PUT_LINE('------------------');
        DBMS_OUTPUT.PUT_LINE('Start Date:        ' || CURSOR.STARTDATE);
        DBMS_OUTPUT.PUT_LINE('End Date:          ' || CURSOR.ENDDATE);
        DBMS_OUTPUT.PUT_LINE('Tenant ID:         ' || CURSOR.TENANTID);
        DBMS_OUTPUT.PUT_LINE('Rent Per Month:    ' || CURSOR.RENTPERMONTH);
        DBMS_OUTPUT.PUT_LINE('Yearly Hike:       ' || CURSOR.YEARLYHIKE);
        DBMS_OUTPUT.PUT_LINE('Agency Commission: ' || CURSOR.AGENCYCOMMISSION);
        DBMS_OUTPUT.PUT_LINE('------------------');
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error getting details for given property id: '
            || SQLERRM);
END;
/