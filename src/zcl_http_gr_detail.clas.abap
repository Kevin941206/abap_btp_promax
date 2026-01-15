class ZCL_HTTP_GR_DETAIL definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_GR_DETAIL IMPLEMENTATION.

  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA: po_number TYPE ebeln.
    DATA: ztt_grs_detail TYPE ztt_grs_detail.
    DATA lr_data TYPE REF TO data.
    DATA: ls_input     TYPE zspo_number.

    "Obtenemos el json
    DATA(lv_json) = request->get_text( ).
    CLEAR: po_number.

    "Convertimos el json a una estructura interna
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = ls_input.

      po_number = ls_input-po_number.

    IF po_number IS NOT INITIAL.

      CALL FUNCTION 'ZVTS_GR_DETAIL'
        EXPORTING po_number  = po_number
        IMPORTING grs_detail = ztt_grs_detail.

      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = ztt_grs_detail " ztt_grs_detail
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
               ).

      response->set_text( lv_json ).

    ENDIF.

  endmethod.
ENDCLASS.
