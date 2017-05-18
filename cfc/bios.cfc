<cfcomponent displayname="Bios Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="bi_name_first" type="string" required="no" default="">
        <cfargument name="bi_name_last" type="string" required="no" default="">
        <cfargument name="bi_name_preface" type="string" required="no" default="">
        <cfargument name="bi_title" type="string" required="no" default="">
        <cfargument name="bi_image" type="string" required="no" default="">
        <cfargument name="bi_content" type="string" required="no" default="">
        <cfargument name="bi_preview" type="string" required="no" default="">
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
		<cfif #arguments.bi_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="bi_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
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
                        height = "#request.height_bios#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_bios#"
                        height = "#request.width_bios#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_bios#"
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
                           width = "request.width_bios"
                           height = "request.height_bios">
                    
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
            	
				<cfquery name="insert" datasource="#request.DSN#" result="insert_Result" >
                    INSERT INTO bios
                    (bi_name_first, bi_name_last, bi_name_preface, bi_title, bi_image, bi_content, 
                     bi_preview, created_at)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.bi_name_first#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bi_name_last#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bi_name_preface#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bi_title#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bi_content#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bi_preview#" cfsqltype = "cf_sql_varchar">,
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
        <cfset new_key = #insert_result.IDENTITYCOL#>
		
		<!--- save the page links --->
		<!--- ------------------- ---> 
		
		<cfoutput>
		
		<!--- loop over values and insert each --->
		<cfif isDefined('form.link_page_fk')>
			
			<cfloop list="#form.link_page_fk#" index="id" delimiters=",">

				<cfinvoke 
					component = "#request.cfc#.links_x_bios"
					method = "create" 
					bio_fk = "#new_key#"
	        		link_page_fk = "#id#" >
				</cfinvoke>

			</cfloop>

		</cfif>
		
		</cfoutput>
		<!--- ----------------- --->
		
				
        <cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="bio_id" type="string" required="false" default="">
        <cfargument name="bi_name_first" type="string" required="false" default="">
        <cfargument name="bi_name_last" type="string" required="false" default="">

		<cftry>
			<cflock name="read" type="readonly" timeout="5">        
                
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT bio_id, bi_order, bi_name_first, bi_name_last, bi_name_preface, bi_image, bi_title, 
                    bi_content, bi_preview, created_at, updated_at, deleted_at
                      FROM bios
                     WHERE 0=0
                     <cfif #arguments.bio_id# neq "">
                       AND bio_id = <cfqueryparam value = "#arguments.bio_id#" cfsqltype = "cf_sql_integer"> 
                     </cfif>
        
                     <cfif #arguments.bi_name_first# neq "">
                       AND bi_name_first = <cfqueryparam value = "#arguments.bi_name_first#" cfsqltype = "cf_sql_varchar"> 
                     </cfif>
         
                     <cfif #arguments.bi_name_last# neq "">
                       AND bi_name_last = <cfqueryparam value = "#arguments.bi_name_last#" cfsqltype = "cf_sql_varchar">  
                     </cfif>
                     
                     AND deleted_at IS NULL
                     
                     ORDER BY bi_order, bi_name_last, bi_name_first
                                   
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
			
        <cfargument name="bi_order" type="numeric" required="no" default="0">
        <cfargument name="bi_name_first" type="string" required="no" default="">
        <cfargument name="bi_name_last" type="string" required="no" default="">
        <cfargument name="bi_name_preface" type="string" required="no" default="0">
        <cfargument name="bi_title" type="string" required="no" default="">
        <cfargument name="bi_image" type="string" required="no" default="0">
        <cfargument name="org_x_bi_image" type="string" required="no" default="">
        <cfargument name="bi_content" type="string" required="no" default="0">
        <cfargument name="bi_preview" type="string" required="no" default="">
 
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
		<cfif #arguments.bi_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="bi_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
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
                        height = "#request.height_bios#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_bios#"
                        height = "#request.width_bios#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_bios#"
                        height = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
            	</cfif> 
            
                <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                </cfif>
                
                <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_bi_image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_bi_image#">
            	</cfif>
                
            <cfelseif #request.image_manipulator# eq "jpegresize">
                
                <cfif #cffile.serverFileExt# eq "jpg" or #cffile.serverFileExt# eq "jpeg">
                
                    <cfx_jpegresize action = "resize"
                           source = "#Request.upLoadRoot#assets\images\temp\#image#"
                           filename = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                           quality = "90"
                           factor = "scale_factor"
                           width = "request.width_bios"
                           height = "request.height_bios">
					
                    <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
	                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                    </cfif>
                    
                    <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_bi_image#")>
		                <cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_bi_image#">
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
        
        	<cfset save_image = #arguments.org_x_bi_image# >
        
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->
	    
	          			
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE bios
                       SET bi_order = <cfqueryparam value = "#arguments.bi_order#" cfsqltype = "cf_sql_integer">,
                           bi_name_first = <cfqueryparam value = "#arguments.bi_name_first#" cfsqltype = "cf_sql_varchar">,
                           bi_name_last = <cfqueryparam value = "#arguments.bi_name_last#" cfsqltype = "cf_sql_varchar">,
                           bi_name_preface = <cfqueryparam value = "#arguments.bi_name_preface#" cfsqltype = "cf_sql_varchar">,
                           bi_title = <cfqueryparam value = "#arguments.bi_title#" cfsqltype = "cf_sql_varchar">,
                           bi_image = <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
                           bi_content = <cfqueryparam value = "#arguments.bi_content#" cfsqltype = "cf_sql_varchar">,
                           bi_preview = <cfqueryparam value = "#arguments.bi_preview#" cfsqltype = "cf_sql_varchar">		
                     WHERE bio_id = <cfqueryparam value="#arguments.bio_id#" cfsqltype="cf_sql_integer">;
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
			component="#request.cfc#.links_x_bios"
			method="delete" 
			bio_fk="#arguments.bio_id#">
		</cfinvoke>
		
		<!--- loop over values and insert each --->
		<cfif isDefined('form.link_page_fk')>
			
			<cfloop list="#form.link_page_fk#" index="id" delimiters=",">

				<cfinvoke 
					component = "#request.cfc#.links_x_bios"
					method = "create" 
					bio_fk = "#arguments.bio_id#"
	        		link_page_fk = "#id#" >
				</cfinvoke>
		
			</cfloop>

		</cfif>
		
		</cfoutput>
		<!--- ----------------- --->
		
		<cfreturn result>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update_ordering" returntype="struct">

        <cfargument name="bio_id" type="string" required="yes" >
        <cfargument name="bi_order" type="string" required="yes" >

		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated_ordering">

		<cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE bios
                       SET bi_order = <cfqueryparam value = "#arguments.bi_order#" cfsqltype = "cf_sql_integer"> 			
                     WHERE bio_id = <cfqueryparam value="#arguments.bio_id#" cfsqltype="cf_sql_integer">;
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
		
        <cfargument name="bio_id" type="string" required="yes" >
        <cfargument name="deleted_at" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">
        				
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    UPDATE bios
                       SET deleted_at = <cfqueryparam value = "#arguments.deleted_at#" cfsqltype="cf_sql_varchar">
                     WHERE bio_id = <cfqueryparam value="#arguments.bio_id#" cfsqltype="cf_sql_integer"> 
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

	<cffunction name="html_list_main_navigation" returntype="any">
    	
        <cfargument name="bio_id" type="string" required="no" default="" >
        
        <cfinvoke 
            component="#request.cfc#.bios"
            method="read"
            returnvariable="records_Bios">
        </cfinvoke>
	  	
		<cfoutput>
        <select name="bio_fk" class="form-control">
			<option value="0">Select</option>

             <cfloop query="records_Bios">
              
              <cfif #records_Bios.bio_id# eq #arguments.bio_id#>
                  <cfset selected = "selected" >
              <cfelse>
                  <cfset selected = "">
              </cfif>
              
              <option value="#records_Bios.bio_id#" #selected#>#records_Bios.bi_name_preface# #records_Bios.bi_name_first# #records_Bios.bi_name_last#</option>
              
			</cfloop>
        </select>
        </cfoutput>

	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->    

</cfcomponent>
