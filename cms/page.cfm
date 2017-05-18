<cfset urlstring = cgi.path_info>
<cfloop from="1" to=#ListLen(urlstring,"/")# index="i">
<cfif i mod 2>
<cfset paramName = "URL." & ListGetAt(urlstring,i,"/")>
<cfelse>
<cfparam name="#paramName#" default="#ListGetAt(urlstring,i,"/")#">
</cfif>
</cfloop>

<cfif cgi.QUERY_STRING contains "=">
<cfset moveUrl = #rereplace (cgi.QUERY_STRING,"[=?&]","/","ALL")#>
<cfset newUrl = #cgi.path_info# & "/" & #moveUrl#>
<cfheader statuscode="301" statustext="Moved permanently">
<cfheader name="Location" value="#newUrl#"> 
</cfif>

	<cfquery name="q_getAll" datasource="#request.dsn#">
		SELECT id, p_name, p_show_name, p_alias, p_sub_page, p_content, p_desc, p_title, p_keywords, p_date_added, p_date_added_by, p_last_mod, p_last_mod_by, p_priority, p_freq, p_seq, p_facebook, p_retweet, p_location, p_catid, p_image, p_comment, p_publish
        FROM tbl_pages
        WHERE p_alias = <cfqueryparam cfsqltype="cf_sql_longvarchar" maxlength="50" value="#url.go#">
        ORDER BY p_seq, p_date_added, p_name
	</cfquery>
    
	<cfquery name="q_nav" datasource="#request.dsn#">
		SELECT id, p_name, p_show_name, p_alias, p_sub_page, p_content, p_desc, p_title, p_keywords, p_date_added, p_date_added_by, p_last_mod, p_last_mod_by, p_priority, p_freq, p_seq, p_facebook, p_retweet, p_location, p_catid, p_image, p_comment, p_publish
        FROM tbl_pages
        WHERE p_catid = <cfqueryparam cfsqltype="cf_sql_longvarchar" maxlength="50" value="1">
        ORDER BY p_seq, p_date_added, p_name
	</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><cfoutput>#q_getAll.p_title#</cfoutput></title>
</head>

<body>

<cfoutput>
	<table width="95%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="30%" valign="top"><cfloop query="q_nav">
	      <a href="#request.siteurl#admin/page.cfm/go/#q_Nav.p_alias#/">#q_nav.p_name#</a><br /></cfloop></td>
	    <td width="70%"><h1>#q_getAll.p_name#</h1><p>#q_getAll.p_content#</p></td>
      </tr>
  </table>
</cfoutput>

<cfif #q_getAll.RecordCount# EQ 0>
<h1>Sorry, this page has been moved or deleted</h1>
</cfif>
</body>
</html>