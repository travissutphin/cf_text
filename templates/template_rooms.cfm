<cfoutput>

<cfif isDefined('form.details_bio')>

	<cfloop query="records_Bios">
		
		<div class="col-md-4">
	 		
	 		<div class="col-md-8">
	 			<img src="#request.siteURL#assets/images/uploads/#records_Bios.bi_image#"  hspace="10px" vspace="15px" class="img-responsive" />
	 		</div>
	 			 		
	 		<div class="col-md-4">
	 			<br />
	 			#records_Bios.bi_name_preface# #records_Bios.bi_name_first# #records_Bios.bi_name_last# #records_Bios.bi_title#
	 			<br /><br />
	 			
				<form name="details" action="index.cfm?alias=bios" method="post">
					<button name="details_bio" type="submit" class="btn btn-info btn-xs">Full Bio</button>
					<input name="bio_id" type="hidden" value="#records_Bios.bio_id#" />
				</form>
				
	 		</div>
	 		
		</div>
		
	</cfloop>

<cfelse>
	
    <div class="row">
    
	<cfloop from="1" to="30" index="i">
    <cfloop query="records_Bios">
				
        <div class="col-md-3" style="padding:0px; margin:0px; min-height:675px;">
			
            <a href="#records_Bios.bi_preview#">
	 			<img src="#request.siteURL#assets/images/uploads/#records_Bios.bi_image#" class="img-responsive" />
            </a>
            <h3>#records_Bios.bi_title#</h3>
            <hr />
            <p>#records_Bios.bi_content#</p>
            <cfif #records_Bios.bi_preview# neq "">
            	<p><a href="#records_Bios.bi_preview#"><button>Details</button></a></p>
            </cfif>
            
            <div class="ribbon-wrapper-green">
            <div class="ribbon-green">#records_Bios.bi_name_preface#</div>
          	</div>
            
            
	 	</div>
	 	
        <div class="col-md-1">
        &nbsp;
        </div>	 		
	
	</cfloop>
    </cfloop>
    </div>

</cfif>

</cfoutput>