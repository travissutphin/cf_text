<!--- Checks to verify the person logged in has Admin rights. This is cfinluded in all /admin files --->
<cfparam name="SESSION.Auth.IsLoggedIn" default="NO">
<cfif (SESSION.Auth.IsLoggedIn) NEQ "YES">
	<cflocation url="#request.siteURL#admin/index.cfm?error=not_logged_in" addtoken="no">
</cfif>
<cfif (SESSION.Auth.a_active) EQ "0">
	<cflocation url="#request.siteURL#admin/index.cfm?error=acct_not_active" addtoken="no">
</cfif>