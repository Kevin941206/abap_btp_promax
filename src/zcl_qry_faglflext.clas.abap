CLASS zcl_qry_faglflext DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*tabla faglflext
    CLASS-METHODS: GET_faglflext       IMPORTING VALUE(i_operacion)         TYPE text10
                                                       rldnr  type char5
                                                       rrcty  type c
                                                       rvers  type char3
                                                       rbukrs type bukrs
                                                       racct  type zfagl_range_t_racct
                                                       ryear  type zryear
                                       EXPORTING VALUE(lt_faglflext) type  ZTT_FAGLFLEXT.

*tabla skat
    CLASS-METHODS: GET_skat       IMPORTING VALUE(i_operacion)  TYPE text10
                                                  spras       TYPE c
                                                  ktopl         type ktopl
                                                  saknr         type zracct
                                       EXPORTING VALUE(e_txt50) TYPE TXT50_SKAT .

*tabla skat
    CLASS-METHODS: GET_T001      IMPORTING VALUE(i_operacion)  TYPE text10
                                       EXPORTING VALUE(et_companys) TYPE ztt_t001.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_qry_faglflext IMPLEMENTATION.

METHOD GET_T001.

CASE i_operacion.

  WHEN 'READ LIST'.

    "------------------------------------------------------------
    " Declaración de variables
    "------------------------------------------------------------
    DATA:
      lt_business_data TYPE TABLE OF zscm_t001_2=>tys_z_i_t_001_2_type, "Datos recibidos del servicio OData
      lo_http_client   TYPE REF TO if_web_http_client,               "Cliente HTTP
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,         "Proxy OData
      lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,    "Request READ LIST
      lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst,    "Response del servicio
      ls_companys      LIKE LINE OF et_companys.                      "Estructura de salida

    TRY.

        "--------------------------------------------------------
        " Obtención del destino HTTP desde tabla de configuración
        "--------------------------------------------------------
        DATA lv_dest TYPE string.

        SELECT SINGLE destino
          FROM zbtp_t_destino
          INTO @lv_dest.

        "--------------------------------------------------------
        " Creación del destino HTTP (BTP / Cloud Destination)
        "--------------------------------------------------------
        DATA(lo_destination) =
          cl_http_destination_provider=>create_by_cloud_destination(
            i_name = lv_dest
          ).

        "--------------------------------------------------------
        " Creación del cliente HTTP
        "--------------------------------------------------------
        lo_http_client =
          cl_web_http_client_manager=>create_by_http_destination(
            lo_destination
          ).

        "--------------------------------------------------------
        " Creation of the OData V2 remote proxy
        "--------------------------------------------------------
        lo_client_proxy =
          /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
            EXPORTING
              is_proxy_model_key     = VALUE #(
                                          repository_id       = 'DEFAULT'
                                          proxy_model_id      = 'ZSCM_T001_2'
                                          proxy_model_version = '0001'
                                        )
              io_http_client           = lo_http_client
              iv_relative_service_root = '/sap/opu/odata/sap/ZSB_T001_2'
          ).

        " Validation that the HTTP client was created
        ASSERT lo_http_client IS BOUND.

        "--------------------------------------------------------
        " Creation of the READ request for the Entity Set”
        "--------------------------------------------------------
        lo_request =
          lo_client_proxy->create_resource_for_entity_set( 'Z_I_T_001_2' )->create_request_for_read( ).

        " Pagination: first 50 records
        lo_request->set_top( 50 ).
        lo_request->set_skip( 0 ).

        "--------------------------------------------------------
        " Execution of the request
        "--------------------------------------------------------
        lo_response = lo_request->execute( ).

        " Retrieval of business data
        lo_response->get_business_data(
          IMPORTING
            et_business_data = lt_business_data
        ).

        "--------------------------------------------------------
        " Mapping OData data to the output table
        "--------------------------------------------------------
        LOOP AT lt_business_data INTO DATA(ls_business_data).

          ls_companys-bukrs = ls_business_data-bukrs.
          ls_companys-butxt = ls_business_data-butxt.
          ls_companys-ktopl = ls_business_data-ktopl.

          APPEND ls_companys TO et_companys.
          CLEAR ls_companys.

        ENDLOOP.

      "----------------------------------------------------------
      " Exception handling
      "----------------------------------------------------------
      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Remote communication error (HTTP / destination / network)

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Critical HTTP client error

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Critical HTTP client error
        RAISE SHORTDUMP lx_web_http_client_error.

    ENDTRY.

ENDCASE.


ENDMETHOD.

METHOD GET_faglflext.

    CASE i_operacion.
      WHEN 'READ LIST'.

DATA:
  lt_business_data TYPE TABLE OF zscm_faglflext=>tys_z_i_faglflext_type,
  ls_business_data TYPE  zscm_faglflext=>tys_z_i_faglflext_type,
  lo_http_client   TYPE REF TO if_web_http_client,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst,
  ls_faglflext     type  ZES_FAGLFLEXT.


     TRY.
     " Create http client
     DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).

            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

     lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
       EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_FAGLFLEXT'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_FAGLFLEXT' ).

     ASSERT lo_http_client IS BOUND.


" Navigate to the resource and create a request for the read operation
lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_I_FAGLFLEXT' )->create_request_for_read( ).


lo_request->set_top( 50 )->set_skip( 0 ).

" Execute the request and retrieve the business data
lo_response = lo_request->execute( ).
lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

loop At lt_business_data iNTO ls_business_data.
  movE-CORRESPONDING ls_business_data to ls_faglflext.
  append ls_faglflext to lt_faglflext.
endLOOP.


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


METHOD GET_skat.

    CASE i_operacion.
      WHEN 'READ'.


DATA:
  ls_entity_key    TYPE zscm_skat=>tys_z_i_skattype,
  ls_business_data TYPE zscm_skat=>tys_z_i_skattype,
  lo_http_client   TYPE REF TO if_web_http_client,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read.



     TRY.
     " Create http client
*            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = |DS4WD100| ). "|DS4100| ).
DATA lv_dest TYPE string.
            SELECT SINGLE destino FROM zbtp_t_destino INTO @lv_dest.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = lv_dest ).
*            DATA(lo_destination) = cl_http_destination_provider=>create_by_url( 'https://ds4wd.sap.gpromax.com:433?saml2=disabled' ).
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
     lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
       EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                              proxy_model_id      = 'ZSCM_SKAT'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '/sap/opu/odata/sap/ZSB_SKAT' ).

     ASSERT lo_http_client IS BOUND.


" Set entity key
ls_entity_key = VALUE #(
          spras  = 'Spras'
          ktopl  = 'Ktopl'
          saknr  = 'Saknr' ).

" Navigate to the resource
lo_resource = lo_client_proxy->create_resource_for_entity_set( 'Z_I_SKAT' )->navigate_with_key( ls_entity_key ).

" Execute the request and retrieve the business data
lo_response = lo_resource->create_request_for_read( )->execute( ).
lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
e_txt50    = ls_business_data-txt_50.

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
