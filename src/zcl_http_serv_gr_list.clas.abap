class ZCL_HTTP_SERV_GR_LIST definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_SERV_GR_LIST IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: vendor TYPE elifn,
          company TYPE bukrs,
          wo_grs TYPE zchar01,
          w_grs TYPE zchar01,
          w_irs TYPE zchar01,
          w_pay TYPE zchar01,
          po_snumber TYPE ebeln,
          po_enumber TYPE ebeln,
          po_sdate TYPE erdat,
          po_edate TYPE erdat,
          grs_sdate TYPE erdat,
          grs_edate TYPE erdat,
          irs_sdate TYPE erdat,
          irs_edate TYPE erdat,
          pay_sdate TYPE erdat,
          pay_edate TYPE erdat,
          records   TYPE zint4.

     DATA: it_grs_list TYPE ztt_vts_grs_list.

*    DATA: list         TYPE ztt_vts_po_detail,
*          lv_po_number TYPE ebeln,
*          lv_langu     TYPE sy-langu.

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
      ASSIGN COMPONENT 'VENDOR' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        VENDOR = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'COMPANY' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        COMPANY = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'WO_GRS' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        WO_GRS = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'W_GRS' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        W_GRS = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'W_IRS' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        W_IRS  = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'W_PAY' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        W_PAY = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'PO_SNUMBER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        PO_SNUMBER = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'PO_ENUMBER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        PO_ENUMBER = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'PO_SDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        PO_SDATE = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'PO_EDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        PO_EDATE = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.


      ASSIGN COMPONENT 'GRS_SDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        GRS_SDATE = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'GRS_EDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        GRS_EDATE = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'IRS_SDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        IRS_SDATE = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'IRS_EDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        IRS_EDATE = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'PAY_SDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        PAY_SDATE = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'PAY_EDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        PAY_EDATE = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'RECORDS' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        RECORDS = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

    ENDIF.




    IF vendor IS NOT INITIAL.

      CLEAR: it_grs_list.

      CALL FUNCTION 'ZVTS_GR_LIST'
       EXPORTING vendor      = vendor
                 company     = company
                 wo_grs      = wo_grs
                 w_grs       = w_grs
                 w_irs       = w_irs
                 w_pay       = w_pay
                 po_snumber  = po_snumber
                 po_enumber  = po_enumber
                 po_sdate    = po_sdate
                 po_edate    = po_edate
                 grs_sdate   = grs_sdate
                 grs_edate   = grs_edate
                 irs_sdate   = irs_sdate
                 irs_edate   = irs_edate
                 pay_sdate   = pay_sdate
                 pay_edate   = pay_edate
                 records  = records
        IMPORTING grs_list   = it_grs_list.

      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = it_grs_list " ztt_grs_detail
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
               ).

      response->set_text( lv_json ).

    ENDIF.

  endmethod.
ENDCLASS.
