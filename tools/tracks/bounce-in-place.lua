function main()
    reaper.Undo_BeginBlock()
    trackCount = reaper.CountTracks(0) - 1

    reaper.Main_OnCommandEx(40289, 0, 0) -- unselect all items
    createdTrackId = nil
    -- create bus track with random name
    --
    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        if reaper.IsTrackSelected(track) then
            createdTrackId = trackId
        end
    end

    createdTrackId = createdTrackId + 1

    reaper.InsertTrackAtIndex(createdTrackId, false)
    bounceTrack = reaper.GetTrack(0, createdTrackId)
    reaper.GetSetMediaTrackInfo_String(bounceTrack, 'P_NAME', 'bounce-track', true)

    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        if reaper.IsTrackSelected(track) then
            -- create post fader send to bus track

            sendIndex = reaper.CreateTrackSend(track, bounceTrack)
            reaper.SetTrackSendInfo_Value(track, 0, sendIndex, "I_SENDMODE", 0)
        end
    end


    reaper.Main_OnCommandEx(40297, 0, 0) -- unselect all tracks
    reaper.SetTrackSelected(bounceTrack, true); -- select the bounce track
    reaper.Main_OnCommandEx(40788, 0, 0) -- render stereo stem of bus track
    reaper.DeleteTrack(bounceTrack) -- remove created bus track
    reaper.Undo_EndBlock('Bouncing selected tracks in place', -1)
end

reaper.defer(main)
