<cfcomponent displayname="Users x Groups Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create">

        <cfargument name="user_fk" type="numeric" required="false" default="">
        <cfargument name="group_fk" type="numeric" required="false" default="">
		
			<cftry>
				<cflock name="add_to_table" type="exclusive" timeout="5">
	            	
					<cfquery name="insert" datasource="#request.DSN#" >
	                    INSERT INTO users_x_groups
	                    (user_fk, group_fk)
	                    VALUES
	                    (
	                        <cfqueryparam value = "#arguments.user_fk#" cfsqltype = "cf_sql_numeric">,
	                        <cfqueryparam value = "#arguments.group_fk#" cfsqltype = "cf_sql_numeric">          
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
		 
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">

        <cfargument name="user_fk" type="numeric" required="false" default="0">
        <cfargument name="group_fk" type="numeric" required="false" default="0">
		
        <cftry>
			<cflock name="read" type="readonly" timeout="5">        
               
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT uxg.user_fk, uxg.group_fk, g.g_name
                      FROM users_x_groups uxg
                      JOIN groups g ON g.group_id = uxg.group_fk
                     WHERE 0=0
                     
                     <cfif #arguments.user_fk# neq "0">
                       AND uxg.user_fk = <cfqueryparam value = "#arguments.user_fk#" cfsqltype = "cf_sql_numeric"> 
                     </cfif>
        
                     <cfif #arguments.group_fk# neq "0">
                       AND uxg.group_fk = <cfqueryparam value = "#arguments.group_fk#" cfsqltype = "cf_sql_numeric"> 
                     </cfif>
                                    
                </cfquery>
      
			</cflock>	
				
                <cfcatch type="any">
					
					<cfset result.status = "error_reading">
                    
                    <cfif #request.debug# eq "On">
                        <cfrethrow />
                    </cfif>
                    	
				</cfcatch>
                
		</cftry>
                
        <cfreturn query>
        		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
			    
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="delete">

		<cfargument name="user_fk" type="numeric" required="false" default="">

		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="delete" datasource="#request.DSN#" >
                    DELETE FROM users_x_groups
                     WHERE user_fk = #arguments.user_fk#
				</cfquery> 	
                
			</cflock>	
				<cfcatch type="any">
					
					<cfset result.status = "error_deleting">

                   	<cfif #request.debug# eq "On">
                        <cfrethrow />
                    </cfif>
                    	
				</cfcatch>
		</cftry>
		
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->			

	<cffunction name="html_list_pages_x_links" returntype="any">
    	
	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->    

</cfcomponent>
