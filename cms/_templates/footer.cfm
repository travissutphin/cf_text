<cfoutput>

    <!-- jQuery 2.1.4 -->
    <!--- we can use <cfset omit_global_jquery = true> on pages that do not want to use this version of jQuery --->
    <cfif isDefined('omit_global_jquery')>
    	
    <cfelse>
		<script src="#request.siteURL#assets/css_admin/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    </cfif>
    
    <!-- Bootstrap 3.3.5 -->
    <script src="#request.siteURL#assets/css_admin/bootstrap/js/bootstrap.min.js"></script>
    <!-- SlimScroll -->
    <script src="#request.siteURL#assets/css_admin/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="#request.siteURL#assets/css_admin/plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="#request.siteURL#assets/css_admin/dist/js/app.min.js"></script>
    <!-- Data Tables -->
    <script src="#request.siteURL#assets/css_admin/plugins/datatables/jquery.dataTables.min.js"></script>
    
	<script>
        $(function () {
          $('##table1').DataTable({
          "paging": true,
          "lengthChange": false,
          "searching": false,
          "ordering": false,
          "info": true,
          "autoWidth": false
        });
        });
	</script>
	
    <!-- show hide processing message to user --->
	<script type="text/javascript">
     function showHide() {
       var div = document.getElementById("hidden_div");
       if (div.style.display == 'none') {
         div.style.display = '';
       }
       else {
         div.style.display = 'none';
       }
     }
    </script>
         
  </body>
</html>
</cfoutput>