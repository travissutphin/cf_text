<!--- display page links --->	        

    <cfinvoke 
        component="#request.cfc#.links_x_pages"
        page_fk = "#trim(data_Page.page_id)#"
        method="read"
        returnvariable="records_links_pages">
    </cfinvoke>
    
    <cfoutput query="records_links_pages">
        <cfinvoke 
            component="#request.cfc#.pages"
            page_id = "#trim(records_links_pages.link_page_fk)#"
            method="read"
            returnvariable="records_page_alias">
        </cfinvoke>
        
        <ul>
            <cfloop query="records_page_alias">
                <a href="#records_page_alias.p_alias#"><button type="button" class="btn btn-info">#records_page_alias.p_title#</button></a>
                <br />
            </cfloop>
        </ul>
        
    </cfoutput>

<!--- ------------------ --->

<!--- display ads --->

	<cfinclude template="../templates/template_ads.cfm">

<!--- ----------- --->