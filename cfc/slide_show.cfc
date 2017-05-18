<cfcomponent displayname="Slide Show Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="ss_order" type="numeric" required="no" default="0">
        <cfargument name="ss_title" type="string" required="no" default="">
        <cfargument name="ss_caption" type="string" required="no" default="">
        <cfargument name="ss_link" type="string" required="no" default="">
        <cfargument name="ss_image" type="string" required="no" default="">
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
		<cfif #arguments.ss_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ss_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
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
                        height = "#request.height_slide_show#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_slide_show#"
                        height = "#request.width_slide_show#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_slide_show#"
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
                           width = "request.width_slide_show"
                           height = "request.height_slide_show">
                    
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
        
                 
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" >
                    INSERT INTO slide_show
                    (ss_order, ss_title, ss_caption, ss_link, ss_image, created_at)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.ss_order#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.ss_title#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.ss_caption#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.ss_link#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
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
		
        <cfargument name="slide_show_id" type="string" required="false" default="">

		<cftry>
			<cflock name="read" type="readonly" timeout="5">        
                
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT slide_show_id, ss_order, ss_title, ss_caption, ss_link, ss_image, created_at
                      FROM slide_show
                     WHERE 0=0
                     <cfif #arguments.slide_show_id# neq "">
                       AND slide_show_id = <cfqueryparam value = "#arguments.slide_show_id#" cfsqltype = "cf_sql_integer"> 
                     </cfif>
                     
                     ORDER BY ss_order
                                   
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
			
        <cfargument name="ss_title" type="string" required="no" default="">
        <cfargument name="ss_caption" type="string" required="no" default="">
        <cfargument name="ss_link" type="string" required="no" default="">
        <cfargument name="ss_image" type="string" required="no" default="">
        <cfargument name="org_x_ss_image" type="string" required="no" default="">
        
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
		<cfif #arguments.ss_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ss_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
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
                        height = "#request.height_slide_show#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_slide_show#"
                        height = "#request.width_slide_show#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_slide_show#"
                        height = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
            	</cfif> 
            
                <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                </cfif>
                
                <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_ss_image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_ss_image#">
            	</cfif>
                
            <cfelseif #request.image_manipulator# eq "jpegresize">
                
                <cfif #cffile.serverFileExt# eq "jpg" or #cffile.serverFileExt# eq "jpeg">

                    <cfx_jpegresize action = "resize"
                           source = "#Request.upLoadRoot#assets\images\temp\#image#"
                           filename = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                           quality = "90"
                           factor = "scale_factor"
                           width = "request.width_slide_show"
                           height = "request.height_slide_show">

	                <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                    	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                    </cfif>
                    
                    <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_ss_image#")>
		            	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_ss_image#">
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
        
        	<cfset save_image = #arguments.org_x_ss_image# >
        
		</cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->
                			
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE slide_show
                       SET ss_title = <cfqueryparam value = "#arguments.ss_title#" cfsqltype = "cf_sql_varchar">,
                           ss_caption = <cfqueryparam value = "#arguments.ss_caption#" cfsqltype = "cf_sql_varchar">,
                           ss_link = <cfqueryparam value = "#arguments.ss_link#" cfsqltype = "cf_sql_varchar">,
                           ss_image = <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">			
                     WHERE slide_show_id = <cfqueryparam value="#arguments.slide_show_id#" cfsqltype="cf_sql_integer">;
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

	<cffunction name="update_ordering" returntype="struct">

        <cfargument name="slide_show_id" type="string" required="yes" >
        <cfargument name="ss_order" type="string" required="yes" >
        <cfargument name="ss_title" type="string" required="yes" >

		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated_ordering">

		<cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE slide_show
                       SET ss_order = <cfqueryparam value = "#arguments.ss_order#" cfsqltype = "cf_sql_integer">,
                           ss_title = <cfqueryparam value = "#arguments.ss_title#" cfsqltype = "cf_sql_varchar"> 			
                     WHERE slide_show_id = <cfqueryparam value="#arguments.slide_show_id#" cfsqltype="cf_sql_integer">;
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
		
        <cfargument name="slide_show_id" type="string" required="yes" >
		
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<!--- get specific Slide Show Record --->
        <cfinvoke 
            component="#request.cfc#.slide_show"
            method="read"
            slide_show_id = '#arguments.slide_show_id#'
            returnvariable="record_Slide_Show">
        </cfinvoke>
        
		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    DELETE 
                      FROM slide_show
                     WHERE slide_show_id = <cfqueryparam value="#arguments.slide_show_id#" cfsqltype="cf_sql_integer"> 
				</cfquery> 
                	
			</cflock>	
				<cfcatch type="any">
					
					<cfset result.status = "error_deleting">
                    
					<cfif #request.debug# eq "On">
                        <cfrethrow />
                    </cfif>
                    
				</cfcatch>
		</cftry>
        
        <!--- delete the image --->
        <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#record_Slide_Show.ss_image#")>
        	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#record_Slide_Show.ss_image#">	
		</cfif>
        
        <cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
