local trackNaming = {}

function trackNaming.removeNumericalPrefix(track)
    _, localTrackName = reaper.GetTrackName(track, "")

    pattern = "^(%s*%d+%s*-?%s*)"
    if string.match(localTrackName, pattern) then
        res = string.gsub(localTrackName, pattern, '')
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", res, true)
    end
end

function trackNaming.normalizeToLowercase(track)

end

function removeConsolidatedPostFix(track)

end

return trackNaming
