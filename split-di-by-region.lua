

regionTrackList = {
    'gtr-di-clean',
    'gtr-di-crunch',
    'gtr-di-distortion',
    'gtr-di-distortion-2',
}

-- does the value exist in a list
function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- get the track count
local function getAllTracks()
    return reaper.CountTracks(0) - 1
end

-- get the reqion / project marker count
local function getAllRegions()
    return reaper.CountProjectMarkers(0) - 1
end

-- split a track at the region edges
local function splitTrackAtRegion(track, regionIndex)
    retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(regionIndex)
    reaper.Main_OnCommandEx(40289, 0, 0) -- unselect all items

    if isrgn and has_value(regionTrackList, name) then
        trackItems = reaper.CountTrackMediaItems(track) - 1
        reaper.GetSet_LoopTimeRange(true, true, pos, rgnend, false)

        for item = 0, trackItems do
            mediaItem = reaper.GetTrackMediaItem(track, item)

            reaper.SetMediaItemSelected(mediaItem, true)
            reaper.Main_OnCommandEx(40061, 0, 0)

            reaper.SetMediaItemSelected(mediaItem, false)
        end
    end
end

-- split a track
local function splitTrack(track)
    retval, trackName = reaper.GetTrackName(track)


    if has_value(regionTrackList, trackName) then
        reaper.ShowConsoleMsg(trackName .. "\n")
        reaper.SetOnlyTrackSelected(track, true)
        allRegions = getAllRegions()

        for regionId = 0, allRegions do
            splitTrackAtRegion(track, regionId)
        end
        reaper.SetTrackSelected(track, false)
    end
end

-- remove unmatched media items from tracks.
local function clearTrackItems(track)
    retval, trackName = reaper.GetTrackName(track)
    reaper.Main_OnCommandEx(40289, 0, 0) -- unselect all items
    local itemsToDelete = {};

    if has_value(regionTrackList, trackName) then
        reaper.SetOnlyTrackSelected(track, true)

        allRegions = getAllRegions()

        for regionIndex = 0, allRegions do
            retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(regionIndex)

            if isrgn and has_value(regionTrackList, name) then
                trackItems = reaper.CountTrackMediaItems(track) - 1

                reaper.ShowConsoleMsg('about to remove ' .. name .. ' in ' .. trackName .. "\n")
                for item = 0, trackItems do
                    mediaItem = reaper.GetTrackMediaItem(track, item)

                    itemStart = reaper.GetMediaItemInfo_Value(mediaItem, 'D_POSITION')
                    itemLength = reaper.GetMediaItemInfo_Value(mediaItem, 'D_LENGTH')
                    itemEnd = itemStart + itemLength

                    if name ~= trackName and itemStart == pos and itemEnd == rgnend then
                        reaper.SetMediaItemSelected(mediaItem, true)
                        reaper.ShowConsoleMsg('removing ' .. name .. ' in ' ..trackName.. "\n")
                    end
                end
            end
        end
    end

    for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
        table.insert(itemsToDelete, reaper.GetSelectedMediaItem(0, i))
    end

    for i, item in ipairs(itemsToDelete) do
        reaper.DeleteTrackMediaItem(track, item)
    end
end

-- main method
local function splitTracks()
    reaper.Undo_BeginBlock()
    allTracks = getAllTracks()

    reaper.Main_OnCommandEx(40297, 0, 0) -- unselect all items
    reaper.Main_OnCommandEx(40289, 0, 0) -- unselect all items

    for trackId = 0, allTracks do
        track = reaper.GetTrack(0, trackId)
        splitTrack(track)
    end


    for trackId = 0, allTracks do
        track = reaper.GetTrack(0, trackId)
        clearTrackItems(track)
    end

    reaper.Undo_EndBlock()
end

reaper.defer(splitTracks)
