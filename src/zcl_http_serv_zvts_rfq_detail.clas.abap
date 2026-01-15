CLASS zcl_http_serv_zvts_rfq_detail DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_zvts_rfq_detail IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA l_dat TYPE zst_eina_lifnr.
    DATA: lv_vendor    TYPE elifn,
          lv_quota     TYPE ebeln,
          lv_langu     TYPE sy-langu,
          lv_rfq_date  TYPE datum,
          lv_val_start TYPE datum,
          lv_val_end   TYPE datum,
          lv_deadline  TYPE datum,
          lv_terms     TYPE char30,
          lv_curr      TYPE waers,
          lv_rate      TYPE zkursf,
          inco         TYPE char3,
          inco2        TYPE zinco2,
          doc_type     TYPE char20,
          our_ref      TYPE text12,
          your_ref     TYPE text12,
          pur_grp      TYPE ekgrp,
          desc         TYPE zchar1000,
          pur_name     TYPE eknam,
          pur_org      TYPE ekorg,
          plant_addr   TYPE zstring128,
          phone        TYPE char12,
          fax          TYPE telfx,
          email        TYPE char255,
          status       TYPE char255,
          message      TYPE char255.

    DATA rfq_detail TYPE ztt_zvts_rfq_detail.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS:
      <data>        TYPE data,
      <results>     TYPE any,
      <structure>   TYPE any,
      <table>       TYPE ANY TABLE,
      <field>       TYPE any,
      <field_value> TYPE data.

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
      ASSIGN COMPONENT 'VENDOR' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_vendor = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'QUOTATION' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_quota = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'LANGU' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_langu = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
    ENDIF.

    CALL FUNCTION 'ZVTS_RFQ_DETAIL'
      EXPORTING
        vendor     = lv_vendor
        quotation  = lv_quota
        langu      = lv_langu
      IMPORTING
        rfq_date   = lv_rfq_date
        val_start  = lv_val_start
        val_end    = lv_val_end
        deadline   = lv_deadline
        terms      = lv_terms
        curr       = lv_curr
        rate       = lv_rate
        inco       = inco
        inco2      = inco2
        doc_type   = doc_type
        our_ref    = our_ref
        your_ref   = your_ref
        pur_grp    = pur_grp
        desc       = desc
        pur_name   = pur_name
        pur_org    = pur_org
        plant_addr = plant_addr
        phone      = phone
        fax        = fax
        email      = email
        status     = status
        message    = message
        rfq_detail = rfq_detail.

    "Convertimos el resultado en json
    DATA(lv_json1) = /ui2/cl_json=>serialize(
            data        = lv_rfq_date
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json2) = /ui2/cl_json=>serialize(
            data        = lv_val_start
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json3) = /ui2/cl_json=>serialize(
            data        = lv_val_end
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json4) = /ui2/cl_json=>serialize(
            data        = lv_deadline
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json5) = /ui2/cl_json=>serialize(
            data        = lv_terms
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json6) = /ui2/cl_json=>serialize(
            data        = lv_curr
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json7) = /ui2/cl_json=>serialize(
            data        = lv_rate
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json8) = /ui2/cl_json=>serialize(
            data        = inco
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json9) = /ui2/cl_json=>serialize(
            data        = inco2
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json10) = /ui2/cl_json=>serialize(
            data        = doc_type
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json11) = /ui2/cl_json=>serialize(
            data        = our_ref
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json12) = /ui2/cl_json=>serialize(
            data        = your_ref
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json13) = /ui2/cl_json=>serialize(
            data        = pur_grp
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json14) = /ui2/cl_json=>serialize(
            data        = desc
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json15) = /ui2/cl_json=>serialize(
            data        = pur_name
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json16) = /ui2/cl_json=>serialize(
            data        = pur_org
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json17) = /ui2/cl_json=>serialize(
            data        = plant_addr
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json18) = /ui2/cl_json=>serialize(
            data        = phone
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json19) = /ui2/cl_json=>serialize(
            data        = fax
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json20) = /ui2/cl_json=>serialize(
            data        = email
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json21) = /ui2/cl_json=>serialize(
            data        = status
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json22) = /ui2/cl_json=>serialize(
            data        = message
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

          DATA(lv_json23) = /ui2/cl_json=>serialize(
            data        = rfq_detail
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

    response->set_text( lv_json1 && lv_json2 && lv_json3 && lv_json4 && lv_json5 && lv_json6 && lv_json7
    && lv_json8 && lv_json9 && lv_json10 && lv_json11 && lv_json12 && lv_json13 && lv_json14 && lv_json15
    && lv_json16 && lv_json17 && lv_json18 && lv_json19 && lv_json20 && lv_json21 && lv_json22 && lv_json23 ).
  ENDMETHOD.
ENDCLASS.
