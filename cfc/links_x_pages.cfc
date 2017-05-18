<cfcomponent displayname="Links x Pages Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create">

        <cfargument name="page_fk" type="numeric" required="false" default="">
        <cfargument name="link_page_fk" type="numeric" required="false" default="">

			<cftry>
				<cflock name="add_to_table" type="exclusive" timeout="5">
	            	
					<cfquery name="insert" datasource="#request.DSN#" >
	                    INSERT INTO links_x_pages
	                    (page_fk, link_page_fk)
	                    VALUES
	                    (
	                        <cfqueryparam value = "#arguments.page_fk#" cfsqltype = "cf_sql_numeric">,
	                        <cfqueryparam value = "#arguments.link_page_fk#" cfsqltype = "cf_sql_numeric">          
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

        <cfargument name="page_fk" type="numeric" required="false" default="0">
        <cfargument name="link_page_fk" type="numeric" required="false" default="0">

		<cftry>
			<cflock name="read" type="readonly" timeout="5">        
                
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT lxp.link_x_page_id, lxp.page_fk, lxp.link_page_fk, p.p_title
                      FROM links_x_pages lxp
                      JOIN pages p ON p.page_id = lxp.page_fk
                     WHERE 0=0
                     
                     <cfif #arguments.page_fk# neq "0">
                       AND lxp.page_fk = <cfqueryparam value = "#arguments.page_fk#" cfsqltype = "cf_sql_numeric"> 
                     </cfif>
        
                     <cfif #arguments.link_page_fk# neq "0">
                       AND lxp.link_page_fk = <cfqueryparam value = "#arguments.link_page_fk#" cfsqltype = "cf_sql_numeric"> 
                     </cfif>
                     
                     ORDER BY p.p_order
                                    
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

		<cfargument name="page_fk" type="numeric" required="false" default="">

		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="delete" datasource="#request.DSN#" >
                    DELETE FROM links_x_pages
                     WHERE page_fk = #arguments.page_fk#
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
