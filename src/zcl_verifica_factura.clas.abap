CLASS zcl_verifica_factura DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-METHODS: but000             IMPORTING i_operacion TYPE text10
                                                i_lifnr     TYPE lifnr
                                      EXPORTING lv_name     TYPE zes_but000-name_org1.

    CLASS-METHODS: lfa1               IMPORTING i_operacion TYPE text10
                                                i_lifnr     TYPE lifnr
                                      EXPORTING es_lfa1     TYPE zst_lfa1.

    CLASS-METHODS: lfa1V2             IMPORTING i_operacion TYPE text10
                                                i_lifnr     TYPE lifnr
                                      EXPORTING lv_stcd     TYPE zst_lfa1-stcd1.

    CLASS-METHODS: lfa1V3             IMPORTING i_operacion TYPE text10
                                                i_stcd1     TYPE stcd1
                                      EXPORTING es_lfa1     TYPE zst_lfa1.

    CLASS-METHODS: lfa1V4             IMPORTING i_operacion TYPE text10
                                                i_stcd1     TYPE stcd1
                                      EXPORTING it_lfa1     TYPE ztt_lfa1.

    CLASS-METHODS: lfb1               IMPORTING i_operacion TYPE text10
                                                i_lifnr     TYPE lifnr
                                                i_bukrs     TYPE bukrs
                                      EXPORTING lv_zterm    TYPE zst_lfb1-zterm.

    CLASS-METHODS: lfbw               IMPORTING i_operacion TYPE text10
                                                i_lifnr     TYPE lifnr
                                                i_bukrs     TYPE bukrs
                                      EXPORTING lt_lfbw     TYPE ztt_lfbw.

    CLASS-METHODS: t023               IMPORTING VALUE(i_operacion) TYPE text10
                                      EXPORTING VALUE(et_T023T)    TYPE  ztt_t023_t023t.

    CLASS-METHODS: ekpo               IMPORTING VALUE(i_operacion) TYPE text10
                                                i_ebeln            TYPE ebeln
                                      EXPORTING VALUE(et_ekpo)     TYPE ztt_ekpo.

    CLASS-METHODS: ekpo2              IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_ebeln           TYPE zst_vfkp-ebeln
                                                lv_ebelp           TYPE zst_vfkp-ebelp
                                      EXPORTING VALUE(lv_pstyp)    TYPE zekpo-pstyp.

    CLASS-METHODS: ekpo3               IMPORTING VALUE(i_operacion) TYPE text10
                                                 lv_ebeln           TYPE zst_vfkp-ebeln
                                                 lv_ebelp           TYPE zst_vfkp-ebelp
                                       EXPORTING VALUE(es_ekpo)     TYPE zekpo.

    CLASS-METHODS: ekpo4               IMPORTING VALUE(i_operacion) TYPE text10
                                                 lv_ebeln           TYPE zst_vfkp-ebeln
                                                 lv_ebelp           TYPE zst_vfkp-ebelp
                                       EXPORTING VALUE(es_ekpo)     TYPE zekpo.

    CLASS-METHODS: mseg               IMPORTING i_operacion TYPE text10
                                                I_Mblnr     TYPE text10
                                                i_Mjahr     TYPE zmjahr
                                      EXPORTING et_mseg     TYPE ztt_mseg.

    CLASS-METHODS: mkpf_get           IMPORTING VALUE(i_operacion) TYPE text10
                                                i_mblnr            TYPE zchar10
                                                i_mjahr            TYPE ztsnum
                                      EXPORTING VALUE(et_mkpf)     TYPE ztt_mkpf.

    CLASS-METHODS: ekbe               IMPORTING i_operacion TYPE text10
                                      EXPORTING et_ekbe     TYPE ztt_ekbe.

    CLASS-METHODS: vfkp               IMPORTING VALUE(i_operacion) TYPE text10
                                                st_vttk            TYPE zst_vttk
                                      EXPORTING VALUE(ls_vfkp)     TYPE zst_vfkp.

    CLASS-METHODS: vfkp2              IMPORTING VALUE(i_operacion) TYPE text10
                                                st_vtts            TYPE zst_vtts
                                      EXPORTING VALUE(ls_vfkp)     TYPE zst_vfkp.

    CLASS-METHODS: vfkp3              IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_rebel           TYPE zhst-rebel
                                                lv_lblni           TYPE zhst-lblni
                                                lv_lifnr           TYPE lifnr
                                      EXPORTING VALUE(ls_vfkp)     TYPE zst_vfkp.

    CLASS-METHODS: vfkp4              IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_rebel           TYPE zhst-rebel
                                                lv_lifnr           TYPE lifnr
                                      EXPORTING VALUE(lt_vfkp)     TYPE ztt_vfkp.

    CLASS-METHODS: vfkp5              IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_lblni           TYPE zhst-lblni
                                                lv_lifnr           TYPE lifnr
                                      EXPORTING VALUE(ls_vfkp)     TYPE zst_vfkp.

    CLASS-METHODS: vttp               IMPORTING VALUE(i_operacion) TYPE text10
                                                i_ebeln            TYPE ebeln
                                      EXPORTING VALUE(E_vttp)      TYPE zes_vttp.

    CLASS-METHODS: ekbz               IMPORTING VALUE(i_operacion) TYPE text10
                                                i_ebeln            TYPE ebeln
                                      EXPORTING VALUE(E_ekbz)      TYPE ztt_ekbz.

    CLASS-METHODS: ekbz2              IMPORTING VALUE(i_operacion) TYPE text10
                                                i_ebeln            TYPE ebeln
                                                i_ebelp            TYPE ebelp
                                                i_belnr            TYPE belnr_d
                                      EXPORTING VALUE(lv_stunr)    TYPE zes_ekbz-stunr
                                                lv_zaehk           TYPE zes_ekbz-zaehk.

    CLASS-METHODS: search_vendor_lfa1 IMPORTING VALUE(i_operacion) TYPE text10
                                                prov               TYPE text10
                                      EXPORTING VALUE(e_stcd1)     TYPE stcd1.

    CLASS-METHODS: ekko               IMPORTING i_operacion TYPE text10
                                                i_quotation TYPE ebeln
                                      EXPORTING t_ekko      TYPE ztt_ekko_2.

    CLASS-METHODS: prcd_elements      IMPORTING i_operacion TYPE text10
                                                i_KNUMV     TYPE text10
                                                i_KSCHL     TYPE kschl
                                                i_kherk     TYPE char1
                                      EXPORTING e_lifnr     TYPE lifnr.

    CLASS-METHODS: vttk               IMPORTING VALUE(i_operacion) TYPE text10
                                                i_vttk             TYPE ztt_invoice
                                      EXPORTING VALUE(it_vttk)     TYPE ztt_vttk.

    CLASS-METHODS: vttk2              IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_tknum           TYPE zst_vfkp-rebel
                                                lv_tpbez           TYPE ebeln
                                      EXPORTING VALUE(ls_vttk)     TYPE zst_vttk.

    CLASS-METHODS: vttk3              IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_tknum           TYPE zst_vfkp-rebel
                                                lv_exti1           TYPE zst_vttk-exti1
                                      EXPORTING VALUE(v_tknum)     TYPE zst_vttk-tknum
                                                v_exti1            TYPE zst_vttk-exti1.

    CLASS-METHODS: vttk4              IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_tknum           TYPE zst_vfkp-rebel
                                                lv_exti1           TYPE zst_vfkp-rebel
                                      EXPORTING VALUE(v_tknum)     TYPE zst_vttk-tknum
                                                v_exti1            TYPE zst_vttk-exti1.

    CLASS-METHODS: vttk5              IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_tknum           TYPE zst_vfkp-rebel
                                      EXPORTING VALUE(ls_vttk)     TYPE zst_vttk.

    CLASS-METHODS: vtts               IMPORTING VALUE(i_operacion) TYPE text10
                                                st_vttk            TYPE zst_vttk
                                      EXPORTING VALUE(st_vtts)     TYPE zst_vtts.

    CLASS-METHODS: vtts2              IMPORTING VALUE(i_operacion) TYPE text10
                                                st_vttk            TYPE zst_vttk
                                                i_lifnr            TYPE lifnr
                                      EXPORTING VALUE(st_vtts)     TYPE zst_vtts.

    CLASS-METHODS: vtts3              IMPORTING VALUE(i_operacion) TYPE text10
                                                st_vttk            TYPE zst_vttk
                                                i_lifnr            TYPE lifnr
                                      EXPORTING VALUE(st_vtts)     TYPE zst_vtts.

    CLASS-METHODS: vtts4              IMPORTING VALUE(i_operacion) TYPE text10
                                                st_vttk            TYPE zst_vttk
                                      EXPORTING VALUE(st_vtts)     TYPE zst_vtts.

    CLASS-METHODS: adrc               IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_adrnz           TYPE zst_adrc-addrnumber
                                      EXPORTING VALUE(st_adrc)     TYPE zst_adrc.

    CLASS-METHODS: vbfa               IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_ebeln           TYPE ebeln
                                      EXPORTING VALUE(it_vbfa)     TYPE ztt_vbfa.

    CLASS-METHODS: vbfa2              IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_ebeln           TYPE ebeln
                                      EXPORTING VALUE(it_vbfa)     TYPE ztt_vbfa.

    CLASS-METHODS: essr               IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_lblni           TYPE zes_ekbe-lfbnr
                                      EXPORTING VALUE(ls_esrr)     TYPE zst_essr.

    CLASS-METHODS: rbkp               IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_belnr           TYPE belnr_d
                                                lv_gjahr           TYPE gjahr
                                                lv_xblnr           TYPE xblnr
                                      EXPORTING VALUE(ls_rbkp)     TYPE zes_rbkp.

    CLASS-METHODS: t006               IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_msehi           TYPE msehi
                                      EXPORTING VALUE(ls_t006)     TYPE zst_t006.

    CLASS-METHODS: esll               IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_packno          TYPE zst_esll-packno
                                      EXPORTING VALUE(ls_esll)     TYPE zst_esll.

    CLASS-METHODS: eskn               IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_lfbnr           TYPE zes_ekbe-lfbnr
                                                lv_zekkn           TYPE zes_ekbe-zekkn
                                      EXPORTING VALUE(lt_eskn)     TYPE ztt_eskn.

    CLASS-METHODS: ekkn               IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_ebeln           TYPE ebeln
                                                lv_ebelp           TYPE ebelp
                                      EXPORTING VALUE(lt_ekkn)     TYPE ztt_ekkn.

    CLASS-METHODS: zinv_spool         IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_nofact          TYPE char16
                                                lv_doctyp          TYPE char2
                                                lv_ebeln           TYPE ebeln
                                      EXPORTING VALUE(ls_zinv)     TYPE zinv_spool.

    CLASS-METHODS: bkpf               IMPORTING VALUE(i_operacion) TYPE text10
                                                lv_awkey           TYPE awkey
                                      EXPORTING VALUE(lv_belnr)    TYPE belnr_d
                                                lv_gjahr           TYPE gjahr.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_verifica_factura IMPLEMENTATION.

  METHOD but000.
    CASE i_operacion.
      WHEN 'READ'.


        DATA:
          ls_entity_key    TYPE zscm_but000=>tys_z_i_but_000_type,
          ls_business_data TYPE zscm_but000=>tys_z_i_but_000_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_BUT000'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_BUT000' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      partner  = i_lifnr ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_BUT_000' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            lv_name = ls_business_data-name_org_1.


          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.


    ENDCASE.
  ENDMETHOD.

  METHOD lfa1.
    CASE i_operacion.
      WHEN 'READ'.


        DATA:
          ls_entity_key    TYPE zscm_zvts_search_vendor=>tys_z_i_lfa_1_type,
          ls_business_data TYPE zscm_zvts_search_vendor=>tys_z_i_lfa_1_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVTS_SEARCH_VENDOR'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVTS_SEARCH_VENDOR' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      lifnr  = i_lifnr ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFA_1' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            MOVE-CORRESPONDING ls_business_data TO es_lfa1.
            es_lfa1-name1 = ls_business_data-name_1.
            es_lfa1-name2 = ls_business_data-name_2.
            es_lfa1-ort01 = ls_business_data-ort_01.
            es_lfa1-land1 = ls_business_data-land_1.
            es_lfa1-telf1 = ls_business_data-telf_1.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD lfa1V2.
    CASE i_operacion.
      WHEN 'READ'.


        DATA:
          ls_entity_key    TYPE zscm_zvts_search_vendor=>tys_z_i_lfa_1_type,
          ls_business_data TYPE zscm_zvts_search_vendor=>tys_z_i_lfa_1_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVTS_SEARCH_VENDOR'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVTS_SEARCH_VENDOR' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      lifnr  = i_lifnr ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFA_1' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            lv_stcd = ls_business_data-stcd_1.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD lfa1V3.
    CASE i_operacion.
      WHEN 'READ'.


        DATA:
          ls_entity_key    TYPE zscm_zvts_search_vendor=>tys_z_i_lfa_1_type,
          ls_business_data TYPE zscm_zvts_search_vendor=>tys_z_i_lfa_1_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVTS_SEARCH_VENDOR'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVTS_SEARCH_VENDOR' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      stcd_1  = i_stcd1 ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFA_1' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            MOVE-CORRESPONDING ls_business_data TO es_lfa1.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD lfa1V4.
    CASE i_operacion.
      WHEN 'READ'.


        DATA:
          lt_business_data TYPE TABLE OF zscm_zverifica_factura=>tys_z_i_lfa_1_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_stcd1      TYPE RANGE OF stcd1,
          ls_range_stcd1      LIKE LINE OF lt_range_stcd1,
          ls_lfa1             LIKE LINE OF it_lfa1.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVTS_SEARCH_VENDOR'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVTS_SEARCH_VENDOR' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_stcd1, ls_range_stcd1.
            ls_range_stcd1-sign = 'I'.
            ls_range_stcd1-option = 'EQ'.
            ls_range_stcd1-low = i_stcd1.
            APPEND ls_range_stcd1 TO lt_range_stcd1.


            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFA_1' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'STCD1'
                                                                    it_range             = lt_range_stcd1 ).

            lo_filter_node_root = lo_filter_node_1.
            lo_request->set_filter( lo_filter_node_root ).

