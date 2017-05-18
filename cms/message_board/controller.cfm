<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Create Page --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.message_board"
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
    
    <cfset session.show_message = #result.status#>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Delete --->
<cfif isDefined('form.delete')>

    <cfinvoke 
		component="#request.cfc#.message_board"
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

	<cfif isDefined('form.mb_approved')>
        		
        <!--- for view.cfm pages has an onChange() for the ordering --->
    	<!--- this is the code to run when that onChange fires      --->
        <cfinvoke 
            component="#request.cfc#.message_board"
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
 
	<!--- get all Message Board Records --->
    <cfinvoke 
        component="#request.cfc#.message_board"
        method="read"
        returnvariable="records_message_board">
    </cfinvoke>     


<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>