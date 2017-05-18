<cfcomponent displayname="Groups Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="user_fk" type="string" required="yes" default="">
        <cfargument name="gr_name" type="string" required="yes" default="">
        <cfargument name="gr_access_key" type="string" required="yes" default="">
        <cfargument name="created_at" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">

        <!--- random string for naming images --->
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="random_string_Helpers" 
            returnvariable="string_is">
        </cfinvoke>
                
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "created">        
                 
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" result="insert_Result" >
                    INSERT INTO groups
                    (user_fk, gr_name, gr_access_key, created_at)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.user_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.gr_name#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.gr_access_key#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.created_at#" cfsqltype = "cf_sql_varchar">        
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
		
        <cfargument name="user_fk" type="string" required="false" default="">
        <cfargument name="gr_name" type="string" required="false" default="">
        <cfargument name="gr_access_key" type="string" required="false" default="">

		<cftry>
			<cflock name="read" type="readonly" timeout="5">        
                
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT user_fk, gr_name, gr_access_key, created_at, deleted_at
                      FROM groups
                     WHERE 0=0
                     <cfif #arguments.user_fk# neq "">
                       AND user_fk = <cfqueryparam value = "#arguments.user_fk#" cfsqltype = "cf_sql_integer"> 
                     </cfif>
        
                     <cfif #arguments.gr_name# neq "">
                       AND gr_name = <cfqueryparam value = "#arguments.gr_name#" cfsqltype = "cf_sql_varchar"> 
                     </cfif>
                     
                     <cfif #arguments.gr_access_key# neq "">
                       AND gr_access_key = <cfqueryparam value = "#arguments.gr_access_key#" cfsqltype = "cf_sql_varchar"> 
                     </cfif>
                     
                     AND deleted_at IS NULL
                                   
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
			
        <cfargument name="user_fk" type="string" required="yes" default="">
        <cfargument name="gr_name" type="string" required="yes" default="">
        <cfargument name="gr_access_key" type="string" required="yes" default="">
 
         <!--- random string for naming images --->
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="random_string_Helpers" 
            returnvariable="string_is">
        </cfinvoke>
                   
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated">
 
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE groups
                       SET gr_name = <cfqueryparam value = "#arguments.gr_name#" cfsqltype = "cf_sql_integer">,
                           gr_access_key = <cfqueryparam value = "#arguments.gr_access_key#" cfsqltype = "cf_sql_varchar">		
                     WHERE group_id = <cfqueryparam value="#arguments.group_id#" cfsqltype="cf_sql_integer">;
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

	<cffunction name="delete" returntype="struct">
		
        <cfargument name="group_id" type="string" required="yes" >
        <cfargument name="user_fk" type="string" required="yes" >
        <cfargument name="deleted_at" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">
        				
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    UPDATE groups
                       SET deleted_at = <cfqueryparam value = "#arguments.deleted_at#" cfsqltype="cf_sql_varchar">
                     WHERE group_id = <cfqueryparam value="#arguments.group_id#" cfsqltype="cf_sql_integer"> 
                       AND user_fk = <cfqueryparam value="#arguments.user_fk#" cfsqltype="cf_sql_integer"> 
				</cfquery> 
                	
			</cflock>	
            <cfcatch type="any">

                <cfset result.status = "error_deleting">

                <cfif #request.debug# eq "On">
                    <cfrethrow />	
                </cfif>
            
            </cfcatch>
		</cftry>	
		
        <cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->			

	<cffunction name="html_list_group" returntype="any">
    	
        <cfargument name="group_id" type="string" required="no" default="" >
        
        <cfinvoke 
            component="#request.cfc#.groups"
            method="read"
            returnvariable="records_Groups">
        </cfinvoke>
	  	
		<cfoutput>
        <select name="group_fk" class="form-control">
			<option value="0">Select</option>

             <cfloop query="records_Groups">
              
              <cfif #records_Groups.group_id# eq #arguments.group_id#>
                  <cfset selected = "selected" >
              <cfelse>
                  <cfset selected = "">
              </cfif>
              
              <option value="#records_Groups.group_id#" #selected#>#records_Groups.gr_name# #records_Groups.gr_access_key#</option>
              
			</cfloop>
        </select>
        </cfoutput>

	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->    

</cfcomponent>
