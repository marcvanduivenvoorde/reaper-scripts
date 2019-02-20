function findTrack(trackName)
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
function main()
    receivingTrack = findTrack('snare-bus __dr__')
    currentTrack = reaper.GetSelectedTrack(0, 0)

    reaper.SetTrackColor(currentTrack, 1)


    sendIndex = reaper.CreateTrackSend(currentTrack, receivingTrack)

    if (sendIndex == 0) then
        reaper.ShowMessageBox('Coud not create send.')
    end

    reaper.SetTrackSendInfo_Value(currentTrack, 0, sendIndex, "I_SENDMODE", 0)
end

reaper.defer(main)
