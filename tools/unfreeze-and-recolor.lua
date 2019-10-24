
local colors = {}
local defaultColor = 6381660
colors['__bass__'] = 6293644
colors['__dr__'] = 26316
colors['__gtrs__'] = 13408767
colors['__gtr__'] = 8849466
colors['__vox__'] = 12619858
colors['__synth__'] = 16724991

function getColorForTrackName(trackName)
    for key, value in pairs(colors) do
        if string.find(trackName, key) ~= nil then
            return value
        end
    end

    return defaultColor
end

function main()
    reaper.Main_OnCommandEx(41644, 0, 0) -- unfreeze selected tracks

    trackCount = reaper.CountTracks(0) - 1

    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        if reaper.IsTrackSelected(track) then
            _ret, trackName = reaper.GetTrackName(track)
            reaper.SetTrackColor(track, getColorForTrackName(trackName))
        end
    end
end

reaper.defer(main)
