CLASS zcl_http_serv_customers_comp_g DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_customers_comp_g IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: et_customers_list TYPE yttsd_customer_list_e,
          lv_company        TYPE bukrs.

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
      ASSIGN COMPONENT 'COMPANY' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_company = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.


    ENDIF.

    CALL FUNCTION 'YFMSD_CUSTOMERS_COMP_GET'
      EXPORTING
        iv_companycode    = lv_company
      IMPORTING
        et_customers_list = et_customers_list.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = et_customers_list
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json ).
  ENDMETHOD.
ENDCLASS.
