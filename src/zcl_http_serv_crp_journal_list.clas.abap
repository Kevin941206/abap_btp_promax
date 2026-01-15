CLASS zcl_http_serv_crp_journal_list DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_crp_journal_list IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: et_journal_list TYPE ztt_zcrp_journal,
          lv_company      TYPE bukrs,
          lv_date_from    TYPE datum,
          lv_date_to      TYPE datum,
          lv_year         TYPE gjahr,
          lv_tipo         TYPE koart.

    DATA(lv_json) = request->get_text( ).

    "Convertimos el json
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = lr_data.
    IF lr_data IS BOUND.
      ASSIGN lr_data->* TO <data>.
      ASSIGN COMPONENT 'COMPANY' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_company = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'DATE_FROM' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_date_from = <field_value>.
      ENDIF.

      ASSIGN COMPONENT 'DATE_TO' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_date_to = <field_value>.
      ENDIF.

      ASSIGN COMPONENT 'YEAR' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_year = <field_value>.
      ENDIF.

      ASSIGN COMPONENT 'TIPO' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_tipo = <field_value>.
      ENDIF.
    ENDIF.

    CALL FUNCTION 'ZFIGLMX_CRP_JOURNAL_LIST'
      EXPORTING
        i_company      = lv_company
        i_date_from    = lv_date_from
        i_date_to      = lv_date_to
        i_year         = lv_year
        i_tipo         = lv_tipo
      IMPORTING
        t_journal_list = et_journal_list.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = et_journal_list
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json ).
  ENDMETHOD.
ENDCLASS.
