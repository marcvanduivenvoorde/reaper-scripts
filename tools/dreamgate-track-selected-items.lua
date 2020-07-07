function main ()
    reaper.Undo_BeginBlock()

    itemCount = reaper.CountMediaItems(0) - 1

    for itemId = 0, itemCount do
        item = reaper.GetMediaItem(0, itemId)

        if reaper.IsMediaItemSelected(item) then
            reaper.SetMediaItemLength(item, 0.05, true)
            reaper.SetMediaItemInfo_Value(item, 'D_FADEINLEN', 0.004)
            reaper.SetMediaItemInfo_Value(item, 'D_FADEOUTLEN', 0.025)
            reaper.SetMediaItemInfo_Value(item, 'C_FADEINSHAPE', 6)
            reaper.SetMediaItemInfo_Value(item, 'C_FADEOUTSHAPE', 5)
        end
    end

    reaper.Main_OnCommandEx(40108, 0, 0) -- normalize the selected items
    reaper.Undo_EndBlock('Split dreamgate', -1)
end

reaper.defer(main)
