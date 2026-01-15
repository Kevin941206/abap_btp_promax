CLASS zcl_http_rfq_delete DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_rfq_delete IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <data2>       TYPE data,
                   <table>       TYPE any,     "Aquí quedará la tabla del JSON
                   <field_value> TYPE data,
                   <line>        TYPE any.     "Aquí quedará cada registro de la tabla

    DATA: rfq_del  TYPE ztt_rfq,
          rfq_mssg TYPE ztt_tline,

          ls_del   TYPE zes_rfq,
          ls_mssg  TYPE zes_tline,
          mensaje  TYPE ztdline.

    DATA(lv_json) = request->get_text( ).

    " Convertimos el JSON
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = lr_data.

    IF lr_data IS BOUND.

      ASSIGN lr_data->* TO <data>.
      ASSIGN COMPONENT 'RFQ_DEL' OF STRUCTURE <data> TO <field>.

      IF <field> IS ASSIGNED.

        lr_data = <field>.
        ASSIGN lr_data->* TO <table>.             "Aquí está la tabla interna completa

        LOOP AT <table> ASSIGNING <line>.         "Cada línea es un registro

          ASSIGN <line>->* TO <data2>.

          " ===== PURCH_DOC =====
          ASSIGN COMPONENT 'PURCH_DOC' OF STRUCTURE <data2> TO <field>.
          IF <field> IS ASSIGNED.
            lr_data = <field>.
            ASSIGN lr_data->* TO <field_value>.
            ls_del-purch_doc = <field_value>.
          ENDIF.
          UNASSIGN: <field>, <field_value>.

          " ===== ITEM =====
          ASSIGN COMPONENT 'ITEM' OF STRUCTURE <data2> TO <field>.
          IF <field> IS ASSIGNED.
            lr_data = <field>.
            ASSIGN lr_data->* TO <field_value>.
            ls_del-item = <field_value>.
          ENDIF.
          UNASSIGN: <field>, <field_value>.

          APPEND ls_del TO rfq_del.             "Guardamos en tabla final

        ENDLOOP.

      ENDIF.
    ENDIF.

    " Llamada a la función Z
    CALL FUNCTION 'ZVTS_RFQ_DELETE'
      EXPORTING
        rfq_del  = rfq_del
      IMPORTING
        rfq_mssg = rfq_mssg.

    " Convertimos el resultado a JSON
    lv_json = /ui2/cl_json=>serialize(
                data        = rfq_mssg
                pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                compress    = abap_false
              ).

    response->set_text( lv_json ).

  ENDMETHOD.
ENDCLASS.
