FUNCTION zvts_gr_list.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(VENDOR) TYPE  ELIFN
*"     VALUE(COMPANY) TYPE  BUKRS OPTIONAL
*"     VALUE(WO_GRS) TYPE  ZCHAR01 OPTIONAL
*"     VALUE(W_GRS) TYPE  ZCHAR01 OPTIONAL
*"     VALUE(W_IRS) TYPE  ZCHAR01 OPTIONAL
*"     VALUE(W_PAY) TYPE  ZCHAR01 OPTIONAL
*"     VALUE(PO_SNUMBER) TYPE  EBELN OPTIONAL
*"     VALUE(PO_ENUMBER) TYPE  EBELN OPTIONAL
*"     VALUE(PO_SDATE) TYPE  ERDAT OPTIONAL
*"     VALUE(PO_EDATE) TYPE  ERDAT OPTIONAL
*"     VALUE(GRS_SDATE) TYPE  ERDAT OPTIONAL
*"     VALUE(GRS_EDATE) TYPE  ERDAT OPTIONAL
*"     VALUE(IRS_SDATE) TYPE  ERDAT OPTIONAL
*"     VALUE(IRS_EDATE) TYPE  ERDAT OPTIONAL
*"     VALUE(PAY_SDATE) TYPE  ERDAT OPTIONAL
*"     VALUE(PAY_EDATE) TYPE  ERDAT OPTIONAL
*"     VALUE(RECORDS) TYPE  ZINT4 OPTIONAL
*"  EXPORTING
*"     VALUE(MESSAGE) TYPE  ZCHAR255
*"     VALUE(MORE) TYPE  ZCHAR01
*"     VALUE(GRS_LIST) TYPE  ZTT_VTS_GRS_LIST
*"----------------------------------------------------------------------
      DATA:prov(10), provc(10) TYPE n, t_menge LIKE zes_ekbe-menge, dp_key like zes_bkpf-awkey.

*    - entradas
*      data: begin of t_ent,
*             ebeln like zes_ekbe-ebeln,
*             porc like sy-tabix,
*            end of t_ent.

*    - verif. factura
*      data: begin of t_ver,
*             ebeln like zes_ekbe-ebeln,
*             porc like sy-tabix,
*            end of t_ver.

*    - pagos
*      data: begin of t_pag,
*             ebeln like zes_ekbe-ebeln,
*             porc like sy-tabix,
*            end of t_pag.


      data: v_fec_ped1 LIKE zes_bkpf-bldat,
            v_fec_ped2 LIKE zes_bkpf-bldat,
            v_fec_pag1 LIKE zes_bkpf-bldat,
            v_fec_pag2 LIKE zes_bkpf-bldat,
            v_fec_ent1 LIKE zes_bkpf-bldat,
            v_fec_ent2 LIKE zes_bkpf-bldat,
            v_fec_ver1 LIKE zes_bkpf-bldat,
            v_fec_ver2 LIKE zes_bkpf-bldat.


      TYPES: BEGIN OF TY_PAGOS,
              EBELN LIKE ZEKPO-EBELN,                    " No. Pedido
              EBELP LIKE ZEKPO-EBELP,                    " Posicion
              BUKRS LIKE ZEKPO-BUKRS,                    " Sociedad
              MATNR LIKE ZEKPO-MATNR,                    " Material
              MEINS LIKE ZEKPO-MEINS,                    " Unidad Medida
              TXZ01 LIKE ZEKPO-TXZ01,                    " Desc. Material
              PSTYP LIKE ZEKPO-PSTYP,
              WERKS LIKE ZEKPO-WERKS,
              MENGE LIKE ZES_EKBE-MENGE,                    " Cant. Eda.
              MATNR_D(18),                               " Material long 8
              BEDAT LIKE ZEKKO-BEDAT,                    " Fecha Pedido
              WRBTR LIKE ZES_EKBE-WRBTR,                    " Importe verif.
              BUDAT LIKE ZES_EKBE-BUDAT,                    " Fecha Eda.
              MENGE2 LIKE ZES_EKBE-MENGE,                   " Cant. Verificada
              BUDAT2 LIKE ZES_EKBE-BUDAT,                   " Fecha Verificacion
