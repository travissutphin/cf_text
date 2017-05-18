<cfinclude template="../_templates/header.cfm">

      <!-- =============================================== -->

<cfinclude template="../_templates/nav.cfm">

      <!-- =============================================== -->

  	<!-- DATE PICKER -->
  	<!-----------------> 	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">  
    <cfset omit_global_jquery = true>
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    
	<script>
	$(function() {
	$( "#datepicker" ).datepicker();
	});
	</script>
    
<cfoutput>

<cfinclude template="controller.cfm">
    
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Create Blog Post
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
                        Post On:<br />
                        <div class="input-group">
  							<span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
  							<input name="bp_post_on" type="text" class="form-control" id="datepicker" value="#DateFormat(now(), "mm/dd/yyyy")#"></input>
						</div>						                
		             
                    </div>
                    
                    <cfif #request.blog_allow_customer_change_layout# eq "On">
                    
						<div class="col-md-4">
							Page Layout:<br />
							<cfinvoke 
								component="#request.cfc#.page_layouts"
								method="html_list_layouts">
							</cfinvoke>
						</div>	
                    
                    <cfelse>
                    
                    	<input name="bp_layout_fk" type="hidden" value="#request.blog_layout_default#" />
                    
                    </cfif>	 	                            
 
 						<div class="col-md-4">
							Allow Comments:<br />
							<select name="bp_allow_comments" class="form-control">
                            	<option value="Yes">Yes</option>
                                <option value="No" checked="checked">No</option>
                            </select>
						</div>	                  
            
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                    
                    <div class="col-md-6">
                        Title:<br />
                        <input name="bp_title" type="text" class="form-control" value="" />
                    </div>
            
                    <div class="col-md-6">
                        Alias: (if blank, Title will be used)<br />
                        <input name="bp_alias" type="text" class="form-control" value="" />
                    </div>
                    
                        
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>

					<div class="col-md-12">
                        Blog Banner Image:<br />
                        <input name="bp_image" type="file" />
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                                                                       
                    <div class="col-md-12">
                        Blog Content:<br />
                        <!--<textarea id="txtarea" class="add_tinymce" data-required="true"></textarea>-->
                        <textarea id="txtarea" name="bp_content" rows="5" data-required="true" class="mceEditor"></textarea>
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
                        <li role="presentation" class="active"><a href="##categories" aria-controls="links" role="tab" data-toggle="tab">Categories</a></li>
                        <li role="presentation"><a href="##images" aria-controls="links" role="tab" data-toggle="tab">Images</a></li>
                        <li role="presentation"><a href="##seo" aria-controls="settings" role="tab" data-toggle="tab">SEO</a></li>
                        <li role="presentation"><a href="##social" aria-controls="settings" role="tab" data-toggle="tab">Social</a></li>
                      </ul>
                    
                      <div class="tab-content">
                      
                        <!-- Tab panes -->
                        <div role="tabpanel" class="tab-pane active" id="categories">
                            
                            <cfinvoke 
                                component="#request.cfc#.blog_categories"
                                method="html_checkbox_blog_categories">
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
                        
                        <div role="tabpanel" class="tab-pane" id="seo">
                            Title:<br />
                            <input name="bp_meta_title" type="text" class="form-control" value="" />
                            <br />
                            Tags:<br />
                            <input name="bp_meta_tags" type="text" class="form-control" value="" />
                            <br />
                            Description:<br />
                            <textarea name="bp_meta_description" rows="6" class="form-control"></textarea>
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