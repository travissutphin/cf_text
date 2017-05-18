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
            Update Content Page
            <small></small>
          </h1>
        </section>
		
        <cfif isDefined('show_message')>
        	#show_message#
        </cfif>
           
        <!-- Main content -->
        <section class="content"  style="min-height: 1200px;">

			<cfloop query="values_Page">
            <form name="manage" action="crud_update.cfm" method="post" role="form" enctype="multipart/form-data" onsubmit="showHide();">                    
                
                <div class="col-md-8">
                    
                    <cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS">
                        <div class="col-md-4">
                            Navigation:<br />
                            <cfinvoke 
                                component="#request.cfc#.pages"
                                p_parent_id = "#values_Page.p_parent_id#"
                                method="html_list_main_navigation">
                            </cfinvoke>
                        </div>
                        
                        <div class="col-md-4">
                            Page Layout:<br />
                            <cfinvoke 
                                component="#request.cfc#.page_layouts"
                                page_layout_id = "#values_Page.p_layout_fk#"
                                method="html_list_layouts">
                            </cfinvoke>
                        </div>	
                    	                            
                        <div class="col-md-12">
                            &nbsp;<!-- spacer -->
                        </div>
                    <cfelse>
                    	<!--- used when customer is logged in --->
                    	<input name="p_parent_id" type="hidden" value="#values_Page.p_parent_id#" />
                        <input name="p_layout_fk" type="hidden" value="#values_Page.p_layout_fk#" />
                    </cfif>
                    
                    <div class="col-md-6">
                        Title:<br />
                        <input name="p_title" type="text" class="form-control" value="#values_Page.p_title#" />
                    </div>
            
                    <div class="col-md-6">
                        <cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS">
                        	Alias: (if blank, Title will be used)<br />
							<input name="p_alias" type="text" class="form-control" value="#values_Page.p_alias#" />
                        <cfelse>
                        	<input name="p_alias" type="hidden" value="#values_Page.p_alias#" />
                        </cfif>
                    </div>
  
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>                  
                        
                    <div class="col-md-12">
                        Image to add to content area:<br />
                        <input name="p_image" type="file" />
                        <input name="org_x_p_image" type="hidden" value="#values_Page.p_image#" />
                        <cfif #values_Page.p_image# neq "">
                        	<img src="#request.siteURL#assets/images/uploads/#values_Page.p_image#" width="150px" hspace="10px" vspace="15px" class="img-responsive" />
                        </cfif>
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                                                    
                    <div class="col-md-12">
                        Page Content:<br />
                        <!--<textarea id="txtarea" class="add_tinymce" data-required="true"></textarea>-->
                        <textarea id="txtarea" name="p_content" rows="5" data-required="true" class="mceEditor">#values_Page.p_content#</textarea>
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                        
                    <div class="col-md-2">
                        <input name="update" type="submit" class="btn btn-success" value="Update">  
                        <input name="page_id" type="hidden" value="#values_Page.page_id#">           
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
                        <li role="presentation"><a href="##seo" aria-controls="settings" role="tab" data-toggle="tab">SEO</a></li>
                        <cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS">
                        <li role="presentation" ><a href="##templates" aria-controls="profile" role="tab" data-toggle="tab">Templates</a></li>
                        </cfif>
                        <li role="presentation"><a href="##social" aria-controls="settings" role="tab" data-toggle="tab">Social</a></li>
                      </ul>
                    
                      <!-- Tab panes -->
                      <div class="tab-content">

                        <div role="tabpanel" class="tab-pane active" id="links">
                            
	                        <cfinvoke 
	            				component="#request.cfc#.pages"
	            				page_id = "#values_Page.page_id#"
	            				method="html_checkbox_pages">
	        				</cfinvoke>
                            
                        </div>
                        
                        <div role="tabpanel" class="tab-pane" id="seo">
                            Title:<br />
                            <input name="p_meta_title" type="text" class="form-control" value="#values_Page.p_meta_title#" />
                            <br />
                            Tags:<br />
                            <input name="p_meta_tags" type="text" class="form-control" value="#values_Page.p_meta_tags#" />
                            <br />
                            Description:<br />
                            <textarea name="p_meta_description" rows="6" class="form-control">#values_Page.p_meta_description#</textarea>
                        </div>
                        
                        <cfif #SESSION.Auth.a_priv# eq "KINGSITEWHIRKS">                      
                        <div role="tabpanel" class="tab-pane" id="templates">
							<br />
                            Before Content:<br />
                            <cfinvoke 
                            	component="#request.cfc#.page_templates"
                            	before_or_after_content = "p_template_before"
                            	page_template_id = "#values_Page.p_template_before#"
                            	method="html_list_templates">
                        	</cfinvoke>
                        
                            <br />
                            After Content:<br />
                             <cfinvoke 
                            	component="#request.cfc#.page_templates"
                            	before_or_after_content = "p_template_after"
                            	page_template_id = "#values_Page.p_template_after#"
                            	method="html_list_templates">
                        	</cfinvoke> 
                                
                        </div>
                        <cfelse>
							<!--- used when customer is logged in --->
                            <input name="p_template_before" type="hidden" value="#values_Page.p_template_before#" />
                            <input name="p_tempalte_after" type="hidden" value="#values_Page.p_template_after#" />                        
                        </cfif>
                        
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
            "code","link"
        ],
        toolbar: "code | link | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent ",
		
		mode : "specific_textareas",
		editor_selector : "mceEditor"
});</script>
        
<cfinclude template="../_templates/footer.cfm">