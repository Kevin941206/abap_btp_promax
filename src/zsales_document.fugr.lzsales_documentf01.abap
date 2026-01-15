*----------------------------------------------------------------------*
***INCLUDE LZSALES_DOCUMENTF01 .
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  F_FILL_CUSTOMER
*&---------------------------------------------------------------------*
FORM f_fill_customer  USING  pv_kunnr CHANGING es_cust.

  DATA:  lw_kna1 TYPE ty_kna1.

  zcl_qry_operations_to_s4hana=>sales_info_kna1( EXPORTING i_operacion = 'READ'
                                                           i_kunnr = pv_kunnr
                                                 IMPORTING es_customer = DATA(ls_customer) ).

  MOVE-CORRESPONDING ls_customer TO es_cust.

*  SELECT
*  SINGLE kunnr
*         land1
*         name1
*         name2
*         ort01
*         pstlz
*         regio
*         stras
*         telf1
*         ort02
*    FROM kna1
*    INTO lw_kna1
*   WHERE kunnr EQ pv_kunnr.
*  IF sy-subrc EQ 0.
*    MOVE: lw_kna1-land1  TO e_customer-country,
*          lw_kna1-name1  TO e_customer-name,
*          lw_kna1-ort01  TO e_customer-city,
*          lw_kna1-regio  TO e_customer-region,
*          lw_kna1-name2  TO e_customer-name2,
*          lw_kna1-pstlz  TO e_customer-zipcode,
*          lw_kna1-stras  TO e_customer-street,
*          lw_kna1-telf1  TO e_customer-telephone,
*          lw_kna1-ort02  TO e_customer-district.
*  ENDIF.

ENDFORM.                    " F_FILL_CUSTOMER

*&---------------------------------------------------------------------*
*&      Form  F_GET_ORDER
*&---------------------------------------------------------------------*
FORM f_get_order
  USING  pv_vbeln .

  zcl_qry_operations_to_s4hana=>sales_info_vbap( EXPORTING i_operacion = 'READ'
                                                           i_vbeln = pv_vbeln
                                                 IMPORTING et_vbap = t_vbap ).

*  SELECT  vbeln
*          posnr
*          matnr
*          arktx
*          kwmeng
*          vrkme
*          netwr
*          waerk
*          vstel
*          prctr      "LLUNA 28.01.2019
*          mwsbp      "LLUNA 23.03.2020
*    FROM  vbap
*    INTO  TABLE t_vbap
*    WHERE vbeln EQ pv_vbeln.
*  IF sy-subrc EQ 0.
*    SORT t_vbap
*      BY vbeln
*         posnr.
*  ENDIF.

ENDFORM.                    " GET_ORDER_DATA

*&---------------------------------------------------------------------*
*&      Form  F_GET_DELIVERY
*&---------------------------------------------------------------------*
FORM f_get_delivery  USING    pv_vbeln.

  zcl_qry_operations_to_s4hana=>sales_info_lips( EXPORTING i_operacion = 'READ'
                                                           i_vbeln = pv_vbeln
                                                  IMPORTING et_lips = t_lips ).

*  SELECT  vbeln
*          posnr
*          erdat
*          matnr
*          arktx
*          lfimg
*          vrkme
*          netwr
*          prctr      "LLUNA 28.01.2019
*    FROM  lips
*    INTO  TABLE t_lips
*    WHERE vbeln EQ pv_vbeln.
*  IF sy-subrc EQ 0.
*    SORT t_lips
*      BY vbeln
*         posnr.
*  ENDIF.

ENDFORM.                    " F_GET_DELIVERY

*&---------------------------------------------------------------------*
*&      Form  F_GET_BILL
*&---------------------------------------------------------------------*
FORM f_get_bill  USING    pv_vbeln.

  zcl_qry_operations_to_s4hana=>sales_info_vbrp( EXPORTING i_operacion = 'READ'
                                                           i_vbeln = pv_vbeln
                                                           IMPORTING et_vbrp = t_vbrp ).