*              maktx like makt-maktx,                    " Desc. Material
              BELNR LIKE ZES_EKBE-BELNR,                    " Doc. Compras
              GJAHR LIKE ZES_EKBE-GJAHR,                    " Periodo
              WRBTR2 LIKE ZES_EKBE-WRBTR,                    " Importe verif.
              WAERS LIKE ZES_EKBE-WAERS,                    " Moneda
              WAERS2 LIKE ZES_EKBE-WAERS,                    " Moneda
              AUGBL LIKE ZST_BSEG-AUGBL,                    "
              AUGDT LIKE ZST_BSEG-AUGDT,                    " FEcha PAgo
              PSWBT LIKE ZST_BSEG-PSWBT,                    " PAgo
              PSWSL LIKE ZST_BSEG-PSWSL,
              ZUONR LIKE ZST_BSEG-ZUONR,                    " Asignacion
              ZFBDT LIKE ZST_BSEG-ZFBDT,
              ZTERM LIKE ZST_BSEG-ZTERM,
              ZBD1T LIKE ZST_BSEG-ZBD1T,
              ZBD2T LIKE ZST_BSEG-ZBD2T,
              ZBD3T LIKE ZST_BSEG-ZBD3T,
              ZBD1P LIKE ZST_BSEG-ZBD1P,
              ZBD2P LIKE ZST_BSEG-ZBD2P,
              SKFBT LIKE ZST_BSEG-SKNTO,
              WSKTO LIKE ZST_BSEG-SKNTO,
              SGTXT LIKE ZST_BSEG-SGTXT,
              PORC(3),
              DET(1),
              CANT_DEV LIKE ZES_EKBE-MENGE,
              DEVOLUCION(1),
              elikz like Zekpo-elikz, " Ent. final
              erekz like Zekpo-erekz, " Fact. final
      END OF TY_PAGOS.

      TYPES: BEGIN OF TY_PAGOSH,
          EBELN  LIKE ZEKPO-EBELN,                    " No. Pedido
          BUKRS  LIKE ZEKPO-BUKRS,                    " Sociedad
          BELNR  LIKE ZES_EKBE-BELNR,                    " Doc. Compras
          GJAHR  LIKE ZES_EKBE-GJAHR,                    " Periodo
          BEDAT  LIKE ZEKKO-BEDAT,                    " Fecha Pedido
          WRBTR  LIKE ZES_EKBE-WRBTR,                    " Importe Eda.
          BUDAT  LIKE ZES_EKBE-BUDAT,                    " Fecha Eda.
          WAERS  LIKE ZES_EKBE-WAERS,                    " Moneda Eda.
          WRBTR2 LIKE ZES_EKBE-WRBTR,                   " Importe verif.
          BUDAT2 LIKE ZES_EKBE-BUDAT,                   " Fecha Verificacion
          WAERS2 LIKE ZES_EKBE-WAERS,                   " Moneda Verif.
          AUGBL  LIKE ZST_BSEG-AUGBL,                    "
          AUGDT  LIKE ZST_BSEG-AUGDT,                    " FEcha PAgo
          PSWBT  LIKE ZST_BSEG-PSWBT,                    " PAgo
          PSWSL  LIKE ZST_BSEG-PSWSL,
          ZUONR  LIKE ZST_BSEG-ZUONR,                    " Asignacion
          ZFBDT  LIKE ZST_BSEG-ZFBDT,
          ZTERM  LIKE ZST_BSEG-ZTERM,
          ZBD1T  LIKE ZST_BSEG-ZBD1T,
          ZBD2T  LIKE ZST_BSEG-ZBD2T,
          ZBD3T  LIKE ZST_BSEG-ZBD3T,
          ZBD1P  LIKE ZST_BSEG-ZBD1P,
          ZBD2P  LIKE ZST_BSEG-ZBD2P,
          SKFBT  LIKE ZST_BSEG-SKNTO,
          WSKTO  LIKE ZST_BSEG-SKNTO,
          SGTXT  LIKE ZST_BSEG-SGTXT,
          PORC(3),                                  " Porcentaje
          DET(1),                                   " Ver detalle.
          CANT_DEV LIKE ZES_EKBE-MENGE,
          DEVOLUCION(1),
      END OF TY_PAGOSH.

      TYPES: BEGIN OF TY_EKKO,
            EBELN LIKE ZEKKO-EBELN,
      END OF TY_EKKO.

      TYPES: BEGIN OF TY_PEDIDOS,
            SIGN(1)   TYPE C,
            OPTION(2) TYPE C,
            LOW  LIKE ZEKKO-EBELN,
            HIGH LIKE ZEKKO-EBELN,
      END OF TY_PEDIDOS.

      TYPES: BEGIN OF TY_BEDAT,
           SIGN(1)   TYPE C,
           OPTION(2) TYPE C,
           LOW  LIKE ZEKKO-BEDAT,
           HIGH LIKE ZEKKO-BEDAT,
      END OF TY_BEDAT.

      TYPES: BEGIN OF TY_BUDAT,
           SIGN(1)   TYPE C,
           OPTION(2) TYPE C,
           LOW  LIKE ZES_EKBE-BUDAT,
           HIGH LIKE ZES_EKBE-BUDAT,
      END OF TY_BUDAT.

      TYPES: BEGIN OF TY_BUDAT2,
           SIGN(1)   TYPE C,
           OPTION(2) TYPE C,
           LOW  LIKE ZES_EKBE-BUDAT,
           HIGH LIKE ZES_EKBE-BUDAT,
      END OF TY_BUDAT2.

      TYPES: BEGIN OF TY_AUGDT,
           SIGN(1)   TYPE C,
           OPTION(2) TYPE C,
           LOW  LIKE ZST_BSEG-AUGDT,
           HIGH LIKE ZST_BSEG-AUGDT,
      END OF TY_AUGDT.

      TYPES: BEGIN OF TY_bukrs,
           SIGN(1)   TYPE C,
           OPTION(2) TYPE C,
           LOW  LIKE ZEKKO-bukrs,
           HIGH LIKE ZEKKO-bukrs,
      END OF TY_bukrs.

      TYPES: BEGIN OF ty_ent,
             ebeln like zes_ekbe-ebeln,
             porc like sy-tabix,
      END OF ty_ent.

      TYPES: BEGIN OF ty_ver,
             ebeln like zes_ekbe-ebeln,
             porc like sy-tabix,
      END OF ty_ver.

      TYPES: BEGIN OF ty_pag,
             ebeln like zes_ekbe-ebeln,
             porc like sy-tabix,
            END OF ty_pag.

      DATA: t_ent       TYPE STANDARD TABLE OF ty_ent,
            wa_ent      LIKE LINE OF t_ent.

      DATA: T_PAGOS     TYPE STANDARD TABLE OF TY_PAGOS,
            WA_PAGOS    LIKE LINE OF T_PAGOS.

      DATA: T_PAGOS2    TYPE STANDARD TABLE OF TY_PAGOS,
            WA_PAGOS2   LIKE LINE OF T_PAGOS2.

      DATA: T_PAGOSH    TYPE STANDARD TABLE OF TY_PAGOSH,
            WA_PAGOSH   LIKE LINE OF T_PAGOSH.

      DATA: T_PAGOSH2   TYPE STANDARD TABLE OF TY_PAGOSH,
            WA_PAGOSH2  LIKE LINE OF T_PAGOSH2.

      DATA: TH_EKKO     TYPE STANDARD TABLE OF TY_EKKO,
            WA_EKKO     LIKE LINE OF T_PAGOSH2.

      DATA: tr_pedidos  TYPE STANDARD TABLE OF ty_pedidos,
            wa_pedidos  LIKE LINE OF tr_pedidos.

      DATA: T_BEDAT     TYPE STANDARD TABLE OF TY_BEDAT,
            wa_BEDAT    LIKE LINE OF T_BEDAT.

      DATA: T_BUDAT     TYPE STANDARD TABLE OF TY_BUDAT,
            WA_BUDAT    LIKE LINE OF T_BUDAT.

      DATA: T_BUDAT2    TYPE STANDARD TABLE OF TY_BUDAT2,
            WA_BUDAT2   LIKE LINE OF T_BUDAT2.

      DATA: T_AUGDT     TYPE STANDARD TABLE OF TY_AUGDT,
            WA_AUGDT    LIKE LINE OF T_AUGDT.

      DATA: p_bukrs     TYPE STANDARD TABLE OF ty_bukrs,
            wa_bukrs    LIKE LINE OF p_bukrs.

      DATA: it_ekko     TYPE ztt_ekko.
      DATA: it_ekko_tmp TYPE ztt_ekko,
            wa_ekko_tmp LIKE LINE OF it_ekko_tmp.

      DATA: it_ekpo     TYPE ztt_ekpo,
            wa_ekpo     LIKE LINE OF it_ekpo.

      DATA: tr_pedidos_ekpo TYPE STANDARD TABLE OF ty_pedidos,
            wa_pedidos_ekpo LIKE LINE OF tr_pedidos_ekpo.

      DATA: c_ent LIKE zekpo-menge,
            c_sal LIKE zekpo-menge,
            dif   LIKE zekpo-menge.

      DATA: it_ekbe TYPE ztt_ekbe,
            wa_ekbe LIKE LINE OF it_ekbe.

      DATA: it_bkpf TYPE zfi_tt_allx_bkpf,
            wa_bkpf LIKE LINE OF it_bkpf.

      DATA: it_bseg TYPE ztt_lt_fi_item,
            wa_bseg LIKE LINE OF it_bseg.

      DATA: t_ver   TYPE STANDARD TABLE OF ty_ver,
            wa_ver  LIKE LINE OF t_ver.

      DATA: t_pag       TYPE STANDARD TABLE OF ty_pag,
            wa_pag      LIKE LINE OF t_pag.

      DATA: it_grs_list TYPE ztt_vts_grs_list,
            wa_grs_list LIKE LINE OF it_grs_list.

      DATA: it_ekko2    TYPE ztt_ekko,
            wa_ekko2    LIKE LINE OF it_ekko2.

      CLEAR: t_ent, t_ver, t_pag, it_ekko, it_ekko_tmp, wa_ekko_tmp, it_ekpo, wa_ekpo.
      CLEAR: wa_ent, tr_pedidos_ekpo, wa_pedidos_ekpo, it_ekbe.
      CLEAR: it_bkpf, wa_bkpf, it_bseg, wa_bseg, t_ver, wa_ver, it_ekko2, wa_ekko2 .

      CLEAR prov.
      IF vendor CA 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
        prov  = vendor.
      ELSE.
        provc = vendor.
        prov  = provc.
      ENDIF.

