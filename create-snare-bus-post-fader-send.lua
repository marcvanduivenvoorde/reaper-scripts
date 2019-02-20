require "findTrack";

function main()
    receivingTrack = findTrack('snare-bus __dr__')
    currentTrack = reaper.getSelectedTrack(0, 0)

    reaper.setTrackColor(currentTrack, 1)

    if receivingTrack == false then
        reaper.showMessageBox('Could not find receiving track.')
        return
    end

    sendIndex = reaper.createTrackSend(currentTrack, receivingTrack)

    if (sendIndex == 0) then
        reaper.showMessageBox('Coud not create send.')
    end

    reaper.SetTrackSendInfo_Value(currentTrack, 0, sendIndex, "I_SENDMODE", 0)
end

reaper.defer(main)