*  SELECT  vbeln
*          posnr
*          erdat
*          matnr
*          arktx
*          fkimg
*          vrkme
*          netwr
*          vstel
*          prctr   "LLUNA 28.01.2019
*          mwsbp   "LLUNA 23.03.2020
*    FROM  vbrp
*    INTO  TABLE t_vbrp
*    WHERE vbeln EQ pv_vbeln.
*  IF sy-subrc EQ 0.
*    SORT t_vbrp
*      BY vbeln
*         posnr.
*  ENDIF.

ENDFORM.                    " F_GET_BILL

*&---------------------------------------------------------------------*
*&      Form  F_FILL_OUT_ORDER
*&---------------------------------------------------------------------*
FORM f_fill_out_order CHANGING it_detail TYPE ztt_sales_data.

  DATA: lw_vbap   TYPE zst_vbap, "ty_vbap,
        lw_detail TYPE zsales_data.

  DATA: lt_docflow TYPE STANDARD TABLE OF zst_vbfa, "vbfa,
        lw_docflow TYPE zst_vbfa. "vbfa.

  lt_docflow[] = t_docflow[].

  DELETE lt_docflow
   WHERE vbtyp_n NE 'J'.

  SORT lt_docflow
    BY vbelv
       posnv.

  LOOP AT t_vbap
    INTO lw_vbap.

    lw_detail-document = lw_vbap-vbeln.
    lw_detail-pos = lw_vbap-posnr.
    lw_detail-material = lw_vbap-matnr.
    lw_detail-description = lw_vbap-arktx.
    lw_detail-quantity = lw_vbap-kwmeng.
    lw_detail-unit = lw_vbap-vrkme.
    lw_detail-amount = lw_vbap-netwr.
    lw_detail-currency = lw_vbap-waerk.
    lw_detail-shippoint = lw_vbap-vstel.
    lw_detail-profit_ctr = lw_vbap-prctr.
    lw_detail-impuesto = lw_vbap-mwsbp.

*    MOVE: lw_vbap-vbeln  TO lw_detail-document,
*          lw_vbap-posnr  TO lw_detail-pos,
*          lw_vbap-matnr  TO lw_detail-material,
*          lw_vbap-arktx  TO lw_detail-description,
*          lw_vbap-kwmeng TO lw_detail-quantity,
*          lw_vbap-vrkme  TO lw_detail-unit,
*          lw_vbap-netwr  TO lw_detail-amount,
*          lw_vbap-waerk  TO lw_detail-currency,
*          lw_vbap-vstel  TO lw_detail-shippoint,
*          lw_vbap-prctr  TO lw_detail-profit_ctr,  "LLUNA 28.01.2019
*          lw_vbap-mwsbp  TO lw_detail-impuesto.    "LLUNA 23.03.2020

    READ TABLE lt_docflow
          INTO lw_docflow
          WITH KEY vbelv = lw_vbap-vbeln
                   posnv = lw_vbap-posnr
    BINARY SEARCH.
    IF sy-subrc EQ 0.
*      MOVE lw_docflow-erdat TO lw_detail-delv_date.
       lw_detail-delv_date = lw_docflow-erdat.
    ENDIF.

    APPEND lw_detail   TO it_detail.
    CLEAR  lw_detail.

  ENDLOOP.

ENDFORM.                    " F_FILL_OUT

*&---------------------------------------------------------------------*
*&      Form  F_FILL_OUT_DELIVERY
*&---------------------------------------------------------------------*
FORM f_fill_out_delivery CHANGING it_detail TYPE ztt_sales_data.

  DATA: lw_lips   TYPE zst_lips, "ty_lips,
        lw_detail TYPE zsales_data.

  LOOP AT t_lips
    INTO lw_lips.

    lw_detail-document = lw_lips-vbeln.
    lw_detail-pos = lw_lips-posnr.
    lw_detail-delv_date = lw_lips-erdat.
    lw_detail-material = lw_lips-matnr.
    lw_detail-description = lw_lips-arktx.
    lw_detail-quantity = lw_lips-lfimg.
    lw_detail-unit = lw_lips-vrkme.
    lw_detail-amount = lw_lips-netwr.
    lw_detail-profit_ctr = lw_lips-prctr.

