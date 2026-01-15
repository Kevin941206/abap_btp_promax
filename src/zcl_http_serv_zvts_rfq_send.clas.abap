CLASS zcl_http_serv_zvts_rfq_send DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_zvts_rfq_send IMPLEMENTATION.


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

    DATA: lv_quotation TYPE ebeln,
          lv_langu     TYPE sy-langu,
          lv_currency  TYPE waers,
          lv_reference TYPE text12,
          lv_incoterm  TYPE char3,
          lv_incoterm2 TYPE zinco2,
          lv_comments  TYPE char255,
          lv_ssouser   TYPE char20,
          detail       TYPE ztt_zvts_rfq_upd,
          ls_detail    LIKE LINE OF detail,
          lv_message   TYPE char255.
*    lv_vbeln        TYPE vbeln_va,
*          lv_invoice      TYPE zvbeln_vf,
*          lv_name1        TYPE name1_gp,
*          lv_name2        TYPE name2_gp,
*          lv_begin_date   TYPE erdat,
*          lv_end_date     TYPE erdat,
*          lt_bukrs        TYPE ztt_ebpp_bukrs,
*          ls_bukrs        LIKE LINE OF lt_bukrs,
*          lt_sold_to      TYPE ztt_wkunnr,
*          ls_sold_to      LIKE LINE OF lt_sold_to,
*          lt_ship_to      TYPE ztt_wkunnr,
*          ls_ship_to      LIKE LINE OF lt_ship_to,
*          lt_sales_orders TYPE yttsd_salesorder_list_e,
*          lt_invoices     TYPE yttsd_invoices_list_t,
*          lv_from         TYPE char10,
*          lv_to           TYPE char10.

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

      ASSIGN COMPONENT 'QUOTATION' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_quotation = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'LANGU' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_langu = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'CURRENCY' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_currency = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'REFERENCE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_reference = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'INCOTERM' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_incoterm = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'INCOTERM2' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_incoterm2 = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'COMMENTS' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_incoterm2 = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'SSOUSER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_incoterm2 = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'DETAIL' OF STRUCTURE <data> TO <results>.
      ASSIGN <results>->* TO <table>.

      LOOP AT <table> ASSIGNING <structure>.
        ASSIGN <structure>->* TO <data>.

        ASSIGN COMPONENT 'ITEM' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-item = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'ITEM_CAT' OF STRUCTURE  <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-item_cat = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'PRICE' OF STRUCTURE  <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-price = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'DEL_DATE' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-del_date = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'ITEM_CAT' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-item_cat = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'DEL_DAYS' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-del_days = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'COMMENTS' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-comments = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'PACKNO' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-packno = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'ICMS' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-icms = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'RICMS' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-ricms = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'ICMSBR' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-icmsbr = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'STICMS' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-sticms = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'STI' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-sti = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'IPI' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-ipi = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'J_1BNBM' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-j_1bnbm = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'J_2BNBM' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-j_2bnbm = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'IVA' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          ls_detail-iva = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.
        IF ls_detail IS NOT INITIAL.
          APPEND ls_detail TO detail.
          CLEAR ls_detail.
        ENDIF.
      ENDLOOP.
     UNASSIGN: <results>, <table>,  <structure>.

    ENDIF.

    CALL FUNCTION 'ZVTS_RFQ_SEND'
      EXPORTING
        quotation = lv_quotation
        langu     = lv_langu
        currency  = lv_currency
        reference = lv_reference
        incoterm  = lv_incoterm
        incoterm2 = lv_incoterm2
        comments  = lv_comments
        ssouser   = lv_ssouser
        detail    = detail
      IMPORTING
        message   = lv_message.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = lv_message
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).


    response->set_text( lv_json ).
  ENDMETHOD.
ENDCLASS.