*       PERFORM valida_fechas using PO_SDATE  PO_EDATE
*                                   GRS_SDATE GRS_EDATE
*                                   IRS_SDATE IRS_EDATE
*                                   PAY_SDATE PAY_EDATE.

      CLEAR: v_fec_ped1, v_fec_ped2, v_fec_ent1, v_fec_ent2, v_fec_ver1,
             v_fec_ver2, v_fec_pag1, v_fec_pag2.

      IF NOT po_sdate IS INITIAL.
*        PERFORM val_fec USING: PO_SDATE v_fec_ped1.
        v_fec_ped1 = po_sdate.
      ENDIF.
*      CHECK sy-subrc EQ 0.

      IF NOT po_edate IS INITIAL.
*        PERFORM val_fec USING: PO_EDATE v_fec_ped2.
        v_fec_ped2 = po_edate.
      ENDIF.
*      CHECK sy-subrc EQ 0.

      IF NOT grs_sdate IS INITIAL.
*        PERFORM val_fec USING: GRS_SDATE v_fec_ent1.
        v_fec_ent1 = grs_sdate.
      ENDIF.
*      CHECK sy-subrc EQ 0.

      IF NOT grs_edate IS INITIAL.
*        PERFORM val_fec USING: GRS_EDATE v_fec_ent2.
        v_fec_ent2 = grs_edate.
      ENDIF.
