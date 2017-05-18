<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Create Blog Category --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.blog_comments"
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


<!--- Delete --->
<cfif isDefined('form.delete')>

    <cfinvoke 
		component="#request.cfc#.blog_comments"
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


 	<!--- get all Comments Records --->
	<cfinvoke 
        component="#request.cfc#.blog_comments"
        method="join_blog_posts_x_blog_comments"
    	returnvariable="records_Blog_Comments">
    </cfinvoke>     


<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>