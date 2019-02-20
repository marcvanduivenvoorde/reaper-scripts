package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path


-- find a track by it's name, show error and return false when not found
function findTrack.find(trackName)
    for trackId = 0, reaper.CountTracks(0) - 1 do
        track = reaper.GetTrack(0, trackId)

        _, localTrackName = reaper.GetTrackName(track, "")
        if localTrackName == trackName then
            return track
        end
    end

    reaper.ShowMessageBox("Could not find track with name: " .. trackName, "track not found", 0)

    return false
end

-- setup the track color for the new track
-- add a postfader send to the snare bus track
function main()
    receivingTrack = findTrack('snare-bus __dr__')
    currentTrack = reaper.GetSelectedTrack(0, 0)

    reaper.SetTrackColor(currentTrack, 26316)

    sendIndex = reaper.CreateTrackSend(currentTrack, receivingTrack)
    reaper.GetSetMediaTrackInfo_String(currentTrack, "P_NAME", "snare __dr__", true)

    if (sendIndex == 0) then
        reaper.ShowMessageBox('Could not create send.')
    end

    reaper.SetTrackSendInfo_Value(currentTrack, 0, sendIndex, "I_SENDMODE", 0)
end

reaper.defer(main)
