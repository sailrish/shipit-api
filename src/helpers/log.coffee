_log = (src, user, level, details) ->
  user = user?.get 'email'
  user ?= 'n/a'
  console.log JSON.stringify {level, user, src, details}

info = (src, user, details) ->
  _log src, user, 'INFO', details

warn = (src, user, details) ->
  _log src, user, 'WARN', details

error = (src, user, details) ->
  _log src, user, 'ERROR', details


module.exports = {info, warn, error}

