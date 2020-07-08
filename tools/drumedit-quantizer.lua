function main ()
    reaper.Undo_BeginBlock()

    itemCount = reaper.CountMediaItems(0) - 1

    for itemId = 0, itemCount do
        item = reaper.GetMediaItem(0, itemId)

        if reaper.IsMediaItemSelected(item) then
            reaper.SetMediaItemLength(item, 0.05, true)
            reaper.SetMediaItemInfo_Value(item, 'D_FADEINLEN', 0)
            reaper.SetMediaItemInfo_Value(item, 'D_FADEOUTLEN', 0)
            command = reaper.NamedCommandLookup('_FNG_QUANTIZE_TO_GRID')
            reaper.UpdateItemInProject(item)
            reaper.Main_OnCommandEx(command, 0, 0) -- normalize the selected items
        end
    end

    for itemId = 0, itemCount do
        item = reaper.GetMediaItem(0, itemId)

        if reaper.IsMediaItemSelected(item) then
            start = reaper.GetMediaItemInfo_Value(item, 'D_POSITION')
            nextItem = reaper.GetMediaItem(0, itemId + 1)

            if nextItem then
                nextStart = reaper.GetMediaItemInfo_Value(nextItem, 'D_POSITION')

                if (nextStart >= start) then
                    length = nextStart - start - 0.025
                    reaper.SetMediaItemLength(item, length, true)
                end
            end
        end
    end

    command = reaper.NamedCommandLookup('_SWS_AWFILLGAPSQUICKXFADE')
    reaper.Main_OnCommandEx(command, 0, 0) -- normalize the selected items

    reaper.Undo_EndBlock('Split dreamgate', -1)
end

reaper.defer(main)
