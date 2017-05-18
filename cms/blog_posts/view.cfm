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
            Blog Posts
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
                        <th width="50px">Post On</th>
                        <th>Title</th>
                        <th>Alias</th>
                        <th width="75px"></th>
                        <th width="75px">
                            <form name="edit_page" action="crud_create.cfm" method="post">
                            	<button name="add" class="btn btn-block btn-info btn-xs">Add</button>
                        	</form>
                        </th>
                    </tr>
				</thead>
        			
                    <!--- BLOG ENTRIES --->
					<cfloop query="records_Blog_Posts">
                   
                    <form name="edit_main_page" action="view.cfm" method="post">
                    <tr class="bg-light-blue">
                        <td>#DateFormat(records_Blog_Posts.bp_post_on, "mm/dd/yyyy")#</td>
                        <td>#records_Blog_Posts.bp_title#</td>
                        <td>#records_Blog_Posts.bp_alias#</td>
                        <td><a href="crud_update.cfm?blog_post_id=#records_Blog_Posts.blog_post_id#"><input type"button" class="btn btn-block btn-success btn-xs" value="Update"/></a></td>
                        <td>
                        <button name="delete" type="submit" class="btn btn-block btn-danger btn-xs">Delete</button>
                        </td>
                    </tr>
                    <input name="blog_post_id" type="hidden" value="#records_Blog_Posts.blog_post_id#" />
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