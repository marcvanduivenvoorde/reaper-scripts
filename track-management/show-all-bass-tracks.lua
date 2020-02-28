package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackManager = require("libs.trackManager")

function main()
    trackManager.hideAllTracks()
    trackManager.showTracksByGroup(trackDecorator.group.bass)
    trackManager.hideTracksByGroup(trackDecorator.group.hidden)
end

reaper.defer(main)
