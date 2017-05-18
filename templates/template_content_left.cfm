<!--- PAGE HEADER --->           

<div class="col-md-12">  
  
  <h1><cfoutput>#data_Page.p_title#</cfoutput></h1>
  
</div>


<!--- LEFT --->
<div class="col-md-9">

    <div class="row clear">
      <div class="col-md-12">

        <!--- TEMPLATE BEFORE CONTENT --->
		<cfif #data_Page.p_template_before# neq '0'>
        	
            <cfinvoke 
                component="#request.cfc#.page_templates"
                method="read"
                page_template_id = "#data_Page.p_template_before#"
                returnvariable="template_before_content">
            </cfinvoke>
            
            <cfoutput query="template_before_content">
            	<cfinclude template="../templates/#template_before_content.pt_template#">
            </cfoutput>
        
        </cfif>

        <div class="col-md-12"> 
			<!--- CONTENT --->     
            <cfoutput>
            
				<cfif #data_page.p_image# neq "">
                <img src="#request.siteURL#assets/images/uploads/#data_page.p_image#" width="250px" hspace="25px" vspace="5px" class="img-responsive pull-left" />
                </cfif>
                <cfset image_location = #request.siteURL# & "assets/images/">
                <cfset p_content = replace(#data_Page.p_content#,"../assets/images/",#image_location#,"ALL")>
                #p_content#
                
            </cfoutput>
        </div>
        
        <!--- TEMPLATE AFTER CONTENT --->
        <cfif #data_Page.p_template_after# neq '0'>
        	
            <cfinvoke 
                component="#request.cfc#.page_templates"
                method="read"
                page_template_id = "#data_Page.p_template_after#"
                returnvariable="template_after_content">
            </cfinvoke>

            <cfoutput query="template_after_content">
            	<cfinclude template="../templates/#template_after_content.pt_template#">
            </cfoutput>
        
        </cfif>
        
      </div><!-- //<div class="col-md-12"> -->
    </div><!-- //<div class="row"> -->

</div><!-- //<div class="col-md-10"> -->


<!--- RIGHT --->
<div class="col-md-3">

	<cfinclude template="../templates/template_side_bar.cfm">

</div><!-- //<div class="col-md-8"> -->
