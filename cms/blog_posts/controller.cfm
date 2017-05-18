<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->


<!--- Create Page --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.blog_posts"
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

<!--- Update Pae --->
<cfif isDefined('form.update')>

    <cfinvoke 
		component="#request.cfc#.blog_posts"
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

    <Cfset url.blog_post_id = #form.blog_post_id#>
            
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Delete Comment--->
<cfif isDefined('url.delete_comment')>

    <cfinvoke 
		component="#request.cfc#.blog_comments"
		method="delete" 
		blog_comment_id="#url.delete_comment#"
        returnvariable="result">
	</cfinvoke>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value="#result.status#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset session.show_message = #result#>
    <cflocation url="crud_update.cfm?blog_post_id=#url.blog_post_id#" addtoken="no">
    <cfabort>
    
</cfif>

<!--- Delete Comments with IP address--->
<cfif isDefined('url.delete_ip')>

    <cfinvoke 
		component="#request.cfc#.blog_comments"
		method="delete" 
		bcom_ip_address="#url.delete_ip#"
        returnvariable="result">
	</cfinvoke>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value="#result.status#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset session.show_message = #result#>
    <cflocation url="crud_update.cfm?blog_post_id=#url.blog_post_id#" addtoken="no">
    <cfabort>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->


    <cfif isDefined('url.blog_post_id')> 
    
		<!--- get specific Page Records --->
        <cfinvoke 
            component="#request.cfc#.blog_posts"
            method="read"
            blog_post_id = '#url.blog_post_id#'
            returnvariable="values_Blog_Posts">
        </cfinvoke>   
    
    <cfelse>
    
		<!--- get all Parent Page Records --->
        <!--- 0 = Parent Pages --->
        <cfinvoke 
            component="#request.cfc#.blog_posts"
            method="read"
            returnvariable="records_Blog_Posts">
        </cfinvoke>
    
    </cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>