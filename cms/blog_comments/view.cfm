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
           Blog Comments
            <small></small>
          </h1>
        </section>
		
        <cfif isDefined('session.show_message')>
        	#session.show_message#
            <cfset session.show_message = "">
        </cfif>
           
        <!-- Main content -->
        <section class="content">

                    
			<table class="table table-bordered table-hover">
              
				<thead>
                    <tr>
                        <th>Blog Post</th>
                        <th>Name</th>
                        <th>Date</th>
                        <th width="75px">
                            <form name="add" action="crud_create.cfm" method="post">
                            	<button name="add" class="btn btn-block btn-info btn-xs">Add</button>
                        	</form>
                        </th>
                    </tr>
				</thead>

                <!--- Records --->
				<cfloop query="records_Blog_Comments">
                   
                <form name="edit_main_page" action="" method="post">        		
                <tr>
                	<td>#records_Blog_Comments.bp_title#</td>
                    <td>#records_Blog_Comments.bcom_name#</td>
                    <td>#records_Blog_Comments.bcom_date_added#</td>
                    <td>
                    	<button name="delete" type="submit" class="btn btn-block btn-danger btn-xs" onclick="return confirm('Delete this record?')">Delete</button>
                    </td>
                </tr>
                <input name="blog_comment_id" type="hidden" value="#records_Blog_Comments.blog_comment_id#" />
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