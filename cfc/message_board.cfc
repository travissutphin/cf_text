<cfcomponent displayname="Message Board Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="mb_name_first" type="string" required="no" default="">
        <cfargument name="mb_name_last" type="string" required="no" default="">
        <cfargument name="mb_message" type="string" required="no" default="">
		<cfargument name="mb_approved" type="string" required="no" default="0">
        <cfargument name="mb_ip_address" type="string" required="no" default="">
        <cfargument name="mb_image" type="string" required="no" default="">

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
		<cfif #arguments.mb_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="mb_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
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
                        height = "#request.height_message_boards#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_message_boards#"
                        height = "#request.width_message_boards#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_message_boards#"
                        height = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
            	</cfif>

                <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                	<cffile action = "delete" file = "#request.upLoadRoot#assets\images\temp\#image#">
            	</cfif>
                
            <cfelseif #request.image_manipulator# eq "jpegresize">
                
                <cfif #cffile.serverFileExt# eq "jpg" or #cffile.serverFileExt# eq "jpeg">
                    
                    <cfx_jpegresize action = "resize"
                           source = "#Request.upLoadRoot#assets\images\temp\#image#"
                           filename = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                           quality = "90"
                           factor = "scale_factor"
                           width = "request.width_message_boards"
                           height = "request.height_message_boards">
                    
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
        
        </cfif><!--- // <cfif isDefined ('argument.mb_image') and #argument.mb_image# neq ""> --->
        
        
        <!--- get users ip address --->
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="user_ip_address_Helpers" 
            returnvariable="ip_address">
        </cfinvoke>
          
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" >
                    INSERT INTO message_board
                    (mb_name_first, mb_name_last, mb_message, mb_ip_address,mb_approved, mb_image)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.mb_name_first#" cfsqltype = "cf_sql_string">,
                        <cfqueryparam value = "#arguments.mb_name_last#" cfsqltype = "cf_sql_string">,
                        <cfqueryparam value = "#arguments.mb_message#">,
                        <cfqueryparam value = "#ip_address#">,
                        <cfqueryparam value = "#arguments.mb_approved#">,
                        <cfqueryparam value = "#save_image#">
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
		
        <cfargument name="message_board_id" type="string" required="false" default="">
        <cfargument name="mb_approved" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT message_board_id, mb_name_first, mb_name_last, mb_message, mb_created_on, mb_ip_address, mb_approved, mb_image
			  FROM message_board
             WHERE 0=0
			 <cfif #arguments.message_board_id# neq "">
               AND message_board_id = <cfqueryparam value = "#arguments.message_board_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>

 			<cfif #arguments.mb_approved# neq "">
               AND mb_approved = <cfqueryparam value = "#arguments.mb_approved#" cfsqltype = "cf_sql_integer"> 
             </cfif>
                          
             ORDER BY mb_approved ASC, mb_created_on DESC
                           
		</cfquery>
        
		<cfreturn query>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
			
        <cfargument name="mb_name_first" type="string" required="no" default="">
        <cfargument name="mb_name_last" type="string" required="no" default="">
        <cfargument name="mb_message" type="string" required="no" default="">
		<cfargument name="mb_approved" type="string" required="no" default="">
        <cfargument name="mb_approved_saved" type="string" required="no" default="">
                
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated">
                			
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE message_board
                       SET mb_name_first = <cfqueryparam value = "#arguments.mb_name_first#" cfsqltype = "cf_sql_varchar">,
                           mb_name_last = <cfqueryparam value = "#arguments.mb_name_last#" cfsqltype = "cf_sql_varchar">,
                           mb_message = <cfqueryparam value = "#arguments.mb_message#" cfsqltype = "cf_sql_varchar">,
                           mb_approved = <cfqueryparam value = "#arguments.mb_approved#" cfsqltype = "cf_sql_varchar">				
                     WHERE message_board_id = <cfqueryparam value="#arguments.message_board_id#" cfsqltype="cf_sql_integer">;
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

        <cfargument name="message_board_id" type="string" required="no" >
        <cfargument name="mb_approved" type="string" required="no" default="" >
        <cfargument name="mb_approved_saved" type="string" required="no" default="" >
        
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "approved">

		<cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE message_board
                       SET mb_approved = <cfqueryparam value = "#arguments.mb_approved#" cfsqltype = "cf_sql_integer">		
                     WHERE message_board_id = <cfqueryparam value="#arguments.message_board_id#" cfsqltype="cf_sql_integer">;
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
		
        <cfargument name="message_board_id" type="string" required="yes" >
		
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">
       
		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    DELETE 
                      FROM message_board
                     WHERE message_board_id = <cfqueryparam value="#arguments.message_board_id#" cfsqltype="cf_sql_integer"> 
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

</cfcomponent>
