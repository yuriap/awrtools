set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.1.00.08'
,p_default_workspace_id=>50057735323918503
,p_default_application_id=>210
,p_default_owner=>'AWRTOOLS21'
);
end;
/
prompt --application/set_environment
 
prompt APPLICATION 210 - AWR Tools
--
-- Application Export:
--   Application:     210
--   Name:            AWR Tools
--   Date and Time:   11:38 Friday February 9, 2018
--   Exported By:     AWRTOOLS21ADM
--   Flashback:       0
--   Export Type:     Application Export
--   Version:         5.1.1.00.08
--   Instance ID:     218223986453927
--

-- Application Statistics:
--   Pages:                     18
--     Items:                   82
--     Computations:             4
--     Validations:              5
--     Processes:               28
--     Regions:                 51
--     Buttons:                 23
--   Shared Components:
--     Logic:
--       Items:                  1
--       Data Loading:           1
--     Navigation:
--       Lists:                  6
--       Breadcrumbs:            1
--         Entries:              6
--     Security:
--       Authentication:         1
--     User Interface:
--       Themes:                 1
--       Templates:
--         Page:                 9
--         Region:              15
--         Label:                5
--         List:                11
--         Popup LOV:            1
--         Calendar:             1
--         Breadcrumb:           1
--         Button:               3
--         Report:               9
--       LOVs:                   5
--       Shortcuts:              1
--     Globalization:
--     Reports:
--   Supporting Objects:  Included

