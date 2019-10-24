function main()

    trackCount = reaper.CountTracks(0) - 1
    poolId = -1

    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        if reaper.IsTrackSelected(track) then
            envelopeCount = reaper.CountTrackEnvelopes(track) - 1
            timeStart = 0
            timeEnd = 0
            timeStart, timeEnd = reaper.GetSet_LoopTimeRange(false, false, timeStart, timeEnd, true)

            for envelopeId = 0, envelopeCount do
                envelope = reaper.GetTrackEnvelope(track, envelopeId)
                _ret, envelopeName = reaper.GetEnvelopeName(envelope)


                if 'Volume (Pre-FX)' == envelopeName then
                    itemId = reaper.InsertAutomationItem(envelope, poolId, timeStart, timeEnd - timeStart)
                    poolId = math.floor(reaper.GetSetAutomationItemInfo(envelope, itemId, 'D_POOL_ID', 0, false))
                end
            end
        end
    end
end

reaper.defer(main)
