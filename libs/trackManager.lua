local trackManager = {}

function trackmanager.showAllTracks()
    for trackId = 0, reaper.CountTracks(0) - 1 do
        track = reaper.GetTrack(0, trackId)

        _, localTrackName = reaper.GetTrackName(track, "")

        -- when __ignore__ is not found in trackname then show
        -- else hide the track
        if string.match(localTrackName, '__ignore__') == nil then
            reaper.SetTrackStateChunk(track, '', false)
        else
            reaper.SetTrackStateChunk(track, '', false)
        end
    end
end

function trackmanager.showTracksByTag(tag)
    trackManager.showAllTracks();

    for trackId = 0, reaper.CountTracks(0) - 1 do
        track = reaper.GetTrack(0, trackId)

        _, localTrackName = reaper.GetTrackName(track, "")

        -- when tag is not found in trackname, then hide it
        -- otherwise show it.
        if string.match(localTrackName, tag) == nil then
            reaper.SetTrackStateChunk(track, '', false)
        else
            reaper.SetTrackStateChunk(track, '', false)
        end
    end

end

return trackManager
