package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackFinder = require("libs.TrackFinder")
trackDecorator = require('libs.trackDecorator')

-- setup the track color for the new track
-- add a postfader send to the snare bus track
function main()
    receivingTrack = trackFinder.find('snare-bus __dr__')
    currentTrack = reaper.GetSelectedTrack(0, 0)

    trackDecorator.createPostFaderSend(currentTrack, receivingTrack)
    trackDecorator.decorateSnare(currentTrack)

    if (sendIndex == 0) then
        reaper.ShowMessageBox('Could not create send.')
    end
end

reaper.defer(main)
