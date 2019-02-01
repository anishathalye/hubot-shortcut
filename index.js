const fs = require('fs')
const path = require('path')

module.exports = (robot, scripts) => {
  const scriptsPath = path.resolve(__dirname, 'src')
  if (fs.existsSync(scriptsPath)) {
    for (const script of fs.readdirSync(scriptsPath).sort()) {
      if (scripts != null && !scripts.includes('*')) {
        if (scripts.includes(script)) {
          robot.loadFile(scriptsPath, script)
        }
      } else {
        robot.loadFile(scriptsPath, script)
      }
    }
  }
}
