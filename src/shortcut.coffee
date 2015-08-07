# Description:
#   A macro system for hubot
#
# Notes:
#   hubot-shortcut uses hubot-conf for configuration. Macros can be configured
#   by running a command like:
#
#       hubot conf set macro.test "hubot echo hello; hubot echo goodbye"
#       hubot conf set macro.ls "hubot conf dump shortcut"
#
#   Macros can be used by typing "!<macro name>", like "!ls" for example.
#
# Author:
#   anishathalye


module.exports = (robot) ->

  config = require('hubot-conf')('shortcut', robot)

  robot.hear /^!([a-z]+)/, (res) ->
    alias = res.match[1]
    cmds = config(alias)
    if cmds?
      original = res.message.text
      cmds = cmds.split ';'
      for cmd in cmds
        # reuse existing message object
        res.message.text = cmd
        robot.receive res.message
      # reset to original text
      res.message.text = original
