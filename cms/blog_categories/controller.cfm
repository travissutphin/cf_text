<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Create Blog Category --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.blog_categories"
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

<!--- Update Blog Category --->
<cfif isDefined('form.update')>

    <cfinvoke 
		component="#request.cfc#.blog_categories"
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
    <cfset url.view_record = #form.blog_category_id#>
	    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Delete --->
<cfif isDefined('form.delete')>

    <cfinvoke 
		component="#request.cfc#.blog_categories"
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

    <cfif isDefined('url.view_record')> 
    
		<!--- get specific blog_categories Records --->
        <cfinvoke 
            component="#request.cfc#.blog_categories"
            method="read"
            blog_category_id = '#url.view_record#'
            returnvariable="records_Blog_Categories">
        </cfinvoke>   
    
    <cfelse>
 
 		<!--- get all Slide Show Records --->
        <cfinvoke 
            component="#request.cfc#.blog_categories"
            method="read"
            returnvariable="records_Blog_Categories">
        </cfinvoke>     

    </cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>