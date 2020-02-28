package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackManager = require("libs.trackManager")
trackDecorator = require("libs.trackDecorator")

function main()
    reaper.Undo_BeginBlock()


    trackCount = reaper.CountTracks(0) - 1

    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        if reaper.IsTrackSelected(track) then
            reaper.GetSetMediaTrackInfo_String(track, 'P_ICON', '', true)
            trackDecorator.removeFromGroup(track, trackDecorator.group.hidden)
        end
    end

    reaper.Undo_EndBlock('Unhiding selected tracks', -1)
end

reaper.defer(main)
