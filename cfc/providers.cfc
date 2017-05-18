<cfcomponent displayname="Providers Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="pr_name" type="numeric" required="yes" default="">
        <cfargument name="pr_domain" type="string" required="yes" default="">
        <cfargument name="pr_active" type="string" required="yes" default="1">
                
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "created">       
                 
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" >
                    INSERT INTO providers
                    (pr_name, pr_domain, pr_active)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.pr_name#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.pr_domain#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.pr_active#" cfsqltype = "cf_sql_varchar">
                     );
				</cfquery> 	
                
			</cflock>	
				<cfcatch type="any">
					
					<cfset result.status = "error_creating">
                    
                    <cfif #request.debug# eq "On">
                    	<cfrethrow />	
                    </cfif>
                    
				</cfcatch>
		</cftry>
		
        <cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="provider_id" type="string" required="false" default="">
        <cfargument name="pr_active" type="string" required="false" default="1">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT provider_id, pr_name, pr_domain, pr_active
			  FROM providers
             WHERE 0=0
			 <cfif #arguments.provider_id# neq "">
               AND provider_id = <cfqueryparam value = "#arguments.provider_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
             <cfif #arguments.pr_active# neq "">
               AND pr_active = <cfqueryparam value = "#arguments.pr_active#" cfsqltype = "cf_sql_integer"> 
             </cfif>
             
             ORDER BY pr_name
                           
		</cfquery>
        
		<cfreturn query>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
			
        <cfargument name="pr_name" type="string" required="no" default="">
        <cfargument name="pr_domain" type="string" required="no" default="">
        <cfargument name="pr_active" type="string" required="no" default="1">

		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated">

        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE providers
                       SET pr_name = <cfqueryparam value = "#arguments.pr_name#" cfsqltype = "cf_sql_varchar">,
                           pr_domain = <cfqueryparam value = "#arguments.pr_domain#" cfsqltype = "cf_sql_varchar">,
                           pr_active = <cfqueryparam value = "#arguments.pr_active#" cfsqltype = "cf_sql_varchar">
                     WHERE provider_id = <cfqueryparam value="#arguments.provider_id#" cfsqltype="cf_sql_integer">;
                </cfquery>
                
            </cflock>

            <cfcatch type="any">
            	
				<cfset result.status = "error_updating">
				
				<cfif #request.debug# eq "On">
                	<cfrethrow />	
                </cfif>
    
            </cfcatch>
        </cftry>

		<cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
