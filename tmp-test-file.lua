package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackFinder = require("TrackFinder")

-- setup the track color for the new track
-- add a postfader send to the snare bus track
function main()
    receivingTrack = trackFinder.find('snare-bus __dr__')
    currentTrack = reaper.GetSelectedTrack(0, 0)

    reaper.SetTrackColor(currentTrack, 26316)

    sendIndex = reaper.CreateTrackSend(currentTrack, receivingTrack)

    reaper.GetSetMediaTrackInfo_String(currentTrack, "P_NAME", "snare __dr__", true)
    reaper.SetTrackSendInfo_Value(currentTrack, 0, sendIndex, "I_SENDMODE", 0)

    if (sendIndex == 0) then
        reaper.ShowMessageBox('Could not create send.')
    end

end

reaper.defer(main)
