<cfinclude template="../_templates/header.cfm">

      <!-- =============================================== -->

<cfinclude template="../_templates/nav.cfm">

      <!-- =============================================== -->

<cfoutput>

<cfinclude template="controller.cfm">
    
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Bios
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
                        <th>Image</th>
                        <th>Name</th>
                        <th>Title</th>
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
        			
					<cfloop query="records_Bios">
                   
                    <form name="edit_main_page" action="view.cfm" method="post">
                    <tr>
                        <td>
                        	<input name="bi_order" value="#records_Bios.bi_order#" type="text" class="form-control input-sm" onchange="this.form.submit()">
                        </td>
                        <td>
							<cfif #records_Bios.bi_image# neq "">
                        		<img src="#request.siteURL#assets/images/uploads/#records_Bios.bi_image#" width="125px" hspace="10px" vspace="15px" class="img-responsive" />
                            </cfif>
                        </td>
                        <td>#records_Bios.bi_name_preface# #records_Bios.bi_name_first# #records_Bios.bi_name_last#</td>
                        <td>#records_Bios.bi_title#</td>
                        <td><a href="crud_update.cfm?bio_id=#records_Bios.bio_id#"><input type"button" class="btn btn-block btn-success btn-xs" value="Update"/></a></td>
                        <td>
                        <cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS">
                        <input name="delete" value="delete" type="submit" class="btn btn-block btn-danger btn-xs" onClick="return confirm('Do you really want to delete this record?');" />
                        </cfif>
                        </td>
                    </tr>
                    <input name="bio_id" type="hidden" value="#records_Bios.bio_id#" />
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