CLASS zcl_http_serv_po_send_conf DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_po_send_conf IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS:
      <data>        TYPE data,
      <data2>       TYPE data,
      <results>     TYPE any,
      <structure>   TYPE any,
      <table>       TYPE ANY TABLE,
      <field>       TYPE any,
      <field_value> TYPE data.

    DATA: lv_ebeln  TYPE ebeln,
          lv_langu  TYPE spras,
          lt_detail TYPE zvts_tt_po_confirm,
          ls_detail LIKE LINE OF lt_detail,
          lv_msg    TYPE char255.

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

      ASSIGN COMPONENT 'PO_NUMBER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_ebeln = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'LANGUAGE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_langu = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'DETAIL' OF STRUCTURE <data> TO <results>.
      ASSIGN <results>->* TO <table>.

      LOOP AT <table> ASSIGNING <structure>.
        ASSIGN <structure>->* TO <data2>.

        ASSIGN COMPONENT 'ITEM' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-item = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'QUANTITY' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-quantity = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'DELIV_DATE' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-deliv_date = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'TIME' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-time = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'TRAN_TYPE' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-tran_type = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'ID_TRANS' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-id_trans = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'PERSON' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-person = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'PEN_QANT' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-pen_qant = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        APPEND ls_detail TO lt_detail.
        CLEAR ls_detail.
      ENDLOOP.
      UNASSIGN: <results>, <table>, <data2>, <structure>.

    ENDIF.

    CALL FUNCTION 'ZVTS_PO_SEND_CONF'
      EXPORTING
        po_number = lv_ebeln
        language  = lv_langu
        detail    = lt_detail
      IMPORTING
        message   = lv_msg.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = lv_msg
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json ).

  ENDMETHOD.
ENDCLASS.
