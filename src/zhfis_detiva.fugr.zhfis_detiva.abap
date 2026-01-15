FUNCTION zhfis_detiva.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_COMPANY_CODE) TYPE  BUKRS
*"     VALUE(I_DATE_FROM) TYPE  BUDAT DEFAULT SY-DATUM
*"     VALUE(I_DATE_TO) TYPE  BUDAT DEFAULT SY-DATUM
*"  EXPORTING
*"     VALUE(E_DOCSDETIVA) TYPE  ZTT_ZHFIS_DETIVA
*"----------------------------------------------------------------------
** Consulta Documentos Compensación Pago a Proveedores.
*
  CLEAR: lt_bsakbsad[], lt_listadoccompprov[], lt_listadoccompcli[], lt_bsakbsad[], lt_bseg[],
         lt_listadoc[], lt_listadoc_fi[], lt_lifnr[], lt_kunnr[], lt_bkpf_fi[], lt_bkpf_tc_pago[],
         lt_lfa1[], lt_kna1[], lt_skb1[], lt_retenciones[].


*  SELECT bukrs augbl auggj belnr gjahr INTO TABLE lt_listadoccompprov
*           FROM bsak
*        WHERE bukrs  EQ i_company_code
*          AND budat  GE i_date_from
*          AND budat  LE i_date_to
*          AND ( umsks  EQ space OR umsks  EQ 'A' )
*          AND belnr  LIKE '15%'.

  zcl_qry_zhfis_detiva=>zhfis_bsak( EXPORTING i_operacion = 'READ' i_company_code = i_company_code
  i_date_from = i_date_from i_date_to = i_date_to IMPORTING lt_listadoccompprov = lt_listadoccompprov ).

  SORT lt_listadoccompprov BY bukrs augbl auggj ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_listadoccompprov.

** Consulta Documentos Compensación Cobranza Clientes.
*
*  SELECT bukrs augbl auggj belnr gjahr INTO TABLE lt_listadoccompcli
*           FROM bsad
*        WHERE bukrs  EQ i_company_code
*          AND budat  GE i_date_from
*          AND budat  LE i_date_to
*          AND ( umsks  EQ space OR umsks  EQ 'A' )
*          AND belnr  LIKE '14%'.
  zcl_qry_zhfis_detiva=>zhfis_bsad( EXPORTING i_operacion = 'READ' i_company_code = i_company_code
  i_date_from = i_date_from i_date_to = i_date_to IMPORTING lt_listadoccompcli = lt_listadoccompcli ).

  SORT lt_listadoccompcli BY bukrs augbl auggj ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_listadoccompcli.

*   Consulta Principal Documentos Pagados Proveedores.

  IF lt_listadoccompprov[] IS NOT INITIAL.

*    SELECT bukrs belnr gjahr buzei budat bldat cpudt xblnr augbl auggj waers shkzg dmbtr wrbtr lifnr blart
*       INTO CORRESPONDING FIELDS OF TABLE lt_bsakbsad
*             FROM bsak
*           FOR ALL ENTRIES IN lt_listadoccompprov
*          WHERE bukrs  EQ i_company_code
**            AND budat  GE i_date_from
**            AND budat  LE i_date_to
*            AND augbl  EQ lt_listadoccompprov-augbl
*            AND auggj  EQ lt_listadoccompprov-auggj
*            AND umsks  EQ space
*            AND ( belnr  NOT LIKE '15%' AND belnr  NE lt_listadoccompprov-augbl ).

    zcl_qry_zhfis_detiva=>zhfis_bsak2( EXPORTING i_operacion = 'READ' i_company_code = i_company_code
     lt_listadoccompprov = lt_listadoccompprov  IMPORTING lt_bsakbsad = lt_bsakbsad ).
  ENDIF.

* Consulta Pagos a Terceros Agentes Aduanales


* Consulta Principal Documentos Pagados Clientes.
  IF lt_listadoccompcli[] IS NOT INITIAL.
*
*    SELECT bukrs belnr gjahr buzei budat bldat cpudt xblnr augbl auggj waers shkzg dmbtr wrbtr kunnr blart
*       APPENDING CORRESPONDING FIELDS OF TABLE lt_bsakbsad
*             FROM bsad
*           FOR ALL ENTRIES IN lt_listadoccompcli
*          WHERE bukrs  EQ i_company_code
**            AND budat  GE i_date_from
**            AND budat  LE i_date_to
*            AND augbl  EQ lt_listadoccompcli-augbl
*            AND auggj  EQ lt_listadoccompcli-auggj
*            AND umsks  EQ space
*            AND ( belnr  NOT LIKE '14%' AND belnr NE lt_listadoccompcli-augbl ).
    zcl_qry_zhfis_detiva=>zhfis_bsad2( EXPORTING i_operacion = 'READ' i_company_code = i_company_code
    lt_listadoccompcli = lt_listadoccompcli IMPORTING lt_bsakbsad = lt_bsakbsad ).
  ENDIF.
