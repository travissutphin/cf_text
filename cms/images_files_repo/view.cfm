<cfinclude template="../_templates/header.cfm">

      <!-- =============================================== -->

<cfinclude template="../_templates/nav.cfm">

<!--- send this to the upload.cfm page --->
<cfset session.cfc_to_use = "images_files_repo">
<cfset session.file_field = "ifr_image">
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
            Image / File Repository
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
                        <th>Image</th>
                        <th>
                        <!-- Batch Upload -->
                        <button type="button" class="btn btn-block btn-primary btn-xs" data-toggle="modal" data-target="##myModal">
                          Batch Image Upload
                        </button>
                        </th>
                        <th width="75px">&nbsp;</th>
                    </tr>
				</thead>

                <!--- Image File Repo Records --->
				<cfloop query="records_Images_Files_Repo">
                   
                <form name="edit_main_page" action="" method="post">        		
                <tr>
                    <td><img src="#Request.siteURL#assets/images/uploads/#records_Images_Files_Repo.ifr_image#" width="200px" /></td>
                    <td><cfoutput>#Request.siteURL#assets/images/uploads/#records_Images_Files_Repo.ifr_image#</cfoutput></td>
                    <td><button name="delete" type="submit" class="btn btn-block btn-danger btn-xs" onclick="return confirm('Delete this record?')">Delete</button></td>
                </tr>
                <input name="image_file_repo_id" type="hidden" value="#records_Images_Files_Repo.image_file_repo_id#" />
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


<!-- Modal Batch Upload -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="window.location.reload()"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Batch Upload</h4>
      </div>
      <div class="modal-body">
        <iframe src="../plugins/batch_processor/fileupload.cfm" width="100%" height="600px"></iframe> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" onClick="window.location.reload()">Close</button>
      </div>
    </div>
  </div>
</div>

<cfinclude template="../_templates/footer.cfm">