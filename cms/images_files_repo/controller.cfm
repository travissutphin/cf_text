<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Create Page --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.images_files_repo"
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
		component="#request.cfc#.images_files_repo"
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
    <cfset url.view_record = #form.image_file_repo#>
	    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Delete Page --->
<cfif isDefined('form.delete')>

    <cfinvoke 
		component="#request.cfc#.images_files_repo"
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

	  <!--- get all Image File Repo Records --->
      <cfinvoke 
          component="#request.cfc#.images_files_repo"
          method="read"
          returnvariable="records_Images_Files_Repo">
      </cfinvoke>     

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>