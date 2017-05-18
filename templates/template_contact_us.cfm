<!--- note: session vars declared in controller.cfm --->

<cfinvoke 
    component="#request.cfc#._helpers"
    method="random_string_Helpers"
    returnvariable="random_captcha">
</cfinvoke>
<cfset session.random_captcha = #random_captcha#>

<!--- if submitted, show user message --->
<cfif isDefined('session.show_message') and #session.show_message# neq "">
	<cfoutput>#session.show_message#</cfoutput>
    <cfset #session.show_message# = "">
</cfif>

<cfoutput>

<cfif #request.default_to_email# eq "test@email.com">

	<h2>The "TO" Email Address is not set in /Application.cfm file on root (request.default_to_email)</h2>

<cfelse>
    <form name="form_contact_us" action="index.cfm?alias=contact-us" method="post">        
        <div class="row">
            
            <div class="col-md-6">
                Your Name:<br />
                <input name="name" type="text" value="#session.contact_us.name#" class="form-control" />
            </div>
            
            <div class="col-md-6">
                Your Email:<br />
                <input name="email" type="text" value="#session.contact_us.email#" class="form-control" />
            </div>
        
            <div class="col-md-12">
                &nbsp;<!-- spacer -->
            </div>
        
            <div class="col-md-6">
                How did you hear about us?<br />
                <textarea name="hear_about_us" class="form-control" >#session.contact_us.hear_about_us#</textarea>
            </div>
        
            <div class="col-md-6">
                Comment or Question:<br />
                <textarea name="comment" class="form-control" >#session.contact_us.comment#</textarea>
            </div>
        
            <div class="col-md-12">
                &nbsp;<!-- spacer -->
            </div>
        
            <div class="col-md-6">
                Enter the text you see in the box:<br />
                <input name="match_this" type="text" class="form-control" /> &nbsp;&nbsp; 
            </div>   
    
            <div class="col-md-6">
                <br />
                <cfimage action="captcha" difficulty="medium" fontSize="44" text="#random_captcha#" />
            </div>   
            
            <div class="col-md-12">
                &nbsp;<!-- spacer -->
            </div>
                
            <div class="col-md-6">
                <input name="send_contact_us" type="submit" value="Send" class="btn btn-success" />
            </div>
               
        </div> <!-- // <div class="row"> -->      
    </form>

</cfif>

</cfoutput>