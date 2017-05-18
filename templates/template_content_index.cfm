<!--- INDEX PAGE --->
<div class="row">

   <cfinclude template="../plugins/simple_slideshow/index.cfm">
  
</div>

<div class="row">
	<div class="col-md-12">&nbsp;</div>
</div>

<div class="row">
  <div class="col-md-12">
  
	<!--- CONTENT --->     
	<cfoutput>
    
		<cfif #data_page.p_image# neq "">
		  <img src="#request.siteURL#assets/images/uploads/#data_page.p_image#" width="250px" hspace="25px" vspace="5px" class="img-responsive pull-left" />
		</cfif>
		
        <!--- all images will get full url for current site to uploads dir --->
		<cfset image_location = #request.siteURL# & "assets/images/">
		<cfset p_content = replace(#data_Page.p_content#,"../../assets/images/",#image_location#,"ALL")>
		#p_content#
		
	</cfoutput>	
  
  </div>
</div>