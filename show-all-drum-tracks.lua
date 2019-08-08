package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackManager = require("libs.trackManager")

function main()
    trackmanager.showAllTracks()
    trackManager.showTracksByTag('__dr__')
end

reaper.defer(main)