*            lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).
            LOOP AT lt_business_data INTO DATA(ls_business_data).
              MOVE-CORRESPONDING ls_business_data TO ls_lfa1.
              APPEND ls_lfa1 TO it_lfa1.
              CLEAR ls_lfa1.
            ENDLOOP.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD lfb1.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          ls_entity_key    TYPE zscm_lfb1=>tys_z_i_lfb_1_type,
          ls_business_data TYPE zscm_lfb1=>tys_z_i_lfb_1_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVTS_SEARCH_VENDOR'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVTS_SEARCH_VENDOR' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      lifnr  = i_lifnr
                      bukrs  = i_bukrs ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFB_1' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            lv_zterm = ls_business_data-zterm.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD lfbw.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          lt_business_data TYPE TABLE OF zscm_zverifica_factura=>tys_z_i_lfbwtype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_lifnr      TYPE RANGE OF lifnr,
          ls_range_lifnr      LIKE LINE OF lt_range_lifnr,
          lt_range_bukrs      TYPE RANGE OF bukrs,
          ls_range_bukrs      LIKE LINE OF lt_range_bukrs,
          ls_lfbw             LIKE LINE OF lt_lfbw.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVTS_SEARCH_VENDOR'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVTS_SEARCH_VENDOR' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_bukrs, ls_range_bukrs.
            ls_range_bukrs-sign = 'I'.
            ls_range_bukrs-option = 'EQ'.
            ls_range_bukrs-low = i_bukrs.
            APPEND ls_range_bukrs TO lt_range_bukrs.

            CLEAR: lt_range_lifnr, ls_range_lifnr.
            ls_range_lifnr-sign = 'I'.
            ls_range_lifnr-option = 'EQ'.
            ls_range_lifnr-low = i_lifnr.
            APPEND ls_range_lifnr TO lt_range_lifnr.

            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFBW' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'LIFNR'
                                                                    it_range             = lt_range_lifnr ).
            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'BUKRS'
                                                                    it_range             = lt_range_bukrs ).

            lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
            lo_request->set_filter( lo_filter_node_root ).

*lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).
            MOVE-CORRESPONDING lt_business_data TO lt_lfbw.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD t023.
    CASE i_operacion.
      WHEN 'READ'.


        DATA:
          lt_business_data TYPE TABLE OF zscm_t023=>tys_z_i_t_023_t_023_ttype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        TRY.
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_T023'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_T023' ).

            ASSERT lo_http_client IS BOUND.


            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_T_023_T_023_T' )->create_request_for_read( ).

            lo_request->set_top( 5000 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            " et_prodfamilys_get = lt_business_data.
            MOVE-CORRESPONDING lt_business_data TO et_T023T.


          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.

    ENDCASE.

  ENDMETHOD.

  METHOD ekpo.
    CASE i_operacion.
      WHEN 'READ'.


        DATA:
          lt_business_data TYPE TABLE OF zscm_ekpo=>tys_z_i_ekpotype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node.
*             lt_range_DELETE_MC TYPE RANGE OF <element_name>,
*             lt_range_UPDATE_MC TYPE RANGE OF <element_name>.

        DATA:
          lt_range_ebeln TYPE RANGE OF ebeln,
          ls_range_ebeln LIKE LINE OF lt_range_ebeln.

        TRY.
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
                 EXPORTING
                      is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                          proxy_model_id      = 'ZSCM_EKPO'
                                                          proxy_model_version = '0001' )
                    io_http_client             = lo_http_client
                    iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_EKPO' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_ebeln, ls_range_ebeln.
            ls_range_ebeln-sign = 'I'.
            ls_range_ebeln-option = 'EQ'.
            ls_range_ebeln-low = i_ebeln.
            APPEND ls_range_ebeln TO lt_range_ebeln.


            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_EKPO' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'EBELN'
                                                                    it_range             = lt_range_ebeln ).

            lo_filter_node_root = lo_filter_node_1.
            lo_request->set_filter( lo_filter_node_root ).

            lo_request->set_top( 5000 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            MOVE-CORRESPONDING lt_business_data TO et_ekpo.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.

        ENDTRY.

    ENDCASE.

  ENDMETHOD.

  METHOD ekpo2.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_ekpotype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_ekpotype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
                 EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      ebeln  = lv_ebeln
                      ebelp  = lv_ebelp ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_EKPO' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            lv_pstyp = ls_business_data-pstyp.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD ekpo3.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_ekpotype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_ekpotype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
                 EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      ebeln  = lv_ebeln
                      ebelp  = lv_ebelp ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_EKPO' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            IF ls_business_data-loekz EQ space.
              MOVE-CORRESPONDING ls_business_data TO es_ekpo.
            ENDIF.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD ekpo4.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_ekpotype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_ekpotype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
                 EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      ebeln  = lv_ebeln
                      ebelp  = lv_ebelp ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_EKPO' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            MOVE-CORRESPONDING ls_business_data TO es_ekpo.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD mSEG.
    CASE i_operacion.
      WHEN 'READ'.


        DATA:
          lt_business_data TYPE TABLE OF zscm_mseg=>tys_z_i_mseg_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1  TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2  TYPE REF TO /iwbep/if_cp_filter_node
* lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
* lt_range_MBLNR TYPE RANGE OF <element_name>,
* lt_range_MJAHR TYPE RANGE OF <element_name>.

          .
        DATA:
          lt_range_mblnr TYPE RANGE OF zchar10,
          ls_range_mblnr LIKE LINE OF lt_range_mblnr,
          lt_range_mjahr TYPE RANGE OF ztsnum,
          ls_range_mjahr LIKE LINE OF lt_range_mjahr.

        TRY.
            " Create http client
*DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
*                                             comm_scenario  = '<Comm Scenario>'
*                                             comm_system_id = '<Comm System Id>'
*                                             service_id     = '<Service Id>' ).
*lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_MSEG'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_MSEG' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_mjahr, ls_range_mjahr.
            ls_range_mjahr-sign = 'I'.
            ls_range_mjahr-option = 'EQ'.
            ls_range_mjahr-low = i_mjahr.
            APPEND ls_range_mjahr TO lt_range_mjahr.

            CLEAR: lt_range_mjahr, ls_range_mjahr.
            ls_range_mjahr-sign = 'I'.
            ls_range_mjahr-option = 'EQ'.
            ls_range_mjahr-low = i_mjahr.
            APPEND ls_range_mjahr TO lt_range_mjahr.

            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_MSEG' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).
