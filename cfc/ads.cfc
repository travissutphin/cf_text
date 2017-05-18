<cfcomponent displayname="Ads Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="ads_order" type="numeric" required="no" default="0">
        <cfargument name="ads_title" type="string" required="no" default="">
        <cfargument name="ads_image" type="string" required="no" default="">
        <cfargument name="ads_link" type="string" required="no" default="">

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
		<cfif #arguments.ads_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ads_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
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
                        height = "#request.height_ads#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_ads#"
                        height = "#request.width_ads#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_ads#"
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
                           width = "request.width_ads"
                           height = "request.height_ads">
                    
                    <cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                
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
                    INSERT INTO ads
                    (ads_order, ads_title, ads_image, ads_link)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.ads_order#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.ads_title#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.ads_link#" cfsqltype = "cf_sql_varchar">          
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
		
        <cfargument name="ad_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT ad_id, ads_title, ads_image, ads_order, ads_link
			  FROM ads
             WHERE 0=0
			 <cfif #arguments.ad_id# neq "">
               AND ad_id = <cfqueryparam value = "#arguments.ad_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
             
             ORDER BY ads_order
                           
		</cfquery>
        
		<cfreturn query>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
			
        <cfargument name="ads_title" type="string" required="no" default="">
        <cfargument name="ads_image" type="string" required="no" default="">
        <cfargument name="org_x_ads_image" type="string" required="no" default="">
        <cfargument name="ads_link" type="string" required="no" default="">
        
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
		<cfif #arguments.ads_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ads_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
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
                        height = "#request.height_ads#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_ads#"
                        height = "#request.width_ads#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_ads#"
                        height = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
            	</cfif>
            
            	<cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                </cfif>
                
                <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_ads_image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_ads_image#">
            	</cfif>
                
            <cfelseif #request.image_manipulator# eq "jpegresize">
                
                <cfif #cffile.serverFileExt# eq "jpg" or #cffile.serverFileExt# eq "jpeg">

                    <cfx_jpegresize action = "resize"
                           source = "#Request.upLoadRoot#assets\images\temp\#image#"
                           filename = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                           quality = "90"
                           factor = "scale_factor"
                           width = "request.width_ads"
                           height = "request.height_ads">

	                <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                    	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
                    </cfif>
                    
                    <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_ads_image#")>
		            	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#arguments.org_x_ads_image#">
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
        
        	<cfset save_image = #arguments.org_x_ads_image# >
        
        </cfif><!--- // <cfif isDefined ('argument.ads_image') and #argument.ads_image# neq ""> --->
                			
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE ads
                       SET ads_title = <cfqueryparam value = "#arguments.ads_title#" cfsqltype = "cf_sql_varchar">,
                           ads_image = <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
                           ads_link = <cfqueryparam value = "#arguments.ads_link#" cfsqltype = "cf_sql_varchar">				
                     WHERE ad_id = <cfqueryparam value="#arguments.ad_id#" cfsqltype="cf_sql_integer">;
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

        <cfargument name="ad_id" type="string" required="yes" >
        <cfargument name="ads_order" type="string" required="yes" >
        <cfargument name="ads_title" type="string" required="yes" >
        <cfargument name="ads_link" type="string" required="yes" >

		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated_ordering">

		<cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE ads
                       SET ads_order = <cfqueryparam value = "#arguments.ads_order#" cfsqltype = "cf_sql_integer">,
                           ads_title = <cfqueryparam value = "#arguments.ads_title#" cfsqltype = "cf_sql_varchar">,
                           ads_link = <cfqueryparam value = "#arguments.ads_link#" cfsqltype = "cf_sql_varchar">			
                     WHERE ad_id = <cfqueryparam value="#arguments.ad_id#" cfsqltype="cf_sql_integer">;
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
		
        <cfargument name="ad_id" type="string" required="yes" >
		
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<!--- get specific Slide Show Record --->
        <cfinvoke 
            component="#request.cfc#.ads"
            method="read"
            ad_id = '#arguments.ad_id#'
            returnvariable="record_Ads">
        </cfinvoke>
        
		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    DELETE 
                      FROM ads
                     WHERE ad_id = <cfqueryparam value="#arguments.ad_id#" cfsqltype="cf_sql_integer"> 
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
        <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#record_Ads.ads_image#")>
        	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#record_Ads.ads_image#">	
		</cfif>
        
        <cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
