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
            Slide Show
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
                        <th width="50px">Ordering</th>
                        <th>Title</th>
                        <th>Image</th>
                        <th>&nbsp;</th>
                        <th width="75px">
                            <form name="add" action="crud_create.cfm" method="post">
                            	<button name="add" class="btn btn-block btn-info btn-xs">Add</button>
                        	</form>
                        </th>
                    </tr>
				</thead>

                <!--- Slide Show Records --->
				<cfloop query="records_Slide_Show">
                   
                <form name="edit_main_page" action="" method="post">        		
                <tr>
                	<td><input name="ss_order" value="#records_Slide_Show.ss_order#" type="text" class="form-control input-sm" onchange="this.form.submit()"></td>
                    <td><input name="ss_title" value="#records_Slide_Show.ss_title#" type="text" class="form-control input-sm" onchange="this.form.submit()"></td>
                    <td><img src="#Request.siteURL#assets/images/uploads/#records_Slide_Show.ss_image#" width="400px" /></td>
                    <td>
                    	<a href="crud_update.cfm?view_record=#records_Slide_Show.slide_show_id#"><button name="view_record" type="button" class="btn btn-block btn-xs">Update</button></a>
                    </td>
                    <td><button name="delete" type="submit" class="btn btn-block btn-danger btn-xs" onclick="return confirm('Delete this record?')">Delete</button></td>
                </tr>
                <input name="slide_show_id" type="hidden" value="#records_Slide_Show.slide_show_id#" />
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