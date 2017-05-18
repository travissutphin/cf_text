<cfcomponent displayname="Image File Repo Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="ifr_image" type="string" required="no" default="">

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
		<cfif #arguments.ifr_image# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ifr_image" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
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
                        height = "#request.height_image_file_repo#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#">                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_image_file_repo#"
                        height = "#request.width_image_file_repo#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"> 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_image_file_repo#"
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
                           width = "request.width_image_file_repo"
                           height = "request.height_image_file_repo">
                    
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
                    INSERT INTO images_files_repo
                    (ifr_image)
                    VALUES
                    (
                        <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">           
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
		
        <cfargument name="image_file_repo_id" type="string" required="false" default="">
		
        <cftry>
			<cflock name="read" type="readonly" timeout="5">        
               
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT image_file_repo_id, ifr_image
                      FROM images_files_repo
                     WHERE 0=0
                     <cfif #arguments.image_file_repo_id# neq "">
                       AND image_file_repo_id = <cfqueryparam value = "#arguments.image_file_repo_id#" cfsqltype = "cf_sql_integer"> 
                     </cfif>
                     
                     ORDER BY image_file_repo_id
                                   
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
	
    	<!--- create and delete only --->		
	       
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update_ordering" returntype="struct">         
    
    </cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="delete" returntype="struct">
		
        <cfargument name="image_file_repo_id" type="string" required="yes" >
		
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<!--- get specific Slide Show Record --->
        <cfinvoke 
            component="#request.cfc#.images_files_repo"
            method="read"
            image_file_repo_id = '#arguments.image_file_repo_id#'
            returnvariable="record_Images_Files_Repo">
        </cfinvoke>
        
		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    DELETE 
                      FROM images_files_repo
                     WHERE image_file_repo_id = <cfqueryparam value="#arguments.image_file_repo_id#" cfsqltype="cf_sql_integer"> 
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
        <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#record_Images_Files_Repo.ifr_image#")>
        	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#record_Images_Files_Repo.ifr_image#">	
		</cfif>
        
        <cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
