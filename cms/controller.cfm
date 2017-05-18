<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- display message --->
<cfif isDefined('url.msg')>

    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value = "#url.msg#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset show_message = #result#>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Log in admin --->
<cfif isDefined('form.login')>

    <cfif #form.a_email# neq "" and #form.a_pswd# neq "">
        
        <cfset form.redirect_success = "control_panel.cfm">
		<cfset form.redirect_failure = "index.cfm">
        
        <cfinvoke 
            component="#request.cfc#.admin"
            method="login" 
            argumentcollection="#form#"
            returnvariable="result">
        </cfinvoke>
        
        <!--- only Admin allowed in CMS --->
        <cfif #SESSION.Auth.a_priv# neq '1'>
        	<cflocation url="#request.siteURL#cms/index.cfm?msg=logged_out" addtoken="no">
		</cfif>
   
    </cfif>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Recover Password --->
<cfif isDefined('form.recover_password')>

    <cfinvoke 
		component="#request.cfc#.admin"
		method="recover_password" 
		argumentcollection="#form#"
        returnvariable="result">
	</cfinvoke>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Create Adim --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.admin"
		method="create" 
		argumentcollection="#form#"
        returnvariable="result">
	</cfinvoke>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value = "#result.status#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset show_message = #result#>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Update Adim --->
<cfif isDefined('form.update')>

    <cfinvoke 
		component="#request.cfc#.admin"
		method="update" 
		argumentcollection="#form#"
        returnvariable="result">
	</cfinvoke>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value = "#result.status#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset show_message = #result#>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Delete Adim --->
<cfif isDefined('form.delete')>

    <cfinvoke 
		component="#request.cfc#.admin"
		method="delete" 
		argumentcollection="#form#"
        returnvariable="result">
	</cfinvoke>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value = "#result.status#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset show_message = #result#>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

	<!--- get all Admin Records --->
    <cfinvoke 
		component="#request.cfc#.admin"
		method="read"
        returnvariable="records_Admin">
	</cfinvoke>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>