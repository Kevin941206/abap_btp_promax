class ZCL_HTTP_SERV_RFQ_ATTACH definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_SERV_RFQ_ATTACH IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: quotation TYPE ebeln,
          attach    TYPE zvtt_attach.

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
      ASSIGN COMPONENT 'QUOTATION' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        quotation  = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
    ENDIF.

    CALL FUNCTION 'ZVTS_RFQ_ATTACH'
       EXPORTING
                 quotation = quotation
       IMPORTING
                 attach    = attach.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
               data        = attach     " ztt_grs_detail
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
               ).

    response->set_text( lv_json ).

  endmethod.
ENDCLASS.