*      CHECK sy-subrc EQ 0.

      IF NOT irs_sdate IS INITIAL.
*        PERFORM val_fec USING: IRS_SDATE v_fec_ver1.
        v_fec_ver1 = irs_sdate.
      ENDIF.
*      CHECK sy-subrc EQ 0.

      IF NOT irs_edate IS INITIAL.
*        PERFORM val_fec USING: IRS_EDATE v_fec_ver2.
        v_fec_ver2 = irs_edate.
      ENDIF.
*      CHECK sy-subrc EQ 0.

      IF NOT pay_sdate IS INITIAL.
*        PERFORM val_fec USING: PAY_SDATE v_fec_pag1.
        v_fec_pag1 = pay_sdate.
      ENDIF.
*      CHECK sy-subrc EQ 0.

      IF NOT pay_edate IS INITIAL.
*        PERFORM val_fec USING: PAY_EDATE v_fec_pag2.
        v_fec_pag2 = pay_edate.
      ENDIF.
*      CHECK sy-subrc EQ 0.


      CLEAR: t_pagos, t_pagos2, t_pagosh, t_pagosh2, th_ekko.
      CLEAR: wa_pagos, wa_pagos2, wa_pagosh, wa_pagosh2, wa_ekko.

*      PERFORM rangos using  PO_SNUMBER PO_ENUMBER COMPANY.

      CLEAR tr_pedidos.
      CLEAR wa_pedidos.

      IF po_snumber NE space AND po_enumber  NE space.
        wa_pedidos-sign   = 'I'.
        wa_pedidos-option = 'BT'.
        wa_pedidos-low    = po_snumber.
        wa_pedidos-high   = po_enumber.
        APPEND wa_pedidos TO tr_pedidos.
      ENDIF.
      IF ( po_snumber EQ space AND po_enumber  NE space ) OR
         ( po_snumber NE space AND po_enumber  EQ space ).
        wa_pedidos-sign   = 'I'.
        wa_pedidos-option = 'EQ'.
        wa_pedidos-low    = po_snumber.
        wa_pedidos-high   = po_enumber.
        APPEND wa_pedidos TO tr_pedidos.
      ENDIF.

      CLEAR t_bedat.
      CLEAR wa_bedat.

      " CONTINUAR
      IF v_fec_ped1 NE 0 AND v_fec_ped2 NE 0.
        wa_bedat-sign   = 'I'.
        wa_bedat-option = 'BT'.
        wa_bedat-low    = v_fec_ped1.
        wa_bedat-high   = v_fec_ped2.
        APPEND wa_bedat TO t_bedat.
      ENDIF.
      IF ( v_fec_ped1 EQ 0 AND v_fec_ped2 NE 0 ) OR
         ( v_fec_ped1 NE 0 AND v_fec_ped2 EQ 0 ).
        wa_bedat-sign   = 'I'.
        wa_bedat-option = 'EQ'.
        wa_bedat-low    = v_fec_ped1.
        wa_bedat-high   = v_fec_ped2.
        APPEND wa_bedat TO t_bedat.
      ENDIF.

      CLEAR t_budat.
      CLEAR wa_budat.
      IF v_fec_ent1 NE 0 AND v_fec_ent2 NE 0.
        wa_budat-sign   = 'I'.
        wa_budat-option = 'BT'.
        wa_budat-low    = v_fec_ent1.
        wa_budat-high   = v_fec_ent2.
        APPEND wa_budat TO t_budat.
      ENDIF.

      IF ( v_fec_ent1 EQ 0 AND v_fec_ent2 NE 0 ) OR
         ( v_fec_ent1 NE 0 AND v_fec_ent2 EQ 0 ).
        wa_budat-sign   = 'I'.
        wa_budat-option = 'EQ'.
        wa_budat-low    = v_fec_ent1.
        wa_budat-high   = v_fec_ent2.
        APPEND wa_budat TO t_budat.
      ENDIF.

      CLEAR t_budat2.
      CLEAR wa_budat2.
      IF v_fec_ver1 NE 0 AND v_fec_ver2 NE 0.
        wa_budat2-sign    = 'I'.
        wa_budat2-option  = 'BT'.
        wa_budat2-low     = v_fec_ver1.
        wa_budat2-high    = v_fec_ver2.
        APPEND wa_budat2 TO t_budat2.
      ENDIF.
      IF ( v_fec_ver1 EQ 0 AND v_fec_ver2 NE 0 ) OR
         ( v_fec_ver1 NE 0 AND v_fec_ver2 EQ 0 ).
        wa_budat2-sign   = 'I'.
        wa_budat2-option = 'EQ'.
        wa_budat2-low    = v_fec_ver1.
        wa_budat2-high   = v_fec_ver2.
        APPEND wa_budat2 TO t_budat2.
      ENDIF.

      CLEAR t_augdt.
      CLEAR wa_augdt.
      IF v_fec_pag1 NE 0 AND v_fec_pag2 NE 0.
        wa_augdt-sign   = 'I'.
        wa_augdt-option = 'BT'.
        wa_augdt-low    =  v_fec_pag1.
        wa_augdt-high   =  v_fec_pag2.
        APPEND wa_augdt TO t_augdt.
      ENDIF.

      IF ( v_fec_pag1 EQ 0 AND v_fec_pag2 NE 0 ) OR
         ( v_fec_pag1 NE 0 AND v_fec_pag2 EQ 0 ).
        wa_augdt-sign   = 'I'.
        wa_augdt-option = 'EQ'.
        wa_augdt-low    =  v_fec_pag1.
        wa_augdt-high   = v_fec_pag2.
        APPEND wa_augdt TO t_augdt.
      ENDIF.

