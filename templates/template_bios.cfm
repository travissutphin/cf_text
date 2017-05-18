<cfoutput>

<cfif not isDefined('form.details_bio')>

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

	<cfloop query="records_Bios">
	
		<div class="col-md-12">
			
			<form name="details" action="index.cfm?alias=bios" method="post">
					<button name="x" type="submit" class="btn btn-info btn-xs pull-right">Bio List</button>
			</form>
				
			<h3>#records_Bios.bi_name_preface# #records_Bios.bi_name_first# #records_Bios.bi_name_last# - #records_Bios.bi_title#</h3>
	 		
		</div>

		<div class="col-md-12">
			&nbsp;
		</div>
				
		<div class="col-md-3">
	 		
	 		<img src="#request.siteURL#assets/images/uploads/#records_Bios.bi_image#" class="img-responsive" />
	 		
	 	</div>
	 			 		
	 	<div class="col-md-9">

			#records_Bios.bi_content#
			
			<!--- display page links --->	        
	        <cfinvoke 
	            component="#request.cfc#.links_x_bios"
	            bio_fk = #trim(records_Bios.bio_id)#
	        	method="read"
	        	returnvariable="records_links_pages">
	        </cfinvoke>
	       	
	       	<cfloop query="records_links_pages">
		       	<cfinvoke 
		            component="#request.cfc#.pages"
		            page_id = #trim(records_links_pages.link_page_fk)#
		        	method="read"
		        	returnvariable="records_page_alias">
		        </cfinvoke>
	        	
	        	<cfloop query="records_page_alias">
	       			<a href="#records_page_alias.p_alias#"><input name="update" type="submit" class="btn btn-warning" value="#records_page_alias.p_title#"></a>
	       			<br /><br />
	       		</cfloop>
	       		
	       	</cfloop>
	        <!--- ------------------ --->
			
	 	</div>
	
	</cfloop>

</cfif>

</cfoutput>