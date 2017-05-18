<cfprocessingdirective suppresswhitespace="yes">
<cfset request.cfc = "cfc">	
<cfset request.DSN = "NeaseCC">    
<cfset request.masterDSN = "">

<cfset request.title = "Nease Cross Country">
<cfset request.siteURL = "http://#cgi.server_name#/">
<cfset request.appURL = "http://#cgi.server_name#/cms/">
<cfset request.default_email = "noReply@website.com">
<cfset this_page = GetFileFromPath (GetTemplatePath ())>
<cfset this_domain = "http://#cgi.server_name##Replace (cgi.path_info, '/#this_page#', '', 'ALL')#">
<cfset request.debug = "On"><!--- On or Off - this ads cfthrow to the cfcatch --->


<!--- ROOT LOCATION TO UPLOAD IMAGES/FILES --->
<!-------------------------------------------->
	<cfset full_url = "#cgi.server_name##cgi.script_name#">
    <cfif #full_url# contains "gallery/" or #full_url# contains "gallery_categories/" or #full_url# contains "ads/" or #full_url# contains "slide_show/" or #full_url# contains "blog_posts/">
        <cfset request.upLoadRoot = "#Expandpath("../../")#">
    <cfelse>
        <cfset request.upLoadRoot = "#Expandpath("../../../")#">
    </cfif>
<!-------------------------------------------->
<!--- ROOT LOCATION TO UPLOAD IMAGES/FILES --->


<!--- NAVIGATION SETTINGS --->
<!--------------------------->
	<!--- values are either On or Off --->
	<cfset request.active_pages = "On">
    <cfset request.latest_news = "On">
    <cfset request.blog = "On">
    <cfset request.active_image_repository = "On">
    <cfset request.active_slide_show = "On">
    <cfset request.active_gallery_categories = "On">
    <cfset request.active_bios = "On">
    <cfset request.active_ads = "On">
    <cfset request.message_board = "On">
<!--------------------------->
<!--- NAVIGATION SETTINGS --->



<!--- PAGE SETTINGS --->
<!--------------------->
	<!--- pages settings for the customer login accounts --->
	<!--- values are either On or Off if not otherwise noted --->
	<cfset request.pages_allow_customer_to_create = "On">
	<cfset request.pages_allow_customer_all_selections = "On">
    <cfset request.pages_allow_customer_change_layout = "On">
    <cfset request.page_layout_default = "1"><!--- 1=Full Page, 2=Content Left, 3=Content Right --->
	
    <!--- blog settings --->
    <!--- values are either On or Off if not otherwise noted --->
    <cfset request.blog_allow_customer_change_layout = "Off">
    <cfset request.blog_layout_default = "2"><!--- 1=Full Page, 2=Content Left, 3=Content Right ---> 
<!--------------------->
<!--- PAGE SETTINGS --->




<!--- IMAGE SETTINGS --->
<!---------------------->
	<cfset request.image_manipulator = "cfimage"><!--- cfimage or jpegresize --->
    <!--- slideshow --->
    <cfset request.width_slide_show = "2000">
    <cfset request.height_slide_show = "800">
    <!--- gallery --->
    <cfset request.width_gallery = "1400">
    <cfset request.height_gallery = "720">
    <!--- pages/blog posts/latest news --->
    <cfset request.width_pages = "900">
    <cfset request.height_pages = "700">
    <!--- bios --->
    <cfset request.width_bios = "900">
    <cfset request.height_bios = "700">
    <!--- ads --->
    <cfset request.width_ads = "600">
    <cfset request.height_ads = "400">
    <!--- images_files_repo --->
    <cfset request.width_image_file_repo = "600">
    <cfset request.height_image_file_repo = "400">
    <!--- blog --->
    <cfset request.width_blog_posts = "600">
    <cfset request.height_blog_posts = "400">
<!---------------------->
<!--- IMAGE SETTINGS --->


<!--- APPLICATION MGNT --->
<!------------------------>
	<cfif IsDefined ("URL.Logout")>
        <CFAPPLICATION
            NAME="#request.title#-Thorium90" 
            SESSIONMANAGEMENT="YES"
            SESSIONTIMEOUT="#CreateTimeSpan(0, 0, 0, 0)#">         			
        <cflocation url="#request.siteURL#cms/index.cfm?msg=logged_out" addtoken="no">
    <cfelse>
        <CFAPPLICATION
            NAME="#request.title#-Thorium90" 
            SESSIONMANAGEMENT="Yes"
            SESSIONTIMEOUT="#CreateTimeSpan(0, 0, 30, 0)#">
    </cfif>    
<!------------------------>
<!--- APPLICATION MGNT ---> 


<!--- ERROR HANDLING 

    <cferror type="validation" template="../error_report.cfm" >
    <cferror type="exception" template="../error_report.cfm" >
    <cferror type="request" template="../error_report.cfm" >
    --->
<!---------------------->
<!--- ERROR HANDLING --->
    
</cfprocessingdirective>