*
            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'MBLNR'
                                                                    it_range             = lt_range_MBLNR ).
            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'MJAHR'
                                                                    it_range             = lt_range_MJAHR ).

*lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
*lo_request->set_filter( lo_filter_node_root ).

            lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).
            MOVE-CORRESPONDING lt_business_data TO et_MSEG.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.


    ENDCASE.
  ENDMETHOD.

  METHOD mkpf_get.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          lt_business_data TYPE TABLE OF zsb_mkpf=>tys_z_i_mkpftype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node.
*         lt_range_DELETE_MC TYPE RANGE OF <element_name>,
*         lt_range_UPDATE_MC TYPE RANGE OF <element_name>.

        DATA:
          lt_range_mblnr TYPE RANGE OF zchar10,
          ls_range_mblnr LIKE LINE OF lt_range_mblnr,
          lt_range_mjahr TYPE RANGE OF ztsnum,
          ls_range_mjahr LIKE LINE OF lt_range_mjahr.

        TRY.
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSB_MKPF'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_MKPF' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_mblnr, ls_range_mblnr.
            ls_range_mblnr-sign = 'I'.
            ls_range_mblnr-option = 'EQ'.
            ls_range_mblnr-low = i_mblnr.
            APPEND ls_range_mblnr TO lt_range_mblnr.

            CLEAR: lt_range_mjahr, ls_range_mjahr.
            ls_range_mjahr-sign = 'I'.
            ls_range_mjahr-option = 'EQ'.
            ls_range_mjahr-low = i_mjahr.
            APPEND ls_range_mjahr TO lt_range_mjahr.

            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_MKPF' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'MBLNR'
                                                                    it_range             = lt_range_mblnr ).
            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'MJAHR'
                                                                    it_range             = lt_range_mjahr ).

            lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
            lo_request->set_filter( lo_filter_node_root ).

            lo_request->set_top( 5000 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            MOVE-CORRESPONDING lt_business_data TO et_mkpf.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.

    ENDCASE.

  ENDMETHOD.

  METHOD ekbe.
    CASE i_operacion.
      WHEN 'READ'.
        DATA:
          lt_business_data TYPE TABLE OF zscm_po_details=>tys_z_i_ekbetype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_3    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_ebeln      TYPE RANGE OF ebeln,
          ls_ekbe             LIKE LINE OF et_ekbe.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_PO_DETAILS'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_PO_DETAIL' ).

            ASSERT lo_http_client IS BOUND.

            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_EKBE' )->create_request_for_read( ).


            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            LOOP AT lt_business_data INTO DATA(ls_business_data).
              MOVE-CORRESPONDING ls_business_data TO ls_ekbe.
              APPEND ls_ekbe TO et_ekbe.
              CLEAR ls_ekbe.
            ENDLOOP.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vfkp.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          lt_business_data TYPE TABLE OF zscm_zget_transp_liq=>tys_z_i_vfkptype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_rebel      TYPE RANGE OF char10,
          ls_range_rebel      LIKE LINE OF lt_range_rebel.
