<cfcomponent displayname="Roles Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="role_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT role_id, r_name
			  FROM roles
             WHERE 0=0
			 <cfif #arguments.role_id# neq "">
               AND role_id = <cfqueryparam value = "#arguments.role_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
                           
		</cfquery>
        
		<cfreturn query>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="delete" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
