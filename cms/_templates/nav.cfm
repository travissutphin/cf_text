<cfoutput>
<!--- NOTES --->
<!--- #request.active_x# are all set in the Application.cfm file --->
     <!-- Left side column. contains the sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          <!-- Sidebar user panel -->
          
          <!--
          <div class="user-panel">
          <div class="pull-left image">
          	<img src="../../dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
          </div>
          <div class="pull-left info">
          	<p>#SESSION.Auth.a_name_first# #SESSION.Auth.a_name_last#</p>
          </div>
          </div>
          -->

          <!-- /.search form -->
          <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu">
            <li class="header">MAIN NAVIGATION</li>
            
            	<li><a href="#request.appURL#control_panel.cfm"><i class="fa fa-circle-o text-red"></i> <span>Dashboard</span></a></li>
            <cfif #request.active_pages# eq "On">
     			<li><a href="#request.appURL#pages/view.cfm?page_type=Page"><i class="fa fa-circle-o text-aqua"></i> <span>Pages</span></a></li>
            </cfif>
            <cfif #request.latest_news# eq "On">
            	<li><a href="#request.appURL#pages/view.cfm?page_type=News"><i class="fa fa-circle-o text-aqua"></i> <span>Latest News</span></a></li>
            </cfif>
            <cfif #request.blog# eq "On">
            	<li><a href="#request.appURL#pages/view.cfm?page_type=Blog"><i class="fa fa-circle-o text-aqua"></i> <span>Blog Posts</span></a></li>
                <li><a href="#request.appURL#blog_categories/"><i class="fa fa-circle-o text-aqua"></i> <span>Blog Categories</span></a></li>
            </cfif>
            <cfif #request.active_image_repository# eq "On">
            	<li><a href="#request.appURL#images_files_repo/"><i class="fa fa-circle-o text-aqua"></i> <span>Image Repository</span></a></li>
            </cfif>
            <cfif #request.active_slide_show# eq "On">
     			<li><a href="#request.appURL#slide_show/"><i class="fa fa-circle-o text-aqua"></i> <span>Slide Show</span></a></li>
            </cfif>
            <cfif #request.active_gallery_categories# eq "On">
            	<li><a href="#request.appURL#gallery_categories/"><i class="fa fa-circle-o text-aqua"></i> <span>Galleries</span></a></li>
            </cfif>
            <cfif #request.active_bios# eq "On">
            	<li><a href="#request.appURL#bios/"><i class="fa fa-circle-o text-aqua"></i> <span>Bios</span></a></li>
            </cfif>
            <cfif #request.active_ads# eq "On">
            	<li><a href="#request.appURL#ads/"><i class="fa fa-circle-o text-aqua"></i> <span>Ads</span></a></li>
            </cfif>
            <cfif #request.message_board# eq "On">
            	<li><a href="#request.appURL#message_board/"><i class="fa fa-circle-o text-aqua"></i> <span>Message Board</span></a></li>
            </cfif>
            <li><a href="#request.appURL#index.cfm?logout"><i class="fa fa-circle-o text-aqua"></i> <span>Log Out</span></a></li>
            <!--
            <li><a href="##"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>
            <li><a href="##"><i class="fa fa-circle-o text-yellow"></i> <span>Warning</span></a></li>
            <li><a href="#request.appUrl#admin"><i class="fa fa-circle-o text-aqua"></i> <span>Administrators</span></a></li>
            -->
          </ul>
        </section>
        <!-- /.sidebar -->
      </aside>
</cfoutput>