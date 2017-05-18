<cfcomponent displayname="Links x Bios Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create">

        <cfargument name="bio_fk" type="numeric" required="false" default="">
        <cfargument name="link_page_fk" type="numeric" required="false" default="">
		
			<cftry>
				<cflock name="add_to_table" type="exclusive" timeout="5">
	            	
					<cfquery name="insert" datasource="#request.DSN#" >
	                    INSERT INTO links_x_bios
	                    (bio_fk, link_page_fk)
	                    VALUES
	                    (
	                        <cfqueryparam value = "#arguments.bio_fk#" cfsqltype = "cf_sql_numeric">,
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

        <cfargument name="bio_fk" type="numeric" required="false" default="0">
        <cfargument name="link_page_fk" type="numeric" required="false" default="0">
		
        <cftry>
			<cflock name="read" type="readonly" timeout="5">        
               
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT link_x_bio_id, bio_fk, link_page_fk
                      FROM links_x_bios lxb
                      JOIN pages p ON p.page_id = lxb.link_page_fk
                     WHERE 0=0
                     
                     <cfif #arguments.bio_fk# neq "0">
                       AND lxb.bio_fk = <cfqueryparam value = "#arguments.bio_fk#" cfsqltype = "cf_sql_numeric"> 
                     </cfif>
        
                     <cfif #arguments.link_page_fk# neq "0">
                       AND lxb.link_page_fk = <cfqueryparam value = "#arguments.link_page_fk#" cfsqltype = "cf_sql_numeric"> 
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

		<cfargument name="bio_fk" type="numeric" required="false" default="">

		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="delete" datasource="#request.DSN#" >
                    DELETE FROM links_x_bios
                     WHERE bio_fk = #arguments.bio_fk#
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
