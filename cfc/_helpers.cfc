<cfcomponent displayname="Random Functions" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create_alias_Helpers" returntype="string">
    	
        <cfargument name="alias" type="string" required="yes">
		
		<cfset alias = #Replace(arguments.alias, "'", "&##8217;", "ALL")# >
        <cfset alias = #Replace(arguments.alias, chr(34), "&##34;", "ALL")# > 
        <cfset alias = replaceList(arguments.alias, chr(8216) & "," & chr(8217) & "," & chr(8220) & "," & chr(8221) & "," & chr(8212) & "," & chr(8213) & "," & chr(8230),"',',"","",--,--,...")>
        <cfset alias = #Replace(arguments.alias," ","-","ALL")#>  
        
        <cfreturn alias>
    
    </cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="random_string_Helpers" returntype="string">

		<cfset ststring=structNew()>
        <cfloop index="i" from="1" to="4" step="1">
          <cfset a = randrange(48,122)>
          <cfif (#a# gt 57 and #a# lt 65) or (#a# gt 90 and #a# lt 97)>
            <cfset ststring["#i#"]="E">
          <cfelse>
            <cfset ststring["#i#"]=#chr(a)#>
          </cfif>
        </cfloop>
        
        <cfset random_string ="#ststring[1]##ststring[2]##ststring[3]##ststring[4]#">
        
        <cfreturn random_string>

    </cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="user_ip_address_Helpers" returntype="string">
		
        <cfset real_ipaddress = ''>
		
		<cfif CGI.HTTP_X_Forwarded_For EQ ""><!--- Checking proxy address --->
        	<cfset real_ipaddress = CGI.REMOTE_ADDR>
        <cfelse>
        	<cfset real_ipaddress = CGI.HTTP_X_Forwarded_For>
        </cfif>
        
        <cfreturn real_ipaddress>

    </cffunction>  

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->   
     
</cfcomponent>