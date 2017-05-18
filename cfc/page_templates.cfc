<cfcomponent displayname="Page Templates Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
  
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">

        <cfargument name="page_template_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
            
            SELECT page_template_id, pt_template_name, pt_template
              FROM page_templates
             WHERE 0=0
             
             <cfif #arguments.page_template_id# neq "">
               AND page_template_id = <cfqueryparam value = "#arguments.page_template_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
             
             ORDER BY pt_template_name
                            
        </cfquery>
        
        <cfreturn query>
        		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
			    
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="delete" returntype="struct">

	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->			

	<cffunction name="html_list_templates" returntype="any">
    	
        <cfargument name="page_template_id" type="string" required="no" default="" >
        <cfargument name="before_or_after_content" type="string" required="no" default="" >
        
        <cfinvoke 
            component="#request.cfc#.page_templates"
            method="read"
            returnvariable="records_templates">
        </cfinvoke>
	  
        <select name="<cfoutput>#arguments.before_or_after_content#</cfoutput>" class="form-control">
        	
        	<option value="0">No template</option>
        	
            <cfoutput query="records_templates">
              
              <cfif #records_templates.page_template_id# eq #arguments.page_template_id#>
                  <cfset selected = "selected">
              <cfelse>
                  <cfset selected = "">
              </cfif>
              
              <option value="#records_templates.page_template_id#" #selected#>#records_templates.pt_template_name#</option>
              
			</cfoutput>
            
        </select>

	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->    

</cfcomponent>
