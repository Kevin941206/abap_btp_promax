class ZCL_HTTP_SERV_SALES_DOCUMENT definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_SERV_SALES_DOCUMENT IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: lv_document TYPE vbeln,
          ls_customer TYPE zsales_customer,
          ls_document TYPE zsales_document,
          lv_doctype  TYPE zvbtypl,
          ls_return   TYPE bapiret1,
          t_detail    TYPE ztt_sales_data,
          t_shipment  TYPE ztt_transp_data.

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
      ASSIGN COMPONENT 'I_DOCUMENT' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_document = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
    ENDIF.

    CALL FUNCTION 'ZSALES_DOCUMENT_INFO'
      EXPORTING
        i_document = lv_document
      IMPORTING
        e_customer = ls_customer
        e_document = ls_document
        e_doctype  = lv_doctype
        e_return   = ls_return
        t_detail   = t_detail
        t_shipment = t_shipment.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = ls_customer
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json2) = /ui2/cl_json=>serialize(
             data        = ls_document
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json3) = /ui2/cl_json=>serialize(
             data        = lv_doctype
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json4) = /ui2/cl_json=>serialize(
             data        = ls_return
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json5) = /ui2/cl_json=>serialize(
             data        = t_detail
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).
    DATA(lv_json6) = /ui2/cl_json=>serialize(
             data        = t_shipment
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json && lv_json2 && lv_json3 && lv_json4 && lv_json5 && lv_json6 ).

  endmethod.
ENDCLASS.
