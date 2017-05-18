<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>An Error Occurred</title>
    <!-- Bootstrap core CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<cfoutput>
<div class="container">
    <div class="alert alert-danger"><h3><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> &nbsp;&nbsp; We're sorry, but an error has occurred</h3></div>
    <p>We have been notified and are working to resolve it.</p>
</div>

<cfmail to="sitewhirks@sutphinfamily.com"
		cc="matt@sitewhirks.com; steve@sitewhirks.com"
		from="noReply@sitewhirks.com"
        subject="Error from #request.title#"
        type="html">
        An error has occured on #request.title#
        <ul>
            <li><b>Location:</b> #error.remoteAddress#</li>
            <li><b>Browser:</b> #error.browser#</li>
            <li><b>Date and Time the Error Occurred:</b> #error.dateTime#</li>
            <li><b>Template: #error.template#</b></li>
            <li><b>SQL: #error.rootCause.Sql#</b></li>
            <li><b>Message Content</b>:
                <p>#error.diagnostics#</p>
            </li>
        </ul>        
</cfmail>
</cfoutput>
</body>
</html>