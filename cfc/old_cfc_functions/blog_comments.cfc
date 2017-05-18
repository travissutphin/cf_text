<cfcomponent displayname="Blog Comments Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="blog_post_fk" type="numeric" required="yes">
        <cfargument name="bcom_name" type="string" required="no" default="">
        <cfargument name="bcom_comment" type="string" required="no" default="">
        <cfargument name="bcom_ip_address" type="string" required="yes">
        <cfargument name="bcom_date_added" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd HH:mm:ss")#">
                
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "created">       
		
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="user_ip_address_Helpers" 
            returnvariable="result_ip_address">
        </cfinvoke>

       
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" >
                    INSERT INTO blog_comments
                    (blog_post_fk, bcom_name, bcom_comment, bcom_ip_address, bcom_date_added)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.blog_post_fk#" cfsqltype = "cf_sql_numeric">,
                        <cfqueryparam value = "#arguments.bcom_name#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bcom_comment#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#result_ip_address#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bcom_date_added#" cfsqltype = "cf_sql_varchar">      
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
		
        <cfargument name="blog_blog_fk" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT blog_comment_id, blog_post_fk, bcom_name, bcom_comment, bcom_ip_address, bcom_date_added
			  FROM blog_comments
             WHERE 0=0
			 <cfif #arguments.blog_post_fk# neq "">
               AND blog_post_fk = <cfqueryparam value = "#arguments.blog_post_fk#" cfsqltype = "cf_sql_integer"> 
             </cfif>
             
             ORDER BY bcom_date_added DESC
                           
		</cfquery>
        
		<cfreturn query>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="join_blog_posts_x_blog_comments" returntype="query">
		        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT bcom.blog_post_fk, bcom.bcom_name, bcom.bcom_comment, bcom.bcom_ip_address, bcom.bcom_date_added, bp.bp_order, bp.bp_title, bp.bp_post_on, bp.bp_allow_comments, bp.bp_alias, bp.bp_image, bp.bp_template_before, bp.bp_content, bp.bp_template_after, bp.p_layout_fk, bp.bp_meta_title, bp.bp_meta_tags, bp.bp_meta_description, bp.created_at
			 FROM blog_comments bcom
             JOIN blog_posts bp ON bp.blog_post_id = bcom.blog_post_fk            
             ORDER BY bcom_blog_post_fk, bcom_date_added
                           
		</cfquery>
        
		<cfreturn query>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
			
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->			

	<cffunction name="delete" returntype="struct">
        
        <cfargument name="blog_comment_id" type="string" required="no" default="" >
       	<cfargument name="bcom_ip_address" type="string" required="no" default="" >
		
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">
        
        <cfif #arguments.blog_comment_id# neq "" or #arguments.bcom_ip_address# neq "">
            <cftry>
                <cflock name="delete_to_table" type="exclusive" timeout="5">	
                    
                    <cfif #arguments.blog_comment_id# neq "">
                        <cfquery datasource="#request.DSN#">
                            DELETE 
                              FROM blog_comments
                             WHERE blog_comment_id = <cfqueryparam value="#arguments.blog_comment_id#" cfsqltype="cf_sql_integer"> 
                        </cfquery> 
                    </cfif>
    
                    <cfif #arguments.bcom_ip_address# neq "">
                        <cfquery datasource="#request.DSN#">
                            DELETE 
                              FROM blog_comments
                             WHERE bcom_ip_address = <cfqueryparam value="#arguments.bcom_ip_address#" cfsqltype="cf_sql_varchar"> 
                        </cfquery> 
                    </cfif>
                    
                </cflock>	
                    <cfcatch type="any">
                        
                        <cfset result.status = "error_deleting">
    
                        <cfif #request.debug# eq "On">
                            <cfrethrow />	
                        </cfif>
                    
                    </cfcatch>
            </cftry>
        </cfif>
        <cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