*     ---  rango x cias
      CLEAR: p_bukrs.
      CLEAR: wa_bukrs.
      IF NOT company IS INITIAL.
        wa_bukrs-sign   = 'I'.
        wa_bukrs-option = 'EQ'.
        wa_bukrs-low    = company.
        APPEND wa_bukrs TO p_bukrs.
      ENDIF.

      IF NOT tr_pedidos[] IS INITIAL.
*        SELECT ebeln INTO TABLE th_ekko
*           FROM ekko
*           WHERE EBELN in tr_pedidos
*             AND lifnr EQ prov
*             and bukrs in p_bukrs
*             AND bstyp EQ 'F'
*             AND ( frgke EQ 'D' or frgke EQ 'E' or frgke EQ 'F' or frgke EQ space )
*             AND loekz eq space.


      zcl_ekko_gr_list=>ekko_get( EXPORTING i_operacion  = 'READ'
                                    et_ebeln     = tr_pedidos
                                    ev_lifnr     = prov
                                    et_bukrs     = p_bukrs
                                    ev_bstyp     = 'F'
                                    ev_loekz     = space
                                    ev_filter    = 'A'
                          IMPORTING et_ekko      = it_ekko ).

      MOVE-CORRESPONDING it_ekko TO th_ekko.

      ELSEIF PO_SDATE IS INITIAL AND PO_SNUMBER IS INITIAL.
*        SELECT ebeln INTO TABLE th_ekko
*           FROM ekko
*           WHERE lifnr EQ prov
*             and bukrs in p_bukrs
*             AND bstyp EQ 'F'
*             AND ( frgke EQ 'D' or frgke EQ 'E' or frgke EQ 'F' or frgke EQ space )
*             AND loekz eq space.

        zcl_ekko_gr_list=>ekko_get( EXPORTING i_operacion  = 'READ'
                                    "et_ebeln     = tr_pedidos_empty   "* Tabla Vacia"
                                    ev_lifnr     = prov
                                    et_bukrs     = p_bukrs
                                    ev_bstyp     = 'F'
                                    ev_loekz     = space
                                    ev_filter    = 'B'
                          IMPORTING et_ekko      = it_ekko ).

        MOVE-CORRESPONDING it_ekko TO th_ekko.

      ELSE.
        IF wa_bedat-low NE 0 AND wa_bedat-high NE 0.

*        SELECT ebeln into th_ekko-ebeln
*          FROM ekko
*           up to RECORDS rows
*           WHERE ebeln IN tr_pedidos
*             AND lifnr EQ prov
*             and bukrs in p_bukrs
*             AND bstyp EQ 'F'
*             AND bedat IN t_bedat
*             AND ( frgke EQ 'D' or frgke EQ 'E' or frgke EQ 'F' or frgke EQ space )
*             AND loekz eq space
*            order by ebeln.
*             append th_ekko.
*        ENDSELECT.


          zcl_ekko_gr_list=>ekko_get( EXPORTING i_operacion  = 'READ'
                                    et_ebeln     = tr_pedidos   "* Tabla Vacia"
                                    ev_lifnr     = prov
                                    et_bukrs     = p_bukrs
                                    ev_bstyp     = 'F'
                                    et_bedat     = t_bedat

                                    ev_loekz     = space
                                    ev_filter    = 'C'
                                      IMPORTING et_ekko      = it_ekko_tmp ).

          IF it_ekko_tmp IS NOT INITIAL.

            LOOP AT it_ekko_tmp INTO wa_ekko_tmp.
              IF sy-tabix =< records.
                APPEND wa_ekko_tmp TO it_ekko.
              ENDIF.
            ENDLOOP.

            MOVE-CORRESPONDING it_ekko TO th_ekko.

          ENDIF.


        ELSEIF wa_bedat-low NE 0 AND wa_bedat-high EQ 0.
