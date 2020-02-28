package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

trackManager = require("libs.trackManager")
trackDecorator = require("libs.trackDecorator")

function main()
    reaper.Undo_BeginBlock()


    trackCount = reaper.CountTracks(0) - 1

    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        if reaper.IsTrackSelected(track) then
            reaper.GetSetMediaTrackInfo_String(track, 'P_ICON', 'bin.png', true)
            trackDecorator.addToGroup(track, trackDecorator.group.hidden)
        end
    end

    trackManager.hideTracksByGroup(trackDecorator.group.hidden)
    reaper.Undo_EndBlock('Hiding selected tracks', -1)
end

reaper.defer(main)
