function findTrack(trackName)
    for trackId = 0, reaper.CounntTracks(0) - 1 do
        track = reaper.getTrack(0, trackId)

        if track.trackName == trackName then
            return track
        end
    end

    return false
end
