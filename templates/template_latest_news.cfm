<cfoutput>

<cfif isDefined('form.details_latest_news')>
	
	<!--- SHOW DETIALS --->

    <div class="col-md-12">
        <form name="archived_latest_news" action="" method="post">
            <input name="view_latest_news" type="submit" class="btn btn-info btn-sm pull-right" value="View Latest News" />
        </form>
    </div>
        
	<cfloop query="records_Latest_News">
	
		<div class="col-md-12">
			
			<h2>#records_Latest_News.p_title#</h2>
            #dateFormat(records_Latest_News.created_at,"Full")#

		</div>

		<div class="col-md-12">
			
            <cfif #records_Latest_News.p_image# neq "">
            	<img src="#request.siteURL#assets/images/uploads/#records_Latest_News.p_image#" width="275px" hspace="20px" vspace="5px" class="img-thumbnail pull-left" />
            </cfif>
            #records_Latest_News.p_content#
            
		</div>
	
	</cfloop>
	
<cfelse>
	
	<!--- SHOW ACTIVE LIST --->
    <!--- active list determined by request.max_latest_news var in Application.cfm file --->
	<cfif isDefined('form.view_archived_latest_news')>
         <div class="col-md-12">
            <form name="archived_latest_news" action="" method="post">
                <input name="view_latest_news" type="submit" class="btn btn-info btn-sm pull-right" value="View Latest News" />
            </form>
        </div>
    <cfelse>
        <div class="col-md-12">
            <form name="archived_latest_news" action="" method="post">
                <input name="view_archived_latest_news" type="submit" class="btn btn-info btn-sm pull-right" value="View Archived News" />
            </form>
        </div>
    </cfif>
    
	<div class="col-md-12">
    
        <cfloop query="records_Latest_News">
            <h2>
            	<span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
                #records_Latest_News.p_title# 
                <small>#dateFormat(records_Latest_News.created_at,"Full")#</small>
            </h2>

            <form name="latest_news" action="" method="post">
                <input name="latest_news" type="submit" class="btn btn-info btn-sm" value="Read News" />
                <input name="details_latest_news" type="hidden" value="#records_Latest_News.p_alias#" />
            </form>           
        </cfloop>
        
    </div>

</cfif>

</cfoutput>