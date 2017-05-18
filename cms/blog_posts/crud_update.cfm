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
        <!-- Content Header (Blog header) -->
        <section class="content-header">
          <h1>
            Update Blog Post
            <small></small>
          </h1>
        </section>
		
        <cfif isDefined('show_message')>
        	#show_message#
        </cfif>
     
        <!-- Main content -->
        <section class="content"  style="min-height: 1200px;">

			<cfloop query="values_Blog_Posts">
            <form name="manage" action="crud_update.cfm" method="post" role="form" enctype="multipart/form-data" onsubmit="showHide();">                    
                
                <div class="col-md-8">

                    <div class="col-md-4">
                        Post On:<br />
                        <div class="input-group">
  							<span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
                            <input name="bp_post_on" type="text" class="form-control" id="datepicker" value="#DateFormat(values_Blog_Posts.bp_post_on, "mm/dd/yyyy")#"></input>
						</div>	   
                    </div>
                        
                    
                    <cfif #request.blog_allow_customer_change_layout# eq "On">
                    
						<div class="col-md-4">
							Blog Layout:<br />
							<cfinvoke 
								component="#request.cfc#.page_layouts"
                                page_layout_id = "#values_Blog_Posts.p_layout_fk#"
								method="html_list_layouts">
							</cfinvoke>
						</div>	
                    
                    <cfelse>
                    
                    	<input name="bp_layout_fk" type="hidden" value="#values_Blog_Posts.bp_layout_fk#" />
                    
                    </cfif>	                            
  
   						<div class="col-md-4">
							Allow Comments:<br />
							<select name="bp_allow_comments" class="form-control">
                            	<option value="Yes" <cfif #values_Blog_Posts.bp_allow_comments# eq "Yes">selected</cfif>>Yes</option>
                                <option value="No" <cfif #values_Blog_Posts.bp_allow_comments# eq "No">selected</cfif>>No</option>
                            </select>
						</div>	
                                         
            
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>


 
                    <div class="col-md-6">
                        Title:<br />
                        <input name="bp_title" type="text" class="form-control" value="#values_Blog_Posts.bp_title#" />
                    </div>
            
                    <div class="col-md-6">
                        Alias: (if blank, Title will be used)<br />
						<input name="bp_alias" type="text" class="form-control" value="#values_Blog_Posts.bp_alias#" />
                    </div>
  
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>                  
                        
                    <div class="col-md-12">
                        Blog Image / Banner Image:<br />
                        <input name="bp_image" type="file" />
                        <input name="org_x_bp_image" type="hidden" value="#values_Blog_Posts.bp_image#" />
                        <cfif #values_Blog_Posts.bp_image# neq "">
                        	<img src="#request.siteURL#assets/images/uploads/#values_Blog_Posts.bp_image#" width="150px" hspace="10px" vspace="15px" class="img-responsive" />
                        </cfif>
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                                                    
                    <div class="col-md-12">
                        Blog Content:<br />
                        <!--<textarea id="txtarea" class="add_tinymce" data-required="true"></textarea>-->
                        <textarea id="txtarea" name="bp_content" rows="5" data-required="true" class="mceEditor">#values_Blog_Posts.bp_content#</textarea>
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                        
                    <div class="col-md-2">
                        <input name="update" type="submit" class="btn btn-success" value="Update">  
                        <input name="blog_post_id" type="hidden" value="#values_Blog_Posts.blog_post_id#">           
                    </div>
                    
                    <div class="col-md-10">
                        <div id="hidden_div" style="display:none" class="pull-left">
                            <img src="#Request.siteURL#assets/images/ajax-loader.gif" /> &nbsp;&nbsp; Processing Request
                        </div>
                	</div>
 
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
					
                    <!--- comments start --->
                   <cfinvoke 
                        component="#request.cfc#.blog_comments"
                        method="read"
                        blog_post_fk = "#values_Blog_Posts.blog_post_id#"
                        returnvariable="records_Blog_Comments">
                    </cfinvoke>
                    <div class="col-md-12 well">
                    <h3>Comments</h3>
                    <cfloop query="records_Blog_Comments">                        
                        
                        <a href="crud_update.cfm?blog_post_id=3&delete_ip=#records_Blog_Comments.bcom_ip_address#" class="pull-right" onclick="return confirm('Delete all comments with IP address #records_Blog_Comments.bcom_ip_address#?')">Delete all Comments with IP #records_Blog_Comments.bcom_ip_address#</a>
                    	  
                        <a href="crud_update.cfm?blog_post_id=3&delete_comment=#records_Blog_Comments.blog_comment_id#" class="pull-right" onclick="return confirm('Delete this Comment?')">Delete this Comment</a>
                       
                        <strong>#records_Blog_Comments.bcom_name#</strong> -- #DateFormat(records_Blog_Comments.bcom_date_added, "mmmm dd, yyyy HH:mm:ss")#<br />
                        #records_Blog_Comments.bcom_ip_address#<br />
                        <cfset comment = Replace(records_Blog_Comments.bcom_comment, "#chr(13)##chr(10)#", "<br>" , "all")>
                        #comment#
                        <br /><hr />
                    </cfloop>
                    </div> 
                    <!--- comments end --->
                
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
                    
                      <!-- Tab panes -->
                      <div class="tab-content">

                        <div role="tabpanel" class="tab-pane active" id="categories">
                            
                            <cfinvoke 
                                component="#request.cfc#.blog_categories"
                                blog_post_id = "#values_Blog_Posts.blog_post_id#"
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
                            <input name="bp_meta_title" type="text" class="form-control" value="#values_Blog_Posts.bp_meta_title#" />
                            <br />
                            Tags:<br />
                            <input name="bp_meta_tags" type="text" class="form-control" value="#values_Blog_Posts.bp_meta_tags#" />
                            <br />
                            Description:<br />
                            <textarea name="bp_meta_description" rows="6" class="form-control">#values_Blog_Posts.bp_meta_description#</textarea>
                        </div>
    
                        <div role="tabpanel" class="tab-pane" id="social">
                            
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
            "code","link","image","paste", "autoresize"
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