*        SELECT ebeln INTO TABLE th_ekko
*           FROM ekko
*           WHERE ebeln IN tr_pedidos
*             AND lifnr EQ prov
*             and bukrs in p_bukrs
*             AND bstyp EQ 'F'
*             AND bedat IN t_bedat
*             AND ( frgke EQ 'D' or frgke EQ 'E' or frgke EQ 'F' or frgke EQ space )
*             AND loekz eq space.

          zcl_ekko_gr_list=>ekko_get( EXPORTING i_operacion  = 'READ'
                                    et_ebeln     = tr_pedidos   "* Tabla Vacia"
                                    ev_lifnr     = prov
                                    et_bukrs     = p_bukrs
                                    ev_bstyp     = 'F'
                                    et_bedat     = t_bedat

                                    ev_loekz     = space
                                    ev_filter    = 'C'
                                      IMPORTING et_ekko      = it_ekko ).

          MOVE-CORRESPONDING it_ekko TO th_ekko.

          IF it_ekko_tmp IS NOT INITIAL.

            LOOP AT it_ekko_tmp INTO wa_ekko_tmp.
              IF sy-tabix =< records.
                APPEND wa_ekko_tmp TO it_ekko.
              ENDIF.
            ENDLOOP.

          ENDIF.
        ENDIF.
      ENDIF.

      CHECK th_ekko IS NOT INITIAL.
      SORT th_ekko BY ebeln.
*
*      SELECT ebeln ebelp bukrs matnr meins txz01 pstyp werks menge elikz erekz
*          INTO CORRESPONDING FIELDS OF TABLE t_pagos
*          FROM ekpo FOR ALL ENTRIES IN th_ekko  "Pedidos
*          WHERE ebeln EQ th_ekko-ebeln
*          AND loekz EQ space.
*
*      CHECK sy-subrc = 0.

      LOOP AT th_ekko INTO wa_ekko.
        CLEAR: wa_pedidos_ekpo.
        wa_pedidos_ekpo-sign   = 'I'.
        wa_pedidos_ekpo-option = 'EQ'.
        wa_pedidos_ekpo-low    = wa_ekko-ebeln.
*        wa_pedidos-high   = .
        APPEND wa_pedidos_ekpo TO tr_pedidos_ekpo.
      ENDLOOP.

      zcl_ekpo=>ekpo_get( EXPORTING i_operacion  = 'READ'
                                    et_ebeln     = tr_pedidos
                                    ev_loekz     = space
                                   "ev_filter    = 'A'
                          IMPORTING et_ekpo      = it_ekpo ).


      CHECK it_ekpo IS NOT INITIAL.

      MOVE-CORRESPONDING it_ekpo TO t_pagos.


      DATA: po_sum LIKE zekpo-menge.  " sumariza el total del pedido

**    - Busca entradas
      LOOP AT t_pagos INTO wa_pagos.
*
        AT NEW ebeln.   " Nuevo pedido
          CLEAR: c_ent,  "sumariza entradas
                 c_sal,  "sumariza salidas
                 po_sum. "sumariza cant. del pedido
        ENDAT.

**    - cantidad del pedido
        ADD wa_pagos-menge TO po_sum.

        IF wa_pagos-elikz NE space. " si tiene marcada entrega final en automático esta completa
          ADD wa_pagos-menge TO c_ent.
        ELSE. " Busca el total de la entrada por posición

        wa_pagos-matnr_d = wa_pagos-matnr. "material

*        SELECT menge budat wrbtr waers
*            INTO  (t_pagos-menge, t_pagos-budat,
*                   t_pagos-wrbtr, t_pagos-waers)
*            FROM ekbe
*            WHERE ebeln EQ t_pagos-ebeln
*            AND   ebelp EQ t_pagos-ebelp
*            AND   bewtp = 'E'
*            AND   bwart IN ('101', '103', '105', '911', '913', '123').
*                ADD t_pagos-menge TO c_ent.
*        ENDSELECT.

        CLEAR: it_ekbe, wa_ekbe.
        zcl_ekbe_gr_list=>ekbe_get( EXPORTING i_operacion = 'READ'
                                              i_ebeln     = wa_pagos-ebeln
                                              i_ebelp     = wa_pagos-ebelp
                                              i_bewtp     = 'E'
                                              ev_filter   = '1'
                                        IMPORTING et_ekbe = it_ekbe ).

        IF it_ekbe IS NOT INITIAL.

          LOOP AT it_ekbe INTO wa_ekbe.
            c_ent = c_ent + wa_ekbe-menge.

            wa_pagos-menge =  wa_ekbe-menge.
            wa_pagos-budat =  wa_ekbe-budat.
            wa_pagos-wrbtr =  wa_ekbe-wrbtr.
            wa_pagos-waers =  wa_ekbe-waers.

          ENDLOOP.