*
  LOOP AT lt_bsakbsad INTO ls_bsakbsad.
    MOVE-CORRESPONDING ls_bsakbsad TO ls_listadoc.
    MOVE-CORRESPONDING ls_bsakbsad TO ls_listadoc_fi.

    APPEND ls_listadoc TO lt_listadoc.
    APPEND ls_listadoc_fi TO lt_listadoc_fi.
    IF ls_bsakbsad-lifnr IS NOT INITIAL.
*      MOVE ls_bsakbsad-lifnr TO ls_lifnr-lifnr.
      ls_lifnr-lifnr = ls_bsakbsad-lifnr.
      APPEND ls_lifnr TO lt_lifnr.
    ENDIF.
    IF ls_bsakbsad-kunnr IS NOT INITIAL.
*      MOVE ls_bsakbsad-kunnr TO ls_kunnr-kunnr.
      ls_kunnr-kunnr = ls_bsakbsad-kunnr.
      APPEND ls_kunnr TO lt_kunnr.
    ENDIF.
  ENDLOOP.

  SORT lt_listadoc BY bukrs augbl auggj ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_listadoc.

  SORT lt_listadoc_fi BY bukrs belnr gjahr ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_listadoc_fi.

  SORT lt_lifnr BY lifnr ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_lifnr.

  SORT lt_kunnr BY kunnr ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_kunnr.

  IF lt_listadoc_fi[] IS NOT INITIAL.
*    SELECT bukrs belnr gjahr buzei koart shkzg dmbtr wrbtr mwskz hkont INTO TABLE lt_bseg
*           FROM bseg
*          FOR ALL ENTRIES IN lt_listadoc_fi
*          WHERE bukrs EQ lt_listadoc_fi-bukrs
*            AND belnr EQ lt_listadoc_fi-belnr
*            AND gjahr EQ lt_listadoc_fi-gjahr.
    zcl_qry_zhfis_detiva=>zhfis_bseg( EXPORTING i_operacion = 'READ' lt_listadoc_fi = lt_listadoc_fi IMPORTING lt_bseg = lt_bseg ).

  ENDIF.
*
  IF lt_listadoc[] IS NOT INITIAL.
*    SELECT bukrs belnr gjahr buzei koart shkzg dmbtr wrbtr mwskz hkont APPENDING TABLE lt_bseg
*           FROM bseg
*          FOR ALL ENTRIES IN lt_listadoc
*          WHERE bukrs EQ lt_listadoc-bukrs
*            AND belnr EQ lt_listadoc-augbl
*            AND gjahr EQ lt_listadoc-auggj.
    zcl_qry_zhfis_detiva=>zhfis_bseg2( EXPORTING i_operacion = 'READ' lt_listadoc = lt_listadoc IMPORTING lt_bseg = lt_bseg ).
  ENDIF.

  SORT lt_bseg BY bukrs belnr gjahr buzei ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_bseg.

  IF lt_listadoc_fi[] IS NOT INITIAL.
*E. Detalles Cabecera Doc Contable FI (BKPF)
*    SELECT bukrs belnr gjahr bktxt usnam  INTO TABLE lt_bkpf_fi
*           FROM bkpf
*          FOR ALL ENTRIES IN lt_listadoc_fi
*          WHERE bukrs EQ lt_listadoc_fi-bukrs
*            AND belnr EQ lt_listadoc_fi-belnr
*            AND gjahr EQ lt_listadoc_fi-gjahr
*            AND xreversal EQ space.   " No concidera doc anulados
    zcl_qry_zhfis_detiva=>zhfis_bkpf( EXPORTING i_operacion = 'READ' lt_listadoc_fi = lt_listadoc_fi IMPORTING lt_bkpf_fi = lt_bkpf_fi ).

    SORT lt_bkpf_fi BY bukrs belnr gjahr ASCENDING.
  ENDIF.
*
  IF lt_listadoc[] IS NOT INITIAL.
*H. Tipo Cambio del Pago FI (BKPF)
*    SELECT bukrs belnr gjahr kursf blart bldat INTO TABLE lt_bkpf_tc_pago
*           FROM bkpf
*          FOR ALL ENTRIES IN lt_listadoc
*          WHERE bukrs EQ lt_listadoc-bukrs
*            AND belnr EQ lt_listadoc-augbl
*            AND gjahr EQ lt_listadoc-auggj.
    zcl_qry_zhfis_detiva=>zhfis_bkpf2( EXPORTING i_operacion = 'READ' lt_listadoc = lt_listadoc IMPORTING lt_bkpf_tc_pago = lt_bkpf_tc_pago ).

    SORT lt_bkpf_tc_pago BY bukrs belnr gjahr ASCENDING.
  ENDIF.
*
  IF lt_lifnr[] IS NOT INITIAL.
