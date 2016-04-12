passwdUser = require 'passwd-user'
Promise = require 'bluebird'

module.exports = (username, cb) ->
	Promise.try ->
		if process.platform isnt 'linux' and process.platform isnt 'darwin'
			throw new Error('Platform not supported.')

		username = username ? process.env.SUDO_USER or process.env.USER

		passwdUser(username) # this is not a bluebird promise
		.then (passwd) ->
			return passwd.homedir
	.asCallback(cb)
