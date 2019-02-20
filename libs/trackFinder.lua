local trackFinder
-- find a track by it's name, show error and return false when not found
function trackFinder.find(trackName)
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
return trackFinder
