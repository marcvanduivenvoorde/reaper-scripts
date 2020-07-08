function main ()
    reaper.Undo_BeginBlock()

    itemCount = reaper.CountMediaItems(0) - 1

    for itemId = 0, itemCount do
        item = reaper.GetMediaItem(0, itemId)

        if reaper.IsMediaItemSelected(item) then
            reaper.SetMediaItemLength(item, 0.025, true)
            reaper.SetMediaItemInfo_Value(item, 'D_FADEINLEN', 0)
            reaper.SetMediaItemInfo_Value(item, 'D_FADEOUTLEN', 0)
        end
    end
    command = reaper.NamedCommandLookup('_FNG_QUANTIZE_TO_GRID')
    reaper.Main_OnCommandEx(command, 0, 0) -- normalize the selected items

    for itemId = 0, itemCount do
        item = reaper.GetMediaItem(0, itemId)
        itemTrack = reaper.GetMediaItemInfo_Value(item, 'P_TRACK')
        trackId = reaper.GetTrackGUID(itemTrack)

        if reaper.IsMediaItemSelected(item) then
            start = reaper.GetMediaItemInfo_Value(item, 'D_POSITION')
            nextItem = reaper.GetMediaItem(0, itemId + 1)

            if nextItem ~= nil then
                nextItemTrack = reaper.GetMediaItemInfo_Value(nextItem, 'P_TRACK')
                nextTrackId = reaper.GetTrackGUID(nextItemTrack)

                if trackId == nextTrackId then
                    nextStart = reaper.GetMediaItemInfo_Value(nextItem, 'D_POSITION')

                    if (nextStart >= start) then
                        length = nextStart - start - 0.025
                        reaper.SetMediaItemLength(item, length, true)
                    end
                end

            end
        end
    end

    command = reaper.NamedCommandLookup('_SWS_AWFILLGAPSQUICKXFADE')
    reaper.Main_OnCommandEx(command, 0, 0) -- normalize the selected items

    reaper.Undo_EndBlock('Split dreamgate', -1)
end

reaper.defer(main)
