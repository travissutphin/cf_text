<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Create Page --->
<cfif isDefined('form.create')>

    <cfinvoke 
		component="#request.cfc#.pages"
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
		component="#request.cfc#.pages"
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

    <Cfset url.page_id = #form.page_id#>
            
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

<!--- Delete Page --->
<cfif isDefined('form.delete')>

    <cfinvoke 
		component="#request.cfc#.pages"
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
    
    <cfset show_message = #result#>
    
</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

	<cfif isDefined('form.page_id') and isDefined('form.p_order')>
		
        <!--- for view.cfm pages has an onChange() for the ordering --->
    	<!--- this is the code to run when that onChange fires      --->
        <cfinvoke 
            component="#request.cfc#.pages"
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

    <cfif isDefined('url.page_id')> 
    
		<!--- get specific Page Records --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            page_id = '#url.page_id#'
            returnvariable="values_Page">
        </cfinvoke>   
    
    <cfelse>
    
		<!--- get all Parent Page Records --->
        <!--- 0 = Parent Pages --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            p_parent_id = '0'
            returnvariable="records_parent_Pages">
        </cfinvoke>
    
        <!--- get all Latest News Page Records --->
        <!--- -2 = Section Text Pages --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            p_parent_id = '-2'
            returnvariable="records_section_text_Pages">
        </cfinvoke>
        
        <!--- get all Latest News Page Records --->
        <!--- -1 = Parent Pages --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            p_parent_id = '-1'
            returnvariable="records_latest_news_Pages">
        </cfinvoke>
        

        <!--- get all Landing Page Records --->
        <!--- -3 = Landing Pages --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            p_parent_id = '-3'
            returnvariable="records_landing_Pages">
        </cfinvoke>
    
    </cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfprocessingdirective>