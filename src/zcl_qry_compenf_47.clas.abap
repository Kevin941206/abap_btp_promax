CLASS zcl_qry_compenf_47 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS: bkpf IMPORTING i_operacion TYPE char10
                                  i_bukrs     TYPE bukrs
                                  i_budat     TYPE budat
                                  i_xblnr     TYPE xblnr
                        EXPORTING es_bkpf     TYPE zst_bkpf.

    CLASS-METHODS: zfi_const IMPORTING i_operacion TYPE char10
                                       i_modul     TYPE zstfi_const-modul
                                       i_progr     TYPE zstfi_const-progr
                             EXPORTING et_const    TYPE zttfi_const.

    CLASS-METHODS: lfa1 IMPORTING i_operacion TYPE char10
                                  i_lifnr     TYPE lifnr
                        EXPORTING e_ktokk     TYPE ktokk.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_qry_compenf_47 IMPLEMENTATION.

  METHOD bkpf.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          lt_business_data TYPE TABLE OF zscm_salesorder_list=>tys_z_i_bkpftype,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

        DATA:
          lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_3    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_4    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_bukrs      TYPE RANGE OF bukrs,
          ls_range_bukrs      LIKE LINE OF lt_range_bukrs,
          lt_range_budat      TYPE RANGE OF budat,
          ls_range_budat      LIKE LINE OF lt_range_budat,
          lt_range_xblnr      TYPE RANGE OF xblnr,
          ls_range_xblnr      LIKE LINE OF lt_range_xblnr.


        TRY.
            " Create http client
            DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              EXPORTING
                 is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                     proxy_model_id      = 'ZSCM_SALESORDER_LIST'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_SALESORDER_LIST' ).

            ASSERT lo_http_client IS BOUND.

            ls_range_bukrs-sign = 'I'.
            ls_range_bukrs-option = 'EQ'.
            ls_range_bukrs-low = i_bukrs.
            APPEND ls_range_bukrs TO lt_range_bukrs.
            CLEAR ls_range_bukrs.

            ls_range_budat-sign = 'I'.
            ls_range_budat-option = 'EQ'.
            ls_range_budat-low = i_budat.
            APPEND ls_range_budat TO lt_range_budat.
            CLEAR ls_range_budat.

            ls_range_xblnr-sign = 'I'.
            ls_range_xblnr-option = 'EQ'.
            ls_range_xblnr-low = i_xblnr.
            APPEND ls_range_xblnr TO lt_range_xblnr.
            CLEAR ls_range_xblnr.

            " Navigate to the resource and create a request for the read operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_BKPF' )->create_request_for_read( ).

            " Create the filter tree
            lo_filter_factory = lo_request->create_filter_factory( ).

            lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'BUKRS'
                                                                    it_range             = lt_range_bukrs ).
            lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'BUDAT'
                                                                    it_range             = lt_range_budat ).
            lo_filter_node_3  = lo_filter_factory->create_by_range( iv_property_path     = 'XBLNR'
                                                                    it_range             = lt_range_xblnr ).

            lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 )->and( lo_filter_node_3 ).
            lo_request->set_filter( lo_filter_node_root ).

            lo_request->set_top( 50 )->set_skip( 0 ).

            " Execute the request and retrieve the business data
            lo_response = lo_request->execute( ).
            lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

            READ TABLE lt_business_data INTO DATA(ls_business_data) INDEX 1.
            MOVE-CORRESPONDING ls_business_data TO es_bkpf.

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

  METHOD zfi_const.
    CASE i_operacion.
      WHEN 'READ'.


    ENDCASE.
  ENDMETHOD.

  METHOD lfa1.
    CASE i_operacion.
      WHEN 'READ'.

        DATA:
          ls_entity_key    TYPE zscm_zget_transp_liq=>tys_z_i_lfa_1_type,
          ls_business_data TYPE zscm_zget_transp_liq=>tys_z_i_lfa_1_type,
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
                                                     proxy_model_id      = 'ZSCM_ZGET_TRANSP_LIQ'
                                                     proxy_model_version = '0001' )
                io_http_client             = lo_http_client
                iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_ZGET_TRANSP_LIQ' ).

            ASSERT lo_http_client IS BOUND.


            " Set entity key
            ls_entity_key = VALUE #(
                      lifnr  = i_lifnr ).

            " Navigate to the resource
            lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFA_1' )->navigate_with_key( ls_entity_key ).

            " Execute the request and retrieve the business data
            lo_response = lo_resource->create_request_for_read( )->execute( ).
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            e_ktokk = ls_business_data-ktokk.

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