*    MOVE: lw_lips-vbeln  TO lw_detail-document,
*          lw_lips-posnr  TO lw_detail-pos,
*          lw_lips-erdat  TO lw_detail-delv_date,
*          lw_lips-matnr  TO lw_detail-material,
*          lw_lips-arktx  TO lw_detail-description,
*          lw_lips-lfimg  TO lw_detail-quantity,
*          lw_lips-vrkme  TO lw_detail-unit,
*          lw_lips-netwr  TO lw_detail-amount,
*          lw_lips-prctr  TO lw_detail-profit_ctr.  "LLUNA 28.01.2019

    APPEND lw_detail TO it_detail.
    CLEAR lw_detail.

  ENDLOOP.

ENDFORM.                    " F_FILL_OUT_DELIVERY

*&---------------------------------------------------------------------*
*&      Form  F_FILL_OUT_BILL
*&---------------------------------------------------------------------*
FORM f_fill_out_bill CHANGING it_detail TYPE ztt_sales_data.

  DATA: lw_vbrp   TYPE zst_vbrp, "ty_vbrp,
        lw_detail TYPE zsales_data.

  DATA: lt_docflow   TYPE STANDARD TABLE OF zst_vbfa, "vbfa,
        lw_docflow_j TYPE zst_vbfa, "vbfa,
        lw_docflow_m TYPE zst_vbfa. "vbfa.

  lt_docflow[] = t_docflow[].

  SORT lt_docflow
    BY vbeln
       posnn
       vbtyp_n.

  LOOP AT t_vbrp
    INTO lw_vbrp.

    lw_detail-document = lw_vbrp-vbeln.
    lw_detail-pos = lw_vbrp-posnr.
    lw_detail-material = lw_vbrp-matnr.
    lw_detail-description = lw_vbrp-arktx.
    lw_detail-quantity = lw_vbrp-fkimg.
    lw_detail-unit = lw_vbrp-vrkme.
    lw_detail-amount = lw_vbrp-netwr.
    lw_detail-shippoint = lw_vbrp-vstel.
    lw_detail-profit_ctr = lw_vbrp-prctr.
    lw_detail-impuesto = lw_vbrp-mwsbp.

*    MOVE: lw_vbrp-vbeln  TO lw_detail-document,
*          lw_vbrp-posnr  TO lw_detail-pos,
*          lw_vbrp-matnr  TO lw_detail-material,
*          lw_vbrp-arktx  TO lw_detail-description,
*          lw_vbrp-fkimg  TO lw_detail-quantity,
*          lw_vbrp-vrkme  TO lw_detail-unit,
*          lw_vbrp-netwr  TO lw_detail-amount,
*          lw_vbrp-vstel  TO lw_detail-shippoint,
*          lw_vbrp-prctr  TO lw_detail-profit_ctr,  "LLUNA 28.01.2019
*          lw_vbrp-mwsbp  TO lw_detail-impuesto.    "LLUNA 23.03.2020

    READ TABLE lt_docflow
          INTO lw_docflow_m
          WITH KEY vbeln = lw_vbrp-vbeln
                   posnn = lw_vbrp-posnr
                   vbtyp_n = 'M'
                   BINARY SEARCH.
    IF sy-subrc EQ 0.
      READ TABLE lt_docflow
            INTO lw_docflow_j
            WITH KEY vbeln = lw_docflow_m-vbelv
                     posnn = lw_docflow_m-posnv
                     vbtyp_n = 'J'
                     BINARY SEARCH.
      IF sy-subrc EQ 0.
