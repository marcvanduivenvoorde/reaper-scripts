package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackManager = require("libs.trackManager")

function main()
    trackManager.showAllTracks()
    trackManager.showTracksByTag('__gtrs__')
end

reaper.defer(main)
