<cfcomponent displayname="Blog Post Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="bp_order" type="numeric" required="no" default="0">
        <cfargument name="bp_title" type="string" required="no" default="">
        <cfargument name="bp_post_on" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">
        <cfargument name="bp_allow_comments" type="string" required="no" default="No">
        <cfargument name="bp_alias" type="string" required="no" default="">
        <cfargument name="bp_image" type="string" required="no" default="">
        <cfargument name="bp_template_before" type="numeric" required="no" default="0">
        <cfargument name="bp_content" type="string" required="no" default="">
        <cfargument name="bp_template_after" type="numeric" required="no" default="0">
        <cfargument name="p_layout_fk" type="numeric" required="no" default="0">
        <cfargument name="bp_meta_title" type="string" required="no" default="">
        <cfargument name="bp_meta_tags" type="string" required="no" default="">
        <cfargument name="bp_meta_description" type="string" required="no" default="">
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
		<cfif #arguments.bp_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="bp_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <!--- resize image --->
            <cfif #request.image_manipulator# eq "cfimage">
                    
                <cfimage
                    action = "resize"
                    width = "#request.width_blog_posts#"
                    height = "#request.height_blog_posts#"
                    source = "#Request.upLoadRoot#assets\images\temp\#image#"
                    destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
            
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
                           width = "request.width_blog_posts"
                           height = "request.height_blog_posts">
                    
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
		<cfif #arguments.bp_alias# neq "">
            <cfset alias = #arguments.bp_alias#>
        <cfelse>
            <cfset alias = #arguments.bp_title#>
        </cfif>
    	
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="create_alias_Helpers" 
            alias = "#alias#"
            returnvariable="result_alias">
		</cfinvoke>
        
        <cfset arguments.bp_alias = #result_alias#>
        <!--- end --->

        <!--- add current date to end of alias --->
		<cfset arguments.bp_alias = #result_alias# & '-' & #DateFormat(arguments.bp_post_on, "yyyy-mm-dd")#>

		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" result="insert_result" >
                    INSERT INTO blog_posts
                    (bp_order, bp_title, bp_post_on, bp_allow_comments, bp_alias, bp_image, bp_template_before, bp_content, bp_template_after, p_layout_fk, 
                     bp_meta_title, bp_meta_tags, bp_meta_description, created_at)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.bp_order#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.bp_title#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bp_post_on#" cfsqltype = "cf_sql_date">,
                        <cfqueryparam value = "#arguments.bp_allow_comments#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bp_alias#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bp_template_before#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.bp_content#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bp_template_after#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.p_layout_fk#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.bp_meta_title#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bp_meta_tags#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bp_meta_description#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.created_at#" cfsqltype = "cf_sql_date">           
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
        <cfset new_key = #insert_result.IDENTITYCOL#>
        
		<!--- save the page links --->
		<!--- ------------------- ---> 
		
		<!--- loop over values and insert each --->
		<cfif isDefined('form.blog_category_fk')>
		
		<cfoutput>
        	
			<cfloop list="#form.blog_category_fk#" index="id" delimiters=",">

				<cfinvoke 
					component = "#request.cfc#.blog_posts_x_blog_categories"
					method = "create" 
					blog_post_fk = "#new_key#"
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

        <cfargument name="blog_post_id" type="string" required="false" default="">
        <cfargument name="bp_alias" type="string" required="false" default="">
        <cfargument name="max_rows" type="any" required="false" default="9999">

		<cftry>
			<cflock name="read" type="readonly" timeout="5">
            
            <cfquery name="query" datasource="#request.DSN#" maxrows="#arguments.max_rows#">
                SELECT blog_post_id, bp_order, bp_title, bp_post_on, bp_allow_comments, bp_alias, bp_image, 
                bp_template_before, bp_content, 
                bp_template_after, p_layout_fk, bp_parent_id, 
                bp_meta_title, bp_meta_tags, bp_meta_description, 
                created_at, updated_at, deleted_at
                  FROM blog_posts
                 WHERE 0=0
                 <cfif #arguments.blog_post_id# neq "">
                   AND blog_post_id = <cfqueryparam value = "#arguments.blog_post_id#" cfsqltype = "cf_sql_integer"> 
                 </cfif>
    
                 <cfif #arguments.bp_alias# neq "">
                   AND bp_alias = <cfqueryparam value = "#arguments.bp_alias#" cfsqltype = "cf_sql_varchar"> 
                 </cfif>
                 
                 AND deleted_at IS NULL
                 
                 ORDER BY bp_post_on DESC   
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
		
        <cfargument name="bp_order" type="numeric" required="no">
        <cfargument name="bp_title" type="string" required="no">
        <cfargument name="bp_posted_on" type="string" required="no">
        <cfargument name="bp_allow_comments" type="string" required="no">
        <cfargument name="bp_alias" type="string" required="no">
        <cfargument name="bp_image" type="string" required="no">
        <cfargument name="bp_template_before" type="numeric" required="no" default="0">
        <cfargument name="bp_content" type="string" required="no" default="">
        <cfargument name="bp_template_after" type="numeric" required="no" default="0">
        <cfargument name="p_layout_fk" type="numeric" required="no">
        <cfargument name="bp_meta_title" type="string" required="no">
        <cfargument name="bp_meta_tags" type="string" required="no">
        <cfargument name="bp_meta_description" type="string" required="no">
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
		<cfif #arguments.bp_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="bp_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <!--- resize image --->
            <cfif #request.image_manipulator# eq "cfimage">
                    
                <cfimage
                    action = "resize"
                    width = "#request.width_blog_posts#"
                    height = "#request.height_blog_posts#"
                    source = "#Request.upLoadRoot#assets\images\temp\#image#"
                    destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
            
                <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                </cfif>
                
                <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_bp_image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_bp_image#">
            	</cfif>
                
            <cfelseif #request.image_manipulator# eq "jpegresize">
                
                <cfif #cffile.serverFileExt# eq "jpg" or #cffile.serverFileExt# eq "jpeg">
                    
                    <cfx_jpegresize action = "resize"
                           source = "#Request.upLoadRoot#assets\images\temp\#image#"
                           filename = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                           quality = "90"
                           factor = "scale_factor"
                           width = "request.width_blog_posts"
                           height = "request.height_blog_posts">
					
                    <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
	                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                    </cfif>
                    
                    <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_bp_image#")>
		                <cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_bp_image#">
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
        
        	<cfset save_image = #arguments.org_x_bp_image# >
        
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->

	    
        <!--- clean name and create alias  --->
		<cfif #arguments.bp_alias# neq "">
            <cfset alias = #arguments.bp_alias#>
        <cfelse>
            <cfset alias = #arguments.bp_title#>
        </cfif>
    	
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="create_alias_Helpers" 
            alias = "#alias#"
            returnvariable="result_alias">
		</cfinvoke>
        
        <cfset arguments.bp_alias = #result_alias#>
        <!--- end --->
        			
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE blog_posts
                       SET                       
                        	bp_title = <cfqueryparam value = "#arguments.bp_title#" cfsqltype = "cf_sql_varchar">,
                            bp_post_on = <cfqueryparam value = "#arguments.bp_post_on#" cfsqltype = "cf_sql_varchar">,
                            bp_allow_comments = <cfqueryparam value = "#arguments.bp_allow_comments#" cfsqltype = "cf_sql_varchar">,
                            bp_alias = <cfqueryparam value = "#arguments.bp_alias#" cfsqltype = "cf_sql_varchar">,
                            bp_image = <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
                            bp_template_before = <cfqueryparam value = "#arguments.bp_template_before#" cfsqltype = "cf_sql_integer">,
                            bp_content = <cfqueryparam value = "#arguments.bp_content#" cfsqltype = "cf_sql_varchar">,
                            bp_template_after = <cfqueryparam value = "#arguments.bp_template_after#" cfsqltype = "cf_sql_integer">,
                            p_layout_fk = <cfqueryparam value = "#arguments.p_layout_fk#" cfsqltype = "cf_sql_integer">,
                            bp_meta_title = <cfqueryparam value = "#arguments.bp_meta_title#" cfsqltype = "cf_sql_varchar">,
                            bp_meta_tags = <cfqueryparam value = "#arguments.bp_meta_tags#" cfsqltype = "cf_sql_varchar">,
                            bp_meta_description = <cfqueryparam value = "#arguments.bp_meta_description#" cfsqltype = "cf_sql_varchar">,
                            updated_at = <cfqueryparam value = "#arguments.updated_at#" cfsqltype = "cf_sql_varchar">  			
                     WHERE 	blog_post_id = <cfqueryparam value="#arguments.blog_post_id#" cfsqltype="cf_sql_integer">;
                </cfquery>
                
            </cflock>

            <cfcatch type="any">
            	
				<cfset result.status = "error_updating">
                
				<cfif #request.debug# eq "On">
                	<cfrethrow />
                </cfif>
    
            </cfcatch>
        </cftry>

		
		<!--- save the blog categories --->
		<!--- ------------------------ ---> 
		
		<!--- delete the old references --->
		<cfinvoke 
			component="#request.cfc#.blog_posts_x_blog_categories"
			method="delete" 
			blog_post_fk="#arguments.blog_post_id#">
		</cfinvoke>

        
		<!--- loop over values and insert each --->
		<cfif isDefined('form.blog_category_fk')>
		
		<cfoutput>
        	
			<cfloop list="#form.blog_category_fk#" index="id" delimiters=",">

				<cfinvoke 
					component = "#request.cfc#.blog_posts_x_blog_categories"
					method = "create" 
					blog_post_fk = "#arguments.blog_post_id#"
	        		blog_category_fk = "#id#" >
				</cfinvoke>
		
			</cfloop>
		
		</cfoutput>
        
		</cfif>
		<!--- ----------------- --->


		<cfreturn result>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="delete" returntype="struct">
		
        <cfargument name="blog_post_id" type="string" required="yes" >
        <cfargument name="deleted_at" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">
        				
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    UPDATE blog_posts
                       SET  deleted_at = <cfqueryparam value = "#arguments.deleted_at#" cfsqltype="cf_sql_varchar">
                     WHERE  blog_post_id = <cfqueryparam value="#arguments.blog_post_id#" cfsqltype="cf_sql_integer"> 
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
 
 	<cffunction name="html_checkbox_blog" returntype="any">
    	
        <cfargument name="blog_post_id" type="numeric" required="no" default="0" >
        <cfargument name="bio_id" type="numeric" required="no" default="0" >
        
        <cfset checked = ""><!-- set a default -->
        
        <!--- set the types of blog you do not want the user to be able to select --->
		<!--- FUTURE USE --->
		<cfset neq_ids = ArrayNew(1)>
		<!---<cfset ArrayAppend(neq_ids, "0")>
		<cfset ArrayAppend(neq_ids, "-2")>--->

        <!--- specific parent ids you do not want user to select --->
        <!--- 0 = allow all and anything will run code in the "read" function --->
        <cfinvoke 
            component="#request.cfc#.blog"
            method="read"
            not_bp_parent_id="0"
            returnvariable="records_blog">
        </cfinvoke>
		
            <cfoutput query="records_blog">
               	
               	<!---check for links x blog --->
               	<cfif #arguments.blog_post_id# neq 0>
	               	<cfinvoke 
						component="#request.cfc#.links_x_blog"
			    		method="read"
			    		blog_fk = #arguments.blog_post_id#
			    		link_blog_fk = #records_blog.blog_post_id#
			    		returnvariable="records_links">
					</cfinvoke>
			      
					<cfif #records_links.recordcount# gt 0 and #arguments.blog_post_id# neq 0>
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
			    		link_blog_fk = #records_blog.blog_post_id#
			    		returnvariable="records_links">
					</cfinvoke>
			      
					<cfif #records_links.recordcount# gt 0 and #arguments.bio_id# neq 0>
		            	<cfset checked = "checked">
		            <cfelse>
		            	<cfset checked = "">
		            </cfif>
	            </cfif>
	                         
				<div class="col-md-6">
	            	<input type="checkbox" name="link_blog_fk" value="#records_blog.blog_post_id#" #checked#> #records_blog.bp_title#
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