*          ls_vfkp             LIKE LINE OF t_vfkp.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
       EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_ZGET_TRANSP_LIQ'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZGET_TRANSP_LIQ' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR lt_range_rebel.
            ls_range_rebel-sign = 'I'.
            ls_range_rebel-option = 'EQ'.
            ls_range_rebel-low = st_vttk-tknum.
            APPEND ls_range_rebel TO lt_range_rebel.
            CLEAR ls_range_rebel.


            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTK' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'REBEL'
                                                                    it_range             = lt_range_rebel ).
*lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'VBTYP'
*                                                        it_range             = lt_range_VBTYP ).

            lo_filter_node_root = lo_filter_node_1.
            lo_request->set_filter( lo_filter_node_root ).

            lo_request->set_top( 5000 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

*            CLEAR t_vfkp.

            LOOP AT lt_business_data INTO DATA(ls_business_data).
              MOVE-CORRESPONDING ls_business_data TO ls_vfkp.
*              APPEND ls_vfkp TO t_vfkp.
*              CLEAR ls_vfkp.
            ENDLOOP.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.

    ENDCASE.
  ENDMETHOD.

  METHOD vfkp2.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vfkptype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vfkptype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
       EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      rebel  = st_vtts-tknum
                      tdlnr  = st_vtts-tdlnr ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VFKP' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            IF ls_business_data-lblni NE space.
              MOVE-CORRESPONDING ls_business_data TO ls_vfkp.
            ENDIF.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vfkp3.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vfkptype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vfkptype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
       EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      rebel  = lv_rebel
                      tdlnr  = lv_lifnr
                      lblni  = lv_lblni ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VFKP' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            MOVE-CORRESPONDING ls_business_data TO ls_vfkp.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vfkp4.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          lt_business_data TYPE TABLE OF zscm_zverifica_factura=>tys_z_i_vfkptype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_rebel      TYPE RANGE OF vbeln,
          ls_range_rebel      LIKE LINE OF lt_range_rebel,
          lt_range_tdlnr      TYPE RANGE OF lifnr,
          ls_range_tdlnr      LIKE LINE OF lt_range_tdlnr,
          ls_vfkp             LIKE LINE OF lt_vfkp.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
       EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_rebel, ls_range_rebel.
            ls_range_rebel-sign = 'I'.
            ls_range_rebel-option = 'EQ'.
            ls_range_rebel-low = lv_rebel.
            APPEND ls_range_rebel TO lt_range_rebel.

            CLEAR: lt_range_tdlnr, ls_range_tdlnr.
            ls_range_tdlnr-sign = 'I'.
            ls_range_tdlnr-option = 'EQ'.
            ls_range_tdlnr-low = lv_lifnr.
            APPEND ls_range_tdlnr TO lt_range_tdlnr.


            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VFKP' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'REBEL'
                                                                    it_range             = lt_range_rebel ).
            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'TDLNR'
                                                                    it_range             = lt_range_tdlnr ).

            lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
            lo_request->set_filter( lo_filter_node_root ).

*lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            LOOP AT lt_business_data INTO DATA(ls_business_data).
              IF ls_business_data NE space.
                MOVE-CORRESPONDING ls_business_data TO ls_vfkp.
                APPEND ls_vfkp TO lt_vfkp.
                CLEAR ls_vfkp.
              ENDIF.
            ENDLOOP.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vfkp5.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vfkptype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vfkptype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
       EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      tdlnr  = lv_lifnr
                      lblni  = lv_lblni ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VFKP' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            MOVE-CORRESPONDING ls_business_data TO ls_vfkp.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vttp.
    CASE i_operacion.
      WHEN 'READ'.
        DATA:
          ls_entity_key    TYPE zscm_vttp=>tys_z_i_vttp_type,
          ls_business_data TYPE zscm_vttp=>tys_z_i_vttp_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_VTTP'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_VTTP' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      vbeln  = i_ebeln ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTP' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

*loop at ls_business_data INTO DATA(ls_business_data).
            MOVE-CORRESPONDING ls_business_data TO E_vttp.
*endloop.


          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.

    ENDCASE.
  ENDMETHOD.

  METHOD ekbz.
    CASE i_operacion.
      WHEN 'READ LIST'.


        DATA:
          lt_business_data TYPE TABLE OF zscm_ekbz=>tys_z_i_ekbztype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1  TYPE REF TO /iwbep/if_cp_filter_node,
* lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
* lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_EBELN    TYPE RANGE OF ebeln,
          ls_range_ebeln    LIKE LINE OF lt_range_EBELN.
