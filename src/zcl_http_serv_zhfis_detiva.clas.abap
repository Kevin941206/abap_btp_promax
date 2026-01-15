CLASS zcl_http_serv_zhfis_detiva DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_zhfis_detiva IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
  DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: et_docsdetiva   TYPE ztt_zhfis_detiva,
          lv_company_code TYPE bukrs,
          lv_date_from    TYPE budat,
          lv_date_to      TYPE budat.

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
        lv_company_code = <field_value>.
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
    ENDIF.

     CALL FUNCTION 'ZHFIS_DETIVA'
      EXPORTING
        i_company_code = lv_company_code
        i_date_from    = lv_date_from
        i_date_to      = lv_date_to
      IMPORTING
        e_docsdetiva = et_docsdetiva.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = et_docsdetiva
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json ).
  ENDMETHOD.
ENDCLASS.
