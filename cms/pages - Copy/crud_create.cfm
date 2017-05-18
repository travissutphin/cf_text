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
            Create Content Page
            <small></small>
          </h1>
        </section>
		
        <cfif isDefined('show_message')>
        	#show_message#
        </cfif>
           
        <!-- Main content -->
        <section class="content" style="min-height: 1200px;">


            <form name="manage" action="crud_create.cfm" method="post" role="form" enctype="multipart/form-data" onsubmit="showHide();">                    
                
                <div class="col-md-8">
                    
                    <div class="col-md-4">
                        Navigation:<br />
                        <cfinvoke 
                            component="#request.cfc#.pages"
                            method="html_list_main_navigation">
                        </cfinvoke>
                    </div>
                    
                    <div class="col-md-4">
                        Page Layout:<br />
                        <cfinvoke 
                        	component="#request.cfc#.page_layouts"
                            method="html_list_layouts">
                        </cfinvoke>
                    </div>		                            
                   
            
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                    
                    <div class="col-md-6">
                        Title:<br />
                        <input name="p_title" type="text" class="form-control" value="" />
                    </div>
            
                    <div class="col-md-6">
                        Alias: (if blank, Title will be used)<br />
                        <input name="p_alias" type="text" class="form-control" value="" />
                    </div>
                    
                        
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>

					<div class="col-md-12">
                        Image to add to content area:<br />
                        <input name="p_image" type="file" />
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                                                                       
                    <div class="col-md-12">
                        Page Content:<br />
                        <!--<textarea id="txtarea" class="add_tinymce" data-required="true"></textarea>-->
                        <textarea id="txtarea" name="p_content" rows="5" data-required="true" class="mceEditor"></textarea>
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                        
                    <div class="col-md-2">
                        <input name="create" type="submit" class="btn btn-success" value="Create">             
                    </div>

                    <div class="col-md-10">
                        <div id="hidden_div" style="display:none" class="pull-left">
                            <img src="#Request.siteURL#assets/images/ajax-loader.gif" /> &nbsp;&nbsp; Processing Request
                        </div>
                    </div>
                
                </div>
                
                <div class="col-md-4">
                    
                    <div role="tabpanel">
                    
                      <!-- Nav tabs -->
                      <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="##links" aria-controls="links" role="tab" data-toggle="tab">Include Links</a></li>
                         <li role="presentation"><a href="##images" aria-controls="links" role="tab" data-toggle="tab">Images</a></li>
                        <li role="presentation"><a href="##seo" aria-controls="settings" role="tab" data-toggle="tab">SEO</a></li>
                        <li role="presentation" ><a href="##templates" aria-controls="profile" role="tab" data-toggle="tab">Templates</a></li>
                        <li role="presentation"><a href="##social" aria-controls="settings" role="tab" data-toggle="tab">Social</a></li>
                      </ul>
                    
                      <div class="tab-content">
                      
                        <!-- Tab panes -->
                        <div role="tabpanel" class="tab-pane active" id="links">
                            
                            <cfinvoke 
                                component="#request.cfc#.pages"
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
                          
                          <cfloop query="records_Images_Files_Repo">
                          	<img src="#Request.siteURL#assets/images/uploads/#records_Images_Files_Repo.ifr_image#" width="125px" />
                            <br />
                          </cfloop>
                            
                        </div>
                        
                        <div role="tabpanel" class="tab-pane" id="seo">
                            Title:<br />
                            <input name="p_meta_title" type="text" class="form-control" value="" />
                            <br />
                            Tags:<br />
                            <input name="p_meta_tags" type="text" class="form-control" value="" />
                            <br />
                            Description:<br />
                            <textarea name="p_meta_description" rows="6" class="form-control"></textarea>
                        </div>
                                                
                        <div role="tabpanel" class="tab-pane" id="templates">
                            <br />
                            Before Content:<br />
                            <cfinvoke 
                            	component="#request.cfc#.page_templates"
                            	before_or_after_content = "p_template_before"
                            	method="html_list_templates">
                        	</cfinvoke>
                        
                            <br />
                            After Content:<br />
                             <cfinvoke 
                            	component="#request.cfc#.page_templates"
                            	before_or_after_content = "p_template_after"
                            	method="html_list_templates">
                        	</cfinvoke>                           
                            
                        </div>
                        
                        <div role="tabpanel" class="tab-pane" id="social">
                            
                        </div>
                        
                      </div>
                    
                    </div>
                    
                </div>                         
                    
                </form><!-- /form -->                    



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
            "code","link","image","paste"
        ],
        toolbar: "code | link | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | image ",
		image_caption: true,
		image_advtab: true,
		image_description: true,
		paste_word_valid_elements: "b,strong,i,em,h1,h2",
		plugins: "image imagetools",
  imagetools_toolbar: "rotateleft rotateright | flipv fliph | editimage imageoptions",
		image_list: [
    {title: 'My image 1', value: 'http://sitewhirks.com/dev_swcms/assets/images/uploads/eEwHDesert1.jpg'},
    {title: 'My image 2', value: 'http://www.moxiecode.com/my2.gif'}
  ],
  
  style_formats: [
  {title: 'Image Left', selector: 'img', styles: {
    'float' : 'left',
    'margin': '0 10px 0 10px'
  }},
  {title: 'Image Right', selector: 'img', styles: {
    'float' : 'right',
    'margin': '0 10px 0 10px'
  }}
],
		mode : "specific_textareas",
		editor_selector : "mceEditor"
});</script>
        
<cfinclude template="../_templates/footer.cfm">