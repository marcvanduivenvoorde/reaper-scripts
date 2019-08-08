local trackDecorator = {}

trackDecorator.colors = {}
trackDecorator.vca = {}
trackDecorator.colors.drums = 26316
trackDecorator.colors.guitars = 8849466
trackDecorator.colors.guitarsolo = 13408767
trackDecorator.colors.bass = 6293644
trackDecorator.colors.vocals = 12619858
trackDecorator.colors.synth = 16724991
trackDecorator.vca.drums = 1
trackDecorator.vca.guitars = 2
trackDecorator.vca.bass = 3
trackDecorator.vca.vocals = 4
trackDecorator.vca.synth = 5

function trackDecorator.prepareTrack(sendTrack)
    receivingTrack = trackFinder.find(sendTrack)
    currentTrack = reaper.GetSelectedTrack(0, 0)

    trackDecorator.clearAllSends(currentTrack)
    trackDecorator.createPostFaderSend(currentTrack, receivingTrack)
end

function trackDecorator.decorateSnare(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.drums)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'snare', '__dr__')
end

function trackDecorator.prepareParallelDrumTrack(currentTrack)
    if trackFinder.exists('drum-paracomp __dr__') then
        paracompTrack = trackFinder.find('drum-paracomp __dr__')

        trackDecorator.createPostFaderSend(currentTrack, paracompTrack);
    end

    if trackFinder.exists('drum-reverb __dr__') then
        paracompTrack = trackFinder.find('drum-reverb __dr__')

        trackDecorator.createPostFaderSend(currentTrack, paracompTrack);
    end
end

function trackDecorator.prepareParallelVocalTrack(currentTrack)
    if trackFinder.exists('vocal-paracomp __vox__') then
        paracompTrack = trackFinder.find('vocal-paracomp __vox__')

        trackDecorator.createPostFaderSend(currentTrack, paracompTrack);
    end

    if trackFinder.exists('vocal-reverb __vox__') then
        paracompTrack = trackFinder.find('vocal-reverb __vox__')

        trackDecorator.createPostFaderSend(currentTrack, paracompTrack);
    end

    if trackFinder.exists('vocal-delay __vox__') then
        paracompTrack = trackFinder.find('vocal-reverb __vox__')

        trackDecorator.createPostFaderSend(currentTrack, paracompTrack);
    end
end

function trackDecorator.decorateKick(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.prepareParallelDrumTrack(currentTrack);

    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.drums)
    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'kick', '__dr__')
end

function trackDecorator.decorateTom(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.prepareParallelDrumTrack(currentTrack);
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.drums)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'tom', '__dr__')
end

function trackDecorator.decorateOverhead(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.prepareParallelDrumTrack(currentTrack);
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.drums)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'overhead', '__dr__')
end

function trackDecorator.decorateRoom(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.prepareParallelDrumTrack(currentTrack);
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.drums)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'room', '__dr__')
end

function trackDecorator.decorateGuitar(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.guitars)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.guitars, 'guitar', '__gtr__')
end

function trackDecorator.decorateGuitarSolo(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.guitars)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.guitarsolo, 'guitar', '__gtr__ __gtrs__')
end

function trackDecorator.decorateSynth(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.synth)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.synth, 'synth', '__syn__ __gtrs__')
end

function trackDecorator.decorateBass(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.bass)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.bass, 'bass', '__bass__')
end

function trackDecorator.decorateVocal(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.prepareParallelVocalTrack(currentTrack)
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.vocals)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.vocals, 'vocal', '__vox__')
end

function trackDecorator.decorateDrumReverb(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.addToVcaGroup(currentTrack, trackDecorator.vca.drums)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'drum reverb', '__dr__')
end

function trackDecorator.addToVcaGroup(currentTrack, group)
    setValue = 1 << (group -1)

    reaper.GetSetTrackGroupMembership(currentTrack, "VOLUME_VCA_SLAVE", setValue, setValue)
    reaper.GetSetTrackGroupMembership(currentTrack, "SOLO_SLAVE", setValue, setValue)
    reaper.GetSetTrackGroupMembership(currentTrack, "MUTE_SLAVE", setValue, setValue)
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
    if string.match(localTrackName, '') ~= nil then
        prefix = name
    end

    reaper.SetTrackColor(currentTrack, color)
    reaper.GetSetMediaTrackInfo_String(currentTrack, "P_NAME", prefix .. postfix, true)
end

return trackDecorator