* lt_range_EBELP TYPE RANGE OF <element_name>.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_EKBZ'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_EKBZ' ).

            ASSERT lo_http_client IS BOUND.




            IF i_EBELN IS NOT INITIAL.
              ls_range_ebeln-sign = 'I'.
              ls_range_ebeln-option = 'EQ'.
              ls_range_ebeln-low = i_ebeln.
              APPEND ls_range_ebeln TO lt_range_ebeln.
            ENDIF.

            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_EKBZ' )->create_request_for_read( ).
            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).
*
            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'EBELN'
                                                                    it_range             = lt_range_EBELN ).


            lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            DATA: es_ekbz TYPE zes_ekbz.
            LOOP AT lt_business_data INTO DATA(ls_business_data).
              MOVE-CORRESPONDING ls_business_data TO es_ekbz.
              APPEND es_ekbz TO E_ekbz.

            ENDLOOP.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.

    ENDCASE.
  ENDMETHOD.

  METHOD ekbz2.
    CASE i_operacion.
      WHEN 'READ LIST'.

        DATA:
          ls_entity_key    TYPE zscm_ekbz=>tys_z_i_ekbztype,
          ls_business_data TYPE zscm_ekbz=>tys_z_i_ekbztype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_EKBZ'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_EKBZ' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      ebeln  = i_ebeln
                      ebelp  = i_ebelp
                      belnr  = i_belnr ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_EKBZ' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            lv_stunr = ls_business_data-stunr.
            lv_zaehk = ls_business_data-zaehk.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.

    ENDCASE.
  ENDMETHOD.


  METHOD search_vendor_lfa1.
    CASE i_operacion.
      WHEN 'READ'.
        DATA:
          ls_entity_key    TYPE zscm_zvts_search_vendor=>tys_z_i_lfa_1_type,
          ls_business_data TYPE zscm_zvts_search_vendor=>tys_z_i_lfa_1_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
       EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_ZVTS_SEARCH_VENDOR'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVTS_SEARCH_VENDOR' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      lifnr  = prov ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFA_1' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
*            MOVE-CORRESPONDING ls_business_data TO lfa1.
*            lfa1-name1 = ls_business_data-name_1.
*            lfa1-name2 = ls_business_data-name_2.
*            lfa1-name3 = ls_business_data-name_3.
*            lfa1-name4 = ls_business_data-name_4.
*            lfa1-stcd1 = ls_business_data-stcd_1.
            e_stcd1 = ls_business_data-stcd_1.
          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.


  METHOD prcd_elements.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          ls_entity_key    TYPE zscm_prcd_elements=>tys_z_i_prcd_elementstype,
          ls_business_data TYPE zscm_prcd_elements=>tys_z_i_prcd_elementstype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.



        TRY.
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_PRCD_ELEMENTS'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_PRCD_ELEMENTS' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      knumv  = i_KNUMV
                      kschl  = i_KSCHL
                      kherk  = i_kherk ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_PRCD_ELEMENTS' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            e_lifnr = ls_business_data-lifnr.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.

  ENDMETHOD.


  METHOD ekko.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          lt_business_data TYPE TABLE OF zscm_zvts_rfq_detail=>tys_z_i_ekkotype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

*        DATA:
*          lt_business_data TYPE TABLE OF zscm_zvts_rfq_detail=>tys_z_i_ekkotype,
*          lo_http_client   TYPE REF TO if_web_http_client,
*          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
*          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
*          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
*          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
*          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
*          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
*          lo_filter_node_3    TYPE REF TO /iwbep/if_cp_filter_node,
*          lo_filter_node_4    TYPE REF TO /iwbep/if_cp_filter_node,
*          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_ebeln TYPE RANGE OF ebeln,
          ls_range_ebeln LIKE LINE OF lt_range_ebeln,
          ls_ekko        LIKE LINE OF t_ekko.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
* lt_range_TITLE TYPE RANGE OF <element_name>,
          lt_range_ID         TYPE RANGE OF sysuuid_x16.



        TRY.
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVTS_RFQ_DETAIL'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVTS_RFQ_DETAIL' ).

            ASSERT lo_http_client IS BOUND.


            IF i_quotation IS NOT INITIAL.
              ls_range_ebeln-sign = 'I'.
              ls_range_ebeln-option = 'EQ'.
              ls_range_ebeln-low = i_quotation.
              APPEND ls_range_ebeln TO lt_range_ebeln.
            ENDIF.

            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_EKKO' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).
            IF lt_range_ebeln IS NOT INITIAL.
              lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'EBELN'
                                                                      it_range             = lt_range_ebeln ).
            ENDIF.
            lo_filter_node_root = lo_filter_node_1.

            lo_request->set_filter( lo_filter_node_root ).

*            lo_request->set_top( 5000 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            LOOP AT lt_business_data INTO DATA(ls_business_data).
              MOVE-CORRESPONDING ls_business_data TO ls_ekko.
              ls_ekko-inco1 = ls_business_data-inco_1.
              ls_ekko-inco2 = ls_business_data-inco_2.
              APPEND ls_ekko TO t_ekko.
              CLEAR ls_ekko.
            ENDLOOP.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.

        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vttk.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          lt_business_data TYPE TABLE OF zscm_zverifica_factura=>tys_z_i_vttktype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.
        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_tknum      TYPE RANGE OF char10,
          ls_range_tknum      LIKE LINE OF lt_range_tknum,
          lt_range_vbtyp      TYPE RANGE OF char4,
          ls_range_vbtyp      LIKE LINE OF lt_range_vbtyp,
          ls_invoice          LIKE LINE OF i_vttk,
          ls_vttk             LIKE LINE OF it_vttk.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_tknum, lt_range_vbtyp.
            LOOP AT i_vttk INTO ls_invoice.
              ls_range_tknum-sign = 'I'.
              ls_range_tknum-option = 'EQ'.
              ls_range_tknum-low = ls_invoice-rebel.
              APPEND ls_range_tknum TO lt_range_tknum.
              CLEAR ls_range_tknum.

              ls_range_vbtyp-sign = 'I'.
              ls_range_vbtyp-option = 'EQ'.
              ls_range_vbtyp-low = ls_invoice-rebel.
              APPEND ls_range_vbtyp TO lt_range_vbtyp.
              CLEAR ls_range_vbtyp.
            ENDLOOP.

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'TKNUM'
                                                                    it_range             = lt_range_tknum ).
            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'VBTYP'
                                                                    it_range             = lt_range_vbtyp ).

            lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
            lo_request->set_filter( lo_filter_node_root ).

*lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            LOOP AT lt_business_data INTO DATA(ls_business_data).
              MOVE-CORRESPONDING ls_business_data TO ls_vttk.
              ls_vttk-add01 = ls_business_data-add_01.
              ls_vttk-add02 = ls_business_data-add_02.
              ls_vttk-add03 = ls_business_data-add_03.
              ls_vttk-add04 = ls_business_data-add_04.
              ls_vttk-exti1 = ls_business_data-exti_1.
              ls_vttk-exti2 = ls_business_data-exti_2.
              ls_vttk-text1 = ls_business_data-text_1.
              ls_vttk-text2 = ls_business_data-text_2.
              ls_vttk-text3 = ls_business_data-text_3.
              ls_vttk-text4 = ls_business_data-text_4.
              APPEND ls_vttk TO it_vttk.
              CLEAR ls_vttk.
            ENDLOOP.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vttk2.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vttktype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vttktype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      tknum  = lv_tknum
                      tpbez  = lv_tpbez ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTK' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            MOVE-CORRESPONDING ls_business_data TO ls_vttk.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vttk3.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vttktype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vttktype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      tknum   = lv_tknum
                      sttrg   = '7'
                      exti_1  = lv_exti1 ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTK' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            v_tknum = ls_business_data-tknum.
            v_exti1 = ls_business_data-exti_1.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vttk4.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vttktype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vttktype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      tknum   = lv_tknum
                      sttrg   = '7'
                      exti_1  = lv_exti1 ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTK' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            v_tknum = ls_business_data-tknum.
            v_exti1 = ls_business_data-exti_1.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vttk5.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vttktype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vttktype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      tknum   = lv_tknum
                      sttrg   = '7' ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTK' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            MOVE-CORRESPONDING ls_business_data TO ls_vttk.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vtts.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vttstype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vttstype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      tknum    = st_vttk-tknum
                      tdlnr    = st_vttk-tdlnr
                      abland_1 = 'MX' ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTS' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            MOVE-CORRESPONDING ls_business_data TO st_vtts.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vtts2.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vttstype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vttstype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      tknum    = st_vttk-tknum
                      tdlnr    = i_lifnr ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTS' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            MOVE-CORRESPONDING ls_business_data TO st_vtts.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vtts3.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vttstype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vttstype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      tknum    = st_vttk-tknum
                      tdlnr    = i_lifnr ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTS' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            IF ls_business_data-edland_1 = 'MX'.
              MOVE-CORRESPONDING ls_business_data TO st_vtts.
            ENDIF.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vtts4.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_vttstype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_vttstype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      tknum    = st_vttk-tknum
                      tdlnr    = st_vttk-tdlnr
                      abland_1 = '04' ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VTTS' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            MOVE-CORRESPONDING ls_business_data TO st_vtts.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD adrc.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_adrctype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_adrctype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      addrnumber  = lv_adrnz ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_ADRC' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            st_adrc-country    = ls_business_data-country.
            st_adrc-name1      = ls_business_data-name_1.
            st_adrc-city1      = ls_business_data-city_1.
            st_adrc-post_code1 = ls_business_data-post_code_1.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vbfa.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          lt_business_data TYPE TABLE OF zscm_salesorder_details=>tys_z_i_vbfatype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_vbelv      TYPE RANGE OF vbelv,
          ls_range_vbelv      LIKE LINE OF lt_range_vbelv,
          wa_vbfa             LIKE LINE OF it_vbfa.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_SALESORDER_DETAILS'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_SALESORDER_DETAILS' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_vbelv, ls_range_vbelv.
            ls_range_vbelv-sign = 'I'.
            ls_range_vbelv-option = 'EQ'.
            ls_range_vbelv-low = lv_ebeln.
            APPEND ls_range_vbelv TO lt_range_vbelv.


            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VBFA' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'VBELV'
                                                                    it_range             = lt_range_VBELV ).

            lo_filter_node_root = lo_filter_node_2.
            lo_request->set_filter( lo_filter_node_root ).

*            lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            LOOP AT lt_business_data INTO DATA(ls_business_data).
              MOVE-CORRESPONDING ls_business_data TO wa_vbfa.
              APPEND wa_vbfa TO it_vbfa.
              CLEAR wa_vbfa.
            ENDLOOP.


          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD vbfa2.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          lt_business_data TYPE TABLE OF zscm_salesorder_details=>tys_z_i_vbfatype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_vbelv      TYPE RANGE OF vbelv,
          ls_range_vbelv      LIKE LINE OF lt_range_vbelv,
          wa_vbfa             LIKE LINE OF it_vbfa.



        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_SALESORDER_DETAILS'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_SALESORDER_DETAILS' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_vbelv, ls_range_vbelv.
            ls_range_vbelv-sign = 'I'.
            ls_range_vbelv-option = 'EQ'.
            ls_range_vbelv-low = lv_ebeln.
            APPEND ls_range_vbelv TO lt_range_vbelv.


            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_VBFA' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'VBELV'
                                                                    it_range             = lt_range_VBELV ).

            lo_filter_node_root = lo_filter_node_2.
            lo_request->set_filter( lo_filter_node_root ).

