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


module.exports = (robot) ->

  config = require('hubot-conf')('shortcut', robot)

  robot.hear /^\s*!([a-z]+)/, (res) ->
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
