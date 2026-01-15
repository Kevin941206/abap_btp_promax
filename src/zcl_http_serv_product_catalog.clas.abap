CLASS zcl_http_serv_product_catalog DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_product_catalog IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
  DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: et_product TYPE ytt_stmm_products_e.

    DATA(lv_json) = request->get_text( ).

    "Convertimos el json
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
        CHANGING
        data         = lr_data.

    CALL FUNCTION 'ZFMSD_PRODUCT_CATALOG'
      IMPORTING
        et_product_catalog = et_product.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = et_product
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json ).
  ENDMETHOD.
ENDCLASS.
