package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackFinder = require("libs.trackFinder")
trackDecorator = require('libs.trackDecorator')

-- setup the track color for the new track
-- add a postfader send to the snare bus track
function main()
    reaper.Undo_BeginBlock()
    reaper.Main_OnCommandEx(reaper.NamedCommandLookup('_SWS_DISMPSEND'), 0, 0) -- disable master parent send
    reaper.Main_OnCommandEx(reaper.NamedCommandLookup('_S&M_SENDS6'), 0, 0) -- remove all sends from tracks
    trackCount = reaper.CountTracks(0) - 1

    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        if reaper.IsTrackSelected(track) then
            trackDecorator.setupTrackDefaults(track)
            trackDecorator.decorateVocalLeadTwo(track)
        end
    end

    reaper.Undo_EndBlock('Setting up vocal lead 1 tracks', -1)
end

reaper.defer(main)
