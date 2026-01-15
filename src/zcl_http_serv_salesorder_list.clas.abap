CLASS zcl_http_serv_salesorder_list DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_salesorder_list IMPLEMENTATION.


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

    DATA: lv_vbeln        TYPE vbeln_va,
          lv_invoice      TYPE zvbeln_vf,
          lv_name1        TYPE name1_gp,
          lv_name2        TYPE name2_gp,
          lv_begin_date   TYPE erdat,
          lv_end_date     TYPE erdat,
          lt_bukrs        TYPE ztt_ebpp_bukrs,
          ls_bukrs        LIKE LINE OF lt_bukrs,
          lt_sold_to      TYPE ztt_wkunnr,
          ls_sold_to      LIKE LINE OF lt_sold_to,
          lt_ship_to      TYPE ztt_wkunnr,
          ls_ship_to      LIKE LINE OF lt_ship_to,
          lt_sales_orders TYPE yttsd_salesorder_list_e,
          lt_invoices     TYPE yttsd_invoices_list_t,
          lv_from         TYPE char10,
          lv_to           TYPE char10.

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

      ASSIGN COMPONENT 'IV_SALES_ORDER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_vbeln = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'IV_INVOICE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_invoice = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'IV_NAME1' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_name1 = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'IV_NAME2' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_name2 = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'IV_BEGIN_DATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_from = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'IV_END_DATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_to = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'IT_BUKRS' OF STRUCTURE <data> TO <results>.
      ASSIGN <results>->* TO <table>.

      LOOP AT <table> ASSIGNING <structure>.
        ASSIGN <structure>->* TO <data2>.

        ASSIGN COMPONENT 'BUKRS' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_bukrs-bukrs = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        APPEND ls_bukrs TO lt_bukrs.
        CLEAR ls_bukrs.
      ENDLOOP.
      UNASSIGN: <results>, <table>, <data2>, <structure>.

      ASSIGN COMPONENT 'IT_SOLD_TO' OF STRUCTURE <data> TO <results>.
      ASSIGN <results>->* TO <table>.

      LOOP AT <table> ASSIGNING <structure>.
        ASSIGN <structure>->* TO <data2>.

        ASSIGN COMPONENT 'KUNNR' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_sold_to-kunnr = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.
        IF ls_sold_to IS NOT INITIAL.
          APPEND ls_sold_to TO lt_sold_to.
          CLEAR ls_sold_to.
        ENDIF.
      ENDLOOP.
      UNASSIGN: <results>, <table>, <data2>, <structure>.

      ASSIGN COMPONENT 'IT_SHIP_TO' OF STRUCTURE <data> TO <results>.
      ASSIGN <results>->* TO <table>.

      LOOP AT <table> ASSIGNING <structure>.
        ASSIGN <structure>->* TO <data2>.

        ASSIGN COMPONENT 'KUNNR' OF STRUCTURE <data2> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_ship_to-kunnr = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.
        IF ls_ship_to IS NOT INITIAL.
          APPEND ls_ship_to TO lt_ship_to.
          CLEAR ls_ship_to.
        ENDIF.
      ENDLOOP.
      UNASSIGN: <results>, <table>, <data2>, <structure>.

    ENDIF.

    lv_begin_date = lv_from+6(4) && lv_from+3(2) && lv_from(2).
    lv_end_date = lv_to+6(4) && lv_to+3(2) && lv_to(2).

    CALL FUNCTION 'YFMSD_SALESORDER_LIST'
      EXPORTING
        iv_sales_order  = lv_vbeln
        iv_invoice      = lv_invoice
        iv_name1        = lv_name1
        iv_name2        = lv_name2
        iv_begin_date   = lv_begin_date
        iv_end_date     = lv_end_date
        it_bukrs        = lt_bukrs
        it_sold_to      = lt_sold_to
        it_ship_to      = lt_ship_to
      IMPORTING
        et_sales_orders = lt_sales_orders
        et_invoices     = lt_invoices.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = lt_sales_orders
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json2) = /ui2/cl_json=>serialize(
             data        = lt_invoices
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json && lv_json2 ).

  ENDMETHOD.
ENDCLASS.
