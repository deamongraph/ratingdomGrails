<%@ page import="ratingdom.User" %>


	<fieldset>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" class="form-control" value="${userInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" class="form-control" value="${userInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'fullname', 'error')} required">
	<label for="fullname">
		<g:message code="user.fullname.label" default="Fullname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fullname" required="" class="form-control" value="${userInstance?.fullname}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="email" required="" class="form-control" value="${userInstance?.email}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'phone', 'error')} required">
	<label for="phone">
		<g:message code="user.phone.label" default="Phone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="phone" required="" class="form-control" value="${userInstance?.phone}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'twitterUser', 'error')} required">
	<label for="twitterUser">
		<g:message code="user.twitterUser.label" default="Twitter User" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="twitterUser" required="" class="form-control" value="${userInstance?.twitterUser}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'website', 'error')} ">
	<label for="website">
		<g:message code="user.website.label" default="Website" />
		
	</label>
	<g:textField name="website" class="form-control" value="${userInstance?.website}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'company', 'error')} ">
	<label for="company">
		Eres una empresa?
		
	</label>
	<g:checkBox name="company" class="form-control" value="${userInstance?.company}" />

</div>





	<g:checkBox name="enabled" class="form-control hidden" value="${userInstance?.enabled}" />




</fieldset>
