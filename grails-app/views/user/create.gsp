<!DOCTYPE html>
<html>
<head>
	<title>Ratingdom.com - Eres lo que publicas</title>

	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<!-- Bootstrap -->
	<asset:stylesheet src="bootstrap.min.css"/>
	<asset:stylesheet src="jquery-ui-1.9.2.custom.min.css"/>
	<asset:stylesheet src="glyphicons.css"/>
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
					<li class="active"><a href="../API/" class="glyphicons notes">Nuestro API</a></li>
					<li><a href="../dashboard/" class="glyphicons dashboard">Panel de usuario</a></li>
					<li><a href="../user/create" class="glyphicons group"><span>Registrarse</span></a></li>
				</ul>

			</div>
		</div>

	</div>
	<div class="form-horizontal col-md-2 col-md-offset-4">
	<div id="create-user" class="content scaffold-create" role="main">
			<h4>Rellenar Formulario</h4>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${userInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${userInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:userInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save btn btn-primary" value="Guardar" />
				</fieldset>
			</g:form>
		</div>
		</div>
	</div>
	</body>

</html>
