CLASS zcl_http_serv_po_view_confirm DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_po_view_confirm IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: lv_lifnr     TYPE lifnr,
          lv_bukrs     TYPE bukrs,
          lv_ebeln     TYPE ebeln,
          lv_ebelp     TYPE ebelp,
          lv_language  TYPE sy-langu,
          lv_message   TYPE char255,
          po_confirmed TYPE zvts_tt_po_confirmed.

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
      ASSIGN COMPONENT 'VENDOR' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_lifnr = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'COMPANY' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_bukrs = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'PO_NUMBER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_ebeln = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'PO_ITEM' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_ebelp = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'LANGUAGE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_language = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
    ENDIF.

    CALL FUNCTION 'ZVTS_PO_VIEW_CONFIRMED'
      EXPORTING
        vendor       = lv_lifnr
        company      = lv_bukrs
        po_number    = lv_ebeln
        po_item      = lv_ebelp
        language     = lv_language
      IMPORTING
        message      = lv_message
        po_confirmed = po_confirmed.

    IF lv_message IS INITIAL.
      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = po_confirmed
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).
    ELSE.
      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = lv_message
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).
    ENDIF.

    response->set_text( lv_json ).

  ENDMETHOD.
ENDCLASS.
