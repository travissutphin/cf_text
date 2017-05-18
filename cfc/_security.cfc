<cfcomponent displayname="Security Functions" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="verify_logged_in_Security" returntype="string">
    	
	<!--- if this is not the index page it will verify the user is logged in and if not redirect to the index page --->
    <cfoutput>
		
		<cfif not isDefined('SESSION.Auth.is_logged_in')>
            <cflocation url="#request.siteURL#cms/index.cfm?msg=logged_out" addtoken="no">
        </cfif>

		<cfif isDefined('SESSION.Auth.is_logged_in') and #SESSION.Auth.is_logged_in# neq "Yes">
            <cflocation url="#request.siteURL#cms/index.cfm?msg=logged_out" addtoken="no">
        </cfif>
        
    </cfoutput>
    
    </cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
    
</cfcomponent>