
<%@ page import="ratingdom.DataTwitter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'dataTwitter.label', default: 'DataTwitter')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-dataTwitter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-dataTwitter" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list dataTwitter">
			
				<g:if test="${dataTwitterInstance?.favorite_count}">
				<li class="fieldcontain">
					<span id="favorite_count-label" class="property-label"><g:message code="dataTwitter.favorite_count.label" default="Favoritecount" /></span>
					
						<span class="property-value" aria-labelledby="favorite_count-label"><g:fieldValue bean="${dataTwitterInstance}" field="favorite_count"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.followers_count}">
				<li class="fieldcontain">
					<span id="followers_count-label" class="property-label"><g:message code="dataTwitter.followers_count.label" default="Followerscount" /></span>
					
						<span class="property-value" aria-labelledby="followers_count-label"><g:fieldValue bean="${dataTwitterInstance}" field="followers_count"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.followerscore}">
				<li class="fieldcontain">
					<span id="followerscore-label" class="property-label"><g:message code="dataTwitter.followerscore.label" default="Followerscore" /></span>
					
						<span class="property-value" aria-labelledby="followerscore-label"><g:fieldValue bean="${dataTwitterInstance}" field="followerscore"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.friend_count}">
				<li class="fieldcontain">
					<span id="friend_count-label" class="property-label"><g:message code="dataTwitter.friend_count.label" default="Friendcount" /></span>
					
						<span class="property-value" aria-labelledby="friend_count-label"><g:fieldValue bean="${dataTwitterInstance}" field="friend_count"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.language}">
				<li class="fieldcontain">
					<span id="language-label" class="property-label"><g:message code="dataTwitter.language.label" default="Language" /></span>
					
						<span class="property-value" aria-labelledby="language-label"><g:fieldValue bean="${dataTwitterInstance}" field="language"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.retweetScore}">
				<li class="fieldcontain">
					<span id="retweetScore-label" class="property-label"><g:message code="dataTwitter.retweetScore.label" default="Retweet Score" /></span>
					
						<span class="property-value" aria-labelledby="retweetScore-label"><g:fieldValue bean="${dataTwitterInstance}" field="retweetScore"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.retweets_count}">
				<li class="fieldcontain">
					<span id="retweets_count-label" class="property-label"><g:message code="dataTwitter.retweets_count.label" default="Retweetscount" /></span>
					
						<span class="property-value" aria-labelledby="retweets_count-label"><g:fieldValue bean="${dataTwitterInstance}" field="retweets_count"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.screenname}">
				<li class="fieldcontain">
					<span id="screenname-label" class="property-label"><g:message code="dataTwitter.screenname.label" default="Screenname" /></span>
					
						<span class="property-value" aria-labelledby="screenname-label"><g:fieldValue bean="${dataTwitterInstance}" field="screenname"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.statuses_count}">
				<li class="fieldcontain">
					<span id="statuses_count-label" class="property-label"><g:message code="dataTwitter.statuses_count.label" default="Statusescount" /></span>
					
						<span class="property-value" aria-labelledby="statuses_count-label"><g:fieldValue bean="${dataTwitterInstance}" field="statuses_count"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.totalscore}">
				<li class="fieldcontain">
					<span id="totalscore-label" class="property-label"><g:message code="dataTwitter.totalscore.label" default="Totalscore" /></span>
					
						<span class="property-value" aria-labelledby="totalscore-label"><g:fieldValue bean="${dataTwitterInstance}" field="totalscore"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.tweet}">
				<li class="fieldcontain">
					<span id="tweet-label" class="property-label"><g:message code="dataTwitter.tweet.label" default="Tweet" /></span>
					
						<span class="property-value" aria-labelledby="tweet-label"><g:link controller="tweet" action="show" id="${dataTwitterInstance?.tweet?.id}">${dataTwitterInstance?.tweet?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.updatedOn}">
				<li class="fieldcontain">
					<span id="updatedOn-label" class="property-label"><g:message code="dataTwitter.updatedOn.label" default="Updated On" /></span>
					
						<span class="property-value" aria-labelledby="updatedOn-label"><g:formatDate date="${dataTwitterInstance?.updatedOn}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataTwitterInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="dataTwitter.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:link controller="user" action="show" id="${dataTwitterInstance?.usuario?.id}">${dataTwitterInstance?.usuario?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:dataTwitterInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${dataTwitterInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
