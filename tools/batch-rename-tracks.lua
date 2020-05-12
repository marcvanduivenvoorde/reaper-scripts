function main()
    trackCount = reaper.CountTracks(0) - 1
    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        _, localTrackName = reaper.GetTrackName(track, "")

        reaper.ShowConsoleMsg(localTrackName .. "\n")
        pattern = "^(%s*%d+%s*-?%s*)"
        if string.match(localTrackName, pattern) then

            res = string.gsub(localTrackName, pattern, '')
            reaper.ShowConsoleMsg(res .. "\n")


            reaper.GetSetMediaTrackInfo_String(track, "P_NAME", res, true)
        end
    end

end

reaper.defer(main)
