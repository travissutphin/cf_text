<cfoutput>

    <!--- left column --->
    <div class="col-md-3">
        <cfloop query="records_Blog_Categories">
            <a href="#request.siteURL#Blog?blog_category=#records_Blog_Categories.blog_category_id#">#records_Blog_Categories.bc_category#</a><br />
        </cfloop>
    </div>
    
    <!--- main content --->
    <div class="col-md-9">
        
        <cfloop query="records_Blog_Posts">

            <h3><span class="glyphicon glyphicon-option-vertical" aria-hidden="true"></span> #records_Blog_Posts.p_title# <small>#dateFormat(records_Blog_Posts.p_blog_post_on, "Long")#</small></h3>
            <cfif #url.alias# eq "Blog">
            	              
                <cfset image_location = #request.siteURL# & "assets/images/">
                <cfset p_content_piece = replace(#records_Blog_Posts.p_content#,"../../assets/images/",#image_location#,"ALL")>
                #Left(p_content_piece, 400)# ...
                                
                <br />
            	<a href="#request.siteURL##records_Blog_Posts.p_alias#">Read More <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></a>
            <cfelse>
            	
                <!---
                <cfset image_location = #request.siteURL# & "assets/images/">
                <cfset p_content = replace(#records_Blog_Posts.p_content#,"../../assets/images/",#image_location#,"ALL")>
                #p_content#
                --->
                
            </cfif>

            <hr />
        </cfloop>
	</div>
     



<!---
    <div class="row" style="background-color:##EAA21A; padding: 0px;">          
          
		  <div class="col-md-7">  
          
            <cfif #data_page.p_image# neq "">
                <img src="#request.siteURL#assets/images/uploads/#data_page.p_image#" class="img-responsive" />
            <cfelse>
            	<img src="#request.siteURL#assets/images/default_page_image.jpg" class="img-responsive" />
          	</cfif>
            
          </div>
		  
          <div class="col-md-5">  
          
          	<br /><br />
            <h1 style="color:##FFF">#data_Page.p_title#</h1>
          
          </div>
          
    </div>



    <div class="row">
    
        <div class="col-md-3">
            &nbsp;
        </div>
        
        <div class="col-md-6">
        
          <!--- TEMPLATE BEFORE CONTENT --->
          <cfif #data_Page.p_template_before# neq '0'>
              
              <cfinvoke 
                  component="#request.cfc#.page_templates"
                  method="read"
                  page_template_id = "#data_Page.p_template_before#"
                  returnvariable="template_before_content">
              </cfinvoke>
              
              <cfloop query="template_before_content">
                  <cfinclude template="../templates/#template_before_content.pt_template#">
              </cfloop>
          
          </cfif>
        
			<div class="col-md-12"> 
			<!--- CONTENT --->     
            
                <cfset image_location = #request.siteURL# & "assets/images/">
                <cfset p_content = replace(#data_Page.p_content#,"../../assets/images/",#image_location#,"ALL")>
                #p_content#
                
			</div>
          
          <!--- TEMPLATE AFTER CONTENT --->
          <cfif #data_Page.p_template_after# neq '0'>
              
              <cfinvoke 
                  component="#request.cfc#.page_templates"
                  method="read"
                  page_template_id = "#data_Page.p_template_after#"
                  returnvariable="template_after_content">
              </cfinvoke>
        
              <cfloop query="template_after_content">
                  <cfinclude template="../templates/#template_after_content.pt_template#">
              </cfloop>
          
          </cfif>
          
        </div>

        <div class="col-md-3">
            &nbsp;
        </div>
              
    </div>
	
--->


</cfoutput>