*F. Detalles Proveedor (LFA1)
*    SELECT * INTO TABLE lt_lfa1
*           FROM lfa1
*          FOR ALL ENTRIES IN lt_lifnr
*          WHERE lifnr EQ lt_lifnr-lifnr.
    zcl_qry_zhfis_detiva=>zhfis_lfa1( EXPORTING i_operacion = 'READ' lt_lifnr = lt_lifnr IMPORTING lt_lfa1 = lt_lfa1 ).
  ENDIF.

  IF lt_kunnr[] IS NOT INITIAL.
*G. Detalles Cliente (KNA1)
*    SELECT * INTO TABLE lt_kna1
*           FROM kna1
*          FOR ALL ENTRIES IN lt_kunnr
*          WHERE kunnr EQ lt_kunnr-kunnr.
    zcl_qry_zhfis_detiva=>zhfis_kna1( EXPORTING i_operacion = 'READ' lt_kunnr = lt_kunnr IMPORTING lt_kna1 = lt_kna1 ).
  ENDIF.

  SORT lt_lfa1 BY lifnr ASCENDING.
  SORT lt_kna1 BY kunnr ASCENDING.

**I. Cuentas de Mayor Bancarias
*  SELECT * INTO TABLE lt_skb1
*         FROM skb1
*        WHERE bukrs EQ i_company_code
*          AND hbkid NE space.
  zcl_qry_zhfis_detiva=>zhfis_skb1( EXPORTING i_operacion ='READ' i_company_code = i_company_code IMPORTING lt_skb1 = lt_skb1 ).

  SORT lt_skb1 BY bukrs saknr ASCENDING.

  IF lt_listadoc_fi[] IS NOT INITIAL.
* Retenciones
*    SELECT * INTO TABLE lt_retenciones
*             FROM with_item
*      FOR ALL ENTRIES IN lt_listadoc_fi
*      WHERE bukrs EQ lt_listadoc_fi-bukrs
*        AND belnr EQ lt_listadoc_fi-belnr
*        AND gjahr EQ lt_listadoc_fi-gjahr.
    zcl_qry_zhfis_detiva=>zhfis_item( EXPORTING i_operacion = 'READ' lt_listadoc_fi = lt_listadoc_fi IMPORTING lt_retenciones = lt_retenciones ).
    SORT lt_retenciones BY bukrs belnr gjahr ASCENDING.
  ENDIF.

  LOOP AT lt_bsakbsad INTO ls_bsakbsad.

    CLEAR: ls_docsdetiva.

    READ TABLE lt_docsdetiva INTO ls_docsdetiva
            WITH KEY bukrs = ls_bsakbsad-bukrs
                     belnr = ls_bsakbsad-belnr
                     gjahr = ls_bsakbsad-gjahr.
    IF sy-subrc EQ 0.
      IF ls_bsakbsad-kunnr IS NOT INITIAL.  "Clientes
        IF ls_bsakbsad-shkzg EQ 'S'.
          ls_docsdetiva-wrbtr = ls_docsdetiva-wrbtr + ls_bsakbsad-wrbtr.  "Importe pago
          ls_docsdetiva-dmbtr = ls_docsdetiva-dmbtr  + ls_bsakbsad-dmbtr.  "Importe pago ML
        ENDIF.
        IF ls_bsakbsad-shkzg EQ 'H'.
          ls_docsdetiva-wrbtr = ls_docsdetiva-wrbtr - ls_bsakbsad-wrbtr.  "Importe pago
          ls_docsdetiva-dmbtr = ls_docsdetiva-dmbtr - ls_bsakbsad-dmbtr.  "Importe pago ML
        ENDIF.
      ENDIF.
      IF ls_bsakbsad-lifnr IS NOT INITIAL.  "Proveedores
        IF ls_bsakbsad-shkzg EQ 'S'.
          ls_docsdetiva-wrbtr = ls_docsdetiva-wrbtr - ls_bsakbsad-wrbtr.  "Importe pago
          ls_docsdetiva-dmbtr = ls_docsdetiva-dmbtr - ls_bsakbsad-dmbtr.   "Importe pago ML
        ENDIF.
        IF ls_bsakbsad-shkzg EQ 'H'.
          ls_docsdetiva-wrbtr = ls_docsdetiva-wrbtr + ls_bsakbsad-wrbtr.  "Importe pago
          ls_docsdetiva-dmbtr = ls_docsdetiva-dmbtr + ls_bsakbsad-dmbtr.   "Importe pago ML
        ENDIF.
      ENDIF.

      MODIFY TABLE lt_docsdetiva FROM ls_docsdetiva.

    ELSE.

      READ TABLE lt_bkpf_fi INTO ls_bkpf_fi
                        WITH KEY bukrs = ls_bsakbsad-bukrs
                                 belnr = ls_bsakbsad-belnr
                                 gjahr = ls_bsakbsad-gjahr.

      IF sy-subrc EQ 0.


        MOVE-CORRESPONDING ls_bsakbsad TO ls_docsdetiva.

*        MOVE: ls_bkpf_fi-bktxt TO ls_docsdetiva-bktxt,
*              ls_bkpf_fi-usnam TO ls_docsdetiva-usnam.
        ls_docsdetiva-bktxt = ls_bkpf_fi-bktxt.
        ls_docsdetiva-usnam = ls_bkpf_fi-usnam.

        ls_docsdetiva-waers_mx = 'MXN'.   "     Moneda Local

*     Tipo de Cambio
*        IF ls_docsdetiva-waers EQ 'MXN'.
*          ls_docsdetiva-kursf = 1.
*        ELSE.
        READ TABLE lt_bkpf_tc_pago INTO ls_bkpf_tc_pago
               WITH KEY bukrs = ls_bsakbsad-bukrs
                        belnr = ls_bsakbsad-augbl
                        gjahr = ls_bsakbsad-auggj.
        IF sy-subrc EQ 0.
*            MOVE ls_bkpf_tc_pago-kursf TO ls_docsdetiva-kursf.
          ls_docsdetiva-kursf = ls_bkpf_tc_pago-kursf.
        ENDIF.
*        ENDIF.

*    UUID y Metodo de Pago
        IF ls_bsakbsad-kunnr IS NOT INITIAL.  "Clientes
*          MOVE ls_bsakbsad-kunnr TO ls_docsdetiva-kunnr.
          ls_docsdetiva-kunnr = ls_bsakbsad-kunnr.
          READ TABLE lt_kna1 INTO ls_kna1 WITH KEY kunnr = ls_bsakbsad-kunnr.
          IF sy-subrc EQ 0.
*            MOVE ls_kna1-stcd1 TO ls_docsdetiva-stcd1.
            ls_docsdetiva-stcd1 = ls_kna1-stcd1.
            CONCATENATE ls_kna1-name1 ls_kna1-name2 INTO ls_docsdetiva-name SEPARATED BY space.
          ENDIF.

          CLEAR: lv_vbeln, lv_fecha.
*          SELECT SINGLE vbeln INTO lv_vbeln
*                              FROM bseg
*                             WHERE bukrs EQ ls_bsakbsad-bukrs
*                               AND belnr EQ ls_bsakbsad-belnr
*                               AND gjahr EQ ls_bsakbsad-gjahr
*                               AND buzei EQ ls_bsakbsad-buzei.
          zcl_qry_zhfis_detiva=>zhfis_bseg3( EXPORTING i_operacion = 'READ' ls_bsakbsad = ls_bsakbsad IMPORTING lv_vbeln = lv_vbeln ).

          CONCATENATE '%' ls_bsakbsad-gjahr INTO lv_fecha.
          CONDENSE lv_fecha NO-GAPS.

*          SELECT SINGLE * INTO ls_ztasd_fact_uuid
*                          FROM ztasd_fact_uuid
*                         WHERE vbeln EQ   lv_vbeln
*                           AND bukrs EQ   ls_bsakbsad-bukrs
*                           AND fecha LIKE lv_fecha.
          zcl_qry_zhfis_detiva=>zhfis_ztasd( EXPORTING i_operacion = 'READ' ls_bsakbsad = ls_bsakbsad lv_fecha = lv_fecha lv_vbeln = lv_vbeln
          IMPORTING ls_ztasd_fact_uuid = ls_ztasd_fact_uuid ).

          IF ls_ztasd_fact_uuid IS NOT INITIAL.
            ls_docsdetiva-uuid      = ls_ztasd_fact_uuid-uuid_fac.
            ls_docsdetiva-pymt_meth = ls_ztasd_fact_uuid-metpago.
          ELSE.
*            SELECT SINGLE * INTO ls_zvalida_fi
*                            FROM zvalida_fi
*                               WHERE bukrs EQ ls_bsakbsad-bukrs
*                                 AND belnr EQ ls_bsakbsad-belnr
*                                 AND gjahr EQ ls_bsakbsad-gjahr.
            zcl_qry_zhfis_detiva=>zhfis_zvalida( EXPORTING i_operacion = 'READ' ls_bsakbsad = ls_bsakbsad
            IMPORTING ls_zvalida_fi = ls_zvalida_fi ).

            IF ls_zvalida_fi IS NOT INITIAL.
              ls_docsdetiva-uuid      = ls_zvalida_fi-zuuid.
              ls_docsdetiva-pymt_meth = ls_zvalida_fi-zmpag.
            ENDIF.
          ENDIF.

        ENDIF.

        IF ls_bsakbsad-lifnr IS NOT INITIAL.  "Proveedores
