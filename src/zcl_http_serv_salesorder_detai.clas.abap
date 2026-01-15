CLASS zcl_http_serv_salesorder_detai DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_salesorder_detai IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: lv_sales_rder                TYPE vbeln,
          ls_ystsd_salesorder_detail_e TYPE ystsd_salesorder_detail_e,
          ls_ystsd_totales_s           TYPE ystsd_totales_s,
          lt_yttsd_contacts_s          TYPE yttsd_contacts_s,
          lt_yttsd_positions_s         TYPE yttsd_positions_s,
          lt_yttsd_dates_s             TYPE yttsd_dates_s,
          lt_yttsd_invoices_s          TYPE yttsd_invoices_s.

    "Obtenemos el json
    DATA(lv_json) = request->get_text( )."{"iv_sales_order": "0000000002"}

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
      ASSIGN COMPONENT 'IV_SALES_ORDER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_sales_rder = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
    ENDIF.

    CALL FUNCTION 'YFMSD_SALESORDER_DETAILS'
      EXPORTING
        iv_sales_order         = lv_sales_rder
      IMPORTING
        es_sales_order_details = ls_ystsd_salesorder_detail_e
        es_totales             = ls_ystsd_totales_s
        et_contacts            = lt_yttsd_contacts_s
        et_positions           = lt_yttsd_positions_s
        et_dates               = lt_yttsd_dates_s
        et_invoices            = lt_yttsd_invoices_s.

    "Convertimos el resultado en json
    DATA(lv_json1) = /ui2/cl_json=>serialize(
             data        = ls_ystsd_salesorder_detail_e
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json2) = /ui2/cl_json=>serialize(
             data        = ls_ystsd_totales_s
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json3) = /ui2/cl_json=>serialize(
             data        = lt_yttsd_contacts_s
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json4) = /ui2/cl_json=>serialize(
             data        = lt_yttsd_positions_s
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json5) = /ui2/cl_json=>serialize(
             data        = lt_yttsd_dates_s
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json6) = /ui2/cl_json=>serialize(
             data        = lt_yttsd_invoices_s
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json1 && lv_json2 && lv_json3 && lv_json4 && lv_json5 && lv_json6 ).

  ENDMETHOD.
ENDCLASS.