prompt --application/delete_application
begin
wwv_flow_api.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/create_application
begin
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_display_id=>nvl(wwv_flow_application_install.get_application_id,210)
,p_owner=>nvl(wwv_flow_application_install.get_schema,'AWRTOOLS21')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'AWR Tools')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'F_200')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'7987495A28AD301B93017421ED22C428D36EAD62C7D25559736B089C8F6E9E27'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'5.1'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_date_format=>'DD-MON-YYYY HH24:MI'
,p_date_time_format=>'DD-MON-YYYY HH24:MI'
,p_timestamp_format=>'DD-MON-YYYY HH24.MI.SSXFF'
,p_timestamp_tz_format=>'DD-MON-YYYY HH.MI.SSXFF PM TZR'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(101266483489147630)
,p_application_tab_set=>0
,p_logo_image=>'TEXT:AWR Tools'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=> nvl(wwv_flow_application_install.get_proxy,'')
,p_flow_version=>'release 3.2.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_substitution_string_01=>'AWRTOOLSVER'
,p_substitution_value_01=>'3.2.0'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20180209113231'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_ui_type_name => null
);
end;
/
prompt --application/shared_components/navigation/lists
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(51714162134992520)
,p_name=>'All Utilities'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(51714320607992537)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Query search'
,p_list_item_link_target=>'f?p=&APP_ID.:17:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-window-search'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(55237447938570936)
,p_name=>'All Online Analysis'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(55237690152570976)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'ASH Dashboard'
,p_list_item_link_target=>'f?p=&APP_ID.:63:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-range-chart-area'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(56951075577997044)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'SQL runtime statistics'
,p_list_item_link_target=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-missile'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(99984961931618202)
,p_name=>'All Reports'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(99985176473618230)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'All dumps space usage'
,p_list_item_link_target=>'f?p=&APP_ID.:41:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-check'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(100011097213681068)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Locally loaded AWR data'
,p_list_item_link_target=>'f?p=&APP_ID.:42:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-server-file'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(100035246637735702)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Remotely loaded AWR data'
,p_list_item_link_target=>'f?p=&APP_ID.:43:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-server-bookmark'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(101214027428147369)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(101267609085147662)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(104617048784455360)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Projects'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-folder'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'10,11'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(55127629180930895)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Online Analytics'
,p_list_item_link_target=>'f?p=&APP_ID.:60:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-chart'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'60,61,62,63,64'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(56061742475542030)
,p_list_item_display_sequence=>63
,p_list_item_link_text=>'ASH Dashboard'
,p_list_item_link_target=>'f?p=&APP_ID.:63:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-range-chart-area'
,p_parent_list_item_id=>wwv_flow_api.id(55127629180930895)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(56917623743346408)
,p_list_item_display_sequence=>64
,p_list_item_link_text=>'SQL runtime statistics'
,p_list_item_link_target=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-missile'
,p_parent_list_item_id=>wwv_flow_api.id(55127629180930895)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'64'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(99925090461474506)
,p_list_item_display_sequence=>200
,p_list_item_link_text=>'Storage reports'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-search'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(99987158063642663)
,p_list_item_display_sequence=>210
,p_list_item_link_text=>'All dumps storage usage'
,p_list_item_link_target=>'f?p=&APP_ID.:41:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-database-check'
,p_parent_list_item_id=>wwv_flow_api.id(99925090461474506)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(100005290923671647)
,p_list_item_display_sequence=>220
,p_list_item_link_text=>'Locally loaded AWR data'
,p_list_item_link_target=>'f?p=&APP_ID.:42:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-server-file'
,p_parent_list_item_id=>wwv_flow_api.id(99925090461474506)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'42'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(100025616015722581)
,p_list_item_display_sequence=>230
,p_list_item_link_text=>'Remotely loaded AWR data'
,p_list_item_link_target=>'f?p=&APP_ID.:43:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-server-bookmark'
,p_parent_list_item_id=>wwv_flow_api.id(99925090461474506)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'43'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(51713825299976214)
,p_list_item_display_sequence=>300
,p_list_item_link_text=>'Utilites'
,p_list_item_link_target=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'17,20'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(51577877398603441)
,p_list_item_display_sequence=>310
,p_list_item_link_text=>'Query Search'
,p_list_item_link_target=>'f?p=&APP_ID.:17:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-window-search'
,p_parent_list_item_id=>wwv_flow_api.id(51713825299976214)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(101271964833258608)
,p_list_item_display_sequence=>1000
,p_list_item_link_text=>'Configuration'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cog'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'2'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(101266197061147591)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(101266362852147621)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Log Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_current_for_pages=>'&LOGOUT_URL.'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(101287183238896122)
,p_name=>'Data Load Wizard Progress - AWR Dump Loading'
,p_list_status=>'PUBLIC'
);
end;
/
prompt --application/shared_components/files
begin
null;
end;
/
prompt --application/plugin_settings
begin
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(101213418768147365)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(101213531118147367)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IG'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(101213677932147368)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attribute_01=>'IG'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(101213764045147368)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_CSS_CALENDAR'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(101213878450147368)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'modern'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(101213959406147369)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_03=>'N'
,p_attribute_05=>'SWITCH'
);
end;
/
prompt --application/shared_components/security/authorizations
begin
null;
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_processes
begin
null;
end;
/
prompt --application/shared_components/logic/application_items
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(51457826466478686)
,p_name=>'CURRENT_PROJECT'
,p_protection_level=>'S'
);
end;
/
prompt --application/shared_components/logic/application_computations
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(101301606957896191)
,p_lov_name=>'DATA_LOAD_CHARSET'
,p_lov_query=>'.'||wwv_flow_api.id(101301606957896191)||'.'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101301987739896194)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Unicode UTF-16 Little Endian'
,p_lov_return_value=>'utf-16le'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101302393067896194)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Unicode UTF-16 Big Endian'
,p_lov_return_value=>'utf-16be'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101302740902896195)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'US-ASCII'
,p_lov_return_value=>'us-ascii'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101303157185896196)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Arabic ISO-8859-6'
,p_lov_return_value=>'iso-8859-6'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101303592770896196)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Arabic Windows 1256'
,p_lov_return_value=>'windows-1256'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101303909596896197)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Chinese Big5'
,p_lov_return_value=>'big5'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101304389828896197)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Chinese GBK'
,p_lov_return_value=>'gbk'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101304806181896198)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Cyrilic ISO-8859-5'
,p_lov_return_value=>'iso-8859-5'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101305174189896198)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Cyrilic KOI8-R'
,p_lov_return_value=>'koi8-r'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101305532031896198)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Cyrilic KOI8-U'
,p_lov_return_value=>'koi8-u'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101305908564896199)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Cyrilic Windows 1251'
,p_lov_return_value=>'windows-1251'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101306324718896199)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Eastern European ISO-8859-2'
,p_lov_return_value=>'iso-8859-2'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101306797635896200)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Eastern European Windows 1250'
,p_lov_return_value=>'windows-1250'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101307157665896201)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Greek ISO-8859-7'
,p_lov_return_value=>'iso-8859-7'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101307565430896201)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Greek Windows 1253'
,p_lov_return_value=>'windows-1253'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101307955611896201)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Hebrew ISO-8859-8-i'
,p_lov_return_value=>'iso-8859-8-i'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101308371750896202)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Hebrew Windows 1255'
,p_lov_return_value=>'windows-1255'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101308713177896202)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Japanese EUC'
,p_lov_return_value=>'euc-jp'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101309115518896202)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Japanese Shift JIS'
,p_lov_return_value=>'shift_jis'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101309531201896203)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Korean EUC'
,p_lov_return_value=>'euc-kr'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101310000356896203)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Northern European ISO-8859-4'
,p_lov_return_value=>'iso-8859-4'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101310391002896203)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Northern European Windows 1257'
,p_lov_return_value=>'windows-1257'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101310791115896203)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Southern European ISO-8859-3'
,p_lov_return_value=>'iso-8859-3'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101311188213896204)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Thai TIS-620'
,p_lov_return_value=>'tis-620'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101311563427896206)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Turkish ISO-8859-9'
,p_lov_return_value=>'iso-8859-9'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101311909931896207)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Turkish Windows 1254'
,p_lov_return_value=>'windows-1254'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101312326537896207)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Unicode UTF-8'
,p_lov_return_value=>'utf-8'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101312799892896207)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Vietnamese Windows 1258'
,p_lov_return_value=>'windows-1258'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101313203674896207)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Western European ISO-8859-1'
,p_lov_return_value=>'iso-8859-1'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101313553427896207)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Western European Windows 1252'
,p_lov_return_value=>'windows-1252'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(101291010653896148)
,p_lov_name=>'DATA_LOAD_OPTION'
,p_lov_query=>'.'||wwv_flow_api.id(101291010653896148)||'.'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101291464050896152)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Upload file, comma separated (*.csv) or tab delimited'
,p_lov_return_value=>'UPLOAD'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101291832019896154)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Copy and Paste'
,p_lov_return_value=>'PASTE'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(101299606527896187)
,p_lov_name=>'DATE_FORMAT_OPT'
,p_lov_query=>'.'||wwv_flow_api.id(101299606527896187)||'.'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101299985161896187)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Use application standard format masks'
,p_lov_return_value=>'Y'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(101300319937896188)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Provide custom formats for uploaded columns'
,p_lov_return_value=>'N'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(57108143032390242)
,p_lov_name=>'SOURCEDB'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''Local warehouse'' d, ''$LOCAL$'' r from dual',
'union all',
'select username||''@''||host name, db_link id from user_db_links where db_link not like (select upper(cvalue) from awrconfig where ckey=''DBLINK'')||''%'''))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(57108666722420822)
,p_lov_name=>'SOURCETAB'
,p_lov_query=>'.'||wwv_flow_api.id(57108666722420822)||'.'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(57108913757420837)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'AWR Repository'
,p_lov_return_value=>'AWR'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(57109316412420845)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Memory'
,p_lov_return_value=>'V$VIEW'
);
end;
/
prompt --application/shared_components/navigation/trees
begin
null;
end;
/
prompt --application/pages/page_groups
begin
null;
end;
/
prompt --application/comments
begin
null;
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_api.create_menu(
 p_id=>wwv_flow_api.id(101267511034147656)
,p_name=>' Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(55128517332930913)
,p_short_name=>'All Online Analytics'
,p_link=>'f?p=&APP_ID.:60:&SESSION.'
,p_page_id=>60
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(56118763117386550)
,p_parent_id=>wwv_flow_api.id(55128517332930913)
,p_short_name=>'ASH Dasboard'
,p_link=>'f?p=&APP_ID.:63:&SESSION.::&DEBUG.:::'
,p_page_id=>63
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(101267910416147663)
,p_parent_id=>0
,p_short_name=>'Home'
,p_link=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(104620687558455409)
,p_short_name=>'Projects'
,p_link=>'f?p=&APP_ID.:10:&SESSION.'
,p_page_id=>10
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(104621747095455413)
,p_parent_id=>wwv_flow_api.id(104620687558455409)
,p_short_name=>'Project "&CURRENT_PROJECT."'
,p_link=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:::'
,p_page_id=>11
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(104718887992901607)
,p_parent_id=>wwv_flow_api.id(104621747095455413)
,p_short_name=>'Reports'
,p_link=>'f?p=&APP_ID.:15:&SESSION.'
,p_page_id=>15
);
end;
/
prompt --application/shared_components/user_interface/templates/page
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(101214156255147384)
,p_theme_id=>42
,p_name=>'Left Side Column'
,p_internal_name=>'LEFT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.leftSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-side" id="t_Body_side">',
'      #REGION_POSITION_02#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>  ',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            <div class="t-Footer-srMode">#SCREEN_READER_TOGGLE#</div>',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525196570560608698
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101214301228147414)
,p_page_template_id=>wwv_flow_api.id(101214156255147384)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101214404632147416)
,p_page_template_id=>wwv_flow_api.id(101214156255147384)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101214490083147416)
,p_page_template_id=>wwv_flow_api.id(101214156255147384)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101214568684147416)
,p_page_template_id=>wwv_flow_api.id(101214156255147384)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101214695226147416)
,p_page_template_id=>wwv_flow_api.id(101214156255147384)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101214780680147416)
,p_page_template_id=>wwv_flow_api.id(101214156255147384)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101214865318147416)
,p_page_template_id=>wwv_flow_api.id(101214156255147384)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215001539147416)
,p_page_template_id=>wwv_flow_api.id(101214156255147384)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(101215060392147424)
,p_theme_id=>42
,p_name=>'Left and Right Side Columns'
,p_internal_name=>'LEFT_AND_RIGHT_SIDE_COLUMNS'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.bothSideCols();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-side" id="t_Body_side">',
'      #REGION_POSITION_02#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>  ',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            <div class="t-Footer-srMode">#SCREEN_READER_TOGGLE#</div>',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>false
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525203692562657055
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215161988147425)
,p_page_template_id=>wwv_flow_api.id(101215060392147424)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215305320147425)
,p_page_template_id=>wwv_flow_api.id(101215060392147424)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215366525147425)
,p_page_template_id=>wwv_flow_api.id(101215060392147424)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215412429147425)
,p_page_template_id=>wwv_flow_api.id(101215060392147424)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215586157147425)
,p_page_template_id=>wwv_flow_api.id(101215060392147424)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215651887147425)
,p_page_template_id=>wwv_flow_api.id(101215060392147424)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215729557147425)
,p_page_template_id=>wwv_flow_api.id(101215060392147424)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215878185147425)
,p_page_template_id=>wwv_flow_api.id(101215060392147424)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101215914484147425)
,p_page_template_id=>wwv_flow_api.id(101215060392147424)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(101216064513147425)
,p_theme_id=>42
,p_name=>'Login'
,p_internal_name=>'LOGIN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.appLogin();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody--login no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #REGION_POSITION_01#',
'  #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'  <div class="t-Body-wrap">',
'    <div class="t-Body-col t-Body-col--main">',
'      <div class="t-Login-container">',
'      #BODY#',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>6
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2099711150063350616
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101216187596147426)
,p_page_template_id=>wwv_flow_api.id(101216064513147425)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101216274324147426)
,p_page_template_id=>wwv_flow_api.id(101216064513147425)
,p_name=>'Body Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(101216338482147426)
,p_theme_id=>42
,p_name=>'Marquee'
,p_internal_name=>'MASTER_DETAIL'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.masterDetail();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--masterDetail t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-info" id="t_Body_info">',
'        #REGION_POSITION_02#',
'      </div>',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>  ',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            <div class="t-Footer-srMode">#SCREEN_READER_TOGGLE#</div>',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>1996914646461572319
,p_translate_this_template=>'N'
);
end;
/
begin
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101216415470147427)
,p_page_template_id=>wwv_flow_api.id(101216338482147426)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101216598898147427)
,p_page_template_id=>wwv_flow_api.id(101216338482147426)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101216608317147427)
,p_page_template_id=>wwv_flow_api.id(101216338482147426)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101216797510147427)
,p_page_template_id=>wwv_flow_api.id(101216338482147426)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101216897301147427)
,p_page_template_id=>wwv_flow_api.id(101216338482147426)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101216934261147427)
,p_page_template_id=>wwv_flow_api.id(101216338482147426)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101217029542147427)
,p_page_template_id=>wwv_flow_api.id(101216338482147426)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101217203268147427)
,p_page_template_id=>wwv_flow_api.id(101216338482147426)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101217213845147427)
,p_page_template_id=>wwv_flow_api.id(101216338482147426)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(101217363346147427)
,p_theme_id=>42
,p_name=>'Minimal (No Navigation)'
,p_internal_name=>'MINIMAL_NO_NAVIGATION'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES# t-PageBody--noNav" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  <div class="t-Body-main">',
'      <div class="t-Body-title" id="t_Body_title">',
'        #REGION_POSITION_01#',
'      </div>',
'      <div class="t-Body-content" id="t_Body_content">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-contentInner">',
'          #BODY#',
'        </div>',
'        <footer class="t-Footer">',
'          <div class="t-Footer-body">',
'            <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'            <div class="t-Footer-apex">',
'              <div class="t-Footer-version">#APP_VERSION#</div>  ',
'              <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'              <div class="t-Footer-srMode">#SCREEN_READER_TOGGLE#</div>',
'            </div>',
'          </div>',
'          <div class="t-Footer-top">',
'            <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'          </div>',
'        </footer>',
'      </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>4
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2977628563533209425
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101217454831147429)
,p_page_template_id=>wwv_flow_api.id(101217363346147427)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101217592033147429)
,p_page_template_id=>wwv_flow_api.id(101217363346147427)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101217633630147429)
,p_page_template_id=>wwv_flow_api.id(101217363346147427)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101217792777147429)
,p_page_template_id=>wwv_flow_api.id(101217363346147427)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101217849099147429)
,p_page_template_id=>wwv_flow_api.id(101217363346147427)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101217940786147429)
,p_page_template_id=>wwv_flow_api.id(101217363346147427)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101218050377147429)
,p_page_template_id=>wwv_flow_api.id(101217363346147427)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(101218135861147430)
,p_theme_id=>42
,p_name=>'Modal Dialog'
,p_internal_name=>'MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.modalDialog();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--standard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'      <div class="t-Dialog-bodyWrapperIn"><div class="t-Dialog-body">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      #BODY#',
'      </div></div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--standard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2098960803539086924
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101218216260147430)
,p_page_template_id=>wwv_flow_api.id(101218135861147430)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101218330989147430)
,p_page_template_id=>wwv_flow_api.id(101218135861147430)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101218424526147430)
,p_page_template_id=>wwv_flow_api.id(101218135861147430)
,p_name=>'Dialog Footer'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(101218636249147436)
,p_theme_id=>42
,p_name=>'Right Side Column'
,p_internal_name=>'RIGHT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.rightSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8"> ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>  ',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            <div class="t-Footer-srMode">#SCREEN_READER_TOGGLE#</div>',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>false
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525200116240651575
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101218778477147436)
,p_page_template_id=>wwv_flow_api.id(101218636249147436)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101218894431147436)
,p_page_template_id=>wwv_flow_api.id(101218636249147436)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101218953220147436)
,p_page_template_id=>wwv_flow_api.id(101218636249147436)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101219097897147436)
,p_page_template_id=>wwv_flow_api.id(101218636249147436)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101219196550147436)
,p_page_template_id=>wwv_flow_api.id(101218636249147436)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101219234196147436)
,p_page_template_id=>wwv_flow_api.id(101218636249147436)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101219341735147436)
,p_page_template_id=>wwv_flow_api.id(101218636249147436)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101219494043147436)
,p_page_template_id=>wwv_flow_api.id(101218636249147436)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(101219546756147436)
,p_theme_id=>42
,p_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'      <div class="t-Body-title" id="t_Body_title">',
'        #REGION_POSITION_01#',
'      </div>',
'      <div class="t-Body-content" id="t_Body_content">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-contentInner">',
'          #BODY#',
'        </div>',
'        <footer class="t-Footer">',
'          <div class="t-Footer-body">',
'            <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'            <div class="t-Footer-apex">',
'              <div class="t-Footer-version">#APP_VERSION#</div>  ',
'              <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'              <div class="t-Footer-srMode">#SCREEN_READER_TOGGLE#</div>',
'            </div>',
'          </div>',
'          <div class="t-Footer-top">',
'            <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'          </div>',
'        </footer>',
'      </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>1
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>4070909157481059304
,p_translate_this_template=>'N'
);
end;
/
begin
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101219634418147436)
,p_page_template_id=>wwv_flow_api.id(101219546756147436)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101219786918147436)
,p_page_template_id=>wwv_flow_api.id(101219546756147436)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101219907016147437)
,p_page_template_id=>wwv_flow_api.id(101219546756147436)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101219954788147437)
,p_page_template_id=>wwv_flow_api.id(101219546756147436)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101220070842147437)
,p_page_template_id=>wwv_flow_api.id(101219546756147436)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101220113319147437)
,p_page_template_id=>wwv_flow_api.id(101219546756147436)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101220302317147437)
,p_page_template_id=>wwv_flow_api.id(101219546756147436)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>false
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(101220362871147437)
,p_theme_id=>42
,p_name=>'Wizard Modal Dialog'
,p_internal_name=>'WIZARD_MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.wizardModal();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--wizard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'      <div class="t-Dialog-bodyWrapperIn"><div class="t-Dialog-body">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      #BODY#',
'      </div></div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--wizard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2120348229686426515
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101220433466147437)
,p_page_template_id=>wwv_flow_api.id(101220362871147437)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101220512462147437)
,p_page_template_id=>wwv_flow_api.id(101220362871147437)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(101220629130147437)
,p_page_template_id=>wwv_flow_api.id(101220362871147437)
,p_name=>'Wizard Buttons'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/button
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(101255311357147531)
,p_template_name=>'Icon'
,p_internal_name=>'ICON'
,p_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"><'
||'/span></button>'
,p_hot_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-h'
||'idden="true"></span></button>'
,p_reference_id=>2347660919680321258
,p_translate_this_template=>'N'
,p_theme_class_id=>5
,p_theme_id=>42
);
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(101255455566147533)
,p_template_name=>'Text'
,p_internal_name=>'TEXT'
,p_template=>'<button onclick="#JAVASCRIPT#" class="t-Button #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_hot_template=>'<button onclick="#JAVASCRIPT#" class="t-Button t-Button--hot #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_reference_id=>4070916158035059322
,p_translate_this_template=>'N'
,p_theme_class_id=>1
,p_theme_id=>42
);
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(101255557052147533)
,p_template_name=>'Text with Icon'
,p_internal_name=>'TEXT_WITH_ICON'
,p_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-label">#LABEL#'
||'</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_hot_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-'
||'label">#LABEL#</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_reference_id=>2081382742158699622
,p_translate_this_template=>'N'
,p_theme_class_id=>4
,p_preset_template_options=>'t-Button--iconRight'
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/region
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101220831093147441)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">#BODY#</div>',
'    </div>',
'    <div class="t-Alert-buttons">#PREVIOUS##CLOSE##CREATE##NEXT#</div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Alert'
,p_internal_name=>'ALERT'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2039236646100190748
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101220923806147457)
,p_plug_template_id=>wwv_flow_api.id(101220831093147441)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101222698017147467)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#"> ',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Blank with Attributes'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4499993862448380551
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101222791631147468)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#"> ',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Blank with Attributes (No Grid)'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES_NO_GRID'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3369790999010910123
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101222870769147468)
,p_plug_template_id=>wwv_flow_api.id(101222791631147468)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101222944353147468)
,p_plug_template_id=>wwv_flow_api.id(101222791631147468)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101223105724147468)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ButtonRegion t-Form--floatLeft #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ButtonRegion-wrap">',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##CLOSE##DELETE#</div></div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--content">',
'      <h2 class="t-ButtonRegion-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      #BODY#',
'      <div class="t-ButtonRegion-buttons">#CHANGE#</div>',
'    </div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Buttons Container'
,p_internal_name=>'BUTTONS_CONTAINER'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>17
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2124982336649579661
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101223197190147468)
,p_plug_template_id=>wwv_flow_api.id(101223105724147468)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101223218616147468)
,p_plug_template_id=>wwv_flow_api.id(101223105724147468)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101223987625147469)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--carousel #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'   <div class="t-Region-carouselRegions">',
'     #SUB_REGIONS#',
'   </div>',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Carousel Container'
,p_internal_name=>'CAROUSEL_CONTAINER'
,p_javascript_file_urls=>'#IMAGE_PREFIX#plugins/com.oracle.apex.carousel/1.1/com.oracle.apex.carousel#MIN#.js?v=#APEX_VERSION#'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-Region--showCarouselControls'
,p_preset_template_options=>'t-Region--hiddenOverflow'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2865840475322558786
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101224092816147469)
,p_plug_template_id=>wwv_flow_api.id(101223987625147469)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101224197147147469)
,p_plug_template_id=>wwv_flow_api.id(101223987625147469)
,p_name=>'Slides'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101227350618147473)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--hideShow #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems  t-Region-headerItems--controls">',
'    <button class="t-Button t-Button--icon t-Button--hideShow" type="button"></button>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#EDIT#</div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#CLOSE#</div>',
'    <div class="t-Region-buttons-right">#CREATE#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #COPY#',
'     #BODY#',
'     #SUB_REGIONS#',
'     #CHANGE#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
' </div>',
'</div>'))
,p_page_plug_template_name=>'Collapsible'
,p_internal_name=>'COLLAPSIBLE'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>1
,p_preset_template_options=>'is-expanded:t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2662888092628347716
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101227488820147473)
,p_plug_template_id=>wwv_flow_api.id(101227350618147473)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101227567795147473)
,p_plug_template_id=>wwv_flow_api.id(101227350618147473)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101229602072147474)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ContentBlock #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ContentBlock-header"><h1 class="t-ContentBlock-title">#TITLE#</h1></div>',
'  <div class="t-ContentBlock-body">#BODY#</div>',
'  <div class="t-ContentBlock-buttons">#PREVIOUS##NEXT#</div>',
'</div>'))
,p_page_plug_template_name=>'Content Block'
,p_internal_name=>'CONTENT_BLOCK'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-ContentBlock--h1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2320668864738842174
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101230428461147474)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-HeroRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-HeroRegion-wrap">',
'    <div class="t-HeroRegion-col t-HeroRegion-col--left"><span class="t-HeroRegion-icon t-Icon #ICON_CSS_CLASSES#"></span></div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--content">',
'      <h1 class="t-HeroRegion-title">#TITLE#</h1>',
'      #BODY#',
'    </div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--right"><div class="t-HeroRegion-form">#SUB_REGIONS#</div><div class="t-HeroRegion-buttons">#NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Hero'
,p_internal_name=>'HERO'
,p_theme_id=>42
,p_theme_class_id=>22
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672571031438297268
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101230532014147474)
,p_plug_template_id=>wwv_flow_api.id(101230428461147474)
,p_name=>'Region Body'
,p_placeholder=>'#BODY#'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101231180076147474)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionDialog" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Dialog'
,p_internal_name=>'INLINE_DIALOG'
,p_theme_id=>42
,p_theme_class_id=>24
,p_default_template_options=>'js-modal:js-draggable:js-resizable'
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2671226943886536762
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101231297260147474)
,p_plug_template_id=>wwv_flow_api.id(101231180076147474)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101232142344147478)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-IRR-region #REGION_CSS_CLASSES#" role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
'  <h2 class="u-VisuallyHidden" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Interactive Report'
,p_internal_name=>'INTERACTIVE_REPORT'
,p_theme_id=>42
,p_theme_class_id=>9
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2099079838218790610
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101232452890147478)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-region t-Form--stretchInputs t-Form--labelsAbove #REGION_CSS_CLASSES#" id="#REGION_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Login-header">',
'    <span class="t-Login-logo #ICON_CSS_CLASSES#"></span>',
'    <h1 class="t-Login-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'  </div>',
'  <div class="t-Login-body">',
'    #BODY#',
'  </div>',
'  <div class="t-Login-buttons">',
'    #NEXT#',
'  </div>',
'  <div class="t-Login-links">',
'    #EDIT##CREATE#',
'  </div>',
'  #SUB_REGIONS#',
'</div>'))
,p_page_plug_template_name=>'Login'
,p_internal_name=>'LOGIN'
,p_theme_id=>42
,p_theme_class_id=>23
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672711194551076376
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101232590401147479)
,p_plug_template_id=>wwv_flow_api.id(101232452890147478)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101232642288147479)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'     #SUB_REGIONS#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>',
''))
,p_page_plug_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4070912133526059312
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101232744996147479)
,p_plug_template_id=>wwv_flow_api.id(101232642288147479)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101232893508147479)
,p_plug_template_id=>wwv_flow_api.id(101232642288147479)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101235898053147484)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-TabsRegion #REGION_CSS_CLASSES#" #REGION_ATTRIBUTES# id="#REGION_STATIC_ID#">',
'  #BODY#',
'  <div class="t-TabsRegion-items">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Tabs Container'
,p_internal_name=>'TABS_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>5
,p_preset_template_options=>'t-TabsRegion-mod--simple'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3221725015618492759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101235966009147484)
,p_plug_template_id=>wwv_flow_api.id(101235898053147484)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101236087139147484)
,p_plug_template_id=>wwv_flow_api.id(101235898053147484)
,p_name=>'Tabs'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101237024490147486)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-BreadcrumbRegion #REGION_CSS_CLASSES#"> ',
'  <div class="t-BreadcrumbRegion-body">',
'    <div class="t-BreadcrumbRegion-breadcrumb">',
'      #BODY#',
'    </div>',
'    <div class="t-BreadcrumbRegion-title">',
'      <h1 class="t-BreadcrumbRegion-titleText">#TITLE#</h1>',
'    </div>',
'  </div>',
'  <div class="t-BreadcrumbRegion-buttons">#PREVIOUS##CLOSE##DELETE##HELP##CHANGE##EDIT##COPY##CREATE##NEXT#</div>',
'</div>'))
,p_page_plug_template_name=>'Title Bar'
,p_internal_name=>'TITLE_BAR'
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BreadcrumbRegion--showBreadcrumb'
,p_preset_template_options=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2530016523834132090
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(101237441214147489)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Wizard #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Wizard-header">',
'    <h1 class="t-Wizard-title">#TITLE#</h1>',
'    <div class="u-Table t-Wizard-controls">',
'      <div class="u-Table-fit t-Wizard-buttons">#PREVIOUS##CLOSE#</div>',
'      <div class="u-Table-fill t-Wizard-steps">',
'        #BODY#',
'      </div>',
'      <div class="u-Table-fit t-Wizard-buttons">#NEXT#</div>',
'    </div>',
'  </div>',
'  <div class="t-Wizard-body">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Wizard Container'
,p_internal_name=>'WIZARD_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Wizard--hideStepsXSmall'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2117602213152591491
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(101237551628147489)
,p_plug_template_id=>wwv_flow_api.id(101237441214147489)
,p_name=>'Wizard Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101246051976147514)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value"><a href="#LINK#" #A03#>#A01#</a></span>',
'</li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value"><a href="#LINK#" #A03#>#A01#</a></span>',
'</li>',
''))
,p_list_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_theme_id=>42
,p_theme_class_id=>3
,p_list_template_before_rows=>'<ul class="t-BadgeList t-BadgeList--circular #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Value'
,p_a02_label=>'List item CSS Classes'
,p_a03_label=>'Link Attributes'
,p_reference_id=>2062482847268086664
,p_list_template_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'A01: Large Number',
'A02: List Item Classes',
'A03: Link Attributes'))
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101247766489147521)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--featured'
,p_list_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Secondary Information'
,p_a03_label=>'Initials'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Attributes'
,p_a06_label=>'Card Color Class'
,p_reference_id=>2885322685880632508
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101250110772147522)
,p_list_template_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_list_template_name=>'Links List'
,p_internal_name=>'LINKS_LIST'
,p_theme_id=>42
,p_theme_class_id=>18
,p_list_template_before_rows=>'<ul class="t-LinksList #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<ul class="t-LinksList-list">'
,p_after_sub_list=>'</ul>'
,p_sub_list_item_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_sub_list_item_noncurrent=>'<li class="t-LinksList-item#A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#<'
||'/span></a></li>'
,p_item_templ_curr_w_child=>'<li class="t-LinksList-item is-current is-expanded #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t'
||'-LinksList-badge">#A01#</span></a>#SUB_LISTS#</li>'
,p_item_templ_noncurr_w_child=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'Link Attributes'
,p_a03_label=>'List Item CSS Classes'
,p_reference_id=>4070914341144059318
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101250961962147523)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item is-active #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES# u-color #A06#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item  #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES# u-color #A06#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-MediaList--showIcons:t-MediaList--showDesc'
,p_list_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Class'
,p_a06_label=>'Icon Color Class'
,p_reference_id=>2066548068783481421
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101252115538147524)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Menu Bar'
,p_internal_name=>'MENU_BAR'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  iconType: ''fa'',',
'  slide: e.hasClass("js-slide"),',
'  menubar: true,',
'  menubarOverflow: true',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-showSubMenuIcons'
,p_list_template_before_rows=>'<div class="t-MenuBar #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_reference_id=>2008709236185638887
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101252626021147524)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_name=>'Menu Popup'
,p_internal_name=>'MENU_POPUP'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menu", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({ slide: e.hasClass("js-slide")});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<div id="#PARENT_STATIC_ID#_menu" class="#COMPONENT_CSS_CLASSES#" style="display:none;"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Data ID'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute'
,p_a05_label=>'Shortcut'
,p_reference_id=>3492264004432431646
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101252741773147525)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" role="button">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" role="button">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Navigation Bar'
,p_internal_name=>'NAVIGATION_BAR'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<ul class="t-NavigationBar #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<div class="t-NavigationBar-menu" style="display: none" id="menu_#PARENT_LIST_ITEM_ID#"><ul>'
,p_after_sub_list=>'</ul></div></li>'
,p_sub_list_item_current=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_sub_templ_curr_w_child=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_sub_templ_noncurr_w_child=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'List  Item CSS Classes'
,p_reference_id=>2846096252961119197
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101252831700147525)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Side Navigation Menu'
,p_internal_name=>'SIDE_NAVIGATION_MENU'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.treeView#MIN#.js?v=#APEX_VERSION#'
,p_javascript_code_onload=>'apex.jQuery(''body'').addClass(''t-PageBody--leftNav'');'
,p_theme_id=>42
,p_theme_class_id=>19
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-nav" id="t_Body_nav" role="navigation" aria-label="&APP_TITLE!ATTR.">',
'<div class="t-TreeNav #COMPONENT_CSS_CLASSES#" id="t_TreeNav" data-id="#PARENT_STATIC_ID#_tree" aria-label="&APP_TITLE!ATTR."><ul style="display:none">'))
,p_list_template_after_rows=>'</ul></div></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled True/False'
,p_a04_label=>'Title'
,p_reference_id=>2466292414354694776
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101252940105147526)
,p_list_template_current=>'<li class="t-Tabs-item is-active"><a href="#LINK#" class="t-Tabs-link"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-Tabs-item"><a href="#LINK#" class="t-Tabs-link"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_name=>'Tabs'
,p_internal_name=>'TABS'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Tabs--simple'
,p_list_template_before_rows=>'<ul class="t-Tabs #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>3288206686691809997
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101253788561147526)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Top Navigation Menu'
,p_internal_name=>'TOP_NAVIGATION_MENU'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  if ( apex.actions ) {',
'    apex.actions.addFromMarkup( e );',
'  } else {',
'    apex.debug.warn("Include actions.js to support menu shortcuts");',
'  }',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  slide: e.hasClass("js-slide"),',
'  menubar: true,',
'  menubarOverflow: true',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-tabLike'
,p_list_template_before_rows=>'<div class="t-Header-nav-list #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled True / False'
,p_a03_label=>'Hide'
,p_a04_label=>'Title Attribute'
,p_a05_label=>'Shortcut Key'
,p_reference_id=>2525307901300239072
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(101254288010147527)
,p_list_template_current=>'<li class="t-WizardSteps-step is-active" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></div></li>'
,p_list_template_noncurrent=>'<li class="t-WizardSteps-step" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"><span class="t-Icon a-Icon icon-check"></span></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"'
||'></span></span></div></li>'
,p_list_template_name=>'Wizard Progress'
,p_internal_name=>'WIZARD_PROGRESS'
,p_javascript_code_onload=>'apex.theme.initWizardProgressBar();'
,p_theme_id=>42
,p_theme_class_id=>17
,p_preset_template_options=>'t-WizardSteps--displayLabels'
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2 class="u-VisuallyHidden">#CURRENT_PROGRESS#</h2>',
'<ul class="t-WizardSteps #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'))
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>2008702338707394488
);
end;
/
prompt --application/shared_components/user_interface/templates/report
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(101238067053147490)
,p_row_template_name=>'Alerts'
,p_internal_name=>'ALERTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title">#ALERT_TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">',
'        #ALERT_DESC#',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      #ALERT_ACTION#',
'    </div>',
'  </div>',
'</div>'))
,p_row_template_before_rows=>'<div class="t-Alerts">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</div>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>14
,p_reference_id=>2881456138952347027
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(101238168764147494)
,p_row_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item">',
'  <span class="t-BadgeList-label">#COLUMN_HEADER#</span>',
'  <span class="t-BadgeList-value">#COLUMN_VALUE#</span>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-BadgeList t-BadgeList--circular #COMPONENT_CSS_CLASSES#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BadgeList--responsive'
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed'
,p_reference_id=>2103197159775914759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(101239859508147501)
,p_row_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <a href="#CARD_LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':CARD_LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <div class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_cards">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--featured'
,p_reference_id=>2973535649510699732
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(101242194604147506)
,p_row_template_name=>'Comments'
,p_internal_name=>'COMMENTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Comments-item #COMMENT_MODIFIERS#">',
'    <div class="t-Comments-icon a-MediaBlock-graphic">',
'        <div class="t-Comments-userIcon #ICON_MODIFIER#" aria-hidden="true">#USER_ICON#</div>',
'    </div>',
'    <div class="t-Comments-body a-MediaBlock-content">',
'        <div class="t-Comments-info">',
'            #USER_NAME# &middot; <span class="t-Comments-date">#COMMENT_DATE#</span> <span class="t-Comments-actions">#ACTIONS#</span>',
'        </div>',
'        <div class="t-Comments-comment">',
'            #COMMENT_TEXT##ATTRIBUTE_1##ATTRIBUTE_2##ATTRIBUTE_3##ATTRIBUTE_4#',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Comments #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>',
''))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Comments--chat'
,p_reference_id=>2611722012730764232
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(101242538644147506)
,p_row_template_name=>'Search Results'
,p_internal_name=>'SEARCH_RESULTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition1=>':LABEL_02 is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition2=>':LABEL_03 is null'
,p_row_template3=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition3=>':LABEL_04 is null'
,p_row_template4=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'      <span class="t-SearchResults-misc">#LABEL_04#: #VALUE_04#</span>',
'    </div>',
'  </li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-SearchResults #COMPONENT_CSS_CLASSES#">',
'<ul class="t-SearchResults-list">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>',
'</div>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'NOT_CONDITIONAL'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070913431524059316
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(101242666033147507)
,p_row_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_row_template1=>'<td class="t-Report-cell" #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>'
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Report #COMPONENT_CSS_CLASSES#" id="report_#REGION_STATIC_ID#" #REPORT_ATTRIBUTES#>',
'  <div class="t-Report-wrap">',
'    <table class="t-Report-pagination" role="presentation">#TOP_PAGINATION#</table>',
'    <div class="t-Report-tableWrap">',
'    <table class="t-Report-report" summary="#REGION_TITLE#">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'      </tbody>',
'    </table>',
'    </div>',
'    <div class="t-Report-links">#EXTERNAL_LINK##CSV_LINK#</div>',
'    <table class="t-Report-pagination t-Report-pagination--bottom" role="presentation">#PAGINATION#</table>',
'  </div>',
'</div>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_before_column_heading=>'<thead>'
,p_column_heading_template=>'<th class="t-Report-colHead" #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>'
,p_after_column_heading=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</thead>',
'<tbody>'))
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Report--altRowsDefault:t-Report--rowHighlight'
,p_reference_id=>2537207537838287671
,p_translate_this_template=>'N'
);
begin
wwv_flow_api.create_row_template_patch(
 p_id=>wwv_flow_api.id(101242666033147507)
,p_row_template_before_first=>'<tr>'
,p_row_template_after_last=>'</tr>'
);
exception when others then null;
end;
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(101243930076147508)
,p_row_template_name=>'Timeline'
,p_internal_name=>'TIMELINE'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <div class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':EVENT_LINK is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <a href="#EVENT_LINK#" class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </a>',
'</li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-Timeline #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_timeline">',
''))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_reference_id=>1513373588340069864
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(101244157275147508)
,p_row_template_name=>'Value Attribute Pairs - Column'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_COLUMN'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #COLUMN_HEADER#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #COLUMN_VALUE#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES#>'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068636272681754
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(101245196860147509)
,p_row_template_name=>'Value Attribute Pairs - Row'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #1#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #2#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068321678681753
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(101254880382147527)
,p_template_name=>'Hidden'
,p_internal_name=>'HIDDEN'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer t-Form-labelContainer--hiddenLabel col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label u-VisuallyHidden">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--hiddenLabel rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>13
,p_reference_id=>2039339104148359505
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(101254971141147529)
,p_template_name=>'Optional'
,p_internal_name=>'OPTIONAL'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>',
''))
,p_before_item=>'<div class="t-Form-fieldContainer rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>2317154212072806530
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(101255067064147529)
,p_template_name=>'Optional - Above'
,p_internal_name=>'OPTIONAL_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>#HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>3030114864004968404
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(101255118021147529)
,p_template_name=>'Required'
,p_internal_name=>'REQUIRED'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer is-required rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>2525313812251712801
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(101255303188147530)
,p_template_name=>'Required - Above'
,p_internal_name=>'REQUIRED_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label><span class="t-Form-required"><span class="a-Icon icon-asterisk"></span></span> #HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>3030115129444970113
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/breadcrumb
begin
wwv_flow_api.create_menu_template(
 p_id=>wwv_flow_api.id(101255921228147535)
,p_name=>'Breadcrumb'
,p_internal_name=>'BREADCRUMB'
,p_before_first=>'<ul class="t-Breadcrumb #COMPONENT_CSS_CLASSES#">'
,p_current_page_option=>'<li class="t-Breadcrumb-item is-active"><h1 class="t-Breadcrumb-label">#NAME#</h1></li>'
,p_non_current_page_option=>'<li class="t-Breadcrumb-item"><a href="#LINK#" class="t-Breadcrumb-label">#NAME#</a></li>'
,p_after_last=>'</ul>'
,p_max_levels=>6
,p_start_with_node=>'PARENT_TO_LEAF'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916542570059325
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/popuplov
begin
wwv_flow_api.create_popup_lov_template(
 p_id=>wwv_flow_api.id(101256121228147549)
,p_page_name=>'winlov'
,p_page_title=>'Search Dialog'
,p_page_html_head=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html lang="&BROWSER_LANGUAGE.">',
'<head>',
'<title>#TITLE#</title>',
'#APEX_CSS#',
'#THEME_CSS#',
'#THEME_STYLE_CSS#',
'#FAVICONS#',
'#APEX_JAVASCRIPT#',
'#THEME_JAVASCRIPT#',
'<meta name="viewport" content="width=device-width,initial-scale=1.0" />',
'</head>'))
,p_page_body_attr=>'onload="first_field()" class="t-Page t-Page--popupLOV"'
,p_before_field_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_filter_width=>'20'
,p_filter_max_width=>'100'
,p_filter_text_attr=>'class="t-Form-field t-Form-searchField"'
,p_find_button_text=>'Search'
,p_find_button_attr=>'class="t-Button t-Button--hot t-Button--padLeft"'
,p_close_button_text=>'Close'
,p_close_button_attr=>'class="t-Button u-pullRight"'
,p_next_button_text=>'Next &gt;'
,p_next_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_prev_button_text=>'&lt; Previous'
,p_prev_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_after_field_text=>'</div>'
,p_scrollbars=>'1'
,p_resizable=>'1'
,p_width=>'380'
,p_height=>'380'
,p_result_row_x_of_y=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_result_rows_per_pg=>100
,p_before_result_set=>'<div class="t-PopupLOV-links">'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>2885398517835871876
,p_translate_this_template=>'N'
,p_after_result_set=>'</div>'
);
end;
/
prompt --application/shared_components/user_interface/templates/calendar
begin
wwv_flow_api.create_calendar_template(
 p_id=>wwv_flow_api.id(101256045084147540)
,p_cal_template_name=>'Calendar'
,p_internal_name=>'CALENDAR'
,p_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" summary="#IMONTH# #YYYY#">'
,p_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>',
''))
,p_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_day_close_format=>'</td>'
,p_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_close_format=>'</td>'
,p_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_nonday_close_format=>'</td>'
,p_week_open_format=>'<tr>'
,p_week_close_format=>'</tr> '
,p_daily_title_format=>'<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>'
,p_daily_open_format=>'<tr>'
,p_daily_close_format=>'</tr>'
,p_weekly_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--weekly">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_weekly_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_weekly_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_weekly_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_weekly_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_day_close_format=>'</div></td>'
,p_weekly_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_close_format=>'</div></td>'
,p_weekly_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_weekly_time_close_format=>'</th>'
,p_weekly_time_title_format=>'#TIME#'
,p_weekly_hour_open_format=>'<tr>'
,p_weekly_hour_close_format=>'</tr>'
,p_daily_day_of_week_format=>'<th scope="col" id="#DY#" class="t-ClassicCalendar-dayColumn">#IDAY#</th>'
,p_daily_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--daily">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #DD#, #YYYY#</h1>'))
,p_daily_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL#" class="t-ClassicCalendar-calendar">'
,p_daily_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_daily_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_day_close_format=>'</div></td>'
,p_daily_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol" id="#TIME#">'
,p_daily_time_close_format=>'</th>'
,p_daily_time_title_format=>'#TIME#'
,p_daily_hour_open_format=>'<tr>'
,p_daily_hour_close_format=>'</tr>'
,p_cust_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_cust_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_cust_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" summary="#IMONTH# #YYYY#">'
,p_cust_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_week_open_format=>'<tr>'
,p_cust_week_close_format=>'</tr> '
,p_cust_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_day_close_format=>'</td>'
,p_cust_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">'
,p_cust_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_cust_nonday_close_format=>'</td>'
,p_cust_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">'
,p_cust_weekend_close_format=>'</td>'
,p_cust_hour_open_format=>'<tr>'
,p_cust_hour_close_format=>'</tr>'
,p_cust_time_title_format=>'#TIME#'
,p_cust_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_cust_time_close_format=>'</th>'
,p_cust_wk_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_cust_wk_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_cust_wk_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_cust_wk_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_wk_week_open_format=>'<tr>'
,p_cust_wk_week_close_format=>'</tr> '
,p_cust_wk_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_day_close_format=>'</div></td>'
,p_cust_wk_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_weekend_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_wk_weekend_close_format=>'</td>'
,p_agenda_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--list">',
'  <div class="t-ClassicCalendar-title">#IMONTH# #YYYY#</div>',
'  <ul class="t-ClassicCalendar-list">',
'    #DAYS#',
'  </ul>',
'</div>'))
,p_agenda_past_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-past">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_today_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-today">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_future_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-future">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_past_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-past">#DATA#</li>'
,p_agenda_today_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-today">#DATA#</li>'
,p_agenda_future_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-future">#DATA#</li>'
,p_month_data_format=>'#DAYS#'
,p_month_data_entry_format=>'<span class="t-ClassicCalendar-event">#DATA#</span>'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916747979059326
);
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(101256714240147563)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(101219546756147436)
,p_default_dialog_template=>wwv_flow_api.id(101218135861147430)
,p_error_template=>wwv_flow_api.id(101216064513147425)
,p_printer_friendly_template=>wwv_flow_api.id(101219546756147436)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(101216064513147425)
,p_default_button_template=>wwv_flow_api.id(101255455566147533)
,p_default_region_template=>wwv_flow_api.id(101232642288147479)
,p_default_chart_template=>wwv_flow_api.id(101232642288147479)
,p_default_form_template=>wwv_flow_api.id(101232642288147479)
,p_default_reportr_template=>wwv_flow_api.id(101232642288147479)
,p_default_tabform_template=>wwv_flow_api.id(101232642288147479)
,p_default_wizard_template=>wwv_flow_api.id(101232642288147479)
,p_default_menur_template=>wwv_flow_api.id(101237024490147486)
,p_default_listr_template=>wwv_flow_api.id(101232642288147479)
,p_default_irr_template=>wwv_flow_api.id(101232142344147478)
,p_default_report_template=>wwv_flow_api.id(101242666033147507)
,p_default_label_template=>wwv_flow_api.id(101254971141147529)
,p_default_menu_template=>wwv_flow_api.id(101255921228147535)
,p_default_calendar_template=>wwv_flow_api.id(101256045084147540)
,p_default_list_template=>wwv_flow_api.id(101250110772147522)
,p_default_nav_list_template=>wwv_flow_api.id(101253788561147526)
,p_default_top_nav_list_temp=>wwv_flow_api.id(101253788561147526)
,p_default_side_nav_list_temp=>wwv_flow_api.id(101252831700147525)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(101223105724147468)
,p_default_dialogr_template=>wwv_flow_api.id(101222698017147467)
,p_default_option_label=>wwv_flow_api.id(101254971141147529)
,p_default_required_label=>wwv_flow_api.id(101255118021147529)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(101252741773147525)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.1/')
,p_files_version=>62
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#HAMMERJS_URL#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/modernizr-custom#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(101256270275147552)
,p_theme_id=>42
,p_name=>'Vista'
,p_css_file_urls=>'#THEME_IMAGES#css/Vista#MIN#.css?v=#APEX_VERSION#'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_read_only=>true
,p_reference_id=>4007676303523989775
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(101256394360147554)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_current=>true
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(101256462805147554)
,p_theme_id=>42
,p_name=>'Vita - Dark'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Dark.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Dark#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3543348412015319650
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(101256596408147554)
,p_theme_id=>42
,p_name=>'Vita - Red'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Red.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Red#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>1938457712423918173
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(101256641699147554)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Slate.less'
,p_theme_roller_config=>'{"customCSS":"","vars":{"@g_Accent-BG":"#505f6d","@g_Accent-OG":"#ececec","@g_Body-Title-BG":"#dee1e4","@l_Link-Base":"#337ac0","@g_Body-BG":"#f5f5f5"}}'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Slate#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3291983347983194966
);
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/theme_display_points
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101221175215147464)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101221368253147465)
,p_theme_id=>42
,p_name=>'ALERT_TITLE'
,p_display_name=>'Alert Title'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the title of the alert is displayed.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101221695965147466)
,p_theme_id=>42
,p_name=>'ALERT_ICONS'
,p_display_name=>'Alert Icons'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets how icons are handled for the Alert Region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101221843027147466)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101223406471147468)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the region is styled. Use the "Remove Borders" template option to remove the region''s borders and shadows.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101223523444147468)
,p_theme_id=>42
,p_name=>'BODY_PADDING'
,p_display_name=>'Body Padding'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body padding for the region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101224259425147470)
,p_theme_id=>42
,p_name=>'TIMER'
,p_display_name=>'Timer'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets the timer for when to automatically navigate to the next region within the Carousel Region.'
,p_null_text=>'No Timer'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101224620319147470)
,p_theme_id=>42
,p_name=>'BODY_HEIGHT'
,p_display_name=>'Body Height'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body height. You can also specify a custom height by modifying the Region''s CSS Classes and using the height helper classes "i-hXXX" where XXX is any increment of 10 from 100 to 800.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101225269690147470)
,p_theme_id=>42
,p_name=>'ACCENT'
,p_display_name=>'Accent'
,p_display_sequence=>30
,p_template_types=>'REGION'
,p_help_text=>'Set the Region''s accent. This accent corresponds to a Theme-Rollable color and sets the background of the Region''s Header.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101225836407147471)
,p_theme_id=>42
,p_name=>'HEADER'
,p_display_name=>'Header'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Determines the display of the Region Header which also contains the Region Title.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101226020415147471)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101226985717147471)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the animation when navigating within the Carousel Region.'
,p_null_text=>'Fade'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101228571469147473)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101229775715147474)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101230207415147474)
,p_theme_id=>42
,p_name=>'BODY_STYLE'
,p_display_name=>'Body Style'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the region''s body container.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101230637746147474)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON'
,p_display_name=>'Display Icon'
,p_display_sequence=>50
,p_template_types=>'REGION'
,p_help_text=>'Display the Hero Region icon.'
,p_null_text=>'Yes (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101231560686147477)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101236192716147484)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101236350145147484)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101236752264147484)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101237621057147489)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101238271767147496)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101238452705147496)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101240067985147502)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'REPORT'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101240742525147503)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the overall style for the component.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101240994857147503)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>70
,p_template_types=>'REPORT'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101241318567147504)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Controls how to handle icons in the report.'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101242221717147506)
,p_theme_id=>42
,p_name=>'COMMENTS_STYLE'
,p_display_name=>'Comments Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the style in which comments are displayed.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101242798204147508)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101243100523147508)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101243265436147508)
,p_theme_id=>42
,p_name=>'REPORT_BORDER'
,p_display_name=>'Report Border'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of the Report''s borders.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101244238084147508)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101246146625147520)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101246916851147520)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101247924538147521)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'LIST'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101248694783147521)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101248938876147522)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>80
,p_template_types=>'LIST'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101249280223147522)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101250684383147523)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101251561881147523)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101254398344147527)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101255650388147534)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101256853144147581)
,p_theme_id=>42
,p_name=>'BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the bottom margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101257100430147581)
,p_theme_id=>42
,p_name=>'REGION_BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>210
,p_template_types=>'REGION'
,p_help_text=>'Set the bottom margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101257831882147582)
,p_theme_id=>42
,p_name=>'LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the left margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101258077010147583)
,p_theme_id=>42
,p_name=>'REGION_LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'REGION'
,p_help_text=>'Set the left margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101258808324147584)
,p_theme_id=>42
,p_name=>'RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'FIELD'
,p_help_text=>'Set the right margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101259066144147584)
,p_theme_id=>42
,p_name=>'REGION_RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'REGION'
,p_help_text=>'Set the right margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101259890443147584)
,p_theme_id=>42
,p_name=>'TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'FIELD'
,p_help_text=>'Set the top margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101260027910147584)
,p_theme_id=>42
,p_name=>'REGION_TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'REGION'
,p_help_text=>'Set the top margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101260855966147585)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101261025338147585)
,p_theme_id=>42
,p_name=>'SPACING_BOTTOM'
,p_display_name=>'Spacing Bottom'
,p_display_sequence=>100
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the bottom of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101261239927147585)
,p_theme_id=>42
,p_name=>'SPACING_LEFT'
,p_display_name=>'Spacing Left'
,p_display_sequence=>70
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the left of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101261462314147585)
,p_theme_id=>42
,p_name=>'SPACING_RIGHT'
,p_display_name=>'Spacing Right'
,p_display_sequence=>80
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the right of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101261652511147585)
,p_theme_id=>42
,p_name=>'SPACING_TOP'
,p_display_name=>'Spacing Top'
,p_display_sequence=>90
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the top of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101261810464147585)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the size of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101262033705147585)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>30
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the style of the button. Use the "Simple" option for secondary actions or sets of buttons. Use the "Remove UI Decoration" option to make the button appear as text.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101262787855147585)
,p_theme_id=>42
,p_name=>'BUTTON_SET'
,p_display_name=>'Button Set'
,p_display_sequence=>40
,p_template_types=>'BUTTON'
,p_help_text=>'Enables you to group many buttons together into a pill. You can use this option to specify where the button is within this set. Set the option to Default if this button is not part of a button set.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101263443693147585)
,p_theme_id=>42
,p_name=>'WIDTH'
,p_display_name=>'Width'
,p_display_sequence=>60
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the width of the button.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101263960089147586)
,p_theme_id=>42
,p_name=>'LABEL_POSITION'
,p_display_name=>'Label Position'
,p_display_sequence=>140
,p_template_types=>'REGION'
,p_help_text=>'Sets the position of the label relative to the form item.'
,p_null_text=>'Inline - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101264151647147586)
,p_theme_id=>42
,p_name=>'ITEM_SIZE'
,p_display_name=>'Item Size'
,p_display_sequence=>110
,p_template_types=>'REGION'
,p_help_text=>'Sets the size of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101264361298147586)
,p_theme_id=>42
,p_name=>'LABEL_ALIGNMENT'
,p_display_name=>'Label Alignment'
,p_display_sequence=>130
,p_template_types=>'REGION'
,p_help_text=>'Set the label text alignment for items within this region.'
,p_null_text=>'Right'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101264553594147586)
,p_theme_id=>42
,p_name=>'ITEM_PADDING'
,p_display_name=>'Item Padding'
,p_display_sequence=>100
,p_template_types=>'REGION'
,p_help_text=>'Sets the padding around items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101264820008147586)
,p_theme_id=>42
,p_name=>'ITEM_WIDTH'
,p_display_name=>'Item Width'
,p_display_sequence=>120
,p_template_types=>'REGION'
,p_help_text=>'Sets the width of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101265153217147586)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101265372516147586)
,p_theme_id=>42
,p_name=>'ITEM_POST_TEXT'
,p_display_name=>'Item Post Text'
,p_display_sequence=>30
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Post Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101265538229147586)
,p_theme_id=>42
,p_name=>'ITEM_PRE_TEXT'
,p_display_name=>'Item Pre Text'
,p_display_sequence=>20
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Pre Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(101265730501147586)
,p_theme_id=>42
,p_name=>'RADIO_GROUP_DISPLAY'
,p_display_name=>'Radio Group Display'
,p_display_sequence=>300
,p_template_types=>'FIELD'
,p_help_text=>'Determines the display for radio group items.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
end;
/
prompt --application/shared_components/user_interface/template_options
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101218585936147433)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(101218135861147430)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101220751016147438)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(101220362871147437)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101221055128147461)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101221305302147465)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(101221175215147464)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101221456454147465)
,p_theme_id=>42
,p_name=>'HIDDENHEADER'
,p_display_name=>'Hidden but Accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--accessibleHeading'
,p_group_id=>wwv_flow_api.id(101221368253147465)
,p_template_types=>'REGION'
,p_help_text=>'Visually hides the alert title, but assistive technologies can still read it.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101221596177147466)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--removeHeading'
,p_group_id=>wwv_flow_api.id(101221368253147465)
,p_template_types=>'REGION'
,p_help_text=>'Hides the Alert Title from being displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101221764029147466)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(101221695965147466)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101221911382147467)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(101221843027147466)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101222061165147467)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(101221175215147464)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101222111775147467)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(101221695965147466)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101222253357147467)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(101221175215147464)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101222396615147467)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(101221695965147466)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101222440237147467)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(101221175215147464)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101222598697147467)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101220831093147441)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(101221843027147466)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101223463305147468)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(101223105724147468)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101223665486147468)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(101223105724147468)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(101223523444147468)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101223784697147468)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(101223105724147468)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101223818902147469)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(101223105724147468)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(101223523444147468)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101224340912147470)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(101224259425147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101224467450147470)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(101224259425147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101224607605147470)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(101224259425147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101224739948147470)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101224902339147470)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101224908793147470)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101225028583147470)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(101224259425147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101225192476147470)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101225378588147470)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101225481963147470)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101225543728147471)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101225706879147471)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101225747925147471)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101225932769147471)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(101225836407147471)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101226191407147471)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(101226020415147471)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101226280838147471)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(101225836407147471)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101226382260147471)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101226418761147471)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101226533610147471)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101226684978147471)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(101226020415147471)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101226758230147471)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101226873346147471)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101227049535147472)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(101226985717147471)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101227142741147472)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(101226985717147471)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101227268259147472)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101223987625147469)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101227667837147473)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101227778434147473)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101227867725147473)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101227980112147473)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101228042948147473)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101228147079147473)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101228222180147473)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101228388211147473)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101228488008147473)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101228620820147473)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(101228571469147473)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101228733011147473)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(101228571469147473)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101228854799147473)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(101226020415147471)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101228949954147474)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101229049127147474)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101229137568147474)
,p_theme_id=>42
,p_name=>'REMEMBER_COLLAPSIBLE_STATE'
,p_display_name=>'Remember Collapsible State'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
,p_help_text=>'This option saves the current state of the collapsible region for the duration of the session.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101229280293147474)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101229310000147474)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(101226020415147471)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101229441944147474)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101227350618147473)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101229670701147474)
,p_theme_id=>42
,p_name=>'ADD_BODY_PADDING'
,p_display_name=>'Add Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101229602072147474)
,p_css_classes=>'t-ContentBlock--padded'
,p_template_types=>'REGION'
,p_help_text=>'Adds padding to the region''s body container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101229841368147474)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H1'
,p_display_name=>'Heading Level 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101229602072147474)
,p_css_classes=>'t-ContentBlock--h1'
,p_group_id=>wwv_flow_api.id(101229775715147474)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101229989029147474)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H2'
,p_display_name=>'Heading Level 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101229602072147474)
,p_css_classes=>'t-ContentBlock--h2'
,p_group_id=>wwv_flow_api.id(101229775715147474)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101230023633147474)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H3'
,p_display_name=>'Heading Level 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101229602072147474)
,p_css_classes=>'t-ContentBlock--h3'
,p_group_id=>wwv_flow_api.id(101229775715147474)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101230256017147474)
,p_theme_id=>42
,p_name=>'LIGHT_BACKGROUND'
,p_display_name=>'Light Background'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101229602072147474)
,p_css_classes=>'t-ContentBlock--lightBG'
,p_group_id=>wwv_flow_api.id(101230207415147474)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly lighter background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101230357911147474)
,p_theme_id=>42
,p_name=>'SHADOW_BACKGROUND'
,p_display_name=>'Shadow Background'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101229602072147474)
,p_css_classes=>'t-ContentBlock--shadowBG'
,p_group_id=>wwv_flow_api.id(101230207415147474)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly darker background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101230745624147474)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON_NO'
,p_display_name=>'No'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101230428461147474)
,p_css_classes=>'t-HeroRegion--hideIcon'
,p_group_id=>wwv_flow_api.id(101230637746147474)
,p_template_types=>'REGION'
,p_help_text=>'Hide the Hero Region icon.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101230834295147474)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101230428461147474)
,p_css_classes=>'t-HeroRegion--featured'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101230946251147474)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101230428461147474)
,p_css_classes=>'t-HeroRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the hero region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101231008809147474)
,p_theme_id=>42
,p_name=>'STACKED_FEATURED'
,p_display_name=>'Stacked Featured'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101230428461147474)
,p_css_classes=>'t-HeroRegion--featured t-HeroRegion--centered'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101231384513147474)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(101231180076147474)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101231419046147477)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101231180076147474)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101231657469147477)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101231180076147474)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(101231560686147477)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101231806017147477)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101231180076147474)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(101231560686147477)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101231839152147478)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101231180076147474)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101231947879147478)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101231180076147474)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101232086379147478)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101231180076147474)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(101231560686147477)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101232237660147478)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101232142344147478)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101232350559147478)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101232142344147478)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101232934467147479)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233008853147479)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233113466147479)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233251427147479)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(101224620319147470)
,p_template_types=>'REGION'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233313769147481)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233496275147481)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233587060147481)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233663603147481)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233723224147483)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233900252147483)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101233923854147483)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234010592147483)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234177674147483)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234268415147483)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234374829147483)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234488628147483)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234557901147483)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234663808147483)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234786796147483)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_api.id(101225269690147470)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234879652147483)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(101225836407147471)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101234976496147484)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(101226020415147471)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101235105862147484)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(101225836407147471)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101235112106147484)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101235236736147484)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101235349231147484)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101235443954147484)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(101226020415147471)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101235523716147484)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101235704948147484)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101235756722147484)
,p_theme_id=>42
,p_name=>'TEXT_CONTENT'
,p_display_name=>'Text Content'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(101232642288147479)
,p_css_classes=>'t-Region--textContent'
,p_group_id=>wwv_flow_api.id(101223406471147468)
,p_template_types=>'REGION'
,p_help_text=>'Useful for displaying primarily text-based content, such as FAQs and more.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101236253105147484)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101235898053147484)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(101236192716147484)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101236487918147484)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101235898053147484)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(101236350145147484)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101236577572147484)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101235898053147484)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101236678900147484)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101235898053147484)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(101236350145147484)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101236810363147486)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101235898053147484)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(101236752264147484)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101236960715147486)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101235898053147484)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(101236752264147484)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101237182549147489)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(101237024490147486)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(101229775715147474)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101237245059147489)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(101237024490147486)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101237401129147489)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(101237024490147486)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(101229775715147474)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101237767556147489)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(101237441214147489)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(101237621057147489)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101237817137147489)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101237441214147489)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(101237621057147489)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101237953690147489)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(101237441214147489)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101238386005147496)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(101238271767147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101238530457147496)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101238690046147496)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(101238271767147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101238756410147499)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101238859725147499)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(101238271767147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101238956407147499)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101239013843147500)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101239126864147500)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(101238271767147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101239248230147500)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(101238271767147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101239402188147500)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101239423204147500)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101239568149147500)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101239662229147501)
,p_theme_id=>42
,p_name=>'RESPONSIVE'
,p_display_name=>'Responsive'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--responsive'
,p_template_types=>'REPORT'
,p_help_text=>'Automatically resize badges to smaller sizes as screen becomes smaller.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101239798248147501)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101238168764147494)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101239962748147501)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101240198575147502)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(101240067985147502)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101240274404147502)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101240388733147502)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(101240067985147502)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101240425040147502)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101240581344147502)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(101240067985147502)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101240621675147503)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101240878143147503)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(101240742525147503)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101241060189147503)
,p_theme_id=>42
,p_name=>'CARDS_COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(101240994857147503)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101241139589147504)
,p_theme_id=>42
,p_name=>'CARD_RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(101240994857147503)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101241233491147504)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(101240742525147503)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101241421014147504)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(101241318567147504)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101241547106147505)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(101241318567147504)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101241659119147505)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--featured'
,p_group_id=>wwv_flow_api.id(101240742525147503)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101241739244147505)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101241828087147505)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(101240067985147502)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101241989184147505)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101242027353147505)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101239859508147501)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101242394452147506)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101242194604147506)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(101242221717147506)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101242436630147506)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101242194604147506)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(101242221717147506)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101242827152147508)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101242666033147507)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(101242798204147508)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101242926688147508)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101242666033147507)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(101242798204147508)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101243131751147508)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101242666033147507)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(101243100523147508)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101243349814147508)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101242666033147507)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(101243265436147508)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101243476970147508)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(101242666033147507)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(101243265436147508)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101243570199147508)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(101242666033147507)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(101243265436147508)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101243610920147508)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101242666033147507)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(101243100523147508)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101243742078147508)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101242666033147507)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101243808911147508)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101242666033147507)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(101243265436147508)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101244079122147508)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(101243930076147508)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_api.id(101240742525147503)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact version of timeline with smaller text and fewer columns.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101244341535147508)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(101244157275147508)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101244436204147509)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101244157275147508)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101244577203147509)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101244157275147508)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101244694527147509)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101244157275147508)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101244760097147509)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101244157275147508)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101244891455147509)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(101244157275147508)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101244982311147509)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(101244157275147508)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101245073240147509)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(101244157275147508)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101245225850147509)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(101245196860147509)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101245341646147509)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101245196860147509)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101245411599147509)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101245196860147509)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101245589683147509)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(101245196860147509)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101245625847147509)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(101245196860147509)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(101238452705147496)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101245774428147509)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(101245196860147509)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101245899497147509)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(101245196860147509)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101245993358147509)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(101245196860147509)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(101244238084147508)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101246305326147520)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101246320557147520)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101246422580147520)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101246519498147520)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101246691149147520)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101246739451147520)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101246815268147520)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101247034012147520)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(101246916851147520)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101247169688147520)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(101246916851147520)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101247244409147520)
,p_theme_id=>42
,p_name=>'RESPONSIVE'
,p_display_name=>'Responsive'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--responsive'
,p_template_types=>'LIST'
,p_help_text=>'Automatically resize badges to smaller sizes as screen becomes smaller.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101247395613147520)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(101246916851147520)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101247450380147521)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101247597042147521)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(101246916851147520)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101247683021147521)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(101246051976147514)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(101246916851147520)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101247822312147521)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101248087598147521)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(101247924538147521)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101248183747147521)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101248248237147521)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(101247924538147521)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101248390237147521)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101248464728147521)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(101247924538147521)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101248518996147521)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101248745155147521)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(101248694783147521)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101248834253147522)
,p_theme_id=>42
,p_name=>'CARDS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--stacked'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Stacks the cards on top of each other.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101249090128147522)
,p_theme_id=>42
,p_name=>'COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(101248938876147522)
,p_template_types=>'LIST'
,p_help_text=>'Fills the card background with the color of the icon or default link style.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101249122910147522)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(101248694783147521)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101249340518147522)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(101249280223147522)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101249505981147522)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(101249280223147522)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101249597782147522)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--featured'
,p_group_id=>wwv_flow_api.id(101248694783147521)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101249655819147522)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101249773836147522)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(101247924538147521)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101249901369147522)
,p_theme_id=>42
,p_name=>'RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(101248938876147522)
,p_template_types=>'LIST'
,p_help_text=>'Raises the card so it pops up.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101249934252147522)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101250079623147522)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101247766489147521)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101250221582147523)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101250110772147522)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(101248694783147521)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101250367334147523)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101250110772147522)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101250488314147523)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101250110772147522)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101250512222147523)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101250110772147522)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101250747216147523)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101250110772147522)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(101250684383147523)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101250883846147523)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101250110772147522)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(101250684383147523)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101251051555147523)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101251188061147523)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101251249842147523)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101251380984147523)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101251471766147523)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies colors from the Theme''s color palette to icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101251700026147523)
,p_theme_id=>42
,p_name=>'LIST_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'t-MediaList--large'
,p_group_id=>wwv_flow_api.id(101251561881147523)
,p_template_types=>'LIST'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101251748160147524)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101251855513147524)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101251923482147524)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Display an icon next to the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101252098488147524)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101252285296147524)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(101252115538147524)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101252320708147524)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101252115538147524)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101252476957147524)
,p_theme_id=>42
,p_name=>'ENABLE_SLIDE_ANIMATION'
,p_display_name=>'Enable Slide Animation'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101252115538147524)
,p_css_classes=>'js-slide'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101252541481147524)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101252115538147524)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101253035616147526)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101252940105147526)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(101249280223147522)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101253207361147526)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(101252940105147526)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(101246146625147520)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101253285373147526)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101252940105147526)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(101249280223147522)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101253326525147526)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101252940105147526)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(101251561881147523)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101253429914147526)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101252940105147526)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(101248694783147521)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101253518870147526)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101252940105147526)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(101248694783147521)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101253687866147526)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(101252940105147526)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(101251561881147523)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101253898696147526)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(101253788561147526)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101253945796147526)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(101253788561147526)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101254019560147527)
,p_theme_id=>42
,p_name=>'ENABLE_SLIDE_ANIMATION'
,p_display_name=>'Enable Slide Animation'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(101253788561147526)
,p_css_classes=>'js-slide'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101254114923147527)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(101253788561147526)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101254493861147527)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101254288010147527)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(101254398344147527)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101254532761147527)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(101254288010147527)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(101254398344147527)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101254679476147527)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(101254288010147527)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(101254398344147527)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101254731688147527)
,p_theme_id=>42
,p_name=>'VERTICAL_LIST'
,p_display_name=>'Vertical Orientation'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(101254288010147527)
,p_css_classes=>'t-WizardSteps--vertical'
,p_template_types=>'LIST'
,p_help_text=>'Displays the wizard progress list in a vertical orientation and is suitable for displaying within a side column of a page.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101255710861147534)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(101255557052147533)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(101255650388147534)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101255859873147534)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(101255557052147533)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(101255650388147534)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101256956089147581)
,p_theme_id=>42
,p_name=>'FBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(101256853144147581)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101257111034147581)
,p_theme_id=>42
,p_name=>'RBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(101257100430147581)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101257225082147581)
,p_theme_id=>42
,p_name=>'FBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(101256853144147581)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101257348089147581)
,p_theme_id=>42
,p_name=>'RBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(101257100430147581)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101257476528147581)
,p_theme_id=>42
,p_name=>'FBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(101256853144147581)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the bottom margin for this field.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101257563678147581)
,p_theme_id=>42
,p_name=>'RBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(101257100430147581)
,p_template_types=>'REGION'
,p_help_text=>'Removes the bottom margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101257669108147581)
,p_theme_id=>42
,p_name=>'FBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(101256853144147581)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101257755105147582)
,p_theme_id=>42
,p_name=>'RBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(101257100430147581)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101257969867147582)
,p_theme_id=>42
,p_name=>'FLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(101257831882147582)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101258122866147583)
,p_theme_id=>42
,p_name=>'RLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(101258077010147583)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101258272384147583)
,p_theme_id=>42
,p_name=>'FLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(101257831882147582)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101258376585147583)
,p_theme_id=>42
,p_name=>'RLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(101258077010147583)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101258473869147583)
,p_theme_id=>42
,p_name=>'FLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(101257831882147582)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101258560082147583)
,p_theme_id=>42
,p_name=>'RLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(101258077010147583)
,p_template_types=>'REGION'
,p_help_text=>'Removes the left margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101258618834147583)
,p_theme_id=>42
,p_name=>'FLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(101257831882147582)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101258800644147584)
,p_theme_id=>42
,p_name=>'RLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(101258077010147583)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small left margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101259004819147584)
,p_theme_id=>42
,p_name=>'FRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(101258808324147584)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101259130250147584)
,p_theme_id=>42
,p_name=>'RRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(101259066144147584)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101259214074147584)
,p_theme_id=>42
,p_name=>'FRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(101258808324147584)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101259373227147584)
,p_theme_id=>42
,p_name=>'RRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(101259066144147584)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101259500025147584)
,p_theme_id=>42
,p_name=>'FRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(101258808324147584)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101259583767147584)
,p_theme_id=>42
,p_name=>'RRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(101259066144147584)
,p_template_types=>'REGION'
,p_help_text=>'Removes the right margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101259616872147584)
,p_theme_id=>42
,p_name=>'FRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(101258808324147584)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101259770639147584)
,p_theme_id=>42
,p_name=>'RRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(101259066144147584)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101259931913147584)
,p_theme_id=>42
,p_name=>'FTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(101259890443147584)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101260158548147584)
,p_theme_id=>42
,p_name=>'RTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(101260027910147584)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101260299920147584)
,p_theme_id=>42
,p_name=>'FTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(101259890443147584)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101260362021147585)
,p_theme_id=>42
,p_name=>'RTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(101260027910147584)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101260498653147585)
,p_theme_id=>42
,p_name=>'FTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(101259890443147584)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101260545407147585)
,p_theme_id=>42
,p_name=>'RTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(101260027910147584)
,p_template_types=>'REGION'
,p_help_text=>'Removes the top margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101260698628147585)
,p_theme_id=>42
,p_name=>'FTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(101259890443147584)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101260734307147585)
,p_theme_id=>42
,p_name=>'RTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(101260027910147584)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101260926797147585)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(101260855966147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101261194836147585)
,p_theme_id=>42
,p_name=>'LARGEBOTTOMMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapBottom'
,p_group_id=>wwv_flow_api.id(101261025338147585)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101261370138147585)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(101261239927147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101261512754147585)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(101261462314147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101261773899147585)
,p_theme_id=>42
,p_name=>'LARGETOPMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapTop'
,p_group_id=>wwv_flow_api.id(101261652511147585)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101261927982147585)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(101261810464147585)
,p_template_types=>'BUTTON'
,p_help_text=>'A large button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101262156472147585)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_LINK'
,p_display_name=>'Display as Link'
,p_display_sequence=>30
,p_css_classes=>'t-Button--link'
,p_group_id=>wwv_flow_api.id(101262033705147585)
,p_template_types=>'BUTTON'
,p_help_text=>'This option makes the button appear as a text link.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101262221598147585)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(101262033705147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101262402493147585)
,p_theme_id=>42
,p_name=>'SMALLBOTTOMMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padBottom'
,p_group_id=>wwv_flow_api.id(101261025338147585)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101262464601147585)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(101261239927147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101262529911147585)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(101261462314147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101262694116147585)
,p_theme_id=>42
,p_name=>'SMALLTOPMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padTop'
,p_group_id=>wwv_flow_api.id(101261652511147585)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101262845852147585)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(101262787855147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101262929525147585)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(101262787855147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101263022796147585)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(101262787855147585)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101263165185147585)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(101260855966147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101263289508147585)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(101262033705147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101263347404147585)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(101261810464147585)
,p_template_types=>'BUTTON'
,p_help_text=>'A small button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101263537156147585)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(101263443693147585)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101263662584147585)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(101260855966147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101263739767147586)
,p_theme_id=>42
,p_name=>'TINY'
,p_display_name=>'Tiny'
,p_display_sequence=>10
,p_css_classes=>'t-Button--tiny'
,p_group_id=>wwv_flow_api.id(101261810464147585)
,p_template_types=>'BUTTON'
,p_help_text=>'A very small button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101263867953147586)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(101260855966147585)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101264098515147586)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(101263960089147586)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101264231452147586)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(101264151647147586)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101264479930147586)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(101264361298147586)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101264679754147586)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(101264553594147586)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101264710740147586)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(101264553594147586)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101264968458147586)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(101264820008147586)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101265061871147586)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(101264151647147586)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101265250027147586)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(101265153217147586)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101265423820147586)
,p_theme_id=>42
,p_name=>'POST_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--postTextBlock'
,p_group_id=>wwv_flow_api.id(101265372516147586)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Post Text in a block style immediately after the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101265702051147586)
,p_theme_id=>42
,p_name=>'PRE_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--preTextBlock'
,p_group_id=>wwv_flow_api.id(101265538229147586)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Pre Text in a block style immediately before the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101265873390147586)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_PILL_BUTTON'
,p_display_name=>'Display as Pill Button'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--radioButtonGroup'
,p_group_id=>wwv_flow_api.id(101265730501147586)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the radio buttons to look like a button set / pill button.  Note that the the radio buttons must all be in the same row for this option to work.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101265919725147586)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(101266042982147586)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(101265153217147586)
,p_template_types=>'FIELD'
);
end;
/
prompt --application/shared_components/logic/build_options
begin
null;
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/globalization/translations
begin
null;
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/user_interface/shortcuts
begin
wwv_flow_api.create_shortcut(
 p_id=>wwv_flow_api.id(101268990194147708)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>'Would you like to perform this delete action?'
);
end;
/
prompt --application/shared_components/security/authentications
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(101266483489147630)
,p_name=>'Application Express Authentication'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/data_loading/tables/awrdumps_files
begin
wwv_flow_api.create_load_table(
 p_id=>wwv_flow_api.id(101286920736896065)
,p_name=>'AWR Dump Loading'
,p_owner=>'#OWNER#'
,p_table_name=>'AWRDUMPS_FILES'
,p_unique_column_1=>'DUMP_ID'
,p_is_uk1_case_sensitive=>'N'
,p_is_uk2_case_sensitive=>'N'
,p_is_uk3_case_sensitive=>'N'
,p_skip_validation=>'N'
);
end;
/
prompt --application/user_interfaces
begin
wwv_flow_api.create_user_interface(
 p_id=>wwv_flow_api.id(101266223782147592)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.'
,p_login_url=>'f?p=&APP_ID.:LOGIN_DESKTOP:&SESSION.'
,p_theme_style_by_user_pref=>false
,p_navigation_list_id=>wwv_flow_api.id(101214027428147369)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(101252831700147525)
,p_nav_list_template_options=>'#DEFAULT#'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(101266197061147591)
,p_nav_bar_list_template_id=>wwv_flow_api.id(101252741773147525)
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_api.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Home'
,p_page_mode=>'NORMAL'
,p_step_title=>'Home'
,p_step_sub_title=>'Home'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20180126144603'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(101247562198740112)
,p_plug_name=>'Getting started'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Web AWR Tools. Ver &AWRTOOLSVER.<br>',
'<br>',
'AWR dump warehouse with web-based UI.<br>',
'<br>',
'The main aims are:<br>',
'1) to have some user-friendly interface to manipulate AWR dumps (load, store, comment, unload).<br>',
'2) to create customized reports from raw AWR data using user-friendly interface, Currently, there are two custom reports "SQL queries compare report (HTML)" and "AWR SQL Report (HTML)" and all standard AWR reports.<br>',
'3) to share scripts with command-line AWR Tools. Exact the same main scripts are used for both tools.<br>',
'4) to be able to analyze AWR dumps which contain overlapping snapshot ranges (relevant to a situation when FLASHBACK DATABASE is in use for testing different scenarios).<br>',
'5) Added Online Analytic Tool - allows to analyze ASH data from local AWR warehouse as well as from remote one through dblink, V$ASH is also in use.<br>',
'<br>',
'Use-cases:<br>',
'1. Create a project.<br>',
'2. Load two or more raw AWR dumps.<br>',
'3. Load dumps into AWR repository, if snapshot ranges are overlapping, load the second dump into the second (remote) database.<br>',
'4. Create reports (the are stored automatically).<br>',
'5. Compress dump: Delete a dump file from database storage. AWR data is available for analysis.<br>',
'6. Unload AWR range: unload AWR data from AWR repository for a dump. AWR data can be loaded in the future if the dump file is still in the database. <br>',
'',
'<br>',
'To start <a href="f?p=&APP_ID.:10:&SESSION.">go to Projects page</a>.'))
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(101268011101147669)
,p_plug_name=>'Breadcrumbs'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101237024490147486)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(101267511034147656)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(101255921228147535)
,p_plug_query_row_template=>1
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'AWR load config'
,p_page_mode=>'NORMAL'
,p_step_title=>'AWR loading configuration'
,p_step_sub_title=>'AWR load config'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLADM'
,p_last_upd_yyyymmddhh24miss=>'20170712125547'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(101272341243258610)
,p_plug_name=>'AWR loading configuration'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select CKEY,',
'       CVALUE,',
'       descr',
'  from AWRCONFIG'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(101273594572258627)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(101274071366258628)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(101274673160258632)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(101275266320258633)
,p_name=>'CKEY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CKEY'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Key'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(101275857091258634)
,p_name=>'CVALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CVALUE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Value'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(101276891133299167)
,p_name=>'DESCR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESCR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(101272886000258615)
,p_internal_uid=>1877078289652149
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_max_row_count=>100000
,p_show_nulls_as=>'-'
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(101273272226258623)
,p_interactive_grid_id=>wwv_flow_api.id(101272886000258615)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(101273315872258624)
,p_report_id=>wwv_flow_api.id(101273272226258623)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(101274505647258629)
,p_view_id=>wwv_flow_api.id(101273315872258624)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(101274071366258628)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(101275055095258632)
,p_view_id=>wwv_flow_api.id(101273315872258624)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(101274673160258632)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(101275655436258634)
,p_view_id=>wwv_flow_api.id(101273315872258624)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(101275266320258633)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(101276300824258634)
,p_view_id=>wwv_flow_api.id(101273315872258624)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(101275857091258634)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(101282904787299303)
,p_view_id=>wwv_flow_api.id(101273315872258624)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(101276891133299167)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(101276422367258634)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(101272341243258610)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>' - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Projects'
,p_page_mode=>'NORMAL'
,p_step_title=>'Projects'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20171215121150'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(104617723849455375)
,p_plug_name=>'Report 1'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232142344147478)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PROJ_ID, ',
'PROJ_NAME,',
'PROJ_DATE,',
'PROJ_DESCRIPTION,',
'PROJ_STATUS,',
'(select round(sum(dbms_lob.getlength(filebody))/1024/1024) from awrdumps d, awrdumps_files f where d.dump_id=f.dump_id and d.proj_id=x.proj_id) sz_mb,',
'(select LISTAGG(DBID||'':''||min_snap_id||'':''||max_snap_id, ''; '') WITHIN GROUP (ORDER BY DBID,min_snap_id) from awrdumps d where  d.proj_id=x.proj_id and is_remote=''NO'' and status in (''AWRLOADED'',''COMPRESSED'')) locally_loaded,',
'(select LISTAGG(DBID||'':''||min_snap_id||'':''||max_snap_id, ''; '') WITHIN GROUP (ORDER BY DBID,min_snap_id) from awrdumps d where  d.proj_id=x.proj_id and is_remote=''YES'' and status in (''AWRLOADED'',''COMPRESSED'')) remotely_loaded,',
'''Reports'' action',
'from AWRTOOLPROJECT x;',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(104618173319455375)
,p_name=>'Report 1'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:11:&APP_SESSION.::::P11_PROJ_ID:#PROJ_ID#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="Edit">'
,p_owner=>'AWRTOOLADM'
,p_internal_uid=>5222365608848909
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104618271685455382)
,p_db_column_name=>'PROJ_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Proj Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104618660277455402)
,p_db_column_name=>'PROJ_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'NAME'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104619060137455403)
,p_db_column_name=>'PROJ_DATE'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'DATE'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104619417905455403)
,p_db_column_name=>'PROJ_DESCRIPTION'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'DESCRIPTION'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104619827457455408)
,p_db_column_name=>'PROJ_STATUS'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'STATUS'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104670128151582673)
,p_db_column_name=>'SZ_MB'
,p_display_order=>15
,p_column_identifier=>'F'
,p_column_label=>'Total files size, MB'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104671203887582683)
,p_db_column_name=>'ACTION'
,p_display_order=>25
,p_column_identifier=>'G'
,p_column_label=>'Action'
,p_column_link=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:RP,15:P15_PROJ_ID,CURRENT_PROJECT:#PROJ_ID#,#PROJ_NAME#'
,p_column_linktext=>'#ACTION#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(101247639263740113)
,p_db_column_name=>'LOCALLY_LOADED'
,p_display_order=>35
,p_column_identifier=>'H'
,p_column_label=>'Locally loaded'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(101247764561740114)
,p_db_column_name=>'REMOTELY_LOADED'
,p_display_order=>45
,p_column_identifier=>'I'
,p_column_label=>'Remotely loaded'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(104621915408458465)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'52262'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'PROJ_ID:PROJ_NAME:PROJ_DATE:PROJ_DESCRIPTION:PROJ_STATUS:SZ_MB:ACTION:LOCALLY_LOADED:REMOTELY_LOADED'
,p_flashback_enabled=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(104620841215455410)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101237024490147486)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(101267511034147656)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(101255921228147535)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(104620232608455408)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(104617723849455375)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:11'
,p_grid_new_grid=>false
);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_api.create_page(
 p_id=>11
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Project'
,p_page_mode=>'NORMAL'
,p_step_title=>'Project'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_protection_level=>'C'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20171215120908'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(101499707831687911)
,p_plug_name=>'Dumps'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232142344147478)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    ''a'' action,',
'    dump_id,',
'    proj_id,',
'    loading_date,',
'    filename,',
'    status,',
'    dbid,',
'    min_snap_id,',
'    max_snap_id,',
'    min_snap_dt,',
'    max_snap_dt,',
'    is_remote,',
'    db_description,',
'    dump_description,',
'    (select round(sum(dbms_lob.getlength(filebody))/1024/1024) from awrdumps_files f where d.dump_id=f.dump_id) sz_mb',
'FROM',
'    awrdumps d',
'where proj_id=:P11_PROJ_ID;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P11_PROJ_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(104640374589025067)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AWRTOOLADM'
,p_internal_uid=>5244566878418601
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104640497010025068)
,p_db_column_name=>'DUMP_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Dump id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104640512140025069)
,p_db_column_name=>'PROJ_ID'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Proj id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104640697557025070)
,p_db_column_name=>'LOADING_DATE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Loading date'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104640717775025071)
,p_db_column_name=>'FILENAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Filename'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104640825304025072)
,p_db_column_name=>'STATUS'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Status'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104641001619025073)
,p_db_column_name=>'DBID'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Dbid'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104641059524025074)
,p_db_column_name=>'MIN_SNAP_ID'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Min snap id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104641143856025075)
,p_db_column_name=>'MAX_SNAP_ID'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Max snap id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104641220772025076)
,p_db_column_name=>'MIN_SNAP_DT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Min snap dt'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104641359998025077)
,p_db_column_name=>'MAX_SNAP_DT'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Max snap dt'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104641411066025078)
,p_db_column_name=>'IS_REMOTE'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Is remote'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104641563582025079)
,p_db_column_name=>'DB_DESCRIPTION'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Db description'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104670211661582674)
,p_db_column_name=>'DUMP_DESCRIPTION'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Dump description'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104670373894582675)
,p_db_column_name=>'SZ_MB'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Size, MB'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(99296044972842599)
,p_db_column_name=>'ACTION'
,p_display_order=>170
,p_column_identifier=>'T'
,p_column_label=>'Action'
,p_column_link=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RP:P12_DUMP_ID,P12_DUMP_FILE_NAME,P12_DBID,P12_SNAP1,P12_SNAP2:#DUMP_ID#,#FILENAME#,#DBID#,#MIN_SNAP_ID#,#MAX_SNAP_ID#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil-alt.png" class="apex-edit-pencil-alt" alt="">'
,p_column_type=>'STRING'
,p_display_condition_type=>'PLSQL_EXPRESSION'
,p_display_condition=>'awrtools_contr.lcc_project_check_action(:P11_PROJ_ID,awrtools_contr.c_project_analyze)'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(104650157293029349)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'52544'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'DUMP_ID:PROJ_ID:LOADING_DATE:FILENAME:STATUS:DBID:MIN_SNAP_ID:MAX_SNAP_ID:MIN_SNAP_DT:MAX_SNAP_DT:IS_REMOTE:DB_DESCRIPTION:DUMP_DESCRIPTION:SZ_MB_LOAD2AWR_UNLOADAWR_REMOVEFILE:ACTION'
,p_flashback_enabled=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(101499831706687912)
,p_plug_name=>'Load dump'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>15
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'awrtools_contr.lcc_project_check_action(:P11_PROJ_ID,awrtools_contr.c_project_analyze)'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(104610552025455304)
,p_plug_name=>'Edit project'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(104621313310455413)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101237024490147486)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(101267511034147656)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(101255921228147535)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(104642093941025084)
,p_plug_name=>'Files'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>16
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P11_PROJ_ID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(101500117362687915)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(101499831706687912)
,p_button_name=>'LoadAWRDump'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Load'
,p_button_position=>'BODY'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(104611066479455319)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(104610552025455304)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition=>'awrtools_contr.lcc_project_check_action(:P11_PROJ_ID,awrtools_contr.c_project_edit)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(104611239176455319)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(104610552025455304)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Return'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:::'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(104671102951582682)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(104610552025455304)
,p_button_name=>'Reports'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Reports'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:RP,15:P15_PROJ_ID:&P11_PROJ_ID.'
,p_button_condition=>'awrtools_contr.lcc_project_check_action(:P11_PROJ_ID,awrtools_contr.c_project_analyze)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(104611002037455319)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(104610552025455304)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'awrtools_contr.lcc_project_check_action(:P11_PROJ_ID,awrtools_contr.c_project_create)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(99295595234842594)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(104610552025455304)
,p_button_name=>'Unlock_project'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Unlock project'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_condition=>'awrtools_contr.lcc_project_check_action(:P11_PROJ_ID,awrtools_contr.c_project_unlock)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(99295487436842593)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(104610552025455304)
,p_button_name=>'Lock_project'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Lock project'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_condition=>'awrtools_contr.lcc_project_check_action(:P11_PROJ_ID,awrtools_contr.c_project_lock)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(104611116667455319)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(104610552025455304)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'awrtools_contr.lcc_project_check_action(:P11_PROJ_ID,awrtools_contr.c_project_drop)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(101500244274687916)
,p_branch_name=>'Go To Page 11 after load dump'
,p_branch_action=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(101500117362687915)
,p_branch_sequence=>11
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(99295153532842590)
,p_branch_name=>'Go To Page 11 after create'
,p_branch_action=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP:P11_PROJ_ID:&P11_PROJ_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(104611002037455319)
,p_branch_sequence=>15
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(99295624649842595)
,p_branch_name=>'Go To Page 11 After unlock'
,p_branch_action=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP:P11_PROJ_ID:&P11_PROJ_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(99295595234842594)
,p_branch_sequence=>30
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(99297450618842613)
,p_branch_name=>'Go To Page 11'
,p_branch_action=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(104611066479455319)
,p_branch_sequence=>40
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(104612708113455331)
,p_branch_name=>'Go To Page 10'
,p_branch_action=>'f?p=&APP_ID.:10:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1000
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(101500020335687914)
,p_name=>'P11_AWRDUMPFILE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(101499831706687912)
,p_prompt=>'AWR Dump'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104613161431455333)
,p_name=>'P11_PROJ_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(104610552025455304)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Proj Id'
,p_source=>'PROJ_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104613544264455350)
,p_name=>'P11_PROJ_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(104610552025455304)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'PROJ_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104613999961455353)
,p_name=>'P11_PROJ_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(104610552025455304)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created'
,p_source=>'PROJ_DATE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_display_when=>'P11_PROJ_ID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104614375256455353)
,p_name=>'P11_PROJ_DESCRIPTION'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(104610552025455304)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Description'
,p_source=>'PROJ_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104614761923455353)
,p_name=>'P11_PROJ_STATUS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(104610552025455304)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Status'
,p_source=>'PROJ_STATUS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P11_PROJ_ID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104642136258025085)
,p_name=>'P11_FILESIZE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(104642093941025084)
,p_prompt=>'Total size, MB'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_display_when=>'P11_PROJ_ID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104670422298582676)
,p_name=>'P11_DUMP_DESCR'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(101499831706687912)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dump description'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>3
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(104642448602025088)
,p_computation_sequence=>10
,p_computation_item=>'P11_FILESIZE'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select nvl(round(sum(dbms_lob.getlength(FILEBODY))/1024/1024),0) from awrdumps_files f, awrdumps d where f.dump_id=d.dump_id and d.proj_id=:P11_PROJ_ID;'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(104615537196455357)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from AWRTOOLPROJECT'
,p_attribute_02=>'AWRTOOLPROJECT'
,p_attribute_03=>'P11_PROJ_ID'
,p_attribute_04=>'PROJ_ID'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50712987348476425)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SET_CURRENT_PROJECT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
':CURRENT_PROJECT:=:P11_PROJ_NAME;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(101499239379687906)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ADD_PROJECT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  AWRTOOLS_API.add_project (  ',
'    P_PROJ_NAME => :P11_PROJ_NAME,',
'    P_PROJ_DESCR => :P11_PROJ_DESCRIPTION,',
'    P_PROJ_ID => :P11_PROJ_ID) ;  ',
'  commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(104611002037455319)
,p_process_success_message=>'Project has been created.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(101499367842687907)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'EDIT_PROJECT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  AWRTOOLS_API.edit_project (',
'    P_PROJ_ID => :P11_PROJ_ID,',
'    P_PROJ_NAME => :P11_PROJ_NAME,',
'    P_PROJ_DATE => :P11_PROJ_DATE,',
'    P_PROJ_DESCR => :P11_PROJ_DESCRIPTION) ;  ',
'  commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(104611066479455319)
,p_process_success_message=>'Project has been saved.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(101499486081687908)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'DEL_PROJECT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  AWRTOOLS_API.del_project (  P_PROJ_ID => :P11_PROJ_ID) ;  ',
'  commit;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(104611116667455319)
,p_process_success_message=>'Project has been deleted'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(101499932800687913)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'LOAD_DUMP'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_select_count number;',
'begin',
'  if :P11_AWRDUMPFILE is not null then',
'					',
'	  select count(ID) into l_select_count',
'  		from apex_application_temp_files',
'	 	 where name = :P11_AWRDUMPFILE;',
'					',
'	  if l_select_count = 1 then',
'  		for i in (select id, filename, blob_content',
'			           from apex_application_temp_files ',
'                where name = :P11_AWRDUMPFILE) ',
'      loop',
'        awrtools_api.create_new_dump(:P11_PROJ_ID, i.filename,:P11_DUMP_DESCR,i.blob_content);',
'			end loop; ',
'  	end if;',
'  else',
'    raise_application_error(-20000,''File name is empty'');',
'  end if; ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(101500117362687915)
,p_process_success_message=>'Dump has been stored in the database.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(104616344897455358)
,p_process_sequence=>1000
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(104611116667455319)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(99295247999842591)
,p_process_sequence=>1010
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Lock_Project'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  awrtools_api.lock_project(:P11_PROJ_ID);',
'  commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(99295487436842593)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(99295394129842592)
,p_process_sequence=>1020
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Unlock_Project'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  awrtools_api.unlock_project(:P11_PROJ_ID);',
'  commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(99295595234842594)
);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_api.create_page(
 p_id=>12
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Process AWR dump'
,p_page_mode=>'MODAL'
,p_step_title=>'Process AWR dump'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20171116125731'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(99296806670842607)
,p_plug_name=>'Available actions:'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(99296326351842602)
,p_plug_name=>'Unload AWR range'
,p_parent_plug_id=>wwv_flow_api.id(99296806670842607)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>12
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'awrtools_contr.lcc_dump_check_action(:P12_DUMP_ID,awrtools_contr.c_dump_unloadawr)'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(99296459600842603)
,p_plug_name=>'Delete dump file'
,p_parent_plug_id=>wwv_flow_api.id(99296806670842607)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>15
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'awrtools_contr.lcc_dump_check_action(:P12_DUMP_ID,awrtools_contr.c_dump_removefile)'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(99296775954842606)
,p_plug_name=>'No action available'
,p_parent_plug_id=>wwv_flow_api.id(99296806670842607)
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101227350618147473)
,p_plug_display_sequence=>17
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>'No action available for COMPRESSED dump.'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'not awrtools_contr.lcc_dump_check_action(:P12_DUMP_ID,awrtools_contr.c_dump_any)'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(104642522724025089)
,p_plug_name=>'Load dump to AWR'
,p_parent_plug_id=>wwv_flow_api.id(99296806670842607)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'awrtools_contr.lcc_dump_check_action(:P12_DUMP_ID,awrtools_contr.c_dump_load2awr)'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(99296901922842608)
,p_plug_name=>'Data in AWR Repository'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(104642715372025091)
,p_name=>'Locally loaded data'
,p_parent_plug_id=>wwv_flow_api.id(99296901922842608)
,p_template=>wwv_flow_api.id(101227350618147473)
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x1.snap_id, x1.dbid, x1.instance_number, x1.startup_time, x1.begin_interval_time, x1.end_interval_time, x1.snap_level,x1.error_count, ',
'       decode(loc.proj_name,null,''<UNKNOWN PROJECT>'',loc.proj_name) project',
'from dba_hist_snapshot x1,',
'     (select dbid, min_snap_id, max_snap_id, proj_name, d.proj_id from awrdumps d, AWRTOOLPROJECT p where status=''AWRLOADED'' and d.proj_id=p.proj_id) loc',
'where x1.dbid<>(select dbid from v$database) ',
'and x1.dbid=loc.dbid(+) and x1.snap_id between loc.min_snap_id(+) and loc.max_snap_id(+)',
'order by x1.dbid,x1.snap_id;'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(101242666033147507)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104642972155025093)
,p_query_column_id=>1
,p_column_alias=>'SNAP_ID'
,p_column_display_sequence=>1
,p_column_heading=>'Snap id'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104643011799025094)
,p_query_column_id=>2
,p_column_alias=>'DBID'
,p_column_display_sequence=>2
,p_column_heading=>'Dbid'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104643163186025095)
,p_query_column_id=>3
,p_column_alias=>'INSTANCE_NUMBER'
,p_column_display_sequence=>3
,p_column_heading=>'Instance number'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104643252779025096)
,p_query_column_id=>4
,p_column_alias=>'STARTUP_TIME'
,p_column_display_sequence=>4
,p_column_heading=>'Startup time'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104643361469025097)
,p_query_column_id=>5
,p_column_alias=>'BEGIN_INTERVAL_TIME'
,p_column_display_sequence=>5
,p_column_heading=>'Begin interval time'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104643438688025098)
,p_query_column_id=>6
,p_column_alias=>'END_INTERVAL_TIME'
,p_column_display_sequence=>6
,p_column_heading=>'End interval time'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104643674619025100)
,p_query_column_id=>7
,p_column_alias=>'SNAP_LEVEL'
,p_column_display_sequence=>7
,p_column_heading=>'Snap level'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104643743238025101)
,p_query_column_id=>8
,p_column_alias=>'ERROR_COUNT'
,p_column_display_sequence=>8
,p_column_heading=>'Error count'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50712572404476421)
,p_query_column_id=>9
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>9
,p_column_heading=>'Project'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(104644193001025105)
,p_name=>'Remotely loaded data'
,p_parent_plug_id=>wwv_flow_api.id(99296901922842608)
,p_template=>wwv_flow_api.id(101227350618147473)
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'N'
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from awrcomp_remote_data',
'order by dbid,snap_id',
';'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(101242666033147507)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104644259486025106)
,p_query_column_id=>1
,p_column_alias=>'SNAP_ID'
,p_column_display_sequence=>1
,p_column_heading=>'Snap id'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104644339827025107)
,p_query_column_id=>2
,p_column_alias=>'DBID'
,p_column_display_sequence=>2
,p_column_heading=>'Dbid'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104644485103025108)
,p_query_column_id=>3
,p_column_alias=>'INSTANCE_NUMBER'
,p_column_display_sequence=>3
,p_column_heading=>'Instance number'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104644596180025109)
,p_query_column_id=>4
,p_column_alias=>'STARTUP_TIME'
,p_column_display_sequence=>4
,p_column_heading=>'Startup time'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104644684218025110)
,p_query_column_id=>5
,p_column_alias=>'BEGIN_INTERVAL_TIME'
,p_column_display_sequence=>5
,p_column_heading=>'Begin interval time'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104644731759025111)
,p_query_column_id=>6
,p_column_alias=>'END_INTERVAL_TIME'
,p_column_display_sequence=>6
,p_column_heading=>'End interval time'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104644990320025113)
,p_query_column_id=>7
,p_column_alias=>'SNAP_LEVEL'
,p_column_display_sequence=>7
,p_column_heading=>'Snap level'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(104645029193025114)
,p_query_column_id=>8
,p_column_alias=>'ERROR_COUNT'
,p_column_display_sequence=>8
,p_column_heading=>'Error count'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50712657195476422)
,p_query_column_id=>9
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>9
,p_column_heading=>'Project'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50712793171476423)
,p_query_column_id=>10
,p_column_alias=>'PROJ_ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(101247864459740115)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(99296326351842602)
,p_button_name=>'UnloadAWR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Unload AWR data'
,p_button_position=>'BELOW_BOX'
,p_button_condition=>'awrtools_contr.lcc_dump_check_action(:P12_DUMP_ID,awrtools_contr.c_dump_unloadawr)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(99296293176842601)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(99296459600842603)
,p_button_name=>'Deletedump'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Delete dump'
,p_button_position=>'BELOW_BOX'
,p_button_condition=>'awrtools_contr.lcc_dump_check_action(:P12_DUMP_ID,awrtools_contr.c_dump_removefile)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(104669820799582670)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(104642522724025089)
,p_button_name=>'LoadAWR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Load AWR data'
,p_button_position=>'BELOW_BOX'
,p_button_condition=>'awrtools_contr.lcc_dump_check_action(:P12_DUMP_ID,awrtools_contr.c_dump_load2awr)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(104670106202582672)
,p_branch_action=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(104669820799582670)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(99296501306842604)
,p_branch_name=>'Go To Page 11'
,p_branch_action=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(101247864459740115)
,p_branch_sequence=>12
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(99296660294842605)
,p_branch_name=>'Go To Page 11'
,p_branch_action=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(99296293176842601)
,p_branch_sequence=>15
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(101247985720740116)
,p_branch_name=>'Return to projects'
,p_branch_action=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(101247864459740115)
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(99297068710842609)
,p_name=>'P12_DUMP_FILE_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(99296459600842603)
,p_prompt=>'Dump file name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(99297131113842610)
,p_name=>'P12_DBID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(99296326351842602)
,p_prompt=>'DBID'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(99297276760842611)
,p_name=>'P12_SNAP1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(99296326351842602)
,p_prompt=>'Begin snap'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(99297323945842612)
,p_name=>'P12_SNAP2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(99296326351842602)
,p_prompt=>'End snap'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104642651565025090)
,p_name=>'P12_DUMP_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(104642522724025089)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104669641011582668)
,p_name=>'P12_DEST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(104642522724025089)
,p_prompt=>'Destination'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Locally;LOC,Remotely;REM'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Select destination...'
,p_cHeight=>1
,p_grid_column=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(104669785529582669)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load AWR data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  awrtools_api.load_dump_into_repo(:P12_DUMP_ID,:P12_DEST);',
'  commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(104669820799582670)
,p_process_success_message=>'AWR data has been loaded.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(107763138188739555)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Unload AWR data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  awrtools_api.unload_dump(:P12_DUMP_ID);',
'  commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(101247864459740115)
,p_process_success_message=>'AWR data has been unloaded.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(99296143114842600)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete dump'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  awrtools_api.del_file(:P12_DUMP_ID);',
'  commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(99296293176842601)
);
end;
/
prompt --application/pages/page_00015
begin
wwv_flow_api.create_page(
 p_id=>15
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Reports'
,p_page_mode=>'NORMAL'
,p_step_title=>'Reports'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20171227140146'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(50253096526534048)
,p_plug_name=>'Reports'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232142344147478)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'          report_id,',
'          created,',
'          tp.dic_display_value report_type,',
'          report_params_displ params,',
'          sys.dbms_lob.getlength(report_content) download,',
'          ''Delete'' action',
'from AWRCOMP_REPORTS r, AWRCOMP_D_REPORT_TYPES tp',
'where tp.DIC_ID=report_type and proj_id=:P15_PROJ_ID',
'order by created desc;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(50253114535534049)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AWRTOOLS21ADM'
,p_internal_uid=>50253114535534049
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50253280765534050)
,p_db_column_name=>'REPORT_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Report id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50710569661476401)
,p_db_column_name=>'CREATED'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50710638737476402)
,p_db_column_name=>'REPORT_TYPE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Report type'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50710706667476403)
,p_db_column_name=>'PARAMS'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Params'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50710814405476404)
,p_db_column_name=>'DOWNLOAD'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Download'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'DOWNLOAD:AWRCOMP_REPORTS:REPORT_CONTENT:REPORT_ID::FILE_MIMETYPE:FILE_NAME:::attachment::'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50710973947476405)
,p_db_column_name=>'ACTION'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Action'
,p_column_link=>'f?p=&APP_ID.:16:&SESSION.::&DEBUG.:RP:P16_REPORT_ID:#REPORT_ID#'
,p_column_linktext=>'#ACTION#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(50718699960483320)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'507187'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'REPORT_ID:CREATED:REPORT_TYPE:PARAMS:DOWNLOAD:ACTION'
,p_flashback_enabled=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(104718451934901599)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101237024490147486)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(101267511034147656)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(101255921228147535)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(106578473812102233)
,p_plug_name=>'Chose parameters'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(104730799083968645)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(106578473812102233)
,p_button_name=>'Create_report'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Create report'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_condition=>':P15_PROJ_ID is not null and :P15_REPORT_TYPE is not null'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49230683672898134)
,p_name=>'P15_DB1_START_SNAP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_item_default=>':P15_DB1_SS'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'DB1 start snap'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''DB1_START_SNAP'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49230736549898135)
,p_name=>'P15_DB1_END_SNAP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_item_default=>':P15_DB1_ES'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'DB1 end snap'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''DB1_END_SNAP'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49231040548898138)
,p_name=>'P15_DB2_START_SNAP'
,p_item_sequence=>77
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_item_default=>':P15_DB2_SS'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'DB2 start snap'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''DB2_START_SNAP'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49231148289898139)
,p_name=>'P15_DB2_END_SNAP'
,p_item_sequence=>79
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_item_default=>':P15_DB2_ES'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'DB2 end snap'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''DB2_END_SNAP'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49231327611898141)
,p_name=>'P15_DB1_SS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49231466755898142)
,p_name=>'P15_DB1_ES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49231555363898143)
,p_name=>'P15_DB2_SS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49231672007898144)
,p_name=>'P15_DB2_ES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49232157296898149)
,p_name=>'P15_SQL_ID'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_prompt=>'SQL ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select unique s.sql_id||'': ''||cast(substr(sql_text,1,500) as varchar2(500))||''...'' text, s.sql_id from',
'dba_hist_sqlstat s, dba_hist_sqltext t, AWRDUMPS d',
'where s.sql_id=t.sql_id and s.dbid=t.dbid',
'and d.dump_id=decode(:P15_DB1,''null'',null,:P15_DB1) and s.snap_id>=d.min_snap_id',
'and s.snap_id<=d.max_snap_id and s.dbid=d.dbid'))
,p_cSize=>124
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''SQL_ID'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NOT_ENTERABLE'
,p_attribute_02=>'FIRST_ROWSET'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50252017923534038)
,p_name=>'P15_REMARK'
,p_item_sequence=>25
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_item_default=>'Choose DB1 dump only for filtering belonged SQLs. AWR SQL report will ignore it.'
,p_prompt=>'Remark'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''REMARK'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50252133203534039)
,p_name=>'P15_LEVEL'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_prompt=>'Level'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''LEVEL'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'For ASH analytics report:<br>',
'[sqlid]{histogram} or [wait_class]{histogram} -- describes a list of  components to build.'))
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50712894912476424)
,p_name=>'P15_SQLMULTIPLAN'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_prompt=>'SQLs with multiple plans'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.sql_id||'': ''||cast(substr(sql_text,1,500) as varchar2(500)) || ''...'' text, s.sql_id',
'              from dba_hist_sqlstat s, AWRDUMPS d, dba_hist_sqltext t',
'			 where s.plan_hash_value<>0 ',
'			   and s.parsing_schema_name <> ''SYS''',
'			   and nvl(s.action,''@#$'') not like ''ORA$%''',
'               and decode(s.module, ''performance_info'', 0, 1) = 1',
'               and decode(s.module, ''MMON_SLAVE'', 0, 1) = 1',
'               and s.CPU_TIME_DELTA+s.ELAPSED_TIME_DELTA+s.BUFFER_GETS_DELTA+s.EXECUTIONS_DELTA>0',
'               and d.proj_id=:P15_PROJ_ID and d.dbid=s.dbid and s.snap_id between d.min_snap_id and d.max_snap_id',
'               and t.sql_id=s.sql_id',
'             group by s.dbid, s.sql_id, cast(substr(sql_text,1,500) as varchar2(500))',
'            having count(unique plan_hash_value)>1;'))
,p_cSize=>30
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''SQLMULTIPLAN'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NOT_ENTERABLE'
,p_attribute_02=>'FIRST_ROWSET'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104670875776582680)
,p_name=>'P15_PROJ_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104731108545968654)
,p_name=>'P15_DB1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_prompt=>'Chose AWR dump for DB1'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    --''Loaded at: ''||to_char(loading_date,''yyyy-mon-dd hh24:mi:ss'')||',
'    --'' from ''||filename||',
'    ''DBID: ''||DBID||',
'    '', ''||MIN_SNAP_ID||''-''||MAX_SNAP_ID||',
'    '', ''||to_char(MIN_SNAP_DT,''yyyy-mon-dd hh24:mi:ss'')||''-''||to_char(MAX_SNAP_DT,''yyyy-mon-dd hh24:mi:ss'')||',
'    '', ''||DB_DESCRIPTION||''; REMOTE:''||is_remote',
'    name,',
'    dump_id',
'FROM',
'    awrdumps',
'where status=''AWRLOADED'' and proj_id=:P15_PROJ_ID and IS_REMOTE=''NO''',
'order by MAX_SNAP_DT;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Select dump...'
,p_lov_null_value=>'null'
,p_cHeight=>1
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''DB1'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104731909875968665)
,p_name=>'P15_DB2'
,p_item_sequence=>75
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_prompt=>'Chose AWR dump for DB2'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    --''Loaded at: ''||to_char(loading_date,''yyyy-mon-dd hh24:mi:ss'')||',
'    --'' from ''||filename||',
'    ''DBID: ''||DBID||',
'    '', ''||MIN_SNAP_ID||''-''||MAX_SNAP_ID||',
'    '', ''||to_char(MIN_SNAP_DT,''yyyy-mon-dd hh24:mi:ss'')||''-''||to_char(MAX_SNAP_DT,''yyyy-mon-dd hh24:mi:ss'')||',
'    '', ''||DB_DESCRIPTION||''; REMOTE:''||is_remote',
'    name,',
'    dump_id',
'FROM',
'    awrdumps',
'where status=''AWRLOADED'' and proj_id=:P15_PROJ_ID',
'and IS_REMOTE=decode(:P15_REPORT_TYPE,''AWRCOMP'',IS_REMOTE,''NO'')',
'order by MAX_SNAP_DT;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Select dump...'
,p_cHeight=>1
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''DB2'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104732774470968666)
,p_name=>'P15_SORT'
,p_item_sequence=>105
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_def number;',
'begin',
'select min(DIC_ID) into l_def FROM AWRCOMP_D_SORTORDRS;',
'return l_def;',
'end;'))
,p_item_default_type=>'PLSQL_FUNCTION_BODY'
,p_prompt=>'Sort order'
,p_source=>'select min(DIC_ID) FROM AWRCOMP_D_SORTORDRS;'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT DIC_DISPLAY_VALUE name, DIC_ID FROM AWRCOMP_D_SORTORDRS order by 2'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''SORT'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104733163798968668)
,p_name=>'P15_LIMIT'
,p_item_sequence=>115
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_item_default=>'1e6'
,p_prompt=>'Limit'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''LIMIT'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(104733554858968668)
,p_name=>'P15_FILTER'
,p_item_sequence=>125
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_item_default=>'1=1'
,p_prompt=>'Filter'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>100
,p_cMaxlength=>1000
,p_cHeight=>5
,p_display_when=>'awrtools_reports.get_report_params_visibility(:P15_REPORT_TYPE,''FILTER'')'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'For AWR query plan compare report:<br>',
'Any column from DBA_HIST_SQLSTAT can be used in this filter, for example:<br>',
'not(nvl(action,''~'')=''job name'' or nvl(module,''~'')=''module'' or (nvl(ACTION,''~'') like ''CA%'' and nvl(MODULE,''~'')=''DBMS_SCHEDULER''))',
'<br>or<br>',
'sql_id=''sql ID''<br><br>',
'For ASH analytics report:<br>',
'TBD'))
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(107813162914933368)
,p_name=>'P15_REPORT_TYPE'
,p_item_sequence=>15
,p_item_plug_id=>wwv_flow_api.id(106578473812102233)
,p_prompt=>'Report type'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT DIC_DISPLAY_VALUE name, dic_value FROM awrcomp_d_report_types order by dic_ordr'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Select report type...'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(49230929511898137)
,p_validation_name=>'DB1_START_SNAP'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_cnt number;',
'begin',
'  if :P15_REPORT_TYPE in (''AWRCOMP'') then',
'    if :P15_DB1_SS>:P15_DB1_START_SNAP or :P15_DB1_ES<:P15_DB1_START_SNAP ',
'    then ',
'      return ''Start snap for DB1 is out of range(''||:P15_DB1_SS||''-''||:P15_DB1_ES||'').''; ',
'    end if;',
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'N'
,p_when_button_pressed=>wwv_flow_api.id(104730799083968645)
,p_associated_item=>wwv_flow_api.id(49230683672898134)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(49231215155898140)
,p_validation_name=>'DB1_END_SNAP'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_cnt number;',
'begin',
'  if :P15_REPORT_TYPE in (''AWRCOMP'') then',
'    if :P15_DB1_SS>:P15_DB1_END_SNAP or :P15_DB1_ES<:P15_DB1_END_SNAP ',
'    then ',
'      return ''End snap for DB1 is out of range(''||:P15_DB1_SS||''-''||:P15_DB1_ES||'').''; ',
'    end if;',
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'N'
,p_when_button_pressed=>wwv_flow_api.id(104730799083968645)
,p_associated_item=>wwv_flow_api.id(49230736549898135)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(49231958825898147)
,p_validation_name=>'DB2_START_SNAP'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_cnt number;',
'begin',
'  if :P15_REPORT_TYPE=''AWRCOMP'' then',
'    if :P15_DB2_SS>:P15_DB2_START_SNAP or :P15_DB2_ES<:P15_DB2_START_SNAP ',
'    then ',
'      return ''Start snap for DB2 is out of range(''||:P15_DB2_SS||''-''||:P15_DB2_ES||'').''; ',
'    end if;',
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'N'
,p_when_button_pressed=>wwv_flow_api.id(104730799083968645)
,p_associated_item=>wwv_flow_api.id(49231040548898138)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(49232048788898148)
,p_validation_name=>'DB2_END_SNAP'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_cnt number;',
'begin',
'  if :P15_REPORT_TYPE=''AWRCOMP'' then',
'    if :P15_DB2_SS>:P15_DB2_END_SNAP or :P15_DB2_ES<:P15_DB2_END_SNAP ',
'    then ',
'      return ''End snap for DB2 is out of range(''||:P15_DB2_SS||''-''||:P15_DB2_ES||'').''; ',
'    end if;',
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'N'
,p_when_button_pressed=>wwv_flow_api.id(104730799083968645)
,p_associated_item=>wwv_flow_api.id(49231148289898139)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(49232231942898150)
,p_validation_name=>'CHECK_COMPREPORT'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :P15_REPORT_TYPE in (''AWRCOMP'') then',
'    if :P15_DB1 is null or',
'       :P15_DB1_START_SNAP is null or',
'       :P15_DB1_END_SNAP  is null or',
'       :P15_DB2_START_SNAP  is null or',
'       :P15_DB2_END_SNAP   is null or',
'       :P15_SORT is null or',
'       :P15_LIMIT is null or',
'       :P15_FILTER is null',
'     then',
'       return ''Specify all parameters for the report'';',
'     end if;',
'  end if;',
'  if :P15_REPORT_TYPE in (''AWRSQLREPORT'') then',
'    if :P15_DB1 is null or',
'       :P15_SQL_ID is null',
'     then',
'       return ''Specify all parameters for the report'';',
'     end if;',
'  end if;',
'  if :P15_REPORT_TYPE in (''SQLMULTIPLAN'') then',
'    if :P15_SQLMULTIPLAN is null',
'     then',
'       return ''Specify all parameters for the report'';',
'     end if;',
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'N'
,p_when_button_pressed=>wwv_flow_api.id(104730799083968645)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(49231802177898146)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GETSNAPSHOTRANGES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  begin',
'    select min_snap_id, max_snap_id into :P15_DB1_SS,:P15_DB1_ES ',
'      from awrdumps where dump_id=decode(:P15_DB1,''null'',null,:P15_DB1);',
'  exception',
'    when no_data_found then',
'      :P15_DB1_SS:=null; :P15_DB1_ES:=null;',
'  end;',
'  begin',
'    select min_snap_id, max_snap_id into :P15_DB2_SS,:P15_DB2_ES ',
'      from awrdumps where dump_id=decode(:P15_DB2,''null'',null,:P15_DB2);',
'  exception',
'    when no_data_found then',
'      :P15_DB2_SS:=null; :P15_DB2_ES:=null;',
'  end;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(104735299798980006)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create report'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_id number;',
'begin',
'  l_id:=awrtools_reports.create_report(:P15_REPORT_TYPE, :P15_PROJ_ID);',
'  awrtools_reports.save_param(l_id,''DB1'',:P15_DB1);',
'  awrtools_reports.save_param(l_id,''DB1_START_SNAP'',:P15_DB1_START_SNAP);',
'  awrtools_reports.save_param(l_id,''DB1_END_SNAP'',:P15_DB1_END_SNAP);',
'  awrtools_reports.save_param(l_id,''DB2'',:P15_DB2);',
'  awrtools_reports.save_param(l_id,''DB2_START_SNAP'',:P15_DB2_START_SNAP);',
'  awrtools_reports.save_param(l_id,''DB2_END_SNAP'',:P15_DB2_END_SNAP);',
'  awrtools_reports.save_param(l_id,''SORT'',:P15_SORT);',
'  awrtools_reports.save_param(l_id,''LIMIT'',:P15_LIMIT);',
'  awrtools_reports.save_param(l_id,''FILTER'',:P15_FILTER);',
'  awrtools_reports.save_param(l_id,''SQL_ID'',:P15_SQL_ID);',
'  awrtools_reports.save_param(l_id,''LEVEL'',:P15_LEVEL);',
'  awrtools_reports.save_param(l_id,''SQLMULTIPLAN'',:P15_SQLMULTIPLAN);',
'  commit;  ',
'  awrtools_reports.create_report(l_id);  ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(104730799083968645)
);
end;
/
prompt --application/pages/page_00016
begin
wwv_flow_api.create_page(
 p_id=>16
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Delete report'
,p_page_mode=>'MODAL'
,p_step_title=>'Delete report'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLADM'
,p_last_upd_yyyymmddhh24miss=>'20170522165647'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(107816118580933398)
,p_plug_name=>'Confirmation'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(107816314562933400)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(107816118580933398)
,p_button_name=>'Delete'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Delete'
,p_button_position=>'BELOW_BOX'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(107816408126933401)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(107816118580933398)
,p_button_name=>'Cancel'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Cancel'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:RP::'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(107816543202933402)
,p_branch_name=>'GotoReports'
,p_branch_action=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(107816314562933400)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(107816105904933397)
,p_name=>'P16_REPORT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(107816118580933398)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(107816300373933399)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'DelReport'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'awrtools_api.del_report(:P16_REPORT_ID);',
'commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(107816314562933400)
);
end;
/
prompt --application/pages/page_00017
begin
wwv_flow_api.create_page(
 p_id=>17
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Query Search'
,p_page_mode=>'NORMAL'
,p_step_title=>'Query Search'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20180208121511'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(51598813555693916)
,p_name=>'Search in local AWR repository'
,p_template=>wwv_flow_api.id(101232642288147479)
,p_display_sequence=>5
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  return AWRTOOLS_LOC_UTILS.get_search_query_local',
'    (P_STARTSEARCH => :P17_STARTSEARCH,',
'     P_SEARCH_TYPE => :P17_SEARCH_TYPE,',
'     P_SEARCH_CONDITION => :P17_SEARCHCONDITION);',
'end;',
''))
,p_source_type=>'NATIVE_FNC_REPORT'
,p_display_when_condition=>':p17_sourcedb=''$LOCAL$'''
,p_display_condition_type=>'PLSQL_EXPRESSION'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(101242666033147507)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'No data found'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(51600970034693937)
,p_query_column_id=>1
,p_column_alias=>'DBID'
,p_column_display_sequence=>1
,p_column_heading=>'DBID'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(51601086896693938)
,p_query_column_id=>2
,p_column_alias=>'SQL_ID'
,p_column_display_sequence=>2
,p_column_heading=>'Sql id'
,p_column_link=>'f?p=&APP_ID.:18:&SESSION.::&DEBUG.:RP,18:P18_SQL_ID,P18_SOURCEDB,P18_SOURCETAB,P18_SOURCE_PAGE,P18_ACTION,P17_DUMP_ID:#SQL_ID#,&P17_SOURCEDB.,&P17_SOURCETAB.,17,SHOW_SQL_TEXT_BY_ID,#DUMP_ID#'
,p_column_linktext=>'#SQL_ID#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(51601152015693939)
,p_query_column_id=>3
,p_column_alias=>'SQL_TEXT'
,p_column_display_sequence=>3
,p_column_heading=>'Sql text'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(51601211369693940)
,p_query_column_id=>4
,p_column_alias=>'PROJ_ID'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(51601384916693941)
,p_query_column_id=>5
,p_column_alias=>'PROJ_NAME'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(51601439563693942)
,p_query_column_id=>6
,p_column_alias=>'DUMP_ID'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(56151840350396446)
,p_name=>'Search in remote DB'
,p_template=>wwv_flow_api.id(101232642288147479)
,p_display_sequence=>15
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  return AWRTOOLS_LOC_UTILS.get_search_query_remote',
'    (P_STARTSEARCH => :P17_STARTSEARCH,',
'     P_SEARCH_TYPE => :P17_SEARCH_TYPE,',
'     P_SEARCH_CONDITION => :P17_SEARCHCONDITION,',
'     P_SOURCEDB => :P17_SOURCEDB,',
'     P_SOURCETAB => :P17_SOURCETAB);',
'end;'))
,p_source_type=>'NATIVE_FNC_REPORT'
,p_display_when_condition=>':P17_SOURCEDB<>''$LOCAL$'''
,p_display_condition_type=>'PLSQL_EXPRESSION'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(101242666033147507)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(56151904272396447)
,p_query_column_id=>1
,p_column_alias=>'SQL_ID'
,p_column_display_sequence=>1
,p_column_heading=>'Sql id'
,p_column_link=>'f?p=&APP_ID.:18:&SESSION.::&DEBUG.:RP:P18_SOURCEDB,P18_SOURCETAB,P18_SQL_ID,P18_SOURCE_PAGE,P18_ACTION:&P17_SOURCEDB.,&P17_SOURCETAB.,#SQL_ID#,17,SHOW_SQL_TEXT_BY_ID'
,p_column_linktext=>'#SQL_ID#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(56152093836396448)
,p_query_column_id=>2
,p_column_alias=>'SQL_TEXT'
,p_column_display_sequence=>2
,p_column_heading=>'Sql text'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(56152111183396449)
,p_plug_name=>'Parameters'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>3
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51599910868693927)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(56152111183396449)
,p_button_name=>'AddColumn'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255311357147531)
,p_button_image_alt=>'Add column'
,p_button_position=>'BODY'
,p_button_condition=>':P17_SEARCH_TYPE in (''SQLSTAT'', ''ASH'')'
,p_button_condition_type=>'SQL_EXPRESSION'
,p_icon_css_classes=>'fa-arrow-circle-o-down'
,p_grid_new_row=>'Y'
,p_grid_column=>2
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51598609911693914)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(56152111183396449)
,p_button_name=>'Search'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'Search'
,p_button_position=>'BODY'
,p_grid_new_row=>'Y'
,p_grid_column=>2
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51598964255693917)
,p_name=>'P17_SEARCH_TYPE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(56152111183396449)
,p_prompt=>'Search type'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:By query text;SQLTEXT,By DBA_HIST_SQLSTAT;SQLSTAT,By ASH;ASH'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Choose...'
,p_cHeight=>1
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51599229733693920)
,p_name=>'P17_COLUMNS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(56152111183396449)
,p_prompt=>'Available columns'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select column_name||'' : ''||data_type nm, column_name ',
'from all_tab_columns ',
'where table_name = (case when :P17_SEARCH_TYPE=''SQLSTAT'' then ''DBA_HIST_SQLSTAT'' ',
'                         when :P17_SEARCH_TYPE=''ASH'' then ''DBA_HIST_ACTIVE_SESS_HISTORY'' ',
'                         else ''~'' end)',
'  and :P17_SOURCETAB = ''AWR''',
'union all',
'select column_name, column_name',
'from DICT_COLUMNS',
'where table_name = (case when :P17_SEARCH_TYPE=''SQLSTAT'' then ''GV$SQL'' ',
'                         when :P17_SEARCH_TYPE=''ASH'' then ''GV$ACTIVE_SESSION_HISTORY'' ',
'                         else ''~'' end)',
'  and :P17_SOURCETAB = ''V$VIEW''',
'order by 1;'))
,p_cHeight=>1
,p_colspan=>4
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_display_when=>':P17_SEARCH_TYPE in (''SQLSTAT'', ''ASH'')'
,p_display_when_type=>'SQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51600888285693936)
,p_name=>'P17_SEARCHCONDITION'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(56152111183396449)
,p_prompt=>'Search condition'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>100
,p_cHeight=>5
,p_colspan=>8
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51601702841693945)
,p_name=>'P17_STARTSEARCH'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(56152111183396449)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51602015408693948)
,p_name=>'P17_ADDCOLUMN'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(56152111183396449)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51799519829989301)
,p_name=>'P17_TIP'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(56152111183396449)
,p_prompt=>'Tip:'
,p_source=>'Use "SQL_TEXT like ''%<NAME>%''".'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_colspan=>4
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_display_when=>':P17_SEARCH_TYPE in (''SQLTEXT'')'
,p_display_when_type=>'SQL_EXPRESSION'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56150831284396436)
,p_name=>'P17_SOURCEDB'
,p_item_sequence=>15
,p_item_plug_id=>wwv_flow_api.id(56152111183396449)
,p_item_default=>'$LOCAL$'
,p_prompt=>'Source'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SOURCEDB'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''Local warehouse'' d, ''$LOCAL$'' r from dual',
'union all',
'select username||''@''||host name, db_link id from user_db_links where db_link not like (select upper(cvalue) from awrconfig where ckey=''DBLINK'')||''%'''))
,p_cHeight=>1
,p_colspan=>4
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56150932325396437)
,p_name=>'P17_SOURCETAB'
,p_item_sequence=>17
,p_item_plug_id=>wwv_flow_api.id(56152111183396449)
,p_item_default=>'AWR'
,p_prompt=>'Type'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'SOURCETAB'
,p_lov=>'.'||wwv_flow_api.id(57108666722420822)||'.'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>':P17_SOURCEDB<>''$LOCAL$'''
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'SUBMIT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56152273260396450)
,p_name=>'P17_DUMP_ID'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(56152111183396449)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(51602295511693950)
,p_computation_sequence=>10
,p_computation_item=>'P17_SEARCHCONDITION'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :P17_STARTSEARCH=''NO'' and :P17_ADDCOLUMN=''NO'' then',
'    if :P17_SEARCHCONDITION is not null and trim(:P17_SEARCHCONDITION) <> ''1=2'' then',
'      return '' 1=2 /*''||replace(replace(:P17_SEARCHCONDITION,''/*'',''\*''),''*/'',''*\'')||''*/'';',
'    else',
'      return :P17_SEARCHCONDITION;',
'    end if;',
'  else ',
'    return :P17_SEARCHCONDITION;',
'  end if;',
'end;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(51601988108693947)
,p_computation_sequence=>10
,p_computation_item=>'P17_STARTSEARCH'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'NO'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(51602151262693949)
,p_computation_sequence=>20
,p_computation_item=>'P17_ADDCOLUMN'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'NO'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(51600070857693928)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'AddColumn'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  :P17_SEARCHCONDITION:=:P17_SEARCHCONDITION||'' ''||:P17_COLUMNS;',
'  :P17_ADDCOLUMN:=''YES'';',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(51599910868693927)
,p_process_when=>':P17_SEARCH_TYPE in (''SQLSTAT'', ''ASH'')'
,p_process_when_type=>'SQL_EXPRESSION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(51601828910693946)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SetStartSearch'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  :P17_STARTSEARCH:=''YES'';',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(51598609911693914)
);
end;
/
prompt --application/pages/page_00018
begin
wwv_flow_api.create_page(
 p_id=>18
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'SQL Query Text'
,p_page_mode=>'MODAL'
,p_step_title=>'SQL Query Text'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
''))
,p_page_template_options=>'ui-dialog--stretch'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20180208130317'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(51799844575989304)
,p_plug_name=>'SQL Full Text'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_ID varchar2(10):=''SQL_ID:'';',
'  l_sql_text clob;',
'  l_sourcedb varchar2(100);',
'  l_sourcetab varchar2(100);',
'  procedure getsqltext_localawrrepo(p_sql_id varchar2, p_dbid number, p_text out clob) is',
'  begin',
'    select sql_text into p_text from dba_hist_sqltext where sql_id=p_sql_id and DBID=p_dbid;',
'    --raise_application_error(-20000,''getsqltext_localawrrepo'');',
'  exception when no_data_found then p_text:=''No sql text available in AWR repository.'';  ',
'  end;',
'  procedure getsqltext_remote(p_sql_id varchar2, p_sourcedb varchar2, p_text out clob) is',
'    l_sql varchar2(32765);',
'    l_dbid number;',
'  begin ',
'    execute immediate ''select dbid from v$database@''||p_sourcedb into l_dbid;',
'    l_sql := ''select txt from ',
'                (select cast(substr(sql_text,1,4000) as varchar2(4000)) txt from dba_hist_sqltext@''||p_sourcedb||'' a where sql_id=:p_sql_id and dbid=:p_dbid',
'                 union all',
'                 select cast(substr(SQL_FULLTEXT,1,4000) as varchar2(4000)) from gv$sql@''||p_sourcedb||'' a where sql_id=:p_sql_id',
'                ) where rownum<2'';',
'    execute immediate l_sql into p_text using p_sql_id, l_dbid, p_sql_id;  ',
'    --raise_application_error(-20000,''getsqltext_remote'');',
'  exception ',
'    when no_data_found then p_text:=''No sql text available in remote database.'';  ',
'    when others then p_text:=''Error: ''||sqlerrm||chr(10)||l_sql;  ',
'  end;  ',
'  procedure getsqltext_localawr_by_hash(p_plan_hash number, p_text out clob) is',
'    l_cnt number := 0;',
'    l_dbid number;',
'    ll_sql_text clob;',
'  begin',
'    select dbid into l_dbid from AWRDUMPS where dump_id=:P18_DUMP_ID;',
'    for i in (select * from (select unique sql_id from remote_ash where SQL_PLAN_HASH_VALUE=p_plan_hash and sess_id=:P63_SESS_ID) where rownum<11) loop',
'      getsqltext_localawrrepo(i.sql_id,l_dbid,ll_sql_text);',
'      l_cnt:=l_cnt+1;',
'      p_text:=p_text||''#''||l_cnt||''; SQL_ID: ''||i.sql_id||chr(10);',
'      p_text:=p_text||ll_sql_text||chr(10);',
'      p_text:=p_text||''=======================''||chr(10);',
'    end loop;',
'    if l_cnt=0 then p_text:=''No sql text available in AWR repository for given PLAN_HASH=''||p_plan_hash||''.''; end if; ',
'  end;  ',
'  procedure getsqltext_remote_by_hash(p_plan_hash number, p_sourcedb varchar2, p_text out clob) is',
'    l_cnt number := 0;',
'    ll_sql_text clob;',
'  begin',
'    for i in (select * from (select unique sql_id from remote_ash where SQL_PLAN_HASH_VALUE=p_plan_hash and sess_id=:P63_SESS_ID) where rownum<11) loop',
'      getsqltext_remote(i.sql_id,p_sourcedb,ll_sql_text);',
'      l_cnt:=l_cnt+1;',
'      p_text:=p_text||''#''||l_cnt||''; SQL_ID: ''||i.sql_id||chr(10);',
'      p_text:=p_text||ll_sql_text||chr(10);',
'      p_text:=p_text||''=======================''||chr(10);',
'    end loop;',
'    if l_cnt=0 then p_text:=''No sql text available in remote DB for given PLAN_HASH=''||p_plan_hash||''.''; end if; ',
'  end;   ',
'begin',
'  l_sourcedb:=case when :P18_SOURCE_PAGE=17 then :P17_SOURCEDB when :P18_SOURCE_PAGE=63 then :P63_SOURCEDB end;',
'  l_sourcetab:=case when :P18_SOURCE_PAGE=17 then :P17_SOURCETAB when :P18_SOURCE_PAGE=63 then :P63_SOURCETAB end;',
'--raise_application_error(-20000,:P18_SOURCE_PAGE||'':''||l_sourcedb||'':''||l_sourcetab);  ',
'  if :P18_ACTION = ''SHOW_SQL_TEXT_BY_ID'' then',
'--raise_application_error(-20000,''111'');',
'    if l_sourcedb=''$LOCAL$'' and l_sourcetab = ''AWR'' then',
'      getsqltext_localawrrepo(:P18_SQL_ID,:P18_DBID,l_sql_text);',
'    elsif l_sourcedb<>''$LOCAL$'' then',
'      getsqltext_remote(:P18_SQL_ID,l_sourcedb,l_sql_text);',
'    end if;',
'  elsif :P18_ACTION = ''SHOW_SQL_TEXT_BY_PLANHASH'' then',
'--raise_application_error(-20000,''222'');  ',
'    l_ID:=''PLAN_HASH:'';',
'    if l_sourcedb=''$LOCAL$'' and l_sourcetab = ''AWR'' then',
'      getsqltext_localawr_by_hash(:P18_SQL_ID,l_sql_text);',
'    elsif l_sourcedb<>''$LOCAL$'' then',
'      getsqltext_remote_by_hash(:P18_SQL_ID,l_sourcedb,l_sql_text);',
'    end if;',
'  else',
'--raise_application_error(-20000,''333'');  ',
'     getsqltext_localawrrepo(:P18_SQL_ID,:P18_DBID,l_sql_text);',
'  end if;',
'  awrtools_loc_utils.print_text_as_table(p_text => l_sql_text, p_t_header=> l_ID||'' ''||:P18_SQL_ID, p_width => 1000);',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  return :P18_ACTION in (''SHOW_SQL_TEXT_BY_ID'',''SHOW_SQL_TEXT_BY_PLANHASH'');',
'end;'))
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(55599511452835821)
,p_plug_name=>'Reports'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>5
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(56149471473396422)
,p_plug_name=>'Debug'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>3
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'htp.p(''P18_SOURCE_PAGE:''||:P18_SOURCE_PAGE||''<br>'');',
'htp.p(''P18_ACTION:''||:P18_ACTION||''<br>'');',
'htp.p(''P18_SOURCEDB:''||:P18_SOURCEDB||''<br>'');',
'htp.p(''P18_SOURCETAB:''||:P18_SOURCETAB||''<br>'');',
'htp.p(''P18_SQL_ID:''||:P18_SQL_ID||''<br>'');',
'htp.p(''P18_DBID:''||:P18_DBID||''<br>'');',
'htp.p(''P18_DUMP_ID:''||:P18_DUMP_ID||''<br>'');',
'end;',
''))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(55599606389835822)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(55599511452835821)
,p_button_name=>'awr_sql_cust_rep'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'AWR SQL report (custom)'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_redirect_url=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:RP,16:P15_DB1,P15_REPORT_TYPE,P15_SQL_ID,P15_PROJ_ID,CURRENT_PROJECT:&P18_DUMP_ID.,AWRSQLREPORT,&P18_SQL_ID.,&P18_PROJ_ID.,&P18_PROJ_NAME.'
,p_button_condition=>':P18_SOURCEDB=''$LOCAL$'' and :P18_SOURCETAB=''AWR'' and :P18_DUMP_ID is not null'
,p_button_condition_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(56150367932396431)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(55599511452835821)
,p_button_name=>'getplanh'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_image_alt=>'SQL run time statistics'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_redirect_url=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.:RP:P64_SQL_ID,P64_SOURCEDB,P64_SOURCETAB:&P18_SQL_ID.,&P18_SOURCEDB.,&P18_SOURCETAB.'
,p_button_condition=>':P18_SOURCEDB!=''$LOCAL$'''
,p_button_condition_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51799906047989305)
,p_name=>'P18_SQL_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(55599511452835821)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51804247468989448)
,p_name=>'P18_DBID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(55599511452835821)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55599227111835818)
,p_name=>'P18_DUMP_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(55599511452835821)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55599705787835823)
,p_name=>'P18_PROJ_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(55599511452835821)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55599967834835825)
,p_name=>'P18_PROJ_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(55599511452835821)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56149249096396420)
,p_name=>'P18_SOURCE_PAGE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(55599511452835821)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56149367291396421)
,p_name=>'P18_ACTION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(55599511452835821)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56150495480396432)
,p_name=>'P18_SOURCEDB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(55599511452835821)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56151052953396438)
,p_name=>'P18_SOURCETAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(55599511452835821)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(56149693223396424)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GetData'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :P18_SOURCEDB = ''$LOCAL$'' and :P18_SOURCETAB = ''AWR'' then',
'    case',
'      when :P18_SOURCE_PAGE=63 then ',
'        begin',
'          :p18_dump_id:=:p63_dump_idl;',
'        end;',
'      when :P18_SOURCE_PAGE=17 then ',
'        begin',
'          :p18_dump_id:=:p17_dump_id;',
'        end;',
'      else :p18_dump_id := null;',
'    end case;',
'    begin',
'      SELECT',
'             p.proj_id,',
'             p.proj_name,',
'             d.dbid',
'        into :p18_proj_id, :p18_proj_name, :p18_dbid',
'        FROM awrdumps d, AWRTOOLPROJECT p',
'       where dump_id=:p18_dump_id and d.proj_id=p.proj_id;',
'    exception',
'      when no_data_found then :p18_proj_id:=null; :p18_proj_name:=''<UNDEFINED>''; :p18_dbid:=null;',
'    end;',
'  end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00020
begin
wwv_flow_api.create_page(
 p_id=>20
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'All Utilities'
,p_page_mode=>'NORMAL'
,p_step_title=>'All Utilities'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20171219171649'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(51600740930693935)
,p_plug_name=>'All Utilities'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors:t-MediaList--large:t-MediaList--cols t-MediaList--2cols'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(51714162134992520)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00040
begin
wwv_flow_api.create_page(
 p_id=>40
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'All reports'
,p_page_mode=>'NORMAL'
,p_step_title=>'All reports'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20171219171711'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(99985558848618232)
,p_plug_name=>'All Reports'
,p_component_template_options=>'#DEFAULT#:u-colors:t-MediaList--large:t-MediaList--cols t-MediaList--2cols'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(99984961931618202)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_plug_query_row_template=>1
);
end;
/
prompt --application/pages/page_00041
begin
wwv_flow_api.create_page(
 p_id=>41
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'All dumps space usage'
,p_page_mode=>'NORMAL'
,p_step_title=>'All dumps space usage'
,p_step_sub_title=>'All dumps space usage'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20171218094145'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(50713209316476428)
,p_plug_name=>'Dump space consumption'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232142344147478)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.proj_id, p.proj_name,ROUND(DBMS_LOB.GETLENGTH(f.filebody)/1024/1024)sz_mb,',
'  d.filename,d.dbid, d.min_snap_id, d.max_snap_id, db_description, d.dump_description',
'FROM AWRTOOLPROJECT p,',
'     AWRDUMPS d,',
'     AWRDUMPS_FILES f',
'WHERE p.proj_id=d.proj_id',
'AND d.dump_id  =f.dump_id',
'order by proj_name, sz_mb;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(50713337630476429)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AWRTOOLS21ADM'
,p_internal_uid=>50713337630476429
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50713447594476430)
,p_db_column_name=>'PROJ_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Proj id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50713588670476431)
,p_db_column_name=>'PROJ_NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Project name'
,p_column_link=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP:P11_PROJ_ID:#PROJ_ID#'
,p_column_linktext=>'#PROJ_NAME#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50713663004476432)
,p_db_column_name=>'SZ_MB'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Size, MB'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50713714497476433)
,p_db_column_name=>'FILENAME'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Filename'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50713894125476434)
,p_db_column_name=>'DBID'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'Dbid'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50713930177476435)
,p_db_column_name=>'MIN_SNAP_ID'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Min snap id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50714058349476436)
,p_db_column_name=>'MAX_SNAP_ID'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'Max snap id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50714192760476437)
,p_db_column_name=>'DB_DESCRIPTION'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'DB description'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50714275446476438)
,p_db_column_name=>'DUMP_DESCRIPTION'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>'Dump description'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(51508811669812209)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'515089'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'PROJ_ID:PROJ_NAME:SZ_MB:FILENAME:DBID:MIN_SNAP_ID:MAX_SNAP_ID:DB_DESCRIPTION:DUMP_DESCRIPTION'
,p_flashback_enabled=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(50714418210476440)
,p_plug_name=>'Total sizes, MB'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>5
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
' l_sz number;',
' l_totsz number;',
'begin',
'  begin',
'    SELECT nvl(sum(DBMS_LOB.GETLENGTH(f.filebody)/1024/1024),0) into l_sz FROM AWRDUMPS_FILES f;',
'  exception when no_data_found then l_sz:=0; end;',
'  begin',
'    select bytes/1024/1024 into l_totsz from user_segments ',
'     where segment_name=(select segment_name from user_lobs where table_name=''AWRDUMPS_FILES'');',
'  exception when no_data_found then l_totsz:=0; end;',
'  htp.p(''Total dump files size:              ''||round(l_sz,3));Htp.p(''</br>'');',
'  htp.p(''Total disk space for dump storage: ''||round(l_totsz,3)||'' (compressed)'');',
'end;',
'',
''))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00042
begin
wwv_flow_api.create_page(
 p_id=>42
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Locally loaded AWR data'
,p_page_mode=>'NORMAL'
,p_step_title=>'Locally loaded AWR data'
,p_step_sub_title=>'Locally loaded AWR data'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20171116112116'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(100005694802671651)
,p_plug_name=>'Locally loaded AWR data'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232142344147478)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x1.snap_id, x1.dbid, x1.instance_number, x1.startup_time, x1.begin_interval_time, x1.end_interval_time, x1.snap_level,x1.error_count, ',
'       decode(loc.proj_name,null,''<UNKNOWN PROJECT>'',loc.proj_name) project, loc.proj_id',
'from dba_hist_snapshot x1,',
'     (select dbid, min_snap_id, max_snap_id, proj_name, d.proj_id from awrdumps d, AWRTOOLPROJECT p where status=''AWRLOADED'' and d.proj_id=p.proj_id) loc',
'where x1.dbid<>(select dbid from v$database) ',
'and x1.dbid=loc.dbid(+) and x1.snap_id between loc.min_snap_id(+) and loc.max_snap_id(+)',
'order by x1.dbid,x1.snap_id;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(100005765196671651)
,p_name=>'Locally loaded AWR data'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AWRTOOLS20ADM'
,p_internal_uid=>49938166788727164
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100006137033671662)
,p_db_column_name=>'SNAP_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Snap Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100006504732671664)
,p_db_column_name=>'DBID'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Dbid'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100006958013671665)
,p_db_column_name=>'INSTANCE_NUMBER'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Instance Number'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100007391017671666)
,p_db_column_name=>'STARTUP_TIME'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Startup Time'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100007734985671666)
,p_db_column_name=>'BEGIN_INTERVAL_TIME'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Begin Interval Time'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100008145774671666)
,p_db_column_name=>'END_INTERVAL_TIME'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'End Interval Time'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100008947974671667)
,p_db_column_name=>'SNAP_LEVEL'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Snap Level'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100009382601671668)
,p_db_column_name=>'ERROR_COUNT'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Error Count'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50711166326476407)
,p_db_column_name=>'PROJECT'
,p_display_order=>19
,p_column_identifier=>'K'
,p_column_label=>'Project'
,p_column_link=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP:P11_PROJ_ID:#PROJ_ID#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50711256082476408)
,p_db_column_name=>'PROJ_ID'
,p_display_order=>29
,p_column_identifier=>'L'
,p_column_label=>'Proj id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(100011437267683905)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'499439'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'SNAP_ID:DBID:INSTANCE_NUMBER:STARTUP_TIME:BEGIN_INTERVAL_TIME:END_INTERVAL_TIME:SNAP_LEVEL:ERROR_COUNT:PROJECT:PROJ_ID'
,p_flashback_enabled=>'N'
);
end;
/
prompt --application/pages/page_00043
begin
wwv_flow_api.create_page(
 p_id=>43
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Remotely loaded AWR data'
,p_page_mode=>'NORMAL'
,p_step_title=>'Remotely loaded AWR data'
,p_step_sub_title=>'Remotely loaded AWR data'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20171116113340'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(50711335495476409)
,p_plug_name=>'Remote snapshots'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232142344147478)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from awrcomp_remote_data',
'order by dbid,snap_id',
';'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(50711429560476410)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AWRTOOLS21ADM'
,p_internal_uid=>50711429560476410
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50711578078476411)
,p_db_column_name=>'SNAP_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Snap id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50711659908476412)
,p_db_column_name=>'DBID'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Dbid'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50711710467476413)
,p_db_column_name=>'INSTANCE_NUMBER'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Instance number'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50711857702476414)
,p_db_column_name=>'STARTUP_TIME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Startup time'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50711941800476415)
,p_db_column_name=>'BEGIN_INTERVAL_TIME'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Begin interval time'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50712065480476416)
,p_db_column_name=>'END_INTERVAL_TIME'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'End interval time'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50712183417476417)
,p_db_column_name=>'SNAP_LEVEL'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Snap level'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50712272075476418)
,p_db_column_name=>'ERROR_COUNT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Error count'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50712320427476419)
,p_db_column_name=>'PROJECT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Project'
,p_column_link=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP:P11_PROJ_ID:#PROJ_ID#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50712402360476420)
,p_db_column_name=>'PROJ_ID'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Proj id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(50854182968167528)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'508542'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'SNAP_ID:DBID:INSTANCE_NUMBER:STARTUP_TIME:BEGIN_INTERVAL_TIME:END_INTERVAL_TIME:SNAP_LEVEL:ERROR_COUNT:PROJECT:PROJ_ID'
,p_flashback_enabled=>'N'
);
end;
/
prompt --application/pages/page_00060
begin
wwv_flow_api.create_page(
 p_id=>60
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'All Online Analytics'
,p_page_mode=>'NORMAL'
,p_step_title=>'All Online Analytics'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20180116134025'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(51801291696989318)
,p_plug_name=>'Online Analysis Tools'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors:t-MediaList--large:t-MediaList--cols t-MediaList--2cols'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(55237447938570936)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(101250961962147523)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(55128123748930908)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101237024490147486)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(101267511034147656)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(101255921228147535)
,p_plug_query_row_template=>1
);
end;
/
prompt --application/pages/page_00063
begin
wwv_flow_api.create_page(
 p_id=>63
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'ASH Dasboard'
,p_page_mode=>'NORMAL'
,p_step_title=>'ASH Dasboard'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20180207143852'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(56118392389386540)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101237024490147486)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(101267511034147656)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(101255921228147535)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(56148449682396412)
,p_plug_name=>'Source'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>3
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(111725039482229949)
,p_plug_name=>'Charts'
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'(nvl(:P63_SHOWL,''N'')=''Y'' and :P63_SOURCEDB=''$LOCAL$'') or (nvl(:P63_SHOW,''N'')=''Y'' and :P63_SOURCEDB<>''$LOCAL$'')'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(56147949376396407)
,p_plug_name=>'Top PLAN_HASH with non-single SQL_ID'
,p_parent_plug_id=>wwv_flow_api.id(111725039482229949)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(56148007496396408)
,p_region_id=>wwv_flow_api.id(56147949376396407)
,p_chart_type=>'pie'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'none'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_value_format_scaling=>'auto'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56148189795396409)
,p_chart_id=>wwv_flow_api.id(56148007496396408)
,p_seq=>10
,p_name=>'Top PLAN_HASH with non-single SQL_ID'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from ',
'  (select plan_hash, sum(sec) sec from',
'    (SELECT sql_id, SQL_PLAN_HASH_VALUE PLAN_HASH, sum(sec) sec',
'       FROM remote_ash',
'      where SQL_PLAN_HASH_VALUE>0 and sess_id = :P63_SESS_ID',
'      GROUP BY sql_id, SQL_PLAN_HASH_VALUE)',
'    group by PLAN_HASH having count(unique sql_id)>1',
'    ORDER BY 2 desc ',
') where rownum<21;'))
,p_items_value_column_name=>'SEC'
,p_items_label_column_name=>'PLAN_HASH'
,p_items_label_rendered=>false
,p_link_target=>'f?p=&APP_ID.:18:&SESSION.::&DEBUG.:RP:P18_SOURCE_PAGE,P18_ACTION,P18_SQL_ID,P18_DUMP_ID:63,SHOW_SQL_TEXT_BY_PLANHASH,&PLAN_HASH.,&P63_DUMP_IDL.'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(107930270538383481)
,p_plug_name=>'Top SQL'
,p_parent_plug_id=>wwv_flow_api.id(111725039482229949)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_row_template=>1
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(56128308283394194)
,p_region_id=>wwv_flow_api.id(107930270538383481)
,p_chart_type=>'pie'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'none'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_value_format_scaling=>'auto'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>false
,p_show_value=>true
,p_show_label=>false
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56128869348394204)
,p_chart_id=>wwv_flow_api.id(56128308283394194)
,p_seq=>10
,p_name=>'Top 10 SQLs'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from ',
'  (SELECT nvl(sql_id,''<UNKNOWN SQL>'') sql_id, sum(sec) sec',
'     FROM remote_ash',
'    where sess_id = :P63_SESS_ID',
'    GROUP BY nvl(sql_id,''<UNKNOWN SQL>'')',
'    ORDER BY 2 desc ',
') where rownum<11;'))
,p_items_value_column_name=>'SEC'
,p_items_label_column_name=>'SQL_ID'
,p_items_label_rendered=>false
,p_link_target=>'f?p=&APP_ID.:18:&SESSION.::&DEBUG.:RP,18:P18_SQL_ID,P18_SOURCEDB,P18_SOURCETAB,P18_SOURCE_PAGE,P18_ACTION:&SQL_ID.,&P63_SOURCEDB.,&P63_SOURCETAB.,63,SHOW_SQL_TEXT_BY_ID'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(107931176885383491)
,p_plug_name=>'Top Module and Action'
,p_parent_plug_id=>wwv_flow_api.id(111725039482229949)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_row_template=>1
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(56129741432394213)
,p_region_id=>wwv_flow_api.id(107931176885383491)
,p_chart_type=>'pie'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'none'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_value_format_scaling=>'auto'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>false
,p_show_value=>true
,p_show_label=>false
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56130217691394214)
,p_chart_id=>wwv_flow_api.id(56129741432394213)
,p_seq=>10
,p_name=>'Top Module/Action'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from (SELECT',
'    ''MODULE:''||nvl(module,''N/A'')||''; ACTION:''||nvl(ACTION,''N/A'') mod_act,',
'    sum(sec) sec',
'FROM',
'    remote_ash',
'where sess_id = :P63_SESS_ID',
'GROUP BY',
'    ''MODULE:''||nvl(module,''N/A'')||''; ACTION:''||nvl(ACTION,''N/A'')',
'ORDER BY 2 desc ) where rownum<11;'))
,p_items_value_column_name=>'SEC'
,p_items_label_column_name=>'MOD_ACT'
,p_items_label_rendered=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(111725224827229951)
,p_plug_name=>'Next top 10 queries'
,p_parent_plug_id=>wwv_flow_api.id(111725039482229949)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>25
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_row_template=>1
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(56131066339394218)
,p_region_id=>wwv_flow_api.id(111725224827229951)
,p_chart_type=>'pie'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'none'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_value_format_scaling=>'auto'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>false
,p_show_value=>true
,p_show_label=>false
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56131563166394218)
,p_chart_id=>wwv_flow_api.id(56131066339394218)
,p_seq=>10
,p_name=>'Next Top 10 SQLs'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sql_id, sec',
'from (select x.*, rownum rn from (SELECT',
'    nvl(sql_id,''<UNKNOWN SQL>'') sql_id,',
'    sum(sec) sec',
'FROM',
'    remote_ash',
'where sess_id = :P63_SESS_ID',
'GROUP BY',
'    nvl(sql_id,''<UNKNOWN SQL>'')',
'ORDER BY 2 desc ) x where rownum<21) where rn>10;'))
,p_items_value_column_name=>'SEC'
,p_items_label_column_name=>'SQL_ID'
,p_items_label_rendered=>false
,p_link_target=>'f?p=&APP_ID.:18:&SESSION.::&DEBUG.:RP,18:P18_SQL_ID,P18_SOURCEDB,P18_SOURCETAB,P18_SOURCE_PAGE,P18_ACTION:&SQL_ID.,&P63_SOURCEDB.,&P63_SOURCETAB.,63,SHOW_SQL_TEXT_BY_ID'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(111725694196229956)
,p_plug_name=>'Top 10 events'
,p_parent_plug_id=>wwv_flow_api.id(111725039482229949)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_row_template=>1
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(56132488691394220)
,p_region_id=>wwv_flow_api.id(111725694196229956)
,p_chart_type=>'pie'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'none'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_value_format_scaling=>'auto'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>false
,p_show_value=>true
,p_show_label=>false
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56132936609394220)
,p_chart_id=>wwv_flow_api.id(56132488691394220)
,p_seq=>10
,p_name=>'Top 10 Events'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with nm as (select /*+ result_cache */ name, display_name||''(''||name||'')'' display_name from v$event_name where name != display_name)',
'select coalesce((select display_name from nm where name=event),event) event, sec',
' from (SELECT',
'    nvl(event, ''CPU'') event,',
'    sum(sec) sec',
'FROM',
'    remote_ash',
'where sess_id = :P63_SESS_ID',
'GROUP BY',
'    nvl(event, ''CPU'')',
'ORDER BY 2 desc ) where rownum<11; '))
,p_items_value_column_name=>'SEC'
,p_items_label_column_name=>'EVENT'
,p_items_label_rendered=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166674090584920015)
,p_plug_name=>'Wait event classes by AWR ASH'
,p_parent_plug_id=>wwv_flow_api.id(111725039482229949)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(56133851612394225)
,p_region_id=>wwv_flow_api.id(166674090584920015)
,p_chart_type=>'area'
,p_height=>'800'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_legend_rendered=>'on'
,p_legend_position=>'top'
,p_time_axis_type=>'disabled'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56135536204394229)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>10
,p_name=>'CPU'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''CPU'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time; '))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#00FF00'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''CPU'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56136147188394239)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>20
,p_name=>'User I/O'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''User I/O'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#0000FF'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''User I/O'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56136796661394241)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>30
,p_name=>'Administrative'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''Administrative'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#FFCC00'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''Administrative'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56137381490394242)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>40
,p_name=>'Application'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''Application'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#FF2EF8'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''Application'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56139728046394250)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>50
,p_name=>'Commit'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''Commit'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#FF9500'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''Commit'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56140317881394252)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>60
,p_name=>'Concurrency'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''Concurrency'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#34AADC'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''Concurrency'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56137998673394244)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>70
,p_name=>'Configuration'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''Configuration'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#5856D6'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''Configuration'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56140911595394254)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>80
,p_name=>'Idle'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''Idle'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#C7C7CC'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''Idle'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56138500896394248)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>90
,p_name=>'Network'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''Network'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#8E8E93'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''Network'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56141584211394255)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>100
,p_name=>'Other'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''Other'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#007AFF'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''Other'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56139181151394249)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>110
,p_name=>'Scheduler'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''Scheduler'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#86D94E'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''Scheduler'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(56142171582394257)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_seq=>120
,p_name=>'System I/O'
,p_data_source_type=>'SQL_QUERY'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select TO_CHAR(d.sample_time,''YYYY/MM/DD HH24:MI:SS'') sample_time, nvl(h.sec,0) sec ',
'  from (select sample_time, sum(sec) sec ',
'          from remote_ash where wait_class = ''System I/O'' and sess_id = :P63_SESS_ID',
'         group by sample_time, wait_class) h, ',
'       remote_ash_timeline d ',
' where d.sample_time=h.sample_time(+) and sess_id = :P63_SESS_ID',
' ORDER BY sample_time;'))
,p_items_value_column_name=>'SEC'
,p_group_name_column_name=>'SAMPLE_TIME'
,p_items_label_column_name=>'SAMPLE_TIME'
,p_color=>'#FF0000'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM remote_ash',
' WHERE   wait_class = ''System I/O'' and sess_id = :P63_SESS_ID;'))
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(56134931454394228)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title=>'Number of samples'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(56134351322394225)
,p_chart_id=>wwv_flow_api.id(56133851612394225)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(163349683556019870)
,p_plug_name=>'Input Parameters'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>5
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_plug_display_when_condition=>'P63_SOURCEDB'
,p_plug_display_when_cond2=>'$LOCAL$'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(163831622141271829)
,p_plug_name=>'Input Parameters'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>6
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P63_SOURCEDB'
,p_plug_display_when_cond2=>'$LOCAL$'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(56149073202396418)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(163831622141271829)
,p_button_name=>'LoadCubeLocally'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Analyze'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(56160958627550608)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(163349683556019870)
,p_button_name=>'LoadCubeRemotely'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Analyze'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56147773543396405)
,p_name=>'P63_SOURCEDB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(56148449682396412)
,p_item_default=>'$LOCAL$'
,p_prompt=>'Source'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SOURCEDB'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''Local warehouse'' d, ''$LOCAL$'' r from dual',
'union all',
'select username||''@''||host name, db_link id from user_db_links where db_link not like (select upper(cvalue) from awrconfig where ckey=''DBLINK'')||''%'''))
,p_cHeight=>1
,p_colspan=>4
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56148510669396413)
,p_name=>'P63_SESS_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(56148449682396412)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56148680443396414)
,p_name=>'P63_FILTER_REMASH'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(163349683556019870)
,p_prompt=>'Filter (SQL expression)'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>93
,p_cHeight=>5
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56148805714396416)
,p_name=>'P63_SOURCETAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(56148449682396412)
,p_item_default=>'AWR'
,p_prompt=>'Type'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'SOURCETAB'
,p_lov=>'.'||wwv_flow_api.id(57108666722420822)||'.'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56148969950396417)
,p_name=>'P63_FILTER_REMASHL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_prompt=>'Filter (SQL expression)'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>93
,p_cHeight=>5
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56149754387396425)
,p_name=>'P63_SOURCEDB_PREV'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(56148449682396412)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56162427732550624)
,p_name=>'P63_INST_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(163349683556019870)
,p_item_default=>'1'
,p_prompt=>'RAC node'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Node 1;1,Node 2;2,Node 3;3,Node 4;4'
,p_cHeight=>1
,p_colspan=>4
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56164878745550628)
,p_name=>'P63_START_DT'
,p_item_sequence=>22
,p_item_plug_id=>wwv_flow_api.id(163349683556019870)
,p_prompt=>'Start date'
,p_format_mask=>'YYYY/MON/DD HH24:MI:SS'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>4
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56165231641550628)
,p_name=>'P63_END_DT'
,p_item_sequence=>24
,p_item_plug_id=>wwv_flow_api.id(163349683556019870)
,p_prompt=>'End date'
,p_format_mask=>'YYYY/MON/DD HH24:MI:SS'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_column=>5
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56165662015550629)
,p_name=>'P63_AGG'
,p_item_sequence=>26
,p_item_plug_id=>wwv_flow_api.id(163349683556019870)
,p_item_default=>'by_mi'
,p_prompt=>'Aggregation'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:No Aggregation;no_agg,By Minute;by_mi,By hour;by_hour,By day;by_day'
,p_cHeight=>1
,p_colspan=>4
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56166071511550629)
,p_name=>'P63_SHOW'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(163349683556019870)
,p_item_default=>'N'
,p_prompt=>'Show charts'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_grid_column=>5
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'CUSTOM'
,p_attribute_02=>'Y'
,p_attribute_03=>'Yes'
,p_attribute_04=>'N'
,p_attribute_05=>'No'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56642832900802577)
,p_name=>'P63_DBIDL'
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56643224546802584)
,p_name=>'P63_MIN_SNAPL'
,p_item_sequence=>2
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56643631653802585)
,p_name=>'P63_MAX_SNAPL'
,p_item_sequence=>3
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56644042749802588)
,p_name=>'P63_INST_IDL'
,p_item_sequence=>4
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56644411208802589)
,p_name=>'P63_START_DTHL'
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56644855082802589)
,p_name=>'P63_END_DTHL'
,p_item_sequence=>6
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56645268162802590)
,p_name=>'P63_PROJ_NAMEL'
,p_item_sequence=>7
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56645648391802590)
,p_name=>'P63_PROJ_IDL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_prompt=>'Project'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select proj_name, proj_id from AWRTOOLPROJECT ',
' where proj_id in (select proj_id from awrdumps where status=''AWRLOADED'' and IS_REMOTE=''NO'')',
' order by proj_name'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Select project...'
,p_cHeight=>1
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56646043264802591)
,p_name=>'P63_DUMP_IDL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_prompt=>'Dump'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    ''DBID: ''||DBID||',
'    '', ''||MIN_SNAP_ID||''-''||MAX_SNAP_ID||',
'    '', ''||to_char(MIN_SNAP_DT,''yyyy-mon-dd hh24:mi:ss'')||''-''||to_char(MAX_SNAP_DT,''yyyy-mon-dd hh24:mi:ss'')||',
'    '', ''||DB_DESCRIPTION||''; REMOTE:''||is_remote',
'    name,',
'    dump_id',
'FROM',
'    awrdumps',
'where status=''AWRLOADED'' and proj_id=:P63_PROJ_IDL and IS_REMOTE=''NO''',
'order by MAX_SNAP_DT;'))
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_column=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56646494801802592)
,p_name=>'P63_START_DTL'
,p_item_sequence=>22
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_prompt=>'Start date'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'WITH r AS (',
'    SELECT level n FROM dual',
'    CONNECT BY level <= 1 + round( (TO_DATE(:p63_end_dthl,''YYYY/MON/DD HH24:MI:SS'') - TO_DATE(:p63_start_dthl,''YYYY/MON/DD HH24:MI:SS'') ) * 24 * 60 )',
') SELECT',
'    TO_CHAR(dt,''YYYY/MON/DD HH24:MI:SS'') name_c,',
'    TO_CHAR(dt,''YYYY/MON/DD HH24:MI:SS'') id',
'  FROM',
'    (SELECT TO_DATE(:p63_start_dthl,''YYYY/MON/DD HH24:MI:SS'') + ( n - 1 ) / 24 / 60 dt',
'       FROM r)',
'  WHERE',
'    dt <= TO_DATE(:p63_end_dthl,''YYYY/MON/DD HH24:MI:SS'');'))
,p_cHeight=>1
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56646800400802593)
,p_name=>'P63_END_DTL'
,p_item_sequence=>24
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_prompt=>'End date'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'WITH r AS (',
'    SELECT level n FROM dual',
'    CONNECT BY level <= 3 + round( (TO_DATE(:p63_end_dthl,''YYYY/MON/DD HH24:MI:SS'') - TO_DATE(:p63_start_dthl,''YYYY/MON/DD HH24:MI:SS'') ) * 24 * 60)',
') SELECT',
'    TO_CHAR(dt,''YYYY/MON/DD HH24:MI:SS'') name_c,',
'    TO_CHAR(dt,''YYYY/MON/DD HH24:MI:SS'') id',
'  FROM',
'    (SELECT TO_DATE(:p63_start_dthl,''YYYY/MON/DD HH24:MI:SS'') + ( n - 1 ) / 24 / 60 dt',
'       FROM r)',
'  WHERE',
'    dt <= TO_DATE(:p63_end_dthl,''YYYY/MON/DD HH24:MI:SS'') + 2 /24 / 60;'))
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_column=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56647294341802593)
,p_name=>'P63_AGGL'
,p_item_sequence=>26
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_item_default=>'by_mi'
,p_prompt=>'Aggregation'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:No Aggregation;no_agg,By Minute;by_mi,By hour;by_hour,By day;by_day'
,p_cHeight=>1
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56647606565802593)
,p_name=>'P63_SHOWL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(163831622141271829)
,p_item_default=>'N'
,p_prompt=>'Show charts'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_grid_column=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'CUSTOM'
,p_attribute_02=>'Y'
,p_attribute_03=>'Yes'
,p_attribute_04=>'N'
,p_attribute_05=>'No'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(56148780006396415)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SetParamsFor Local'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :P63_DUMP_IDL is null then',
'    begin',
'      select DUMP_ID into :P63_DUMP_IDL from awrdumps where proj_id=:P63_PROJ_IDL and rownum<2;',
'    exception when others then null;',
'    end;',
'  end if;',
'  for i in (SELECT',
'                   dbid,',
'                   min_snap_id,',
'                   max_snap_id,',
'                   to_date(to_char(min_snap_dt,''YYYY/MON/DD HH24:MI:SS''),''YYYY/MON/DD HH24:MI:SS'') min_snap_dt,',
'                   to_date(to_char(max_snap_dt,''YYYY/MON/DD HH24:MI:SS''),''YYYY/MON/DD HH24:MI:SS'') max_snap_dt,',
'                   proj_name',
'              FROM awrdumps d, AWRTOOLPROJECT p',
'             where dump_id=:P63_DUMP_IDL and d.proj_id=p.proj_id) loop',
'    :P63_PROJ_NAMEL:= i.proj_name;',
'    :P63_DBIDL:=i.dbid;',
'    :P63_MIN_SNAPL:=i.min_snap_id;',
'    :P63_MAX_SNAPL:=i.max_snap_id;',
'    :P63_INST_IDL :=1;',
'    :P63_START_DTHL:=to_char(i.min_snap_dt,''YYYY/MON/DD HH24:MI:SS'');',
'    :P63_END_DTHL:=to_char(i.max_snap_dt,''YYYY/MON/DD HH24:MI:SS'');',
'    :P63_START_DTL:=replace(:P63_START_DTL,''null'','''');',
'    :P63_END_DTL:=replace(:P63_END_DTL,''null'','''');',
'    if not nvl(to_date(:P63_START_DTL,''YYYY/MON/DD HH24:MI:SS''),sysdate+1000) between i.min_snap_dt and i.max_snap_dt then',
'      :P63_START_DTL:=to_char(i.min_snap_dt,''YYYY/MON/DD HH24:MI:SS'');',
'    end if;',
'    if not nvl(to_date(:P63_END_DTL,''YYYY/MON/DD HH24:MI:SS''),sysdate+1000) between i.min_snap_dt and i.max_snap_dt + 1/24/60 then',
'      --:P63_END_DT:=to_char(i.max_snap_dt,''YYYY/MON/DD HH24:MI:SS'');',
'--raise_application_error(-20000,:P63_END_DT||''--''||to_char(i.min_snap_dt,''YYYY/MON/DD HH24:MI:SS'')||''--''||to_char(i.max_snap_dt+ 2/24/60,''YYYY/MON/DD HH24:MI:SS''));',
'       WITH r AS (',
'                  SELECT level n FROM dual',
'                   CONNECT BY level <= 3 + round( (TO_DATE(:P63_end_dthL,''YYYY/MON/DD HH24:MI:SS'') -',
'                                                   TO_DATE(:P63_start_dthL,''YYYY/MON/DD HH24:MI:SS'') ) * 24 * 60)',
'                  )',
'       SELECT',
'         to_char(max(dt),''YYYY/MON/DD HH24:MI:SS'') into :P63_END_DTL',
'         FROM (SELECT TO_DATE(:P63_start_dthL,''YYYY/MON/DD HH24:MI:SS'') + ( n - 1 ) / 24 / 60 dt FROM r)',
'        WHERE dt <= TO_DATE(:P63_end_dthL,''YYYY/MON/DD HH24:MI:SS'') + 1 /24 / 60;',
'',
'    end if;',
'  end loop;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P63_SOURCEDB'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'$LOCAL$'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(56149837502396426)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'OnSourceDBChange'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :P63_SOURCEDB_PREV<>:P63_SOURCEDB then ',
'    :P63_SHOW:=''N'';',
'    :P63_SHOWL:=''N'';',
'  end if;',
'  :P63_SOURCEDB_PREV:=:P63_SOURCEDB;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(56147836703396406)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'LoadRemoteAWRASH'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :P63_SHOW=''Y'' then',
'    if :P63_SOURCEDB <> ''$LOCAL$'' then',
'      AWRTOOLS_REMOTE_ANALYTICS.load_data_cube',
'       (p_sess_id  => :P63_SESS_ID,',
'        p_source   => :P63_SOURCETAB,',
'        p_dblink   => :P63_SOURCEDB,',
'        p_agg      => :P63_AGG, ',
'        p_inst_id  => :P63_INST_ID, ',
'        p_start_dt => to_date(:P63_START_DT,''YYYY/MON/DD HH24:MI:SS''), ',
'        p_end_dt   => to_date(:P63_END_DT,''YYYY/MON/DD HH24:MI:SS''),',
'        p_filter   => :P63_FILTER_REMASH);',
'    end if;',
'  end if;                                                         ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(56160958627550608)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(56149144894396419)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'LoadLocalAWRASH'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :P63_SHOWL=''Y'' then',
'    if :P63_SOURCEDB = ''$LOCAL$'' then',
'      if :P63_SOURCETAB=''AWR'' then',
'        AWRTOOLS_REMOTE_ANALYTICS.load_data_cube',
'         (p_sess_id  => :P63_SESS_ID,',
'          p_source   => :P63_SOURCETAB,',
'          p_dblink   => :P63_SOURCEDB,',
'          p_agg      => :P63_AGGL, ',
'          p_inst_id  => :P63_INST_IDL, ',
'          p_start_dt => to_date(:P63_START_DTL,''YYYY/MON/DD HH24:MI:SS''), ',
'          p_end_dt   => to_date(:P63_END_DTL,''YYYY/MON/DD HH24:MI:SS''),',
'          p_filter   => :P63_FILTER_REMASHL,',
'          p_dump_id  => :P63_DUMP_IDL);    ',
'      else',
'        raise_application_error(-20000,''Feature is not implemented.'');',
'      end if;',
'    end if;',
'  end if;                                                         ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(56149073202396418)
);
end;
/
prompt --application/pages/page_00064
begin
wwv_flow_api.create_page(
 p_id=>64
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'GetPlanHRemote'
,p_page_mode=>'NORMAL'
,p_step_title=>'SQL runtime statistics'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'body.awr {font:bold 10pt Arial,Helvetica,Geneva,sans-serif;color:black; background:White;}',
'pre.awr    {font:8pt Courier;color:black; background:White;}',
'h1.awr     {font:bold 20pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;border-bottom:1px solid #cccc99;margin-top:0pt; margin-bottom:0pt;padding:0px 0px 0px 0px;}',
'h2.awr     {font:bold 18pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}',
'h3.awr     {font:bold 16pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}',
'h4.awr     {font:bold 12pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}',
'h5.awr     {font:bold 10pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}',
'h6.awr     {font:6pt Arial,Helvetica,Geneva,sans-serif;color:black;background-color:White;margin-top:10pt; margin-bottom:10pt;}',
'li.awr        {font: 8pt Arial,Helvetica,Geneva,sans-serif; color:black; background:White;}',
'th.awrbg  {font-family: monospace; font-size: 11px; color:White; background:#0066CC;padding-left:4px; padding-right:4px;padding-bottom:2px}',
'td.awrnc1{font-family: monospace; font-size: 11px; color:black;background:White;   vertical-align:top;}',
'td.awrc1  {font-family: monospace; font-size: 11px; color:black;background:#FFFFCC; vertical-align:top;}',
'td.awrncc1{font-family: monospace; font-size: 11px; color:red;background:White;   vertical-align:top;}',
'td.awrcc1  {font-family: monospace; font-size: 11px; color:red;background:#FFFFCC; vertical-align:top;}',
'a.awr        {font:bold 8pt Arial,Helvetica,sans-serif;color:#663300; vertical-align:top;margin-top:0pt; margin-bottom:0pt;}',
'a.awr1      {font:font-family: monospace; font-size: 11px;color:#663300; vertical-align:top;margin-top:0pt; margin-bottom:0pt;}',
'td.awrncbbt  {font-family: monospace; font-size: 11px;color:black;background:White;vertical-align:top;border-style: ridge;border-width: 1px;}',
'td.awrcbbt    {font-family: monospace; font-size: 11px;color:black;background:#FFFFCC; vertical-align:top;border-style: ridge;border-width: 1px;}',
'table.tdiff   {  border_collapse: collapse; border-spacing: 0px}',
'.hidden    {position:absolute;left:-10000px;top:auto;width:1px;height:1px;overflow:hidden;}',
'.pad           {margin-left:17px;}',
'.doublepad  {margin-left:34px;}',
'span.nm    {background-color:#cceeff;color:red;}'))
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS21ADM'
,p_last_upd_yyyymmddhh24miss=>'20180209113231'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(56149922582396427)
,p_plug_name=>'Report'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_output AWRTOOLS_REMOTE_ANALYTICS.t_output_lines;',
'begin',
'  if :P64_RPT_ID is not null then',
'    AWRTOOLS_REMOTE_ANALYTICS.getreport ',
'      (  P_REPORT => l_output,',
'         P_ID => :P64_RPT_ID) ;',
'    for i in 1..l_output.count loop',
'      htp.p(l_output(i));',
'    end loop;',
'  else',
'    htp.p(''Report is not specified'');',
'  end if;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P64_RPT_ID'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(56150025581396428)
,p_plug_name=>'Input'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(101232642288147479)
,p_plug_display_sequence=>5
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(57270795736656333)
,p_name=>'Save report'
,p_template=>wwv_flow_api.id(101232642288147479)
,p_display_sequence=>7
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>2
,p_display_point=>'BODY'
,p_source=>'select id, sys.dbms_lob.getlength(report) download from AWRTOOLS_ONLINE_RPT where id=:P64_RPT_ID'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P64_RPT_ID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(101242666033147507)
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(57271145215656337)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(57270816625656334)
,p_query_column_id=>2
,p_column_alias=>'DOWNLOAD'
,p_column_display_sequence=>1
,p_column_heading=>'Download'
,p_use_as_row_header=>'N'
,p_column_format=>'DOWNLOAD:AWRTOOLS_ONLINE_RPT:REPORT:ID::FILE_MIMETYPE:FILE_NAME:::attachment::'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(56150522613396433)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(56150025581396428)
,p_button_name=>'Submit'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255311357147531)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_position=>'BODY'
,p_icon_css_classes=>'fa-database-arrow-down'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56150153680396429)
,p_name=>'P64_SQL_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(56150025581396428)
,p_prompt=>'SQL ID'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>2
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56150239156396430)
,p_name=>'P64_SOURCEDB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(56150025581396428)
,p_prompt=>'Source'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SOURCEDB'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''Local warehouse'' d, ''$LOCAL$'' r from dual',
'union all',
'select username||''@''||host name, db_link id from user_db_links where db_link not like (select upper(cvalue) from awrconfig where ckey=''DBLINK'')||''%'''))
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_column=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56150734066396435)
,p_name=>'P64_SOURCETAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(56150025581396428)
,p_item_default=>'V$VIEW'
,p_prompt=>'Type'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'SOURCETAB'
,p_lov=>'.'||wwv_flow_api.id(57108666722420822)||'.'
,p_begin_on_new_line=>'N'
,p_grid_column=>7
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(101254971141147529)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(57271520715656341)
,p_name=>'P64_RPT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(56150025581396428)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(57271757815656343)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CreateReport'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_output AWRTOOLS_REMOTE_ANALYTICS.t_output_lines;',
'begin',
'  if :P64_SQL_ID is not null and :P64_SOURCEDB is not null and :P64_SOURCETAB is not null then',
'    if :P64_SOURCEDB != ''$LOCAL$'' then',
'      select sq_online_rpt.nextval into :P64_RPT_ID from dual;',
'      if :P64_SOURCETAB=''V$VIEW'' then',
'        AWRTOOLS_REMOTE_ANALYTICS.getplanh ',
'          (  P_SQL_ID => :P64_SQL_ID,',
'             P_DBLINK => :P64_SOURCEDB,',
'             P_ID => :P64_RPT_ID) ;',
'      elsif :P64_SOURCETAB=''AWR'' then',
'        AWRTOOLS_REMOTE_ANALYTICS.getplanawrh ',
'          (  P_SQL_ID => :P64_SQL_ID,',
'             P_DBLINK => :P64_SOURCEDB,',
'             P_ID => :P64_RPT_ID ) ;',
'      end if;',
'      for i in 1..l_output.count loop',
'        htp.p(l_output(i));',
'      end loop;',
'    else',
'      htp.p(''Use Project page to create reports.'');',
'    end if;',
'  else',
'    htp.p(''Input parameters are empty.'');',
'  end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_api.create_page(
 p_id=>101