*          MOVE ls_bsakbsad-lifnr TO ls_docsdetiva-lifnr.
          ls_docsdetiva-lifnr = ls_bsakbsad-lifnr.
          READ TABLE lt_lfa1 INTO ls_lfa1 WITH KEY lifnr = ls_bsakbsad-lifnr.
          IF sy-subrc EQ 0.
*            MOVE ls_lfa1-stcd1 TO ls_docsdetiva-stcd1.
            ls_docsdetiva-stcd1 = ls_lfa1-stcd1.
            CONCATENATE ls_lfa1-name1 ls_lfa1-name2 INTO ls_docsdetiva-name SEPARATED BY space.
          ENDIF.

*       UUID

          CLEAR lv_tdline.
          PERFORM read_text USING   'ZUUI'      "UUID
                                    ls_bkpf_fi
                           CHANGING lv_tdline.
*          MOVE lv_tdline TO ls_docsdetiva-uuid.
          ls_docsdetiva-uuid = lv_tdline.

          CLEAR lv_tdline.
          PERFORM read_text USING   'ZMEP'      "Metodo de Pago
                                    ls_bkpf_fi
                           CHANGING lv_tdline.
*          MOVE lv_tdline TO ls_docsdetiva-pymt_meth.
          ls_docsdetiva-pymt_meth = lv_tdline.

        ENDIF.


        LOOP AT lt_bseg INTO ls_bseg
                        WHERE bukrs EQ ls_bsakbsad-bukrs
                          AND belnr EQ ls_bsakbsad-augbl
                          AND gjahr EQ ls_bsakbsad-auggj.

*     Banco
          IF ls_docsdetiva-banka IS INITIAL.
            CLEAR: ls_skb1, ls_t012k, ls_t012, ls_bnka.
            READ TABLE lt_skb1 INTO ls_skb1 WITH KEY bukrs = ls_bseg-bukrs
                                                     saknr = ls_bseg-hkont.
            IF sy-subrc EQ 0.

*              SELECT SINGLE * INTO ls_t012k
*                              FROM t012k
*                             WHERE bukrs EQ ls_bseg-bukrs
*                               AND hbkid EQ ls_skb1-hbkid
*                               AND hktid EQ ls_skb1-hktid.
              zcl_qry_zhfis_detiva=>zhfis_t012k( EXPORTING i_operacion = 'READ' ls_bseg = ls_bseg ls_skb1 = ls_skb1
                                                 IMPORTING ls_t012k = ls_t012k ).

              IF ls_t012k IS NOT INITIAL.

*                MOVE ls_t012k-bankn TO ls_docsdetiva-bankn.
                ls_docsdetiva-bankn = ls_t012k-bankn.

*                SELECT SINGLE * INTO ls_t012
*                             FROM t012
*                            WHERE bukrs EQ ls_bseg-bukrs
*                              AND hbkid EQ ls_skb1-hbkid.
                zcl_qry_zhfis_detiva=>zhfis_t012( EXPORTING i_operacion = 'READ' ls_bseg = ls_bseg ls_skb1 = ls_skb1
                                                  IMPORTING ls_t012 = ls_t012 ).

                IF sy-subrc EQ 0.
*                  SELECT SINGLE * INTO ls_bnka
*                                  FROM bnka
*                                 WHERE banks EQ ls_t012-banks
*                                   AND bankl EQ ls_t012-bankl.
                  zcl_qry_zhfis_detiva=>zhfis_bnka( EXPORTING i_operacion = 'READ' ls_t012 = ls_t012
                                                    IMPORTING ls_bnka = ls_bnka ).

                  IF sy-subrc EQ 0.
*                    MOVE ls_bnka-banka TO ls_docsdetiva-banka.  "BANCO
                    ls_docsdetiva-banka = ls_bnka-banka.
                  ENDIF.
                ENDIF.
              ENDIF.

            ENDIF.
          ENDIF.
        ENDLOOP.

*       En caso de que el Doc. pago no tenga datos bancarios se busca el pago
        CLEAR ls_bkpf_tc_pago.
        READ TABLE lt_bkpf_tc_pago INTO ls_bkpf_tc_pago
                 WITH KEY bukrs = ls_bsakbsad-bukrs
                          belnr = ls_bsakbsad-augbl
                          gjahr = ls_bsakbsad-auggj.

*        MOVE ls_bkpf_tc_pago-bldat TO  ls_docsdetiva-fecha_pago.
        ls_docsdetiva-fecha_pago = ls_bkpf_tc_pago-bldat.

        IF ls_bkpf_tc_pago-blart EQ 'AB'.  "Doc. COntable
          CLEAR: ls_listadoc.
          IF ls_bsakbsad-lifnr IS NOT INITIAL.  "Proveedores
            READ TABLE lt_listadoccompprov INTO ls_listadoc
               WITH KEY bukrs = ls_bsakbsad-bukrs
                        augbl = ls_bsakbsad-augbl
                        auggj = ls_bsakbsad-auggj.
          ENDIF.
          IF ls_bsakbsad-kunnr IS NOT INITIAL.  "Clientes
            READ TABLE lt_listadoccompcli INTO ls_listadoc
               WITH KEY bukrs = ls_bsakbsad-bukrs
                        augbl = ls_bsakbsad-augbl
                        auggj = ls_bsakbsad-auggj.
          ENDIF.

          IF ls_listadoc IS NOT INITIAL.