*        MOVE lw_docflow_j-erdat TO lw_detail-delv_date.
         lw_detail-delv_date = lw_docflow_j-erdat.
      ENDIF.
    ENDIF.
    APPEND lw_detail TO it_detail.
    CLEAR  lw_detail.

  ENDLOOP.

ENDFORM.                    " F_FILL_OUT_BILL
*&---------------------------------------------------------------------*
*&      Form  F_FILL_VBAK
*&---------------------------------------------------------------------*
FORM f_fill_vbak
  USING pv_vbelnc CHANGING es_doc.

  zcl_qry_operations_to_s4hana=>sales_info_vbak_knvv( EXPORTING i_operacion = 'READ'
                                                                i_vbeln = pv_vbelnc
                                                                IMPORTING es_document = DATA(ls_document) ).

  MOVE-CORRESPONDING ls_document TO es_doc.

*  DATA: lw_vbak TYPE ty_vbak,
*        lw_knvv TYPE ty_knvv.
*
*  SELECT SINGLE  vbeln
*          erdat
*          waerk
*          vkorg
*          vtweg
*          spart
*          kunnr
*    FROM vbak
*    INTO lw_vbak
*    WHERE vbeln EQ pv_vbeln.
*
*  IF sy-subrc EQ 0.
*
*    MOVE: lw_vbak-kunnr  TO e_customer-cust_no.
*
*    MOVE: lw_vbak-vbeln  TO e_document-document,
*          lw_vbak-erdat  TO e_document-creation,
*          lw_vbak-waerk  TO e_document-currency,
*          lw_vbak-vkorg  TO e_document-orgvtas.
*
*    SELECT SINGLE kunnr
*           vkorg
*           vtweg
*           spart
*           bzirk
*      FROM knvv
*      INTO lw_knvv
*     WHERE kunnr EQ lw_vbak-kunnr
*       AND vkorg EQ lw_vbak-vkorg
*       AND vtweg EQ lw_vbak-vtweg
*       AND spart EQ lw_vbak-spart.
*
*    IF sy-subrc EQ 0.
*
*      MOVE: lw_knvv-bzirk  TO e_document-zonavtas.
*    ENDIF.
*  ENDIF.

ENDFORM.                    " F_FILL_VBAK

*&---------------------------------------------------------------------*
*&      Form  F_FILL_LIKP
*&---------------------------------------------------------------------*
FORM f_fill_likp
    USING pv_vbeln CHANGING es_doc.

  DATA: lw_likp TYPE ty_likp.

  zcl_qry_operations_to_s4hana=>sales_info_likp( EXPORTING i_operacion = 'READ'
                                                           i_vbeln = pv_vbeln
                                                           IMPORTING es_document = DATA(ls_document) ).

  MOVE-CORRESPONDING ls_document TO es_doc.

*  SELECT
*  SINGLE  vbeln
*          erdat
*          bzirk
*          vstel
*          vkorg
*          kunnr
*          waerk
*    FROM  likp
*    INTO lw_likp
*    WHERE vbeln EQ pv_vbeln.
*  IF sy-subrc EQ 0.
*
*    MOVE: lw_likp-kunnr  TO e_customer-cust_no.
*
*    MOVE: lw_likp-vbeln  TO e_document-document,
*          lw_likp-erdat  TO e_document-creation,
*          lw_likp-waerk  TO e_document-currency,
*          lw_likp-vkorg  TO e_document-orgvtas,
*          lw_likp-bzirk  TO e_document-zonavtas,
*          lw_likp-vstel  TO e_document-shippoint.
*  ENDIF.

ENDFORM.                    " F_FILL_LIKP
*&---------------------------------------------------------------------*
*&      Form  F_FILL_VBRK
*&---------------------------------------------------------------------*
FORM f_fill_vbrk
    USING pv_vbeln CHANGING es_doc.

  DATA: lw_vbrk TYPE ty_vbrk.

  zcl_qry_operations_to_s4hana=>sales_info_vbrk( EXPORTING i_operacion = 'READ'
                                                           i_vbeln = pv_vbeln
                                                 IMPORTING es_document = DATA(ls_document) ).

  MOVE-CORRESPONDING ls_document TO es_doc.