*    -  Si tiene entradas busca reversas
*        IF sy-subrc EQ 0.
*          SELECT menge INTO t_menge FROM ekbe
*             WHERE ebeln EQ t_pagos-ebeln
*               AND ebelp EQ t_pagos-ebelp
*               AND bewtp = 'E'
*               AND bwart IN ('102', '104', '106', '122').
*            ADD t_menge TO c_sal.
*          ENDSELECT.
*        ENDIF.

          CLEAR: it_ekbe, wa_ekbe.
          zcl_ekbe_gr_list=>ekbe_get( EXPORTING i_operacion = 'READ'
                                                i_ebeln     = wa_pagos-ebeln
                                                i_ebelp     = wa_pagos-ebelp
                                                i_bewtp     = 'E'
                                                ev_filter   = '2'
                                          IMPORTING et_ekbe = it_ekbe ).

          IF it_ekbe IS NOT INITIAL.
            LOOP AT it_ekbe INTO wa_ekbe.
              c_sal = c_sal + wa_ekbe-menge.
              t_menge = wa_ekbe-menge.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDIF.

*     al final del pedido
      at end of ebeln.
      dif = c_ent - c_sal.

          IF dif EQ 0. " sin entradas

            wa_ent-ebeln = wa_pagos-ebeln.
            wa_ent-porc  = '0'.
            APPEND wa_ent TO t_ent.

          ELSEIF dif < po_sum. "Parcialidades

            wa_ent-ebeln = wa_pagos-ebeln.
            wa_ent-porc  = '30'.
            append wa_ent TO t_ent.

          ELSE.

            wa_ent-ebeln = wa_pagos-ebeln.
            wa_ent-porc  = '33'.
            append wa_ent TO t_ent.

          ENDIF.


        ENDAT.

        MODIFY t_pagos FROM wa_pagos.  " Verificar si es necesario.


      ENDLOOP. "Entradas

      DATA: V_menge LIKE zes_ekbe-menge, C_menge LIKE zes_ekbe-menge.

**    - Busca Verificaciones
      LOOP at t_pagos INTO wa_pagos.
        AT NEW ebeln.
          CLEAR: V_menge, C_menge, po_sum.
        ENDAT.

*       - cantidad del pedido
        po_sum = po_sum + wa_pagos-menge. "cant. pedido

        IF wa_pagos-erekz ne space. " si tiene marcada verif. compl. en automático esta completa
          ADD wa_pagos-menge TO C_menge.

        ELSE. " Busca el total de la verificación por posición

*          SELECT gjahr wrbtr waers menge budat belnr shkzg
*            INTO (t_pagos-gjahr,  t_pagos-wrbtr2, t_pagos-waers2,
*               t_pagos-menge2, t_pagos-budat2, t_pagos-belnr, ekbe-shkzg)
*            FROM ekbe
*              WHERE ebeln EQ t_pagos-ebeln
*              AND ebelp EQ t_pagos-ebelp
*              AND ( bewtp = 'Q' OR bewtp = 'R' ).
*
*            IF ekbe-shkzg EQ 'S'.
*              add t_pagos-menge2 to V_menge.
*            ELSE.
*              add t_pagos-menge2 to C_menge.
*            ENDIF.
*          ENDSELECT.

          CLEAR: it_ekbe, wa_ekbe.
          zcl_ekbe_gr_list=>ekbe_get( EXPORTING i_operacion = 'READ'
                                              i_ebeln     = wa_pagos-ebeln
                                              i_ebelp     = wa_pagos-ebelp
                                              i_bewtp     = 'Q'
                                              ev_filter   = '3'
                                        IMPORTING et_ekbe = it_ekbe ).

          IF it_ekbe IS NOT INITIAL.
            LOOP AT it_ekbe INTO wa_ekbe.
              IF wa_ekbe-shkzg EQ 'S'.
                V_menge = V_menge + wa_pagos-menge2.
              ELSE.
                C_menge = C_menge + wa_pagos-menge2.
              ENDIF.

              wa_pagos-gjahr  = wa_ekbe-gjahr.
              wa_pagos-wrbtr2 = wa_ekbe-wrbtr.
              wa_pagos-waers2 = wa_ekbe-waers.
              wa_pagos-menge2 = wa_ekbe-menge.
              wa_pagos-budat2 = wa_ekbe-budat.
              wa_pagos-belnr  = wa_ekbe-belnr.

            ENDLOOP.
          ENDIF.
        ENDIF.

**-     Busca pagos
        CONCATENATE wa_pagos-belnr wa_pagos-gjahr INTO dp_key.