*            SELECT SINGLE bldat INTO ls_docsdetiva-fecha_pago
*                    FROM bkpf
*                   WHERE bukrs EQ ls_listadoc-bukrs
*                     AND belnr EQ ls_listadoc-belnr
*                     AND gjahr EQ ls_listadoc-gjahr.
*            IF ls_docsdetiva-waers NE 'MXN'.
*             H.  Tipo Cambio del Pago
*              SELECT SINGLE kursf INTO ls_docsdetiva-kursf
*                     FROM bkpf
*                    WHERE bukrs EQ ls_listadoc-bukrs
*                      AND belnr EQ ls_listadoc-belnr
*                      AND gjahr EQ ls_listadoc-gjahr.
*            ENDIF.
            zcl_qry_zhfis_detiva=>zhfis_bkpf3( EXPORTING i_operacion = 'READ' ls_listadoc = ls_listadoc
                                               IMPORTING ls_docsdetiva = ls_docsdetiva ).

            IF ls_docsdetiva-banka IS INITIAL.
              CLEAR: lt_bseg_temp[].
*              SELECT bukrs belnr gjahr buzei koart shkzg dmbtr wrbtr mwskz hkont
*                     INTO TABLE lt_bseg_temp
*                     FROM bseg
*                    WHERE bukrs EQ ls_listadoc-bukrs
*                      AND belnr EQ ls_listadoc-belnr
*                      AND gjahr EQ ls_listadoc-gjahr.
              zcl_qry_zhfis_detiva=>zhfis_bseg4( EXPORTING i_operacion = 'READ' ls_listadoc = ls_listadoc IMPORTING lt_bseg = lt_bseg_temp ).
              LOOP AT lt_bseg_temp INTO ls_bseg_temp.

                CLEAR: ls_skb1, ls_t012k, ls_t012, ls_bnka.
                READ TABLE lt_skb1 INTO ls_skb1 WITH KEY bukrs = ls_bseg_temp-bukrs
                                                         saknr = ls_bseg_temp-hkont.
                IF sy-subrc EQ 0.

*                  SELECT SINGLE * INTO ls_t012k
*                                  FROM t012k
*                                 WHERE bukrs EQ ls_bseg_temp-bukrs
*                                   AND hbkid EQ ls_skb1-hbkid
*                                   AND hktid EQ ls_skb1-hktid.
                  zcl_qry_zhfis_detiva=>zhfis_t012k2( EXPORTING i_operacion = 'READ' ls_bseg_temp = ls_bseg_temp ls_skb1 = ls_skb1
                                                      IMPORTING ls_t012k = ls_t012k ).

                  IF sy-subrc EQ 0.

*                    MOVE ls_t012k-bankn TO ls_docsdetiva-bankn.
                    ls_docsdetiva-bankn = ls_t012k-bankn.


*                    SELECT SINGLE * INTO ls_t012
*                                 FROM t012
*                                WHERE bukrs EQ ls_bseg_temp-bukrs
*                                  AND hbkid EQ ls_skb1-hbkid.

                    zcl_qry_zhfis_detiva=>zhfis_t012V2( EXPORTING i_operacion = 'READ' ls_bseg_temp = ls_bseg_temp ls_skb1 = ls_skb1
                                                        IMPORTING ls_t012 = ls_t012 ).
                    IF sy-subrc EQ 0.
*                      SELECT SINGLE * INTO ls_bnka
*                                      FROM bnka
*                                     WHERE banks EQ ls_t012-banks
*                                       AND bankl EQ ls_t012-bankl.
                      zcl_qry_zhfis_detiva=>zhfis_bnka( EXPORTING i_operacion = 'READ' ls_t012 = ls_t012 IMPORTING ls_bnka = ls_bnka ).
                      IF sy-subrc EQ 0.
