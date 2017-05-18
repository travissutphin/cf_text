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
            Add to Repo
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

            <form name="manage" action="" method="post" role="form" enctype="multipart/form-data" onsubmit="showHide();">                    
                
                <div class="col-md-4">
                	Image:<br />
                    <input name="ifr_image" type="file" class="form-control"/>
                </div>

                <div class="col-xs-12">
                	&nbsp;<!-- spacer -->
                </div>
                        
                <div class="col-xs-1">
                	<input name="create" type="submit" class="btn btn-success" value="Create">             
                </div>

                <div class="col-xs-11">
                	<div id="hidden_div" style="display:none" class="pull-left">
                		<img src="#Request.siteURL#assets/images/ajax-loader.gif" /> &nbsp;&nbsp; Processing Request
					</div>
                </div>
                                                                   
             </form><!-- /form -->                    



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