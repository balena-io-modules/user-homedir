passwdUser = require 'passwd-user'
homedir = require 'os-homedir'
Promise = require 'bluebird'

module.exports = (username, cb) ->
	Promise.try ->
		if process.platform isnt 'linux' and process.platform isnt 'darwin'
			return homedir()

		username = username ? process.env.SUDO_USER or process.env.USER

		passwdUser(username) # this is not a bluebird promise
		.then (passwd) ->
			return passwd.homedir
	.asCallback(cb)
