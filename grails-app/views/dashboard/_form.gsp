<%@ page import="ratingdom.DataTwitter" %>



<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'favorite_count', 'error')} required">
	<label for="favorite_count">
		<g:message code="dataTwitter.favorite_count.label" default="Favoritecount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="favorite_count" type="number" value="${dataTwitterInstance.favorite_count}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'followers_count', 'error')} required">
	<label for="followers_count">
		<g:message code="dataTwitter.followers_count.label" default="Followerscount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="followers_count" type="number" value="${dataTwitterInstance.followers_count}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'followerscore', 'error')} required">
	<label for="followerscore">
		<g:message code="dataTwitter.followerscore.label" default="Followerscore" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="followerscore" type="number" value="${dataTwitterInstance.followerscore}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'friend_count', 'error')} required">
	<label for="friend_count">
		<g:message code="dataTwitter.friend_count.label" default="Friendcount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="friend_count" type="number" value="${dataTwitterInstance.friend_count}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'language', 'error')} required">
	<label for="language">
		<g:message code="dataTwitter.language.label" default="Language" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="language" required="" value="${dataTwitterInstance?.language}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'retweetScore', 'error')} required">
	<label for="retweetScore">
		<g:message code="dataTwitter.retweetScore.label" default="Retweet Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="retweetScore" type="number" value="${dataTwitterInstance.retweetScore}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'retweets_count', 'error')} required">
	<label for="retweets_count">
		<g:message code="dataTwitter.retweets_count.label" default="Retweetscount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="retweets_count" type="number" value="${dataTwitterInstance.retweets_count}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'screenname', 'error')} required">
	<label for="screenname">
		<g:message code="dataTwitter.screenname.label" default="Screenname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="screenname" required="" value="${dataTwitterInstance?.screenname}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'statuses_count', 'error')} required">
	<label for="statuses_count">
		<g:message code="dataTwitter.statuses_count.label" default="Statusescount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="statuses_count" type="number" value="${dataTwitterInstance.statuses_count}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'totalscore', 'error')} required">
	<label for="totalscore">
		<g:message code="dataTwitter.totalscore.label" default="Totalscore" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="totalscore" type="number" value="${dataTwitterInstance.totalscore}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'tweet', 'error')} required">
	<label for="tweet">
		<g:message code="dataTwitter.tweet.label" default="Tweet" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tweet" name="tweet.id" from="${domains.twitter.Tweet.list()}" optionKey="id" required="" value="${dataTwitterInstance?.tweet?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'updatedOn', 'error')} required">
	<label for="updatedOn">
		<g:message code="dataTwitter.updatedOn.label" default="Updated On" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="updatedOn" precision="day"  value="${dataTwitterInstance?.updatedOn}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: dataTwitterInstance, field: 'usuario', 'error')} required">
	<label for="usuario">
		<g:message code="dataTwitter.usuario.label" default="Usuario" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="usuario" name="usuario.id" from="${domains.User.list()}" optionKey="id" required="" value="${dataTwitterInstance?.usuario?.id}" class="many-to-one"/>

</div>

