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
            Update Bio
            <small></small>
          </h1>
        </section>
		
        <cfif isDefined('show_message')>
        	#show_message#
        </cfif>
           
        <!-- Main content -->
        <section class="content" style="min-height: 1200px;">

		<cfloop query="records_Bios">
		
            <form name="manage" action="" method="post" role="form" enctype="multipart/form-data"  onsubmit="showHide();">                    

			<div class="col-md-8">
			                            
                <div class="col-md-12">
                    
                    <div class="col-md-4">
                        Preface:<br />
                        <input name="bi_name_preface" type="text" class="form-control" value="#records_Bios.bi_name_preface#" />
                    </div>
                    
                    <div class="col-md-4">
                        Title:<br />
                        <input name="bi_title" type="text" class="form-control" value="#records_Bios.bi_title#" />
                    </div>		                            
                   
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>

                    <div class="col-md-4">
                        First Name:<br />
                        <input name="bi_name_first" type="text" class="form-control" value="#records_Bios.bi_name_first#" />
                    </div>
                    
                    <div class="col-md-4">
                        Last Name:<br />
                        <input name="bi_name_last" type="text" class="form-control" value="#records_Bios.bi_name_last#" />
                    </div>		                            

                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>                  
                        
                    <div class="col-md-12">
                        Bio Image:<br />
                        <input name="bi_image" type="file" />
                        <input name="org_x_bi_image" type="hidden" value="#records_Bios.bi_image#" />
                        <cfif #records_Bios.bi_image# neq "">
                        	<img src="#request.siteURL#assets/images/uploads/#records_Bios.bi_image#" width="150px" hspace="10px" vspace="15px" class="img-responsive" />
                        </cfif>
                    </div>
                                     
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                                                    
                    <div class="col-md-12">
                        Bio Content:<br />
                        <!--<textarea id="txtarea" class="add_tinymce" data-required="true"></textarea>-->
                        <textarea id="txtarea" name="bi_content" rows="5" data-required="true" class="mceEditor">#records_Bios.bi_content#</textarea>
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                        
                    <div class="col-md-1">
                        <input name="update" type="submit" class="btn btn-success" value="Update">  
                        <input name="bio_id" type="hidden" value="#records_Bios.bio_id#">                  
                    </div>

                    <div class="col-md-8">
                        <div id="hidden_div" style="display:none" class="pull-right">
                            <img src="#Request.siteURL#assets/images/ajax-loader.gif" /> &nbsp;&nbsp; Processing Request
                        </div>
                    </div>
                                    
                </div>  

			</div>

			<div class="col-md-4">
			
              <div role="tabpanel">
                  
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                      <li role="presentation" class="active"><a href="##links" aria-controls="links" role="tab" data-toggle="tab">Include Links</a></li>
                      <li role="presentation"><a href="##images" aria-controls="links" role="tab" data-toggle="tab">Images</a></li>
                    </ul>
                  
                    <div class="tab-content">
                    
                      <!-- Tab panes -->
                      <div role="tabpanel" class="tab-pane active" id="links">
                          
                        <cfinvoke 
                            component="#request.cfc#.pages"
                            bio_id = "#records_Bios.bio_id#"
                            method="html_checkbox_pages">
                        </cfinvoke>
                          
                      </div>
                      
                      <div role="tabpanel" class="tab-pane" id="images">
                          
                        <!--- get all Image File Repo Records --->
                        <cfinvoke 
                            component="#request.cfc#.images_files_repo"
                            method="read"
                            returnvariable="records_Images_Files_Repo">
                        </cfinvoke> 
                        
                          <div class="col-md-12">
                          <cfloop query="records_Images_Files_Repo">
                              <div class="col-md-3">
                              <img src="#Request.siteURL#assets/images/uploads/#records_Images_Files_Repo.ifr_image#" width="90px" />
                              <br />
                              <input class="form-control" type="text" value="#Request.siteURL#assets/images/uploads/#records_Images_Files_Repo.ifr_image#">
                              </div>
                        </cfloop>
                        </div>
                          
                      </div>
                      
                    </div>
                  
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


<script src="//tinymce.cachefly.net/4.2/tinymce.min.js"></script>
<script>tinyMCE.init({
	
	 plugins: [
            "code","link","image","paste","autoresize"
        ],
        toolbar: "code | link | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | image ",
		image_caption: true,
		image_advtab: true,
		image_description: true,
		paste_word_valid_elements: "b,strong,i,em,h1,h2",
		mode : "specific_textareas",
		editor_selector : "mceEditor",
		autoresize_min_height: 500
});</script>
        
<cfinclude template="../_templates/footer.cfm">