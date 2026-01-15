class ZCL_HTTP_SERV_SUBPRODFAMILYS definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_SERV_SUBPRODFAMILYS IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA: it_prodfam_t TYPE yttsd_prodfam_t.
    DATA(lv_json) = request->get_text( ).

    CALL FUNCTION 'YFMSD_SUBPRODFAMILYS_GET'
      IMPORTING et_prod_subfamilies = it_prodfam_t.

      "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = it_prodfam_t " ztt_grs_detail
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
             ).

    response->set_text( lv_json ).


  endmethod.
ENDCLASS.
