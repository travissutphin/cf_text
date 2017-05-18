<!---  NOT USED --->
<cfabort>

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
            Update
            <small></small>
          </h1>
        </section>
		
        <cfif isDefined('session.show_message')>
        	#session.show_message#
            <cfset session.show_message = "">
        </cfif>
           
        <!-- Main content -->
        <section class="content">
			
            <div class="row">

            <!--- Image File Repo Records --->
			<cfloop query="records_Images_Files_Repo">
            <form name="manage" action="" method="post" role="form" enctype="multipart/form-data" onsubmit="showHide();">                    
                
                <div class="col-md-4">
                	Image:<br />
                    <input name="ifr_image" type="file" class="form-control"/>
                    <cfif #records_Images_Files_Repo.ifr_image# neq "">
                    	<img src="#Request.siteURL#assets/images/uploads/#records_Images_Files_Repo.ifr_image#" width="300px" />
                    </cfif>
                </div>

                <div class="col-md-12">
                	&nbsp;<!-- spacer -->
                </div>
                        
                <div class="col-md-1">
                	<input name="update" type="submit" class="btn btn-success" value="Update" />
                    <input name="image_file_repo_id" type="hidden" value="#records_Images_Files_Repo.image_file_repo_id#" />            
                </div>

                <div class="col-md-11">
                	<div id="hidden_div" style="display:none" class="pull-left">
                		<img src="#Request.siteURL#assets/images/ajax-loader.gif" /> &nbsp;&nbsp; Processing Request
					</div>
                </div>
                                                                   
            </form><!-- /form -->                    
			</cfloop>


        </section><!-- /.content -->
      
      </div><!-- /.content-wrapper -->


<!---
      <footer class="main-footer">
        <div class="pull-right hidden-md">
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