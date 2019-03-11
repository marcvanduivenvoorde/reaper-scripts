package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackFinder = require("libs.trackFinder")
trackDecorator = require('libs.trackDecorator')

-- setup the track color for the new track
-- add a postfader send to the snare bus track
function main()
    trackDecorator.prepareTrack('kick-bus __dr__')
    trackDecorator.decorateKick(currentTrack)
end

reaper.defer(main)
