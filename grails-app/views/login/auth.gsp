
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>    <html class="lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>    <html class="lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html> <!--<![endif]-->
<html>
<head>
	<title>Ratingdom.com - Eres lo que publicas</title>

	<!-- Meta -->
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<!-- Bootstrap -->
	<asset:stylesheet src="bootstrap.min.css"/>
	<asset:stylesheet src="jquery-ui-1.9.2.custom.min.css"/>
	<asset:stylesheet src="glyphicons.css?compile=false"/>
	<asset:javascript src="jquery-1.8.2.min.js"/>
	<asset:stylesheet src="style.css?1382104445"/>





</head>

<body>
<div class="first-container  fluid">
<div class="navbar main hidden-print">

	<div class="container-960">
		<a href="" class="appbrand pull-left visible-menu-hidden hidden-sm"><span>Ratingdom <span>Eres lo que publicas</span></span></a>
		<div class="topnav pull-left">

			<ul class="topnav pull-left">
				<li class="active"><a href="../" class="glyphicons home">Home</a></li>
				<li class="active"><a href="#" class="glyphicons notes">Nuestro API</a></li>
				<li><a href="index.html?lang=en" class="glyphicons dashboard">Panel de usuario</a></li>
				<li><a href="./user/create" class="glyphicons group"><span>Registrarse</span></a></li>
			</ul>

		</div>
	</div>

</div>

<div class="container">
	<div class="form-horizontal col-md-2 col-md-offset-3">
<div id='login'>
	<div class='inner'>
		<div class='fheader'><g:message code="springSecurity.login.header"/></div>

		<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
		</g:if>

		<form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
			<p>
				<label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
				<input type='text' class="form-control"  name='j_username' id='username'/>
			</p>

			<p>
				<label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
				<input type='password' class='form-control' name='j_password' id='password'/>
			</p>

			<p id="remember_me_holder">
				<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
				<label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
			</p>

			<p>
				<input type='submit' class="save btn btn-primary" id="submit" value='${message(code: "springSecurity.login.button")}'/>
			</p>
		</form>
	</div>
</div>
</div></div>
	</div>
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>
