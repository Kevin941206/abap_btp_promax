CLASS zcl_http_serv_payment DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_payment IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: lv_code       TYPE char1,
          lv_vendor     TYPE lifnr,
          lv_company    TYPE bukrs,
          lv_period     TYPE char1,
          lv_start_date TYPE sy-datum,
          lv_end_date   TYPE sy-datum,
          lv_langu      TYPE sy-langu,
          payment_p     TYPE zvts_tt_payment_p,
          payment_s     TYPE zvts_tt_payment_s.

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
      ASSIGN COMPONENT 'CODE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_code = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'VENDOR' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_vendor = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'COMPANY' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_company = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'PERIOD' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_period = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'START_DATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_start_date = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'END_DATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_end_date = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'LANGU' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_langu = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
    ENDIF.

    CALL FUNCTION 'ZVTS_PAYMENT'
      EXPORTING
        code       = lv_code
        vendor     = lv_vendor
        company    = lv_company
        period     = lv_period
        start_date = lv_start_date
        end_date   = lv_end_date
        langu      = lv_langu
      IMPORTING
        payment_p  = payment_p
        payment_s  = payment_s.

    IF lv_code = 'P'.
      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = payment_p
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).
    ENDIF.
    IF lv_code = 'S'.
      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = payment_s
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).
    ENDIF.

    response->set_text( lv_json ).

  ENDMETHOD.
ENDCLASS.
