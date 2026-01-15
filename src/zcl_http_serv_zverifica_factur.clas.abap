CLASS zcl_http_serv_zverifica_factur DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_zverifica_factur IMPLEMENTATION.


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

    DATA: lv_invoice    TYPE char10,
          lv_year       TYPE gjahr,
          lv_invoice_fi TYPE char10,
          lv_year_fi    TYPE gjahr,
          lv_folio      TYPE char10,
          lv_error_flag TYPE char1,
          it_message    TYPE ztt_message,
          it_invoice    TYPE ztt_invoice,
          wa_invoice    LIKE LINE OF it_invoice,
          wa_hst        TYPE zhst,
          it_hst        TYPE STANDARD TABLE OF zhst,
          lv_message    TYPE char255.

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

      ASSIGN COMPONENT 'HST' OF STRUCTURE <data> TO <results>.
      ASSIGN <results>->* TO <table>.

      LOOP AT <table> ASSIGNING <structure>.
        ASSIGN <structure>->* TO <data>.

        ASSIGN COMPONENT 'LBLNI' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          wa_hst-lblni = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'REBEL' OF STRUCTURE  <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          wa_hst-rebel = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        IF wa_hst IS NOT INITIAL.
          APPEND wa_hst TO it_hst.
          CLEAR wa_hst.
        ENDIF.
      ENDLOOP.
      UNASSIGN: <results>, <table>,  <structure>.

*      ASSIGN COMPONENT 'INVOICE' OF STRUCTURE <data> TO <results>.
*      ASSIGN <results>->* TO <table>.
*
*      LOOP AT <table> ASSIGNING <structure>.
*        ASSIGN <structure>->* TO <data>.
*
*        ASSIGN COMPONENT 'ID' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-id = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'NOFACT' OF STRUCTURE  <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-nofact = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'DOCTYP' OF STRUCTURE  <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-doctyp = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'EBELN' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-ebeln = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'MJAHR' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-mjahr = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'RFC_EMISOR' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-rfc_emisor = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'COCODE' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-cocode = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'FEFACT' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-fefact = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'FEBASE' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-febase = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'WAERS' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-waers = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-lifnr = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'TAXCODE' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-taxcode = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IMPBRT' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-impbrt = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IMPIVA' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-impiva = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IMPNET' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-impnet = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'USER' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-user = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'RT_SUBJCT' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-rt_subjct = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IMP_RET' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-imp_ret = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IMP_BASE' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-imp_base = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'GLACCT' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-glacct = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'COST' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-cost = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'VIA' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-via = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'UUID' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-uuid = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'RT_6' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-rt_6 = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'REBEL' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-rebel = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IND_IMP' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-ind_imp = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'TRANSP_EXT' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-transp_ext = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'EXTI2' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-exti2 = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'DR' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-dr = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'BASE_ISR_DR' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-base_isr_dr = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'BASE_IVA_DR' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-base_iva_dr = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IMP_ISR_DR' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-imp_isr_dr = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IMP_IVA_DR' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_invoice-imp_iva_dr = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        IF wa_invoice IS NOT INITIAL.
*          APPEND wa_invoice TO it_invoice.
*          CLEAR wa_invoice.
*        ENDIF.
*      ENDLOOP.
      UNASSIGN: <results>, <table>,  <structure>.
    ENDIF.

    CALL FUNCTION 'ZVERIFICA_FACTURA'
      EXPORTING
        i_invoice    = it_invoice
        i_hst        = wa_hst
      IMPORTING
        l_invoice    = lv_invoice
        l_year       = lv_year
        l_invoice_fi = lv_invoice_fi
        l_year_fi    = lv_year_fi
        l_folio      = lv_folio
        error_flag   = lv_error_flag
        e_message    = it_message.

    "Convertimos el resultado en json
    IF lv_invoice IS INITIAL AND lv_year IS INITIAL AND lv_invoice_fi IS INITIAL
AND lv_year_fi IS INITIAL AND lv_folio IS INITIAL AND lv_message IS INITIAL.
      lv_json = /ui2/cl_json=>serialize(
               data        = 'No se encontraron datos para mostrar.'
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).


      response->set_text( lv_json ).
    ELSE.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
