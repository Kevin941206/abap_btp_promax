CLASS zcl_qry_fbl1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*  *tabla LFB1
    CLASS-METHODS: GET_LFB1       IMPORTING VALUE(i_operacion) TYPE text10
                                                  lifnr        type lifnr
                                  EXPORTING VALUE(e_bukrs) type  bukrs.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_qry_fbl1 IMPLEMENTATION.

METHOD GET_lfb1.
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
                                              proxy_model_id      = 'ZSCM_LFB1'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_LFB1' ).

     ASSERT lo_http_client IS BOUND.


" Set entity key
ls_entity_key = VALUE #(
          lifnr  = lifnr ).
*          bukrs  = Bukrs ).

" Navigate to the resource
lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFB_1' )->navigate_with_key( ls_entity_key ).

" Execute the request and retrieve the business data
lo_response = lo_resource->create_request_for_read( )->execute( ).
lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
e_bukrs = ls_business_data-bukrs.


  CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
" Handle remote Exception
" It contains details about the problems of your http(s) connection

CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
" Handle Exception

CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
" Handle Exception
 RAISE SHORTDUMP lx_web_http_client_error.


ENDTRY.

*DATA:
*  lt_business_data TYPE TABLE OF zscm_lfb1=>tys_z_i_lfb_1_type,
*  lo_http_client   TYPE REF TO if_web_http_client,
*  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
*  lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
*  lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.
*
**DATA:
** lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
** lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
** lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
** lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
** lt_range_LIFNR TYPE RANGE OF <element_name>,
** lt_range_BUKRS TYPE RANGE OF <element_name>.
*
*
*
*     TRY.
*     " Create http client
*            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = |DS4WD100| ). "|DS4100| ).
*            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
*       EXPORTING
*          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
*                                              proxy_model_id      = 'ZSCM_LFB1'
*                                              proxy_model_version = '0001' )
*         io_http_client             = lo_http_client
*         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_LFB1' ).
*
*     ASSERT lo_http_client IS BOUND.
*
*
*" Navigate to the resource and create a request for the read operation
*lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_LFB_1' )->create_request_for_read( ).
*
*" Create the filter tree
**lo_filter_factory = lo_request->create_filter_factory( ).
**
*CLEAR lt_range_spras.
*            ls_range_spras-sign = 'I'.
*            ls_range_spras-option = 'EQ'.
*            ls_range_spras-low = i_langu.
*            APPEND ls_range_spras TO lt_range_LIFNR.
*            CLEAR lt_range_LIFNR.
*
*
*lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = LIFNR ).
*                                                        it_range             = lt_range_LIFNR ).
**lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'BUKRS'
**                                                        it_range             = lt_range_BUKRS ).
*
**lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
**lo_request->set_filter( lo_filter_node_root ).
*
*lo_request->set_top( 50 )->set_skip( 0 ).
*
*" Execute the request and retrieve the business data
*lo_response = lo_request->execute( ).
*lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).
*
*CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
*" Handle remote Exception
*" It contains details about the problems of your http(s) connection
*
*CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
*" Handle Exception
*
*CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
*" Handle Exception
*RAISE SHORTDUMP lx_web_http_client_error.







    endcase.
endmETHOD.

ENDCLASS.
