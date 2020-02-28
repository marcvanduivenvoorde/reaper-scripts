local trackManager = {}

local groups = {
    [1] = 40804, -- drums
    [2] = 40805, -- guitars
    [3] = 40806, -- guitar solo
    [4] = 40807, -- bass
    [5] = 40808, -- vocals
    [6] = 40809, -- backup vocals
    [7] = 40810, -- synth
    [8] = 40811, -- snare
    [9] = 40812, -- kick
    [10] = 40813, -- busses
    [11] = 40814, -- hidden
    [12] = 40815,
    [13] = 40816,
    [14] = 40817,
    [15] = 40818,
    [16] = 40819,
    [17] = 40820,
    [18] = 40821,
    [19] = 40822,
    [20] = 40823,
    [21] = 40824,
    [22] = 40825,
    [23] = 40826,
    [24] = 40827,
}

function trackManager.showAllTracks()
    reaper.Main_OnCommandEx(reaper.NamedCommandLookup('_SWSTL_SHOWALL'), 0, 0);
end

function trackManager.hideAllTracks()
    reaper.Main_OnCommandEx(reaper.NamedCommandLookup('_SWSTL_HIDEALL'), 0, 0) -- hide all tracks
end

function trackManager.showTracksByTag(tag)
    trackManager.showAllTracks();

    for trackId = 0, reaper.CountTracks(0) - 1 do
        track = reaper.GetTrack(0, trackId)

        _, localTrackName = reaper.GetTrackName(track, "")

        -- when tag is not found in trackname, then hide it
        -- otherwise show it.
        if string.match(localTrackName, tag) == nil then
            reaper.SetMediaTrackInfo_Value(track, "B_SHOWINMIXER", 0)
            reaper.SetMediaTrackInfo_Value(track, "B_SHOWINTCP", 0)
        else
            reaper.SetMediaTrackInfo_Value(track, "B_SHOWINMIXER", 1)
            reaper.SetMediaTrackInfo_Value(track, "B_SHOWINTCP", 1)
        end

        if string.match(localTrackName, '__sep__') ~= nil then
            reaper.SetMediaTrackInfo_Value(track, "B_SHOWINMIXER", 1)
        end
    end

    reaper.TrackList_AdjustWindows(false)
end


function trackManager.showTracksByGroup(group)
    reaper.Main_OnCommandEx(40297, 0, 0) -- unselect all tracks
    reaper.Main_OnCommandEx(groups[group], 0, 0) -- select all in group 01
    reaper.Main_OnCommandEx(reaper.NamedCommandLookup('_SWSTL_BOTH'), 0, 0) -- show selected tracks
    reaper.Main_OnCommandEx(40297, 0, 0) -- unselect all tracks
end

function trackManager.hideTracksByGroup(group)
    reaper.Main_OnCommandEx(groups[group], 0, 0) -- select all in group 11 (hidden group)
    reaper.Main_OnCommandEx(reaper.NamedCommandLookup('_SWSTL_HIDE'), 0, 0) -- show selected tracks

    reaper.Main_OnCommandEx(40297, 0, 0) -- unselect all tracks
end

return trackManager
