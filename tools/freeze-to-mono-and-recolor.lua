
function main()
    local color = 15790839
    reaper.Main_OnCommandEx(40901, 0, 0) -- freeze selected tracks
    trackCount = reaper.CountTracks(0) - 1

    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        if reaper.IsTrackSelected(track) then
            reaper.SetTrackColor(track, color)
        end
    end
end

reaper.defer(main)
