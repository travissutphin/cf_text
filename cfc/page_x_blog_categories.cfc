<cfcomponent displayname="Blog Posts x Blog Categories Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create">

        <cfargument name="page_fk" type="numeric" required="false" default="">
        <cfargument name="blog_category_fk" type="numeric" required="false" default="">
		
			<cftry>
				<cflock name="add_to_table" type="exclusive" timeout="5">
	            	
					<cfquery name="insert" datasource="#request.DSN#" >
	                    INSERT INTO page_x_blog_categories
	                    (page_fk, blog_category_fk)
	                    VALUES
	                    (
	                        <cfqueryparam value = "#arguments.page_fk#" cfsqltype = "cf_sql_numeric">,
	                        <cfqueryparam value = "#arguments.blog_category_fk#" cfsqltype = "cf_sql_numeric">          
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

        <cfargument name="page_fk" type="numeric" required="true" >
        <cfargument name="blog_category_fk" type="numeric" required="true" >
		
        <cftry>
			<cflock name="read" type="readonly" timeout="5">        
               
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT page_x_blog_category_id, page_fk, blog_category_fk
                      FROM page_x_blog_categories bxbc
                      JOIN pages p ON p.page_id = bxbc.page_fk
                     WHERE 0=0
                     
                     <cfif #arguments.page_fk# neq "0">
                       AND bxbc.page_fk = <cfqueryparam value = "#arguments.page_fk#" cfsqltype = "cf_sql_numeric"> 
                     </cfif>
        
                     <cfif #arguments.blog_category_fk# neq "0">
                       AND bxbc.blog_category_fk = <cfqueryparam value = "#arguments.blog_category_fk#" cfsqltype = "cf_sql_numeric"> 
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

		<cfargument name="page_fk" type="numeric" required="false" default="">

		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="delete" datasource="#request.DSN#" >
                    DELETE FROM page_x_blog_categories
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
