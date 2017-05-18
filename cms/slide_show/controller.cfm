<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Create Page --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.slide_show"
		method="create" 
		argumentcollection="#form#"
        returnvariable="result">
	</cfinvoke>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value="#result.status#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset session.show_message = #result#>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Update Page --->
<cfif isDefined('form.update')>

    <cfinvoke 
		component="#request.cfc#.slide_show"
		method="update" 
		argumentcollection="#form#"
        returnvariable="result">
	</cfinvoke>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value="#result.status#"
        returnvariable="result">
	</cfinvoke>
    
    <!--- setting these values will allow the update page trigger to be viewed --->
	<cfset session.show_message = #result#>
    <cfset url.view_record = #form.slide_show_id#>
	    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Delete Page --->
<cfif isDefined('form.delete')>

    <cfinvoke 
		component="#request.cfc#.slide_show"
		method="delete" 
		argumentcollection="#form#"
        returnvariable="result">
	</cfinvoke>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value="#result.status#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset session.show_message = #result#>
    <cflocation url="view.cfm">
    <cfabort>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

	<cfif isDefined('form.slide_show_id') and isDefined('form.ss_order')>
		
        <!--- for view.cfm pages has an onChange() for the ordering --->
    	<!--- this is the code to run when that onChange fires      --->
        <cfinvoke 
            component="#request.cfc#.slide_show"
            method="update_ordering" 
            argumentcollection="#form#"
            returnvariable="result">
        </cfinvoke>
        
        <cfinvoke 
            component="#request.cfc#._messages"
            method="message" 
            value="#result.status#"
            returnvariable="result">
        </cfinvoke>
        
        <cfset session.show_message = #result#>
        
    </cfif>
 
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->   

    <cfif isDefined('url.view_record')> 
    
		<!--- get specific Slide Show Records --->
        <cfinvoke 
            component="#request.cfc#.slide_show"
            method="read"
            slide_show_id = '#url.view_record#'
            returnvariable="records_Slide_Show">
        </cfinvoke>   
    
    <cfelse>
 
 		<!--- get all Slide Show Records --->
        <cfinvoke 
            component="#request.cfc#.slide_show"
            method="read"
            returnvariable="records_Slide_Show">
        </cfinvoke>     

    </cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>