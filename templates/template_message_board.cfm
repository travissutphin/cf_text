<!--- MESSAGE BOARD --->           
<cfinvoke 
    component="#request.cfc#._helpers"
    method="random_string_Helpers"
    returnvariable="random_captcha">
</cfinvoke>
<cfset session.random_captcha = #random_captcha#>

<!--- if submitted, show user message 
<cfif isDefined('session.show_message') and #session.show_message# neq "">
	#session.show_message#
    <cfset #session.show_message# = "">
</cfif>
--->

<div class="col-md-12">  

	<cfif isDefined('send_message_board')>
        <div class="alert alert-success">Your message has been created.  Once it has been approved, it will be displayed on the site.</div>
    </cfif>
  
  <cfoutput query="records_Message_Board">
  
  	<div class="well">
    	
        <div class="pull-left">
        <img src="#Request.siteURL#assets/images/uploads/#records_Message_Board.mp_image#" class="img-responsive" />
        </div>
        #records_Message_Board.mb_name_first# #records_Message_Board.mb_name_last#<br />
        #dateFormat(records_Message_Board.mb_created_on,"long")#
        <hr />
        #records_Message_Board.mb_message#
        
    </div>
  
  </cfoutput>
  
</div>

<div class="col-md-12"> 

	<cfoutput>
	<form name="submit_form" action="#request.siteUrl#" method="post" enctype="multipart/form-data">

		<div class="row">
        
            <div class="col-md-6">
                Your First Name:<br />
                <input name="mb_name_first" type="text" value="" class="form-control" />
            </div>
            
            <div class="col-md-6">
                Your Last Name:<br />
                <input name="mb_name_last" type="text" value="" class="form-control" />
            </div>
        
            <div class="col-md-12">
                &nbsp;<!-- spacer -->
            </div>
        
            <div class="col-md-12">
                Comment<br />
                <textarea name="mb_message" class="form-control" ></textarea>
            </div>
        
            <div class="col-md-12">
                &nbsp;<!-- spacer -->
            </div>
            
            <div class="col-md-12">
                Image:<br />
                <input name="mb_image" type="file" class="form-control"/>
            </div>

            <div class="col-md-12">
                &nbsp;<!-- spacer -->
            </div>
                    
            <div class="col-md-6">
                Enter the text you see in the box:<br />
                <input name="match_this" type="text" class="form-control" /> &nbsp;&nbsp; 
            </div>   

            <div class="col-md-12">
                &nbsp;<!-- spacer -->
            </div>
                
            <div class="col-md-6">
                <br />
                <cfimage action="captcha" difficulty="medium" fontSize="44" text="#random_captcha#" />
            </div>   
            
            <div class="col-md-12">
                &nbsp;<!-- spacer -->
            </div>
                
            <div class="col-md-6">
                <input name="send_message_board" type="submit" value="Add Comment" class="btn btn-success" />
            </div>

        </div> <!-- // <div class="row"> --> 
           		
    </form>
    </cfoutput>
    
</div>