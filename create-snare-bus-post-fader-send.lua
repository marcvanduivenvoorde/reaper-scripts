package.path = package.path .. ";" .. lib.abspath(".") .. "/?.lua"
findTrack = require("findTrack")

function main()
    receivingTrack = findTrack.find('snare-bus __dr__')
    currentTrack = reaper.GetSelectedTrack(0, 0)

    reaper.SetTrackColor(currentTrack, 26316)

    sendIndex = reaper.CreateTrackSend(currentTrack, receivingTrack)
    trackName = reaper.GetSetMediaTrackInfo_String(currentTrack, "P_NAME", "", false)
    reaper.GetSetMediaTrackInfo_String(currentTrack, "P_NAME", trackName .. "__dr__", true)

    if (sendIndex == 0) then
        reaper.ShowMessageBox('Could not create send.')
    end

    reaper.SetTrackSendInfo_Value(currentTrack, 0, sendIndex, "I_SENDMODE", 0)
end

reaper.defer(main)
