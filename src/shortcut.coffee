# Description:
#   A macro system for hubot
#
# Notes:
#   hubot-shortcut uses hubot-conf for configuration. Macros can be configured
#   by running a command like the following when hubot-conf is installed:
#
#       hubot conf set shortcut.test "hubot echo hello; hubot echo goodbye"
#       hubot conf set shortcut.list "hubot conf dump shortcut"
#
#   Macros can also be configured with environment variables like:
#
#       HUBOT_SHORTCUT_LIST="hubot conf dump shortcut"
#
#   Macros can be used by typing "!<macro name>", like "!list" for example.
#
# Author:
#   anishathalye

shallowClone = (obj) ->
  copy = {}
  for own key, value of obj
    copy[key] = value
  copy.__proto__ = obj.__proto__ # not standard in ECMAScript, but it works
  return copy

module.exports = (robot) ->

  config = require('hubot-conf')('shortcut', robot)

  robot.hear /^\s*!([a-z]+)(\s+.*)?/, (res) ->
    alias = res.match[1]
    rest = res.match[2]
    cmds = config(alias)
    if cmds?
      cmds = cmds.split ';'
      for cmd, index in cmds
        if rest? and index is cmds.length - 1
          cmd = cmd + rest
        msg = shallowClone(res.message)
        msg.text = cmd
        robot.receive msg