*                        MOVE ls_bnka-banka TO ls_docsdetiva-banka.  "BANCO
                        ls_docsdetiva-banka = ls_bnka-banka.
                      ENDIF.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDIF.

        LOOP AT lt_bseg INTO ls_bseg
                        WHERE bukrs EQ ls_bsakbsad-bukrs
                          AND belnr EQ ls_bsakbsad-belnr
                          AND gjahr EQ ls_bsakbsad-gjahr.
          IF ls_bseg-koart NE 'K' AND ls_bseg-koart NE 'D' AND
             ( ls_bseg-hkont NE '0010600001' AND ls_bseg-hkont NE '0010600002' AND
               ls_bseg-hkont NE '0010601002' AND ls_bseg-hkont NE '0010600005').
            IF ls_bsakbsad-kunnr IS NOT INITIAL.  "Clientes
              IF ls_bseg-shkzg EQ 'S'.
                ls_docsdetiva-subtotal = ls_docsdetiva-subtotal  - ls_bseg-dmbtr.  "Importe pago ML
              ENDIF.
              IF ls_bseg-shkzg EQ 'H'.
                ls_docsdetiva-subtotal = ls_docsdetiva-subtotal + ls_bseg-dmbtr.  "Importe pago ML
              ENDIF.
            ENDIF.
            IF ls_bsakbsad-lifnr IS NOT INITIAL.  "Proveedores
              IF ls_bseg-shkzg EQ 'S'.
                ls_docsdetiva-subtotal = ls_docsdetiva-subtotal + ls_bseg-dmbtr.   "Importe pago ML
              ENDIF.
              IF ls_bseg-shkzg EQ 'H'.
                ls_docsdetiva-subtotal = ls_docsdetiva-subtotal - ls_bseg-dmbtr.   "Importe pago ML
              ENDIF.
            ENDIF.
          ENDIF.

* IVA 16%
          IF ( ls_bseg-hkont EQ '0010600001' AND ls_bseg-mwskz EQ 'X4' ) OR
             ( ls_bseg-hkont EQ '0010600002' AND ls_bseg-mwskz EQ 'V4' ) OR
             ( ls_bseg-hkont EQ '0010601002' AND ls_bseg-mwskz EQ 'A4' ) OR
             ( ls_bseg-hkont EQ '0010600005' AND ls_bseg-mwskz EQ 'V5' ).
            IF ls_bsakbsad-kunnr IS NOT INITIAL.  "Clientes
              IF ls_bseg-shkzg EQ 'S'.
*                ls_docsdetiva-tax_16 = ls_docsdetiva-tax_16  - ls_bseg-dmbtr.  "Importe pago ML
                ls_docsdetiva-tax_16 = ls_docsdetiva-tax_16  - ls_bseg-wrbtr.    "Importe pago MD
              ENDIF.
              IF ls_bseg-shkzg EQ 'H'.
*                ls_docsdetiva-tax_16 = ls_docsdetiva-tax_16 + ls_bseg-dmbtr.  "Importe pago ML
                ls_docsdetiva-tax_16 = ls_docsdetiva-tax_16 + ls_bseg-wrbtr.  "Importe pago MD
              ENDIF.
            ENDIF.
            IF ls_bsakbsad-lifnr IS NOT INITIAL.  "Proveedores
              IF ls_bseg-shkzg EQ 'S'.
*                ls_docsdetiva-tax_16 = ls_docsdetiva-tax_16 + ls_bseg-dmbtr.   "Importe pago ML
                ls_docsdetiva-tax_16 = ls_docsdetiva-tax_16 + ls_bseg-wrbtr.   "Importe pago MD
              ENDIF.
              IF ls_bseg-shkzg EQ 'H'.
*                ls_docsdetiva-tax_16 = ls_docsdetiva-tax_16 - ls_bseg-dmbtr.   "Importe pago ML
                ls_docsdetiva-tax_16 = ls_docsdetiva-tax_16 - ls_bseg-wrbtr.   "Importe pago MD
              ENDIF.
            ENDIF.
          ENDIF.

* IVA 8%
          IF ( ls_bseg-hkont EQ '0010600001' AND ls_bseg-mwskz EQ 'X6' ) OR
             ( ls_bseg-hkont EQ '0010600002' AND ls_bseg-mwskz EQ 'V6' ).
            IF ls_bsakbsad-kunnr IS NOT INITIAL.  "Clientes
              IF ls_bseg-shkzg EQ 'S'.
*                ls_docsdetiva-tax_8 = ls_docsdetiva-tax_8  - ls_bseg-dmbtr.  "Importe pago ML
                ls_docsdetiva-tax_8 = ls_docsdetiva-tax_8  - ls_bseg-wrbtr.  "Importe pago MD
              ENDIF.
              IF ls_bseg-shkzg EQ 'H'.
*                ls_docsdetiva-tax_8 = ls_docsdetiva-tax_8 + ls_bseg-dmbtr.  "Importe pago ML
                ls_docsdetiva-tax_8 = ls_docsdetiva-tax_8 + ls_bseg-wrbtr.  "Importe pago MD
              ENDIF.
            ENDIF.
            IF ls_bsakbsad-lifnr IS NOT INITIAL.  "Proveedores
              IF ls_bseg-shkzg EQ 'S'.
*                ls_docsdetiva-tax_8 = ls_docsdetiva-tax_8 + ls_bseg-dmbtr.   "Importe pago ML
                ls_docsdetiva-tax_8 = ls_docsdetiva-tax_8 + ls_bseg-wrbtr.   "Importe pago MD
              ENDIF.
              IF ls_bseg-shkzg EQ 'H'.
