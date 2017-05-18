<cfoutput>
   
    <cfloop query="records_Ads">
	
		<div class="col-md-12">
    		<cfif #records_Ads.ads_link# neq "">
                <a href="#records_Ads.ads_link#" target="_blank">
                    <img src="#Request.siteURL#assets/images/uploads/#records_Ads.ads_image#" class="img-thumbnail" />
                </a>
                <div class="col-md-12">&nbsp;</div>
            <cfelse>
                <img src="#Request.siteURL#assets/images/uploads/#records_Ads.ads_image#" class="img-thumbnail" />
                <div class="col-md-12">&nbsp;</div>
            </cfif>
		</div>        

	</cfloop>

</cfoutput>