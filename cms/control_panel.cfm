<cfinclude template="_templates/header.cfm">

      <!-- =============================================== -->

<cfinclude template="_templates/nav.cfm">

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
            Thorium Dashboard
            <small>it all starts here</small>
          </h1>
        </section>
		
        <cfif isDefined('show_message')>
        	#show_message#
        </cfif>
            
        <!-- Main content -->
        <section class="content">

<!--- warn user if the default login is still in use --->
<cfif #SESSION.Auth.a_email# eq "default@sitewhirks.com">
	 
     <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value="warning_default_login"
        returnvariable="warning">
	</cfinvoke>
    
	<cfoutput>
		#warning#
	</cfoutput>
    
</cfif>

 <!--- ADMINISTRATORS ---> 
          <!-- Default box -->
          <div class="box box-warning box-solid collapsed-box">
            <div class="box-header with-border">
              <h3 class="box-title">Administrators</h3>
              <div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-plus"></i></button>
              </div>
            </div>
            <div class="box-body">
                    
			<table class="table table-bordered table-hover">
              
				<thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Active</th>
                        <th width="75px"></th>
                        <th width="75px">&nbsp;</th>
                    </tr>
				</thead>
                	
                    <form name="create" action="control_panel.cfm" method="post">
                    <tr>
                    	<td><input name="a_name_first" value="" type="text" class="form-control input-sm" /></td>
                        <td><input name="a_name_last" value="" type="text" class="form-control input-sm" /></td>
                        <td><input name="a_email" value="" type="email" class="form-control input-sm" /></td>
                        <td><input name="a_pswd" value="" type="password" class="form-control input-sm" /></td>
                        <td></td>
                        <td><input type="submit" class="btn btn-block btn-xs btn-info" value="Create" /></td>
                        <td></td>
                   </tr>
                   <input name="create" type="hidden" value="1" />
                   </form>
                    
                   <cfloop query="records_Admin">
                   <form name="update_admin" action="control_panel.cfm" method="post">
                   <tr>
                        <td><input name="a_name_first" value="#records_Admin.a_name_first#" type="text" class="form-control input-sm"></td>
                        <td><input name="a_name_last" value="#records_Admin.a_name_last#" type="text" class="form-control input-sm"></td>
                        <td><input name="a_email" value="#records_Admin.a_email#" type="email" class="form-control input-sm"></td>
                        <td><input name="a_pswd" value="#records_Admin.a_pswd#" type="password" class="form-control input-sm"></td>
                        <td>#records_Admin.a_active#</td>
                        <td><button class="btn btn-block btn-success btn-xs">Save</button></td>
                        <td>
                        <cfif #records_Admin.recordcount# gt 1>
                        <button name="delete" type="submit" class="btn btn-block btn-danger btn-xs" onclick="return confirm('Are you sure you want to delete this item?');">Delete</button>
                        </cfif>
                        </td>
                    </tr>
                    <input name="admin_id" value="#records_Admin.admin_id#" type="hidden">
                    <input name="update" type="hidden" value="1" />
                    </form>
                    </cfloop>
                
			</table>             
              
            </div><!-- /.box-body -->
            <div class="box-footer">
              
            </div><!-- /.box-footer-->
          </div><!-- /.box -->
<!--- // ADMINISTRATORS ---> 
        
  
 
<cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS"> 
<!--- SETINGS --->  
          <!-- Default box -->
          <div class="box box-warning box-solid collapsed-box">
            <div class="box-header with-border">
              <h3 class="box-title">Settings</h3>
              <div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-plus"></i></button>
              </div>
            </div>
            <div class="box-body">
            
            test            
              
            </div><!-- /.box-body -->
            <div class="box-footer">
              
            </div><!-- /.box-footer-->
          </div><!-- /.box -->  
<!--- // SETINGS ---> 
</cfif> 
  
        
        </section><!-- /.content -->
        
      </div><!-- /.content-wrapper -->

      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Thorium CF</b> Version Basic_2.02
        </div>
        <strong>Footer Info can go here</strong>
      </footer>

 
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->
    
</cfoutput>

<cfinclude template="_templates/footer.cfm">