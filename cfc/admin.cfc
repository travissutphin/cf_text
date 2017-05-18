<cfcomponent displayname="Admin Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="provider_fk" type="numeric" required="no" default="">
        <cfargument name="role_fk" type="numeric" required="no" default="">
        <cfargument name="a_name_fist" type="string" required="no" default="">
        <cfargument name="a_name_last" type="string" required="no" default="">
        <cfargument name="a_cell" type="string" required="no" default="">
        <cfargument name="a_pswd" type="string" required="no" default="">
        <cfargument name="a_email" type="string" required="no" default="">
        <cfargument name="a_priv" type="numeric" required="no" default="0">
        <cfargument name="a_active" type="numeric" required="no" default="1">
        <cfargument name="a_receive_text" type="string" required="no" default="1">
        <cfargument name="a_receive_email" type="string" required="no" default="1">
        <cfargument name="created_at" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">
        							
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "created">
		
        <!--- create password if one was not passed --->
        <cfif #arguments.a_pswd# eq "">
            <cfinvoke 
                component="#request.cfc#._helpers"
                method="random_string_Helpers" 
                returnvariable="temp_password">
            </cfinvoke>
            
            <cfset arguments.a_pswd = #temp_password#>
		</cfif>
        
        
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery datasource="#request.DSN#" >
                    INSERT INTO admin
                    (provider_fk, role_fk, a_name_first, a_name_last, a_cell, a_email, a_pswd, a_priv, a_active, a_receive_text, a_receive_email, created_at)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.provider_fk#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value = "#arguments.role_fk#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.a_name_first#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.a_name_last#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.a_cell#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.a_email#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.a_pswd#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.a_priv#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.a_active#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.a_receive_text#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.a_receive_email#" cfsqltype = "cf_sql_varchar">,
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
		
        <cfargument name="admin_id" type="string" required="no" default="">
        <cfargument name="provider_fk" type="string" required="no" default="">
        <cfargument name="role_fk" type="string" required="no" default="">
        <cfargument name="a_name_fist" type="string" required="no" default="">
        <cfargument name="a_name_last" type="string" required="no" default="">
        <cfargument name="a_cell" type="string" required="no" default="">
        <cfargument name="a_pswd" type="string" required="no" default="">
        <cfargument name="a_email" type="string" required="no" default="">
        <cfargument name="a_priv" type="string" required="no" default="0">
        <cfargument name="a_active" type="string" required="no" default="1">
        <cfargument name="a_receive_text" type="string" required="no" default="">
        <cfargument name="a_receive_email" type="string" required="no" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT admin_id, provider_fk, role_fk, a_name_first, a_name_last, a_cell, a_pswd, a_email, a_priv, a_active, a_receive_text, a_receive_email
			  FROM admin
             WHERE 0=0
			 <cfif #arguments.admin_id# neq "">
               AND admin_id = <cfqueryparam value = "#arguments.admin_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>

			 <cfif #arguments.a_cell# neq "">
               AND a_cell = <cfqueryparam value = "#arguments.a_cell#" cfsqltype = "cf_sql_varchar"> 
             </cfif>
             
			 <cfif #arguments.a_pswd# neq "">
               AND a_pswd = <cfqueryparam value = "#arguments.a_pswd#" cfsqltype = "cf_sql_varchar">  
             </cfif>
             
			 <cfif #arguments.a_email# neq "">
               AND a_email = <cfqueryparam value = "#arguments.a_email#" cfsqltype = "cf_sql_varchar"> 
             </cfif>

			 <cfif #arguments.a_active# neq "">
               AND a_active = <cfqueryparam value = "#arguments.a_active#" cfsqltype = "cf_sql_integer"> 
             </cfif>
             
			 <cfif #arguments.a_receive_text# neq "">
               AND a_receive_text = <cfqueryparam value = "#arguments.a_receive_text#" cfsqltype = "cf_sql_varchar"> 
             </cfif>

			 <cfif #arguments.a_receive_email# neq "">
               AND a_receive_email = <cfqueryparam value = "#arguments.a_receive_email#" cfsqltype = "cf_sql_varchar"> 
             </cfif>
             
             <cfif #arguments.role_fk# neq "">
               AND role_fk = <cfqueryparam value = "#arguments.role_fk#" cfsqltype = "cf_sql_varchar"> 
             </cfif>
 
                            
		</cfquery>

		<cfreturn query>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
			
        <cfargument name="admin_id" type="numeric" required="no" default="">
        <cfargument name="provider_fk" type="numeric" required="no" default="">
        <cfargument name="role_fk" type="numeric" required="no" default="">
        <cfargument name="a_name_fist" type="string" required="no" default="">
        <cfargument name="a_name_last" type="string" required="no" default="">
        <cfargument name="a_cell" type="string" required="no" default="">
        <cfargument name="a_pswd" type="string" required="no" default="">
        <cfargument name="a_email" type="string" required="no" default="">
        <cfargument name="a_priv" type="numeric" required="no" default="0">
        <cfargument name="a_active" type="numeric" required="no" default="1">
        <cfargument name="a_receive_text" type="string" required="no" default="">
        <cfargument name="a_receive_email" type="string" required="no" default="">
			
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated">
			
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE admin
                       SET 
                            provider_fk = <cfqueryparam value = "#arguments.provider_fk#" cfsqltype = "cf_sql_integer">,
                            role_fk = <cfqueryparam value = "#arguments.role_fk#" cfsqltype = "cf_sql_integer">,
                            a_name_first = <cfqueryparam value = "#arguments.a_name_first#" cfsqltype = "cf_sql_varchar">,
                            a_name_last = <cfqueryparam value = "#arguments.a_name_last#" cfsqltype = "cf_sql_varchar">,
                            a_cell = <cfqueryparam value = "#arguments.a_cell#" cfsqltype = "cf_sql_varchar">,
                            a_pswd = <cfqueryparam value = "#arguments.a_pswd#" cfsqltype = "cf_sql_varchar">,
                            a_email = <cfqueryparam value = "#arguments.a_email#" cfsqltype = "cf_sql_varchar">,
                            a_priv = <cfqueryparam value = "#arguments.a_priv#" cfsqltype = "cf_sql_integer">,
                            a_active = <cfqueryparam value = "#arguments.a_active#" cfsqltype = "cf_sql_integer">,
                            a_receive_text = <cfqueryparam value = "#arguments.a_receive_text#" cfsqltype = "cf_sql_varchar">,
                            a_receive_email = <cfqueryparam value = "#arguments.a_receive_email#" cfsqltype = "cf_sql_varchar">
                     WHERE admin_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.admin_id#">;
                </cfquery>
                
            </cflock>

            <cfcatch type="any">
                    <cfset result.status = "error_updating">
                </cfcatch>
        </cftry>

		<cfreturn result>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="delete" returntype="struct">
							
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#" >
                    DELETE FROM admin
                     WHERE admin_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.admin_id#"> 
				</cfquery> 
                	
			</cflock>	
				<cfcatch type="any">
					<cfset result.status = "error_deleting">
				</cfcatch>
		</cftry>	
		
        <cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->			

	<cffunction name="login" returntype="any">

        <cfargument name="a_pswd" type="string" required="yes" >
        <cfargument name="a_email" type="string" required="yes" >
        <cfargument name="redirect_success" type="string" required="no" >
        <cfargument name="redirect_failure" type="string" required="no" >
       	<cfargument name="current_location" type="string" required="no" >
        							
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
                <cfset SESSION.Auth.id = result.admin_id>
                <cfset SESSION.Auth.a_name_first = result.a_name_first>
                <cfset SESSION.Auth.a_name_last = result.a_name_last>
                <cfset SESSION.Auth.a_email = result.a_email>
                <cfset SESSION.Auth.a_priv = result.a_priv>
                <cfset SESSION.Auth.a_active = result.a_active>
                <cfset SESSION.Auth.role_fk = result.role_fk>
				
                <!--- capture login details --->
                
                <!--- get users ip address --->
                <cfinvoke 
                    component="#request.cfc#._helpers"
                    method="user_ip_address_Helpers" 
                    returnvariable="ip_address">
                </cfinvoke>				

                <cfquery name="uu" datasource="#request.DSN#">
                    UPDATE admin
                       SET 
                            last_login = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(now(), "yyyy-mm-dd")#"> ,
                            ip_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ip_address#">
                     WHERE admin_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#result.admin_id#">;
                </cfquery>               
                
                        <!--- only Admin allowed in CMS --->
        		<cfif #arguments.current_location# eq 'cms' and #SESSION.Auth.a_priv# neq '1'>
        			<cflocation url="#request.siteURL#cms/index.cfm?msg=logged_out" addtoken="no">
				</cfif>
                
                <cflocation url="#arguments.redirect_success#" addtoken="no">
                		
            <cfelse>

                <cfset session.msg = "invalid_credentials">
                <cflocation url="#arguments.redirect_failure#" addtoken="no">
                
            </cfif>
            
		</cfoutput>
        
        <cfreturn result>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

	<cffunction name="recover_password" returntype="any">

        <cfargument name="a_email" type="string" required="yes" >
        <cfargument name="redirect_success" type="string" required="no" >
        <cfargument name="redirect_failure" type="string" required="no" >
                							
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "password_sent">

		<cfinvoke 
			component="#request.cfc#.admin"
			method="read" 
            a_email = "#arguments.a_email#"
			returnvariable="result">
		</cfinvoke>
	
    	<cfoutput>
        	
			<cfif #result.recordcount# eq 1>
				
                <cfmail to="#result.a_email#"
                		from="noReply@NeaseCrossCountry.com"
                        subject="NeaseCrossCountry.com Password Help"
                        type="html">
                <h3>Your crendentials for #request.title#</h3>
                <p>Your password is #result.a_pswd#</p>
                <p>&nbsp;</p>
                Site: #request.siteUrl#
                </cfmail>
                
                <cfset session.msg = "password_sent">
                <cflocation url="#arguments.redirect_success#" addtoken="no">
                        
            <cfelse>
                 
                <cfset session.msg = "invalid_email">          
                <cflocation url="#arguments.redirect_failure#" addtoken="no">
                
            </cfif>
            
		</cfoutput>
        
        <cfreturn result>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>

