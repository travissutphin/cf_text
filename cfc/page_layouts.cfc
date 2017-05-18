<cfcomponent displayname="Page Layouts Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
  
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">

        <cfargument name="page_layout_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
            
            SELECT page_layout_id, pl_display_name, pl_layout, pl_description
              FROM page_layouts
             WHERE 0=0
             
             <cfif #arguments.page_layout_id# neq "">
               AND page_layout_id = <cfqueryparam value = "#arguments.page_layout_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
                            
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

	<cffunction name="html_list_layouts" returntype="any">
    	
        <cfargument name="page_layout_id" type="string" required="no" default="" >
        
        <cfinvoke 
            component="#request.cfc#.page_layouts"
            method="read"
            returnvariable="records_layouts">
        </cfinvoke>
	  
        <select name="p_layout_fk" class="form-control">
        
            <cfoutput query="records_layouts">
              
              <cfif #records_layouts.page_layout_id# eq #arguments.page_layout_id#>
                  <cfset selected = "selected">
              <cfelse>
                  <cfset selected = "">
              </cfif>
              
              <option value="#records_layouts.page_layout_id#" #selected#>#records_layouts.pl_display_name#</option>
              
			</cfoutput>
            
        </select>

	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->    

</cfcomponent>