*        SELECT bukrs belnr gjahr INTO (bkpf-bukrs, bkpf-belnr, bkpf-gjahr)
*        FROM bkpf
*        WHERE blart = 'RE'
*        AND   awtyp = 'RMRP'
*        AND   awkey = dp_key.
*        ENDSELECT.

        CLEAR: it_bkpf, wa_bkpf.
        zcl_bkpf_gr_list=>get_ext_bkpf( EXPORTING i_operacion = 'READ'
                                                  i_blart     = 'RE'
                                                  i_awkey     = dp_key
                                                  i_awtyp     = 'RMRP'
*                                                  ev_filter   = '1'
                                        IMPORTING et_bkpf     = it_bkpf ).

        IF it_bkpf IS NOT INITIAL.

*          LOOP AT it_bkpf INTO wa_bkpf.
*
*          ENDLOOP.

          READ TABLE it_bkpf INTO wa_bkpf INDEX 1.
*
*         SELECT augbl INTO t_pagos-augbl
*           FROM bseg
*           WHERE belnr EQ bkpf-belnr
*           AND   bukrs EQ bkpf-bukrs
*           AND   gjahr EQ bkpf-gjahr
*           AND   buzid EQ 'K'
*           AND   bschl EQ '31'.
*           ENDSELECT.

          CLEAR: it_bseg, wa_bseg.
          zcl_bseg_gr_list=>get_bseg( EXPORTING i_operacion = 'READ'
                                                         i_belnr     = wa_bkpf-belnr
                                                         i_bukrs     = wa_bkpf-bukrs
                                                         i_gjahr     = wa_bkpf-gjahr
                                                         i_buzid     = 'K'
                                                         i_bschl     = '31'
                                               IMPORTING it_bseg    = it_bseg ).

            IF it_bseg IS NOT INITIAL.
              READ TABLE it_bseg INTO wa_bseg INDEX 1.
              wa_pagos-augbl = wa_bseg-augbl.

              CLEAR: t_pag, wa_pag.
              IF NOT wa_pagos-augbl IS INITIAL.    " Si tiene Compensacion
                wa_pag-ebeln = wa_pagos-ebeln.
                wa_pag-porc  = '99'.
                APPEND wa_pag TO t_pag.
              ENDIF.
            ENDIF.
          ENDIF.

          AT END OF ebeln.
            dif = V_menge - C_menge.
            IF dif = 0.  "sin verificaciones
              wa_ver-ebeln = wa_pagos-ebeln.
              wa_ver-porc  = '0'.
            ELSEIF dif < po_sum. "Parcialidades

              wa_ver-ebeln = wa_pagos-ebeln.
              wa_ver-porc  = '60'.
              APPEND wa_ver TO t_ver.
            ELSE.
              wa_ver-ebeln = wa_pagos-ebeln.
              wa_ver-porc  = '66'.
              APPEND wa_ver TO t_ver.
            ENDIF.
          ENDAT.

      ENDLOOP.

      SORT t_pagos  BY ebeln ebelp.

      LOOP AT th_ekko INTO wa_ekko.
        CLEAR GRS_LIST.

        wa_grs_list-por_ent = '0'.
        wa_grs_list-por_ver = '0'.
        wa_grs_list-por_pag = '0'.
*
**    -  Fecha del pedido
*        SELECT single bedat INTO ekko-bedat FROM ekko
*        WHERE ebeln = th_ekko-ebeln.


        zcl_ekko_gr_list=>ekko_get2( EXPORTING i_operacion  = 'READ'
                                                i_ebeln     = wa_ekko-ebeln
                                                i_filter    = 'A'
                                      IMPORTING et_ekko     = it_ekko2 ).

        READ TABLE it_ekko2 INDEX 1 INTO wa_ekko2.

        wa_grs_list-po_number = wa_ekko-ebeln.
        wa_grs_list-po_date   = wa_ekko2-bedat.

        READ TABLE t_ent WITH KEY ebeln = wa_ekko-ebeln INTO wa_ent.
        IF sy-subrc EQ 0.
          wa_grs_list-por_ent = wa_ent-porc.
        ENDIF.

        READ TABLE t_ver WITH KEY ebeln = wa_ekko-ebeln INTO wa_ver.
        IF sy-subrc EQ 0.
          wa_grs_list-por_ver = wa_ver-porc.
        ENDIF.

        READ TABLE t_pag WITH KEY ebeln = wa_ekko-ebeln INTO wa_pag.
        IF sy-subrc EQ 0.
          wa_grs_list-por_pag = wa_pag-porc.
        ENDIF.

*    - Status
        IF wo_grs NE space.  "Sin entradas
           IF wa_grs_list-por_ent = '0'.
             APPEND wa_grs_list TO grs_list.
           ENDIF.
        ENDIF.

        IF w_grs NE space.
           IF wa_grs_list-por_ent NE '0'.
             APPEND wa_grs_list TO grs_list.
           endif.
        ENDIF.

        IF w_irs ne space.
           if wa_grs_list-por_ver NE '0'.
             APPEND wa_grs_list TO grs_list.
           endif.
        ENDIF.

        IF w_pay NE space.
           IF wa_grs_list-por_pag NE '0'.
             APPEND wa_grs_list TO grs_list.
           ENDIF.
        ENDIF.

      ENDLOOP.

      DELETE ADJACENT DUPLICATES FROM grs_list COMPARING ALL FIELDS.


ENDFUNCTION.
