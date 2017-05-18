<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Create Page --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.ads"
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
		component="#request.cfc#.ads"
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
    <cfset url.view_record = #form.ads_id#>
	    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Delete --->
<cfif isDefined('form.delete')>

    <cfinvoke 
		component="#request.cfc#.ads"
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
    <cflocation url="view.cfm" addtoken="no">
    <cfabort>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

	<cfif isDefined('form.ad_id') and isDefined('form.ads_order')>
		
        <!--- for view.cfm pages has an onChange() for the ordering --->
    	<!--- this is the code to run when that onChange fires      --->
        <cfinvoke 
            component="#request.cfc#.ads"
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
    
		<!--- get specific ads Records --->
        <cfinvoke 
            component="#request.cfc#.ads"
            method="read"
            ad_id = '#url.view_record#'
            returnvariable="records_ads">
        </cfinvoke>   
    
    <cfelse>
 
 		<!--- get all Slide Show Records --->
        <cfinvoke 
            component="#request.cfc#.ads"
            method="read"
            returnvariable="records_ads">
        </cfinvoke>     

    </cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>