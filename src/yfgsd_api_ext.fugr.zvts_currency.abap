FUNCTION ZVTS_CURRENCY.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(LANGU) TYPE  SY-LANGU
*"  EXPORTING
*"     VALUE(CURRENCY) TYPE  ZTT_TCURT
*"----------------------------------------------------------------------
 " You can use the template 'functionModuleParameter' to add here the signature!
.

*Refresh currency. Clear Currency.
*
*select * into table currency from TCURT where spras eq langu and ( waers eq 'MXN' or waers eq 'USD' ).
*
*select *  appending table currency from TCURT where spras eq langu.
 DATA: LT_TCURT    TYPE ZTT_TCURT,
       LS_TCURT    TYPE ZES_TCURT,
       Z_LANGU     TYPE C LENGTH 2.

 ZCL_TCURT=>currency_get( EXPORTING i_operacion = 'READ' IMPORTING currency_get = lt_tcurt ).

  IF lt_tcurt IS NOT INITIAL.

    IF LANGU EQ 'E'.
      Z_LANGU = 'EN'.
    ELSEIF LANGU EQ 'S'.
      Z_LANGU = 'ES'.
    ENDIF.

    LOOP AT LT_TCURT INTO LS_TCURT.

      IF ls_tcurt-waers EQ 'MXN' OR ls_tcurt-waers EQ 'USD'.

        INSERT ls_tcurt INTO TABLE CURRENCY.

      ELSEIF ls_tcurt-spras EQ z_langu AND z_langu IS NOT INITIAL.

        INSERT ls_tcurt INTO TABLE CURRENCY.

      ENDIF.

    ENDLOOP.
  ENDIF.
ENDFUNCTION.
