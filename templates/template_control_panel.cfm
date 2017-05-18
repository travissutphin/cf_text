<cfoutput>
        <p class="login-box-msg">
        	<cfif isDefined ('show_message')>
            	#show_message#
            </cfif>
        </p>        
<!--- Member Control Panel --->
	<cfif isDefined('SESSION.Auth.role_fk') and #SESSION.Auth.role_fk# eq '2'><!--- 2 = Member --->
	
    <!--- Send Email / Text --->
    <div class="row">
    	<h2>Send Text / Email</h2>
        <form name="send_text_email" action="" method="post">
        	<div class="col-xs-4">Email <input name="receive_email" type="checkbox" value="1" /></div>
            <div class="col-xs-4">Text <input name="receive_text" type="checkbox" value="1"/></div>
            <div class="col-xs-4">&nbsp;</div>
            
            <div class="col-xs-12">&nbsp;</div>
            
            <div class="col-xs-12">Subject <input name="subject" class="form-control" /></div>
            
            <div class="col-xs-12">&nbsp;</div>
            
            <div class="col-xs-12">Message <textarea name="message" class="form-control" rows="7"></textarea></div>
            
            <div class="col-xs-12">&nbsp;</div>
            
            <div class="col-xs-4"><button name="send_message" type="submit" class="btn btn-primary btn-block btn-flat">Send</button></div>
            
            <div class="col-xs-12">&nbsp;</div>
        </form>
    </div>  

	</cfif>

</cfoutput>