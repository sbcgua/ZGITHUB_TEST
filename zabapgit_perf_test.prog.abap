*&---------------------------------------------------------------------*
*& Report  ZABAPGIT_PERF_TEST
*&---------------------------------------------------------------------*

REPORT ZABAPGIT_PERF_TEST.


CONSTANTS: gc_xml_version  TYPE string VALUE 'v1.0.0',      "#EC NOTEXT
           gc_abap_version TYPE string VALUE 'v1.17.20'.    "#EC NOTEXT

SELECTION-SCREEN BEGIN OF SCREEN 1001.
* dummy for triggering screen
SELECTION-SCREEN END OF SCREEN 1001.

INCLUDE zabapgit_password_dialog. " !!! Contains SELECTION SCREEN

INCLUDE zabapgit_definitions.
INCLUDE zabapgit_exceptions.
INCLUDE zabapgit_zlib.
INCLUDE zabapgit_html.
INCLUDE zabapgit_util.
INCLUDE zabapgit_xml.

INCLUDE zabapgit_app. " Some deferred definitions here
INCLUDE zabapgit_persistence_old.
INCLUDE zabapgit_persistence.
INCLUDE zabapgit_dot_abapgit.
INCLUDE zabapgit_sap_package.

INCLUDE zabapgit_stage.
INCLUDE zabapgit_git_helpers.
INCLUDE zabapgit_repo.
INCLUDE zabapgit_stage_logic.
INCLUDE zabapgit_git.
INCLUDE zabapgit_objects.
INCLUDE zabapgit_tadir.
INCLUDE zabapgit_file_status.
INCLUDE zabapgit_popups.
INCLUDE zabapgit_zip.
INCLUDE zabapgit_objects_impl.

INCLUDE zabapgit_object_serializing. " All serializing classes here

INCLUDE zabapgit_repo_impl.
INCLUDE zabapgit_background.
INCLUDE zabapgit_transport.

INCLUDE zabapgit_services. " All services here
INCLUDE zabapgit_gui_pages. " All GUI pages here
INCLUDE zabapgit_gui_pages_userexit IF FOUND.
INCLUDE zabapgit_gui_router.
INCLUDE zabapgit_gui.

INCLUDE zabapgit_app_impl.
INCLUDE zabapgit_unit_test.
INCLUDE zabapgit_forms.

INITIALIZATION.
  lcl_password_dialog=>on_screen_init( ).

* Hide Execute button from screen
AT SELECTION-SCREEN OUTPUT.
  IF sy-dynnr = lcl_password_dialog=>dynnr.
    lcl_password_dialog=>on_screen_output( ).
  ELSE.
    PERFORM output.
  ENDIF.

AT SELECTION-SCREEN.
  IF sy-dynnr = lcl_password_dialog=>dynnr.
    lcl_password_dialog=>on_screen_event( sscrfields-ucomm ).
  ENDIF.

**********************************************************************

start-of-selection.

*  constants gc_target_repo_key type lcl_persistence_db=>ty_value value '000000000004'.
  constants gc_target_repo_key type lcl_persistence_db=>ty_value value '000000000011'.
  data: lo_repo type ref to lcl_repo_online,
        lv_user type string,
        lv_pass type string.
  data: lv_sta_time type timestampl,
        lv_end_time type timestampl,
        lv_diff     type p decimals 6.

  get time stamp field lv_sta_time.
  lo_repo ?= lcl_app=>repo_srv( )->get( gc_target_repo_key ).
  get time stamp field lv_end_time.
  lv_diff  = lv_end_time - lv_sta_time.
  write: /(30) 'repo_srv()->get()', lv_diff.

  lv_user = lcl_app=>user( )->get_repo_username( lo_repo->get_url( ) ).

  lcl_password_dialog=>popup(
    EXPORTING iv_repo_url = lo_repo->get_url( )
    CHANGING  cv_user     = lv_user
              cv_pass     = lv_pass ).

  lcl_login_manager=>set(
    iv_uri      = lo_repo->get_url( )
    iv_username = lv_user
    iv_password = lv_pass
  ).

  get time stamp field lv_sta_time.
  lo_repo->get_files_local( ).
  get time stamp field lv_end_time.
  lv_diff  = lv_end_time - lv_sta_time.
  write: /(30) 'get_files_local()', lv_diff.

  get time stamp field lv_sta_time.
  lo_repo->get_files_remote( ).
  get time stamp field lv_end_time.
  lv_diff  = lv_end_time - lv_sta_time.
  write: /(30) 'get_files_remote()', lv_diff.

  get time stamp field lv_sta_time.
  lo_repo->status( ).
  get time stamp field lv_end_time.
  lv_diff  = lv_end_time - lv_sta_time.
  write: /(30) 'status()', lv_diff.