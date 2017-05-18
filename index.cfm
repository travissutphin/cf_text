<cfif isDefined('url.alias')>

<cfelse>
	<cfset #url.alias# = "home">
</cfif>
<cfinclude template="controller.cfm">
<!DOCTYPE html>
<html lang="en" >
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    
	<cfoutput>
    <meta name="description" content="#data_Page.p_meta_description#">
    <meta name="keywords" content="#data_Page.p_meta_tags#">
    </cfoutput>
    
    <link rel="icon" href="../../favicon.ico">

    <title><cfoutput>#request.title# - #data_Page.p_title#</cfoutput></title>

    <!-- Bootstrap core CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->
    <link href="navbar.css" rel="stylesheet">
<style>
body {
  padding-top: 20px;
  padding-bottom: 20px;
  
   margin: 0;
   background-color:#dedede;
-webkit-background-size: cover;
-moz-background-size: cover;
-o-background-size: cover;
background-size: cover;
	
}

.navbar {
  margin-bottom: 20px;
}

p{
	color:#333;
}


</style>
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

<div class="container" style="background-color:#FFF">

<div class="row">
  <div class="col-md-12"><h1 class="text-center"><img src="assets/images/NeasePantherLogo.png" class="img-responsive pull-left"><cfoutput>#request.title#</cfoutput></h1></div>
</div>


      <!-- Static navbar -->
      <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
          </div>
          
          <cfoutput>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="#request.siteURL#">Home</a></li>
              
			  <!---
              <li class="dropdown">
              <a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Services <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="#request.siteURL#Pasture-Boarding">Pasture Boarding</a></li>
                <li><a href="#request.siteURL#Rental-Properties">Rental Properties</a></li>
                <li><a href="#request.siteURL#Alpaca-Sales">Alpaca Sales</a></li>
              </ul>
              </li>
			  --->
			  <!---
              <li><a href="#request.siteURL#Schedule">Schedule</a></li>
              <li><a href="#request.siteURL#Results">Results</a></li>
              <li><a href="#request.siteURL#Reminders">Reminders</a></li>
              <li><a href="#request.siteURL#Gallery">Gallery</a></li>
              --->
              <cfif isDefined('SESSION.Auth.is_logged_in') and #SESSION.Auth.is_logged_in# eq "Yes">
              	<cfif isDefined('SESSION.Auth.role_fk') and #SESSION.Auth.role_fk# eq '2'>
                <li><a href="#request.siteURL#Control-Panel">Send Message</a></li>
                <li><a href="#request.siteURL#Team-Data">Team Data</a></li>
                </cfif> 
                <li><a href="#request.siteURL#My-Profile">My Profile</a></li>
                <li><a href="#request.siteURL#Logout">Log Out</a></li>
              <cfelse>
              	<li><a href="#request.siteURL#Login">Login/Register</a></li>
              </cfif>

            </ul>
          </div><!--/.nav-collapse -->
          </cfoutput>
          
        </div><!--/.container-fluid -->
      </nav>


<cfif #url.alias# eq "home">

	<!--- CONTENT FULL PAGE --->
    <cfinclude template="templates/template_content_index.cfm">

<cfelse>
    
    <cfif #data_Page.p_layout_fk# eq '1'>
    
        <!--- CONTENT FULL PAGE --->
        <cfinclude template="templates/template_content_full.cfm">
        
    <cfelseif #data_Page.p_layout_fk# eq '2'>
    
        <!--- CONTENT ON THE LEFT --->
        <cfinclude template="templates/template_content_left.cfm">
    
    <cfelseif #data_Page.p_layout_fk# eq '3'>
    
        <!--- CONTENT ON THE RIGHT --->
        <cfinclude template="templates/template_content_right.cfm">
        
    </cfif>
    
</cfif>


 	<!--- footer--->
    <div class="col-md-12">
      	<p>&nbsp;</p>
        <div align="center"><cfoutput>#footer.p_content#</cfoutput></div>
    </div>
    
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <cfif #url.alias# neq "home" and #url.alias# neq "gallery">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	</cfif>
    
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

<script>    
    /*!
 * IE10 viewport hack for Surface/desktop Windows 8 bug
 * Copyright 2014-2015 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 */

// See the Getting Started docs for more information:
// http://getbootstrap.com/getting-started/#support-ie10-width

(function () {
  'use strict';

  if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
    var msViewportStyle = document.createElement('style')
    msViewportStyle.appendChild(
      document.createTextNode(
        '@-ms-viewport{width:auto!important}'
      )
    )
    document.querySelector('head').appendChild(msViewportStyle)
  }

})();

</script>

  </body>
</html>
