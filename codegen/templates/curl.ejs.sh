<% var isSessionStart = serviceID === 'session' && actionID === 'start' -%>
<% var SESSION_VARS = isSessionStart ? ['ks'] : ['secret', 'userId', 'sessionType', 'partnerId', 'expiry', 'ks'] -%>
<% if (showSetup && !isSessionStart) { -%>
KALTURA_SESSION=`curl -X POST https://www.kaltura.com/api_v3/service/session/action/start \
    -d "secret=<%- answers.secret %>" \
    -d "userId=<%- answers.userId %>" \
    -d "type=<%- answers.sessionType || 0 %>" \
    -d "partnerId=<%- answers.partnerId || 'YOUR_PARTNER_ID' %>" \
    -d "expiry=<%- answers.expiry || 86400 %>" \
    -d "format=1" | sed 's@"@@g'`
<% } -%>
<% var keys = Object.keys(answers).filter(function(k) {return SESSION_VARS.indexOf(k) === -1}) -%>
<% keys = keys.filter(function(k) {return parameterNames.indexOf(k) !== -1 || parameterNames.indexOf(k.substring(0, k.indexOf('['))) !== -1}) -%>
curl -X POST https://www.kaltura.com/api_v3/service/<%- serviceID %>/action/<%- actionID %> \
<% if (!isSessionStart) { -%>
    -d "ks=$KALTURA_SESSION" \
<% } -%>
<% for (var i = 0; i < keys.length; ++i) { -%>
<%   var ans = keys[i].indexOf('password') === -1 ? answers[keys[i]] : '********' -%>
    -d "<%- keys[i] %>=<%- encodeURIComponent(ans) %>"<%- i === keys.length - 1 ? '' : ' \\' %>
<% } -%>
