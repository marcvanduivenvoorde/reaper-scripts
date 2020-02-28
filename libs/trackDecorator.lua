local trackDecorator = {}

trackDecorator.colors = {}
trackDecorator.vca = {}
trackDecorator.colors.drums = 8323073
trackDecorator.colors.guitars = 4227076
trackDecorator.colors.guitarsolo = 4227076
trackDecorator.colors.bass = 540800
trackDecorator.colors.vocals = 16613382
trackDecorator.colors.synth = 8388737
trackDecorator.vca.drums = 1
trackDecorator.vca.guitars = 2
trackDecorator.vca.guitarsolo = 3
trackDecorator.vca.bass = 4
trackDecorator.vca.vocals = 5
trackDecorator.vca.backupvocals = 6
trackDecorator.vca.synth = 7
trackDecorator.vca.snare = 8
trackDecorator.vca.kick = 9

function trackDecorator.prepareTrack(sendTrack)
    receivingTrack = trackFinder.find(sendTrack)
    currentTrack = reaper.GetSelectedTrack(0, 0)

    trackDecorator.clearAllSends(currentTrack)
    trackDecorator.createPostFaderSend(currentTrack, receivingTrack)
end

function trackDecorator.sendParallelProcessTrack(currentTrack, sendTrack)
    if trackFinder.exists(sendTrack) then
        parallelProcessTrack = trackFinder.find(sendTrack)

        trackDecorator.createPostFaderSend(currentTrack, parallelProcessTrack);
    end
end

function trackDecorator.decorateSnare(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'snare', '__dr__ __snare__')
end

function trackDecorator.decorateKick(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'kick', '__dr__ __kick__')
end

function trackDecorator.decorateTom(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'tom', '__dr__ __tom__')
end

function trackDecorator.decorateOverhead(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'overhead', '__dr__ __oh__')
end

function trackDecorator.decorateRoom(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'room', '__dr__ __room__')
end

function trackDecorator.decorateGuitar(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.guitars, 'guitar', '__gtr__')
end

function trackDecorator.decorateGuitarSolo(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.guitarsolo, 'guitar solo', '__gtr__ __gtrs__')
end

function trackDecorator.decorateSynth(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.synth, 'synth', '__syn__')
end

function trackDecorator.decorateBass(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.bass, 'bass', '__bass__')
end

function trackDecorator.decorateVocal(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.vocals, 'vocal', '__vox__')
end

function trackDecorator.decorateBackupVocal(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.vocals, 'vocal', '__vox__')
end

function trackDecorator.clearAllSends(currentTrack)
    numberOfSends = reaper.GetTrackNumSends(currentTrack, 0)

    for index = 0, numberOfSends do
        reaper.RemoveTrackSend(currentTrack, 0, index)
    end
end

function trackDecorator.createPostFaderSend(currentTrack, receivingTrack)
    sendIndex = reaper.CreateTrackSend(currentTrack, receivingTrack)
    reaper.SetTrackSendInfo_Value(currentTrack, 0, sendIndex, "I_SENDMODE", 0)
end

-- the eventual decorator
function trackDecorator.decorate(currentTrack, color, name, postfix)
    _, localTrackName = reaper.GetTrackName(currentTrack, "")

    prefix = localTrackName
    if string.len(localTrackName) == 0 then
        prefix = name
    end

    reaper.SetTrackColor(currentTrack, color)
    reaper.GetSetMediaTrackInfo_String(currentTrack, "P_NAME", prefix .. ' ' .. postfix, true)
end

return trackDecorator
