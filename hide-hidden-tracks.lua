package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackManager = require("libs.trackManager")
trackDecorator = require("libs.trackDecorator")

function main()
    trackManager.hideTracksByGroup(trackDecorator.group.hidden)
end

reaper.defer(main)
