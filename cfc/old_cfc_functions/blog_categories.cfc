<cfcomponent displayname="Blog Categories Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="bc_category" type="string" required="no" default="0">
                
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "created">       
       
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" >
                    INSERT INTO blog_categories
                    (bc_category)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.bc_category#" cfsqltype = "cf_sql_varchar">       
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
		
        <cfargument name="blog_category_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT blog_category_id, bc_category
			  FROM blog_categories
             WHERE 0=0
			 <cfif #arguments.blog_category_id# neq "">
               AND blog_category_id = <cfqueryparam value = "#arguments.blog_category_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
             
             ORDER BY bc_category
                           
		</cfquery>
        
		<cfreturn query>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
			
        <cfargument name="blog_category_id" type="string" required="no" default="">
        
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated">
                			
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE blog_categories
                       SET bc_category = <cfqueryparam value = "#arguments.bc_category#" cfsqltype = "cf_sql_varchar">
                       WHERE blog_category_id = <cfqueryparam value = "#arguments.blog_category_id#" cfsqltype = "cf_sql_varchar">;
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
        
        <cfargument name="blog_category_id" type="string" required="yes" >
		
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">
        
		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <!---
                <cfquery datasource="#request.DSN#">
                    DELETE 
                      FROM blog_categories
                     WHERE blog_category_id = <cfqueryparam value="#arguments.blog_category_id#" cfsqltype="cf_sql_integer"> 
				</cfquery> 
               	--->
                
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

 	<cffunction name="html_checkbox_blog_categories" returntype="any">
    	
        <cfargument name="page_id" type="numeric" required="no" default="0" >

        <cfset checked = ""><!-- set a default -->

        <cfinvoke 
            component="#request.cfc#.blog_categories"
            method="read"
            returnvariable="records_blog_categories">
        </cfinvoke>
		
            <cfoutput query="records_blog_categories">
          	
                 <cfinvoke 
            		component="#request.cfc#.page_x_blog_categories"
            		method="read"
                    page_fk = "#arguments.page_id#"
                    blog_category_fk = "#records_blog_categories.blog_category_id#"
            		returnvariable="number_page_x_blog_categories">
        		</cfinvoke>


                <cfif #number_page_x_blog_categories.recordcount# gt 0 and #arguments.page_id# neq 0>
                	<cfset checked = "checked">
                <cfelse>
                	<cfset checked = "">
                </cfif>
                
				<div class="col-md-6">
	            	<input type="checkbox" name="blog_category_fk" value="#records_blog_categories.blog_category_id#" #checked#> #records_blog_categories.bc_category#
	            </div>
                
			</cfoutput>

	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ---> 

</cfcomponent>
