function setTrackOffLine()

end


function main()
    reaper.Undo_BeginBlock()
    trackCount = reaper.CountTracks(0) - 1

    reaper.Main_OnCommandEx(40289, 0, 0) -- unselect all items

    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)
        reaper.Main_OnCommandEx(40289, 0, 0) -- unselect all items

        if reaper.IsTrackSelected(track) then
            reaper.Main_OnCommandEx(40421, 0, 0) -- select items on track
            reaper.Main_OnCommandEx(40440, 0, 0) -- set selected items offline
            reaper.Main_OnCommandEx(40535, 0, 0) -- set all fx offline

            reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 1)
            reaper.SetMediaTrackInfo_Value(track, "I_FXEN", 0)

            reaper.Main_OnCommandEx(8, 0, 0) -- toggle fx
        end
    end
    reaper.Undo_EndBlock('Setting selected tracks offline', -1)
end

reaper.defer(main)
