package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

renamer = require('libs.trackNaming');

function main()
    trackCount = reaper.CountTracks(0) - 1
    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

       renamer.removeNumericalPrefix(track)
    end

end

reaper.defer(main)
