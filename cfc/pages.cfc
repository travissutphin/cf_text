<cfcomponent displayname="Pages Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

		<cfargument name="p_page_type" type="string" required="no" default="Page">
        <cfargument name="p_order" type="numeric" required="no" default="0">
        <cfargument name="p_title" type="string" required="no" default="">
        <cfargument name="p_alias" type="string" required="no" default="">
        <cfargument name="p_image" type="string" required="no" default="">
        <cfargument name="p_template_before" type="numeric" required="no" default="0">
        <cfargument name="p_content" type="string" required="no" default="">
        <cfargument name="p_template_after" type="numeric" required="no" default="0">
        <cfargument name="p_layout_fk" type="numeric" required="no" default="0">
        <cfargument name="p_parent_id" type="string" required="no" default="">
        <cfargument name="p_meta_title" type="string" required="no" default="">
        <cfargument name="p_meta_tags" type="string" required="no" default="">
        <cfargument name="p_meta_description" type="string" required="no" default="">
        <cfargument name="p_blog_post_on" type="string" required="no" default="">
        <cfargument name="p_blog_allow_comments" type="string" required="no" default="">
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
 
		<!--- was image uploaded --->
		<cfif #arguments.p_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="p_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <!--- resize image --->
            <cfif #request.image_manipulator# eq "cfimage">
                    
                <cfimage
                    action = "info"
                    source = "#request.upLoadRoot#assets\images\temp\#image#"
                    structname = "image_size_info">
                
                <cfif #image_size_info.height# gt #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        height = "#request.height_pages#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_pages#"
                        height = "#request.width_pages#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_pages#"
                        height = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
            	</cfif>
            
                <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
            	</cfif>
                
            <cfelseif #request.image_manipulator# eq "jpegresize">
                
                <cfif #cffile.serverFileExt# eq "jpg" or #cffile.serverFileExt# eq "jpeg">
                    
                    <cfx_jpegresize action = "resize"
                           source = "#Request.upLoadRoot#assets\images\temp\#image#"
                           filename = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                           quality = "90"
                           factor = "scale_factor"
                           width = "request.width_pages"
                           height = "request.height_pages">
                    
                    <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                    	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                	</cfif>
                    
                <cfelse>
                    
                    <!--- cfx_jpegresize only works with jpg images --->
                    <cfset result.status = "jpg_only">
                    <cfreturn result>
                    <cfbreak>
                    
                </cfif><!--- // <cfif #cffile.serverFileExt# eq "jpg" or #cffile.serverFileExt# eq "jpeg"> --->
            
            </cfif><!--- // <cfif #request.image_manipulator# eq "cfimage"> --->
            <!--- // resize image --->
        
        <cfelse>
        
        	<cfset save_image = "">
        
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> ---> 
	    
              	
        <!--- clean name and create alias  --->
		<cfif #arguments.p_alias# neq "">
            <cfset alias = #arguments.p_alias#>
        <cfelse>
            <cfset alias = #arguments.p_title#>
        </cfif>
    	
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="create_alias_Helpers" 
            alias = "#alias#"
            returnvariable="result_alias">
		</cfinvoke>
        
        <cfset arguments.p_alias = #result_alias#>
        <!--- end --->
        
        
        <!--- if Latest News : id = -1 : or p_page-type = Blog add current date --->
        <cfif #arguments.p_parent_id# eq "-1">
        	<cfset arguments.p_alias = #result_alias# & '-' & #DateFormat(now(), "yyyy-mm-dd")#>
        <cfelseif #arguments.p_page_type# eq "Blog">
        	<cfset arguments.p_alias = #result_alias# & '-' & #DateFormat(arguments.p_blog_post_on, "yyyy-mm-dd")#>
        </cfif>
        <!--- end --->
               
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" result="insert_result" >
                    INSERT INTO pages
                    (p_page_type, p_order, p_title, p_alias, p_image, p_template_before, p_content, p_template_after, p_layout_fk, 
                     p_parent_id, p_meta_title, p_meta_tags, p_meta_description, <cfif #arguments.p_blog_post_on# neq"">p_blog_post_on,</cfif> p_blog_allow_comments, created_at)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.p_page_type#" cfsqltype = "cf_sql_string">,
                        <cfqueryparam value = "#arguments.p_order#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.p_title#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.p_alias#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.p_template_before#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.p_content#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.p_template_after#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.p_layout_fk#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.p_parent_id#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.p_meta_title#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.p_meta_tags#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.p_meta_description#" cfsqltype = "cf_sql_varchar">,
                        <cfif #arguments.p_blog_post_on# neq "">
                        	<cfqueryparam value = "#arguments.p_blog_post_on#" cfsqltype = "cf_sql_varchar">,
                        </cfif>
                        <cfqueryparam value = "#arguments.p_blog_allow_comments#" cfsqltype = "cf_sql_varchar">,
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

        
        <!--- get last created id --->
        <cfset new_key = #insert_result.GENERATED_KEY#> <!--- MySQL --->
		<!---<cfset new_key = #insert_result.IDENTITYCOL#>---> <!--- MSSQL --->
        
        
		<!--- save the PAGE links --->
		<!--- ------------------- ---> 
		
		<!--- loop over values and insert each --->
		<cfif isDefined('form.link_page_fk')>
		
		<cfoutput>
        	
			<cfloop list="#form.link_page_fk#" index="id" delimiters=",">

				<cfinvoke 
					component = "#request.cfc#.links_x_pages"
					method = "create" 
					page_fk = "#new_key#"
	        		link_page_fk = "#id#" >
				</cfinvoke>
		
			</cfloop>
		
		</cfoutput>
        
		</cfif>
		<!--- ----------------- --->


		<!--- save BLOG categories --->
		<!--- loop over values and insert each --->
		<cfif isDefined('form.blog_category_fk')>
		
		<cfoutput>
        	
			<cfloop list="#form.blog_category_fk#" index="id" delimiters=",">

				<cfinvoke 
					component = "#request.cfc#.page_x_blog_categories"
					method = "create" 
					page_fk = "#new_key#"
	        		blog_category_fk = "#id#" >
				</cfinvoke>
		
			</cfloop>
		
		</cfoutput>
        
		</cfif>
		<!--- ----------------- --->
        
                
        		
        <cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">

        <cfargument name="page_id" type="string" required="false" default="">
        <cfargument name="p_page_type" type="string" required="false" default="">
        <cfargument name="p_alias" type="string" required="false" default="">
        <cfargument name="p_parent_id" type="string" required="false" default="">
        <cfargument name="not_p_parent_id" type="any" required="false" default="0">
        <cfargument name="max_rows" type="any" required="false" default="9999">

		<cftry>
			<cflock name="read" type="readonly" timeout="5">
            
            <cfquery name="query" datasource="#request.DSN#" maxrows="#arguments.max_rows#">
                SELECT page_id, p_page_type, p_order, p_title, p_alias, p_image, p_template_before, p_content, 
                p_template_after, p_layout_fk, p_parent_id, 
                p_meta_title, p_meta_tags, p_meta_description, p_blog_post_on, p_blog_allow_comments, 
                created_at, updated_at, deleted_at
                  FROM pages
                 WHERE 0=0
                 
                 <cfif #arguments.p_page_type# neq "">
                   AND p_page_type = <cfqueryparam value = "#arguments.p_page_type#" cfsqltype = "cf_sql_string"> 
                 </cfif>
                 
                 <cfif #arguments.page_id# neq "">
                   AND page_id = <cfqueryparam value = "#arguments.page_id#" cfsqltype = "cf_sql_integer"> 
                 </cfif>
    
                 <cfif #arguments.p_alias# neq "">
                   AND p_alias = <cfqueryparam value = "#arguments.p_alias#" cfsqltype = "cf_sql_varchar"> 
                 </cfif>
     
                 <cfif #arguments.p_parent_id# neq "">
                   AND p_parent_id = <cfqueryparam value = "#arguments.p_parent_id#" cfsqltype = "cf_sql_integer">  
                 </cfif>
    
                 <cfif #arguments.not_p_parent_id# neq "0">
                        AND p_parent_id <> <cfqueryparam value = "0" cfsqltype = "cf_sql_numeric">  
                        AND p_parent_id <> <cfqueryparam value = "-2" cfsqltype = "cf_sql_numeric">              
                 </cfif>
                 
                 AND deleted_at IS NULL
                 
                 <!--- -1 is latest News or p_page_type = Blog --->
                 <cfif #arguments.p_page_type# eq "Blog">
                    ORDER BY p_blog_post_on DESC
                 <cfelseif #arguments.p_parent_id# eq "0">
                 	ORDER BY p_order, p_title
				 <cfelseif #arguments.p_parent_id# neq "-1">
                 	ORDER BY created_at, p_order, p_title
                 <cfelse>
                    ORDER BY p_order, p_title
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
		
        <cfargument name="p_order" type="numeric" required="no">
        <cfargument name="p_title" type="string" required="no">
        <cfargument name="p_alias" type="string" required="no">
        <cfargument name="p_image" type="string" required="no">
        <cfargument name="p_template_before" type="numeric" required="no" default="0">
        <cfargument name="p_content" type="string" required="no" default="">
        <cfargument name="p_template_after" type="numeric" required="no" default="0">
        <cfargument name="p_layout_fk" type="numeric" required="no">
        <cfargument name="p_parent_id" type="string" required="no" default="">
        <cfargument name="p_meta_title" type="string" required="no">
        <cfargument name="p_meta_tags" type="string" required="no">
        <cfargument name="p_meta_description" type="string" required="no">
        <cfargument name="p_blog_post_on" type="string" required="no" default="">
        <cfargument name="p_blog_allow_comments" type="string" required="no" default="">
        <cfargument name="updated_at" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">

        <!--- random string for naming images --->
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="random_string_Helpers" 
            returnvariable="string_is">
        </cfinvoke>
                    
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated">


		<!--- was image uploaded --->
		<cfif #arguments.p_image# neq "">
            
			<!--- upload the image --->
            <cffile action="upload" filefield="p_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <!--- resize image --->
            <cfif #request.image_manipulator# eq "cfimage">
                    
                <cfimage
                    action = "info"
                    source = "#request.upLoadRoot#assets\images\temp\#image#"
                    structname = "image_size_info">
                
                <cfif #image_size_info.height# gt #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        height = "#request.height_pages#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_pages#"
                        height = "#request.width_pages#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_pages#"
                        height = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
            	</cfif> 
            
                <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                </cfif>
                
                <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_p_image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_p_image#">
            	</cfif>
                
            <cfelseif #request.image_manipulator# eq "jpegresize">
                
                <cfif #cffile.serverFileExt# eq "jpg" or #cffile.serverFileExt# eq "jpeg">
                    
                    <cfx_jpegresize action = "resize"
                           source = "#Request.upLoadRoot#assets\images\temp\#image#"
                           filename = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                           quality = "90"
                           factor = "scale_factor"
                           width = "request.width_pages"
                           height = "request.height_pages">
					
                    <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
	                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                    </cfif>
                    
                    <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_p_image#")>
		                <cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_p_image#">
                	</cfif>
                    
                <cfelse>
                    
                    <!--- cfx_jpegresize only works with jpg images --->
                    <cfset result.status = "jpg_only">
                    <cfreturn result>
                    <cfbreak>
                    
                </cfif><!--- // <cfif #cffile.serverFileExt# eq "jpg" or #cffile.serverFileExt# eq "jpeg"> --->
            
            </cfif><!--- // <cfif #request.image_manipulator# eq "cfimage"> --->
            <!--- // resize image --->
        
        <cfelse>
        
        	<cfset save_image = #arguments.org_x_p_image# >
        
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->

	    
        <!--- clean name and create alias  --->
		<cfif #arguments.p_alias# neq "">
            <cfset alias = #arguments.p_alias#>
        <cfelse>
        	<cfset alias_is_blank = true>
            <cfset alias = #arguments.p_title#>
        </cfif>
    	
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="create_alias_Helpers" 
            alias = "#alias#"
            returnvariable="result_alias">
		</cfinvoke>
        
        <cfset arguments.p_alias = #result_alias#>
        <!--- end --->


        <!--- if Latest News : id = -1 : or p_page-type = Blog add current date --->
        <cfif isDefined('alias_is_blank')><!--- alias was submitted balnk so we need to add the date at the end if... --->
			<cfif #arguments.p_parent_id# eq "-1">
                <cfset arguments.p_alias = #result_alias# & '-' & #DateFormat(now(), "yyyy-mm-dd")#>
            <cfelseif #arguments.p_page_type# eq "Blog">
                <cfset arguments.p_alias = #result_alias# & '-' & #DateFormat(arguments.p_blog_post_on, "yyyy-mm-dd")#>
            </cfif>
        </cfif>
        <!--- end --->
                        			
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE pages
                       SET                       
                        	p_title = <cfqueryparam value = "#arguments.p_title#" cfsqltype = "cf_sql_varchar">,
                            p_alias = <cfqueryparam value = "#arguments.p_alias#" cfsqltype = "cf_sql_varchar">,
                            p_image = <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
                            p_template_before = <cfqueryparam value = "#arguments.p_template_before#" cfsqltype = "cf_sql_integer">,
                            p_content = <cfqueryparam value = "#arguments.p_content#" cfsqltype = "cf_sql_varchar">,
                            p_template_after = <cfqueryparam value = "#arguments.p_template_after#" cfsqltype = "cf_sql_integer">,
                            p_layout_fk = <cfqueryparam value = "#arguments.p_layout_fk#" cfsqltype = "cf_sql_integer">,
                            p_parent_id = <cfqueryparam value = "#arguments.p_parent_id#" cfsqltype = "cf_sql_varchar">,
                            p_meta_title = <cfqueryparam value = "#arguments.p_meta_title#" cfsqltype = "cf_sql_varchar">,
                            p_meta_tags = <cfqueryparam value = "#arguments.p_meta_tags#" cfsqltype = "cf_sql_varchar">,
                            p_meta_description = <cfqueryparam value = "#arguments.p_meta_description#" cfsqltype = "cf_sql_varchar">,
                            <cfif #arguments.p_blog_post_on# neq "">
                            p_blog_post_on = <cfqueryparam value = "#arguments.p_blog_post_on#" cfsqltype = "cf_sql_varchar">,
                            </cfif>
                            p_blog_allow_comments = <cfqueryparam value = "#arguments.p_blog_allow_comments#" cfsqltype = "cf_sql_varchar">,
                            updated_at = <cfqueryparam value = "#arguments.updated_at#" cfsqltype = "cf_sql_varchar">  			
                     WHERE 	page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer">;
                </cfquery>
                
            </cflock>

            <cfcatch type="any">
            	
				<cfset result.status = "error_updating">
                
				<cfif #request.debug# eq "On">
                	<cfrethrow />
                </cfif>
    
            </cfcatch>
        </cftry>

		
		<!--- save the page links --->
		<!--- ------------------- ---> 
		
		<cfoutput>
		
		<!--- delete the old references --->
		<cfinvoke 
			component="#request.cfc#.links_x_pages"
			method="delete" 
			page_fk="#arguments.page_id#">
		</cfinvoke>
		
		<!--- loop over values and insert each --->
		<cfif isDefined('form.link_page_fk')>
			
			<cfloop list="#form.link_page_fk#" index="id" delimiters=",">

				<cfinvoke 
					component = "#request.cfc#.links_x_pages"
					method = "create" 
					page_fk = "#arguments.page_id#"
	        		link_page_fk = "#id#" >
				</cfinvoke>
		
			</cfloop>

		</cfif>
		
		</cfoutput>
		<!--- ----------------- --->


		<!--- save the blog categories --->
		<!--- ------------------------ ---> 
		
		<!--- delete the old references --->
		<cfinvoke 
			component="#request.cfc#.page_x_blog_categories"
			method="delete" 
			page_fk="#arguments.page_id#">
		</cfinvoke>

        
		<!--- loop over values and insert each --->
		<cfif isDefined('form.blog_category_fk')>
		
		<cfoutput>
        	
			<cfloop list="#form.blog_category_fk#" index="id" delimiters=",">

				<cfinvoke 
					component = "#request.cfc#.page_x_blog_categories"
					method = "create" 
					page_fk = "#arguments.page_id#"
	        		blog_category_fk = "#id#" >
				</cfinvoke>
		
			</cfloop>
		
		</cfoutput>
        
		</cfif>
		<!--- ----------------- --->

		<cfreturn result>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update_ordering" returntype="struct">

        <cfargument name="page_id" type="string" required="yes" >
        <cfargument name="p_order" type="string" required="yes" >

		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated_ordering">

		<cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE pages
                       SET p_order = <cfqueryparam value = "#arguments.p_order#" cfsqltype = "cf_sql_integer"> 			
                     WHERE page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer">;
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
		
        <cfargument name="page_id" type="string" required="yes" >
        <cfargument name="deleted_at" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">
        				
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    UPDATE pages
                       SET  deleted_at = <cfqueryparam value = "#arguments.deleted_at#" cfsqltype="cf_sql_varchar">
                     WHERE  page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer"> 
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

	<cffunction name="html_list_customers_main_navigation" returntype="any">

        <cfargument name="p_page_id" type="string" required="no" default="" >
        <cfargument name="p_parent_id" type="string" required="no" default="" >
        
		<!--- -1 are the Latest News Items --->
        <cfif #arguments.p_parent_id# eq "-1">
          <cfset news_selected = "selected">
        <cfelse>
          <cfset news_selected = "">
        </cfif>

 		<!--- -3 are the Landing Page Items --->
        <cfif #arguments.p_parent_id# eq "-3">
          <cfset landing_page_selected = "selected">
        <cfelse>
          <cfset landing_page_selected = "">
        </cfif>
        
		<cfoutput>
        <select name="p_parent_id" class="form-control">
            <option value="-1" #news_selected#>Latest News Item</option> <!--- not in main menu --->
            <option value="-3" #landing_page_selected#>Landing Page</option> <!--- not in main menu --->
        </select>
        </cfoutput>

	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->				

	<cffunction name="delete_image" returntype="struct">
		
        <cfargument name="page_id" type="string" required="yes" >
        <cfargument name="delete_image" type="string" required="yes" >
        				
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    UPDATE pages
                       SET  p_image = ''
                     WHERE  page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer"> 
				</cfquery> 
                	
			</cflock>	
				<cfcatch type="any">
					<cfset result.status = "error_deleting">
				</cfcatch>
		</cftry>	
		
         <!--- delete the image --->
        <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.delete_image#")>
        	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.delete_image#">	
		</cfif>
        
        <cfreturn result>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
    
    	<cffunction name="html_list_main_navigation" returntype="any">
    	
        <cfargument name="p_page_id" type="string" required="no" default="" >
        <cfargument name="p_parent_id" type="string" required="no" default="" >
        
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            p_parent_id = '0'
            p_page_type = 'Page'
            returnvariable="records_parent_Pages">
        </cfinvoke>
	  
		<!--- -1 are the Latest News Items --->
        <cfif #arguments.p_parent_id# eq "-1">
          <cfset news_selected = "selected">
        <cfelse>
          <cfset news_selected = "">
        </cfif>
 
 		<!--- -2 are the Section Text Items --->
        <cfif #arguments.p_parent_id# eq "-2">
          <cfset section_text_selected = "selected">
        <cfelse>
          <cfset section_text_selected = "">
        </cfif>

 		<!--- -3 are the Landing Page Items --->
        <cfif #arguments.p_parent_id# eq "-3">
          <cfset landing_page_selected = "selected">
        <cfelse>
          <cfset landing_page_selected = "">
        </cfif>

        	  	
		<cfoutput>
        <select name="p_parent_id" class="form-control">
			<option value="0">Main Content Page</option>
            <option value="-1" #news_selected#>Latest News Item</option> <!--- not in main menu --->
            <option value="-2" #section_text_selected#>Section Text Item</option> <!--- not in main menu --->
            <option value="-3" #landing_page_selected#>Landing Page</option> <!--- not in main menu --->
             <cfloop query="records_parent_Pages">
              
              <cfif #records_parent_Pages.page_id# eq #arguments.p_parent_id#>
                  <cfset selected = "selected" >
              <cfelse>
                  <cfset selected = "">
              </cfif>
              
              <option value="#records_parent_Pages.page_id#" #selected#>#records_parent_Pages.p_title#</option>
              
			</cfloop>
        </select>
        </cfoutput>

	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->    
 
 	<cffunction name="html_checkbox_pages" returntype="any">
    	
        <cfargument name="page_id" type="numeric" required="no" default="0" >
        <cfargument name="bio_id" type="numeric" required="no" default="0" >
        
        <cfset checked = ""><!-- set a default -->
        
        <!--- set the types of pages you do not want the user to be able to select --->
		<!--- FUTURE USE --->
		<cfset neq_ids = ArrayNew(1)>
		<!---<cfset ArrayAppend(neq_ids, "0")>
		<cfset ArrayAppend(neq_ids, "-2")>--->

        <!--- specific parent ids you do not want user to select --->
        <!--- 0 = allow all and anything will run code in the "read" function --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            not_p_parent_id="0"
            p_page_type = 'Page'
            returnvariable="records_pages">
        </cfinvoke>
		
            <cfoutput query="records_pages">
               	
               	<!---check for links x pages --->
               	<cfif #arguments.page_id# neq 0>
	               	<cfinvoke 
						component="#request.cfc#.links_x_pages"
			    		method="read"
			    		page_fk = #arguments.page_id#
			    		link_page_fk = #records_pages.page_id#
			    		returnvariable="records_links">
					</cfinvoke>
			      
					<cfif #records_links.recordcount# gt 0 and #arguments.page_id# neq 0>
		            	<cfset checked = "checked">
		            <cfelse>
		            	<cfset checked = "">
		            </cfif>
	            </cfif>
 				
 				<!---check for links x bios --->
                <cfif #arguments.bio_id# neq 0>
	               	<cfinvoke 
						component="#request.cfc#.links_x_bios"
			    		method="read"
			    		bio_fk = #arguments.bio_id#
			    		link_page_fk = #records_pages.page_id#
			    		returnvariable="records_links">
					</cfinvoke>
			      
					<cfif #records_links.recordcount# gt 0 and #arguments.bio_id# neq 0>
		            	<cfset checked = "checked">
		            <cfelse>
		            	<cfset checked = "">
		            </cfif>
	            </cfif>
	                         
				<div class="col-md-6">
	            	<input type="checkbox" name="link_page_fk" value="#records_pages.page_id#" #checked#> #records_pages.p_title#
	            </div>
              
			</cfoutput>

	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ---> 
           
	<cffunction name="login" returntype="any">

        <cfargument name="a_pswd" type="string" required="yes" >
        <cfargument name="a_email" type="string" required="yes" >
        							
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "login_success">

		<cfinvoke 
			component="#request.cfc#.admin"
			method="read" 
            a_pswd = "#arguments.a_pswd#"
            a_email = "#arguments.a_email#"
			returnvariable="result">
		</cfinvoke>
	
    	<cfoutput>
        	
			<cfif #result.recordcount# eq 1>
				<cfset SESSION.Auth = StructNew()>
                <cfset SESSION.Auth.is_logged_in = "Yes">
                <cfset SESSION.Auth.id = #result.admin_id#>
                <cfset SESSION.Auth.a_name = #result.a_name#>
                <cfset SESSION.Auth.a_email = #result.a_email#>
                <cfset SESSION.Auth.a_priv = #result.a_priv#>
                <cfset SESSION.Auth.a_active = #result.a_active#>
                <cflocation url="control_panel.cfm" addtoken="no">		
            <cfelse>
            	<cflocation url="index.cfm?msg=invalid_credentials" addtoken="no">
            </cfif>
            
		</cfoutput>
        
        <cfreturn result>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
</cfcomponent>