*                ls_docsdetiva-tax_8 = ls_docsdetiva-tax_8 - ls_bseg-dmbtr.   "Importe pago ML
                ls_docsdetiva-tax_8 = ls_docsdetiva-tax_8 - ls_bseg-wrbtr.   "Importe pago MD
              ENDIF.
            ENDIF.
          ENDIF.

        ENDLOOP.

*     Retenciones
* las retenciones como estan gurdadas como negativo se convierten a positivo
        LOOP AT lt_retenciones INTO ls_retenciones
                              WHERE bukrs EQ ls_bsakbsad-bukrs
                                AND belnr EQ ls_bsakbsad-belnr
                                AND gjahr EQ ls_bsakbsad-gjahr.
          IF ls_retenciones-witht EQ '01' OR ls_retenciones-witht EQ '04'.
            IF ls_retenciones-wt_withcd EQ '01' OR ls_retenciones-wt_withcd BETWEEN '10' AND '16'.
              ls_docsdetiva-retencion_isr = ls_docsdetiva-retencion_isr + ( ls_retenciones-wt_qbshh * -1 ).
            ELSE.
              ls_docsdetiva-retencion_otro = ls_docsdetiva-retencion_otro + ( ls_retenciones-wt_qbshh * -1 ).
            ENDIF.
          ELSEIF ls_retenciones-witht EQ '02' OR ls_retenciones-witht EQ '03' OR ls_retenciones-witht EQ '05'
            OR ls_retenciones-witht EQ '06' OR ls_retenciones-witht EQ '08' OR ls_retenciones-witht EQ '09'.
            IF  ls_retenciones-wt_withcd BETWEEN '03' AND '09' OR ls_retenciones-wt_withcd BETWEEN '16' AND '19'.
              ls_docsdetiva-retencion_iva = ls_docsdetiva-retencion_iva + ( ls_retenciones-wt_qbshh * -1 ).
            ELSE.
              ls_docsdetiva-retencion_otro = ls_docsdetiva-retencion_otro + ( ls_retenciones-wt_qbshh * -1 ).
            ENDIF.
          ELSE.
            ls_docsdetiva-retencion_otro = ls_docsdetiva-retencion_otro + ( ls_retenciones-wt_qbshh * -1 ).
          ENDIF.

        ENDLOOP.

        APPEND ls_docsdetiva TO lt_docsdetiva.
      ENDIF.
    ENDIF.
  ENDLOOP.

  LOOP AT lt_docsdetiva INTO ls_docsdetiva.
*    ls_docsdetiva-subtotal = ABS( ls_docsdetiva-subtotal ).
*    ls_docsdetiva-tax_16   = ABS( ls_docsdetiva-tax_16 ).
    IF ls_docsdetiva-waers NE ls_docsdetiva-waers_mx.
      ls_docsdetiva-tax_16 = ls_docsdetiva-tax_16 * ls_docsdetiva-kursf.
      ls_docsdetiva-tax_8  = ls_docsdetiva-tax_8 * ls_docsdetiva-kursf.
    ENDIF.
    ls_docsdetiva-subtotal = ls_docsdetiva-subtotal - ( ls_docsdetiva-retencion_isr + ls_docsdetiva-retencion_iva + ls_docsdetiva-retencion_otro ).
    ls_docsdetiva-total = ( ls_docsdetiva-subtotal + ls_docsdetiva-tax_16 + ls_docsdetiva-tax_8 ).
*                         ( ls_docsdetiva-retencion_isr + ls_docsdetiva-retencion_iva + ls_docsdetiva-retencion_otro ).
    IF ls_docsdetiva-kursf IS INITIAL.
      ls_docsdetiva-kursf = 1.
    ENDIF.

    ls_docsdetiva-subtotal_md       = ls_docsdetiva-subtotal / ls_docsdetiva-kursf.
    ls_docsdetiva-tax_16_md         = ls_docsdetiva-tax_16 / ls_docsdetiva-kursf.
    ls_docsdetiva-tax_8_md          = ls_docsdetiva-tax_8 / ls_docsdetiva-kursf.
    ls_docsdetiva-retencion_isr_md  = ls_docsdetiva-retencion_isr / ls_docsdetiva-kursf.
    ls_docsdetiva-retencion_iva_md  = ls_docsdetiva-retencion_iva / ls_docsdetiva-kursf.
    ls_docsdetiva-retencion_otro_md = ls_docsdetiva-retencion_otro / ls_docsdetiva-kursf.
    ls_docsdetiva-total_md          = ls_docsdetiva-total / ls_docsdetiva-kursf.

    MODIFY TABLE lt_docsdetiva FROM ls_docsdetiva.
  ENDLOOP.


  e_docsdetiva[] = lt_docsdetiva[].
ENDFUNCTION.
