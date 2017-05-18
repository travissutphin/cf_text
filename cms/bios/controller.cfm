<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Create --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.bios"
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
    
    <cfset show_message = #result#>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Update --->
<cfif isDefined('form.update')>

    <cfinvoke 
		component="#request.cfc#.bios"
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
    
    <cfset show_message = #result#>

    <Cfset url.bio_id = #form.bio_id#>
            
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Delete --->
<cfif isDefined('form.delete')>

    <cfinvoke 
		component="#request.cfc#.bios"
		method="delete" 
		bio_id="#form.bio_id#"
        returnvariable="result">
	</cfinvoke>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value="#result.status#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset show_message = #result#>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

	<cfif isDefined('form.bio_id') and isDefined('form.bi_order') and not IsDefined('form.delete')>
		
        <!--- for view.cfm pages has an onChange() for the ordering --->
    	<!--- this is the code to run when that onChange fires      --->
        <cfinvoke 
            component="#request.cfc#.bios"
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
        
        <cfset show_message = #result#>
        
    </cfif>
 
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->   

    <cfif isDefined('url.bio_id')> 
    
		<!--- get specific Records --->
        <cfinvoke 
            component="#request.cfc#.bios"
            method="read"
            bio_id = '#url.bio_id#'
            returnvariable="records_Bios">
        </cfinvoke>   
    
    <cfelse>
    
		<!--- get all Records --->
        <cfinvoke 
            component="#request.cfc#.bios"
            method="read"
            returnvariable="records_Bios">
        </cfinvoke>
    
    </cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>