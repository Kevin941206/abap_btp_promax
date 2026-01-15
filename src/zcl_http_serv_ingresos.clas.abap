CLASS zcl_http_serv_ingresos DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_ingresos IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS:
      <data>        TYPE data,
      <results>     TYPE any,
      <structure>   TYPE any,
      <table>       TYPE ANY TABLE,
      <field>       TYPE any,
      <field_value> TYPE data.

    DATA: lv_bukrs        TYPE bukrs,
          lv_from         TYPE char10,
          lv_date_from    TYPE datum,
          lv_to           TYPE char10,
          lv_date_to      TYPE datum,
          it_account      TYPE ztthfis_racct,
          ls_account      LIKE LINE OF it_account,
          et_docsingresos TYPE ztthfis_docsingresos.

    "Obtenemos el json
    DATA(lv_json) = request->get_text( ).

    "Convertimos el json a una tabla interna
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = lr_data.
    IF lr_data IS BOUND.
      ASSIGN lr_data->* TO <data>.

      ASSIGN COMPONENT 'I_COMPANY_CODE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_bukrs = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_DATE_FROM' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_from = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_DATE_TO' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_to = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_ACCOUNT' OF STRUCTURE <data> TO <results>.
      ASSIGN <results>->* TO <table>.

      LOOP AT <table> ASSIGNING <structure>.
        ASSIGN <structure>->* TO <data>.

        ASSIGN COMPONENT 'RACCT' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_account-racct = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        APPEND ls_account TO it_account.
        CLEAR ls_account.
      ENDLOOP.
    ENDIF.

    lv_date_from = lv_from+6(4) && lv_from+3(2) && lv_from(2).
    lv_date_to = lv_to+6(4) && lv_to+3(2) && lv_to(2).

    CALL FUNCTION 'ZHFIS_INGRESOS'
      EXPORTING
        i_company_code = lv_bukrs
        i_date_from    = lv_date_from
        i_date_to      = lv_date_to
        i_account      = it_account
      IMPORTING
        e_docsingresos = et_docsingresos.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = et_docsingresos
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json ).

  ENDMETHOD.
ENDCLASS.
