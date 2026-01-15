CLASS zcl_http_serv_companycode DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_companycode IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA: lv_json TYPE string,
          lt_comp TYPE ztt_bapi0002_1.

    CALL FUNCTION 'YFMSD_COMPANYCODE_LIST_GET'
      IMPORTING
        et_companycode_list = lt_comp.

    "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = lt_comp
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).

      response->set_text( lv_json ).

  ENDMETHOD.
ENDCLASS.