,p_user_interface_id=>wwv_flow_api.id(101266223782147592)
,p_name=>'Login Page'
,p_alias=>'LOGIN_DESKTOP'
,p_page_mode=>'NORMAL'
,p_step_title=>'AWR Tools - Log In'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(101216064513147425)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'Y'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'AWRTOOLS20ADM'
,p_last_upd_yyyymmddhh24miss=>'20171109170900'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(101266720078147643)
,p_plug_name=>'AWR Tools'
,p_icon_css_classes=>'fa-sign-in'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(101232452890147478)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(101267037491147650)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(101266720078147643)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(101255455566147533)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Log In'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_alignment=>'LEFT'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(101266816217147647)
,p_name=>'P101_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(101266720078147643)
,p_prompt=>'username'
,p_placeholder=>'username'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(101254880382147527)
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(101266922657147649)
,p_name=>'P101_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(101266720078147643)
,p_prompt=>'password'
,p_placeholder=>'password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(101254880382147527)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(101267235253147655)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P101_USERNAME) );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(101267197245147653)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P101_USERNAME,',
'    p_password => :P101_PASSWORD );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(101267488320147656)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(101267373145147655)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>':P101_USERNAME := apex_authentication.get_login_username_cookie;'
);
end;
/
prompt --application/deployment/definition
begin
wwv_flow_api.create_install(
 p_id=>wwv_flow_api.id(51477535498638126)
);
end;
/
prompt --application/deployment/install
begin
null;
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