*  SELECT
*  SINGLE  vbeln
*          waerk
*          vkorg
*          bzirk
*          erdat
*          kunrg
*    FROM vbrk
*    INTO lw_vbrk
*    WHERE vbeln EQ pv_vbeln.
*  IF sy-subrc EQ 0.
*
*    MOVE: lw_vbrk-kunrg  TO e_customer-cust_no.
*
*    MOVE: lw_vbrk-vbeln  TO e_document-document,
*          lw_vbrk-waerk  TO e_document-currency,
*          lw_vbrk-bzirk  TO e_document-zonavtas,
*          lw_vbrk-erdat  TO e_document-creation,
*          lw_vbrk-vkorg  TO e_document-orgvtas.
*  ENDIF.

ENDFORM.                    " F_FILL_VBRK

*INI LDGL 25.08.2020 Se agrega info transportista
*&---------------------------------------------------------------------*
*&      Form  F_FILL_SHIPMENT
*&---------------------------------------------------------------------*
FORM f_fill_shipment CHANGING it_ship TYPE ztt_transp_data.

  DATA: lt_docflow  TYPE STANDARD TABLE OF zst_vbfa.
  DATA: t_vttk  TYPE STANDARD TABLE OF ty_vttk,
        lw_vttk TYPE ty_vttk,
        t_lfa1  TYPE STANDARD TABLE OF ty_lfa1,
        lw_lfa1 TYPE ty_lfa1.

  DATA: lw_shipment TYPE ztransp_data.

  lt_docflow[] = t_docflow[].

  DELETE lt_docflow
   WHERE vbtyp_n NE '8'.    "Dejar solo transporte

  IF lt_docflow[] IS NOT INITIAL.

    zcl_qry_operations_to_s4hana=>sales_info_vttk_lfa1( EXPORTING i_operacion = 'READ'
                                                                  it_docflow = lt_docflow
                                                        IMPORTING et_shipment = it_ship ).

*    SELECT tknum
*           tdlnr
*      FROM vttk
*      INTO TABLE t_vttk
*      FOR ALL ENTRIES IN lt_docflow
*      WHERE tknum EQ lt_docflow-vbeln.
*    IF sy-subrc EQ 0.
*
*      SORT t_vttk
*        BY tknum.
*
*      SELECT lifnr
*             name1
*        FROM lfa1
*        INTO TABLE t_lfa1
*        FOR ALL ENTRIES IN t_vttk
*        WHERE lifnr EQ t_vttk-tdlnr.
*
*      IF sy-subrc EQ 0.
*        SORT t_lfa1
*          BY lifnr.
*      ENDIF.
*    ENDIF.
*
*    IF t_vttk[] IS NOT INITIAL.
*
*      LOOP AT t_vttk
*         INTO lw_vttk.
*
*        lw_shipment-tknum = lw_vttk-tknum.
*
*        IF lw_vttk-tdlnr IS NOT INITIAL.
*          lw_shipment-tdlnr = lw_vttk-tdlnr.
*
*          READ TABLE t_lfa1
*                INTO lw_lfa1
*                WITH KEY lifnr = lw_vttk-tdlnr
*                BINARY SEARCH.
*          IF sy-subrc EQ 0.
*            lw_shipment-name1 = lw_lfa1-name1.
*          ENDIF.
*
*          APPEND lw_shipment TO t_shipment.
*          CLEAR lw_shipment.
*        ENDIF.
*      ENDLOOP.
*    ENDIF.
  ENDIF.

ENDFORM.                    " F_FILL_SHIPMENT
*FIN LDGL 25.08.2020 Se agrega info transportista