*            lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            LOOP AT lt_business_data INTO DATA(ls_business_data).
              IF ls_business_data-vbtyp_n EQ '8'.
                MOVE-CORRESPONDING ls_business_data TO wa_vbfa.
                APPEND wa_vbfa TO it_vbfa.
                CLEAR wa_vbfa.
              ENDIF.
            ENDLOOP.


          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD essr.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_po_details=>tys_z_i_essrtype,
          ls_business_data TYPE zscm_po_details=>tys_z_i_essrtype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_PO_DETAILS'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_PO_DETAILS' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      lblni  = lv_lblni ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_ESSR' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            MOVE-CORRESPONDING ls_business_data TO ls_esrr.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD rbkp.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_rbkptype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_rbkptype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_PO_DETAILS'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_PO_DETAILS' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      belnr  = lv_belnr
                      gjahr  = lv_gjahr
                      xblnr  = lv_xblnr ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_RBKP' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            MOVE-CORRESPONDING ls_business_data TO ls_rbkp.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD t006.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_t_006_type,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_t_006_type,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_PO_DETAILS'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_PO_DETAILS' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      msehi  = lv_msehi ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_T_006' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            MOVE-CORRESPONDING ls_business_data TO ls_t006.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD esll.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_eslltype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_eslltype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_PO_DETAILS'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_PO_DETAILS' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      packno  = lv_packno ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_ESLL' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            MOVE-CORRESPONDING ls_business_data TO ls_esll.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.

        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD eskn.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          lt_business_data TYPE TABLE OF zscm_zverifica_factura=>tys_z_i_eskntype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_packno     TYPE RANGE OF packno,
          ls_range_packno     LIKE LINE OF lt_range_packno,
          lt_range_zekkn      TYPE RANGE OF numc2,
          ls_range_zekkn      LIKE LINE OF lt_range_zekkn,
          ls_eskn             LIKE LINE OF lt_eskn.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_packno, ls_range_packno.
            ls_range_packno-sign = 'I'.
            ls_range_packno-option = 'EQ'.
            ls_range_packno-low = lv_lfbnr.
            APPEND ls_range_packno TO lt_range_packno.

            CLEAR: lt_range_zekkn, ls_range_zekkn.
            ls_range_zekkn-sign = 'I'.
            ls_range_zekkn-option = 'EQ'.
            ls_range_zekkn-low = lv_zekkn.
            APPEND ls_range_zekkn TO lt_range_zekkn.

            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_ESKN' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'PACKNO'
                                                                    it_range             = lt_range_packno ).
            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'ZEKKN'
                                                                    it_range             = lt_range_zekkn ).

            lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
            lo_request->set_filter( lo_filter_node_root ).

*lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            .  lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            LOOP AT lt_business_data INTO DATA(ls_business_data).
              MOVE-CORRESPONDING ls_business_data TO ls_eskn.
              APPEND ls_eskn TO lt_eskn.
              CLEAR ls_eskn.
            ENDLOOP.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD ekkn.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          lt_business_data TYPE TABLE OF zscm_zverifica_factura=>tys_z_i_ekkntype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_ebeln      TYPE RANGE OF ebeln,
          ls_range_ebeln      LIKE LINE OF lt_range_ebeln,
          lt_range_ebelp      TYPE RANGE OF ebelp,
          ls_range_ebelp      LIKE LINE OF lt_range_ebelp,
          ls_ekkn             LIKE LINE OF lt_ekkn.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            CLEAR: lt_range_ebeln, ls_range_ebeln.
            ls_range_ebeln-sign = 'I'.
            ls_range_ebeln-option = 'EQ'.
            ls_range_ebeln-low = lv_ebeln.
            APPEND ls_range_ebeln TO lt_range_ebeln.

            CLEAR: lt_range_ebelp, ls_range_ebelp.
            ls_range_ebelp-sign = 'I'.
            ls_range_ebelp-option = 'EQ'.
            ls_range_ebelp-low = lv_ebelp.
            APPEND ls_range_ebelp TO lt_range_ebelp.

            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_EKKN' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'EBELN'
                                                                    it_range             = lt_range_ebeln ).
            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'EBELP'
                                                                    it_range             = lt_range_ebelp ).

            lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
            lo_request->set_filter( lo_filter_node_root ).

*lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            LOOP AT lt_business_data INTO DATA(ls_business_data).
              IF ls_business_data-loekz EQ space.
                MOVE-CORRESPONDING ls_business_data TO ls_ekkn.
                APPEND ls_ekkn TO lt_ekkn.
                CLEAR ls_ekkn.
              ENDIF.
            ENDLOOP.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD zinv_spool.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_zinv_spooltype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_zinv_spooltype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_PO_DETAILS'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_PO_DETAILS' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      nofact  = lv_nofact
                      doctyp  = lv_doctyp
                      ebeln   = lv_ebeln  ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_RBKP' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            MOVE-CORRESPONDING ls_business_data TO ls_zinv.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD bkpf.
    CASE i_operacion.
      WHEN 'READ LIST'.
        DATA:
          ls_entity_key    TYPE zscm_zverifica_factura=>tys_z_i_bkpftype,
          ls_business_data TYPE zscm_zverifica_factura=>tys_z_i_bkpftype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read.

        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_ZVERIFICA_FACTURA'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZVERIFICA_FACTURA' ).

            ASSERT lo_http_client IS BOUND.

            " Set entity key
            ls_entity_key = VALUE #(
                      awkey  = lv_awkey
                      awtyp  = 'RMRP'
                      blart  = 'RE' ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_BKPF' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
            lv_belnr = ls_business_data-belnr.
            lv_gjahr = ls_business_data-gjahr.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            " Handle Exception

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            " Handle Exception
            RAISE SHORTDUMP lx_web_http_client_error.


        ENDTRY.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
