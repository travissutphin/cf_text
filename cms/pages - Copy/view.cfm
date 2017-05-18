<cfinclude template="../_templates/header.cfm">

      <!-- =============================================== -->

<cfinclude template="../_templates/nav.cfm">

      <!-- =============================================== -->

<cfoutput>
<!-- Data Tables -->
<link rel="stylesheet" href="#request.siteURL#assets/css_admin/plugins/datatables/dataTables.bootstrap.css">

<cfinclude template="controller.cfm">
    
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Content Pages
            <small></small>
          </h1>
        </section>
		
        <cfif isDefined('show_message')>
        	#show_message#
        </cfif>
           
        <!-- Main content -->
        <section class="content">

                    
			<table class="table table-bordered table-hover">
              
				<thead>
                    <tr>
                        <th width="50px">Ordering</th>
                        <th>Title</th>
                        <th>Alias</th>
                        <th>Navigation</th>
                        <th width="75px"></th>
                        <th width="75px">
                        	<cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS">
                            <form name="edit_page" action="crud_create.cfm" method="post">
                            	<button name="add" class="btn btn-block btn-info btn-xs">Add</button>
                        	</form>
                            </cfif>
                        </th>
                    </tr>
				</thead>
        			
                    <!--- PARENT PAGES --->
					<cfloop query="records_parent_Pages">
                   
                    <form name="edit_main_page" action="view.cfm" method="post">
                    <tr class="bg-light-blue">
                        <td>
                        <input name="p_order" value="#records_parent_Pages.p_order#" type="text" class="form-control input-sm" onchange="this.form.submit()"></td>
                        <td>#records_parent_Pages.p_title#</td>
                        <td>#records_parent_Pages.p_alias#</td>
                        <td>Main Nav</td>
                        <td><a href="crud_update.cfm?page_id=#records_parent_Pages.page_id#"><input type"button" class="btn btn-block btn-success btn-xs" value="Update"/></a></td>
                        <td>
                        <cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS">
                        <button name="delete" type="submit" class="btn btn-block btn-danger btn-xs">Delete</button>
                        </cfif>
                        </td>
                    </tr>
                    <input name="page_id" type="hidden" value="#records_parent_Pages.page_id#" />
                    </form>
                    
                        <!--- CHILD PAGES --->
                        <cfinvoke 
                            component="#request.cfc#.pages"
                            method="read"
                            p_parent_id="#records_parent_Pages.page_id#"
                            returnvariable="records_child_Pages">
                        </cfinvoke>
                       
						<cfloop query="records_child_Pages">
                        <form name="edit_sub_page" action="view.cfm" method="post">
						<tr class="bg-aqua">
                            <td><input name="p_order" value="#records_child_Pages.p_order#" type="text" class="form-control input-sm" onchange="this.form.submit()"></td>
                            <td><span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>&nbsp;&nbsp; #records_child_Pages.p_title#</td>
                            <td>#records_child_Pages.p_alias#</td>
                            <td></td> 
                            <td><a href="crud_update.cfm?page_id=#records_child_Pages.page_id#"><input type"button" class="btn btn-block btn-success btn-xs" value="Update"/></a></td>
                            <td>
                            <cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS">
                            <button name="delete" type="submit" class="btn btn-block btn-danger btn-xs">Delete</button>
                            </cfif>
                            </td>
						</tr>
                        <input name="page_id" type="hidden" value="#records_child_Pages.page_id#" />
                        </form>
                        </cfloop>
                    
                    </cfloop>


 					<!--- SECTION TEXT --->
                    <cfloop query="records_section_text_Pages">
                   
                    <form name="edit_main_page" action="view.cfm" method="post">
                    <tr class="bg-gray">
                        <td><input name="p_order" value="#records_section_text_Pages.p_order#" type="text" class="form-control input-sm" onchange="this.form.submit()"></td>
                        <td>#records_section_text_Pages.p_title#</td>
                        <td>#records_section_text_Pages.p_alias#</td>
                        <td>Section Text</td>
                        <td><a href="crud_update.cfm?page_id=#records_section_text_Pages.page_id#"><input type"button" class="btn btn-block btn-success btn-xs" value="Update"/></a></td>
                        <td>
                        <cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS">
                        <button name="delete" type="submit" class="btn btn-block btn-danger btn-xs">Delete</button>
                        </cfif>
                        </td>
                    </tr>
                    <input name="page_id" type="hidden" value="#records_section_text_Pages.page_id#" />
                    </form>                    
                    
                    </cfloop>
                    
 					<!--- LATEST NEWS PAGES --->
                    <cfloop query="records_latest_news_Pages">
                   
                    <form name="edit_main_page" action="view.cfm" method="post">
                    <tr class="bg-purple">
                        <td><input name="p_order" value="#records_latest_news_Pages.p_order#" type="text" class="form-control input-sm" onchange="this.form.submit()"></td>
                        <td>#records_latest_news_Pages.p_title#</td>
                        <td>#records_latest_news_Pages.p_alias#</td>
                        <td>Latest News</td>
                        <td><a href="crud_update.cfm?page_id=#records_latest_news_Pages.page_id#"><input type"button" class="btn btn-block btn-success btn-xs" value="Update"/></a></td>
                        <td><button name="delete" type="submit" class="btn btn-block btn-danger btn-xs">Delete</button></td>
                    </tr>
                    <input name="page_id" type="hidden" value="#records_latest_news_Pages.page_id#" />
                    </form>                    
                    
                    </cfloop>
 
  					<!--- LANDING PAGES --->
                    <cfloop query="records_landing_Pages">
                   
                    <form name="edit_main_page" action="view.cfm" method="post">
                    <tr class="bg-purple">
                        <td><input name="p_order" value="#records_landing_Pages.p_order#" type="text" class="form-control input-sm" onchange="this.form.submit()"></td>
                        <td>#records_landing_Pages.p_title#</td>
                        <td>#records_landing_Pages.p_alias#</td>
                        <td>Landing Page</td>
                        <td><a href="crud_update.cfm?page_id=#records_landing_Pages.page_id#"><input type"button" class="btn btn-block btn-success btn-xs" value="Update"/></a></td>
                        <td><button name="delete" type="submit" class="btn btn-block btn-danger btn-xs">Delete</button></td>
                    </tr>
                    <input name="page_id" type="hidden" value="#records_landing_Pages.page_id#" />
                    </form>                    
                    
                    </cfloop>
                                                       
			</table>             


        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->


<!---
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Thorium CF</b> Version 2.01
        </div>
        <strong>Footer Info can go here</strong>
      </footer>
--->
 
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->
    
</cfoutput>

<cfinclude template="../_templates/footer.cfm">