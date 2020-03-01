local trackDecorator = {}

trackDecorator.colors = {}
trackDecorator.group = {}
trackDecorator.colors.drums = 8323073
trackDecorator.colors.guitars = 4227076
trackDecorator.colors.guitarsolo = 4227076
trackDecorator.colors.bass = 540800
trackDecorator.colors.vocals = 16613382
trackDecorator.colors.synth = 8388737
trackDecorator.group.drums = 1
trackDecorator.group.guitars = 2
trackDecorator.group.guitarsolo = 3
trackDecorator.group.bass = 4
trackDecorator.group.vocals = 5
trackDecorator.group.backupvocals = 6
trackDecorator.group.synth = 7
trackDecorator.group.snare = 8
trackDecorator.group.kick = 9
trackDecorator.group.busses = 10
trackDecorator.group.hidden = 11
trackDecorator.group.kickbus = 47
trackDecorator.group.snarebus = 33
trackDecorator.group.tombus = 34
trackDecorator.group.overheadbus = 35
trackDecorator.group.roombus = 36
trackDecorator.group.guitarbus = 37
trackDecorator.group.guitarharmonybus = 38
trackDecorator.group.guitarsolobus = 39
trackDecorator.group.bassupbus = 40
trackDecorator.group.bassdownbus = 41
trackDecorator.group.synthbus = 42
trackDecorator.group.vocallead1bus = 43
trackDecorator.group.vocallead2bus = 44
trackDecorator.group.vocalharmonybus = 45
trackDecorator.group.vocalbackupbus = 46
trackDecorator.group.acousticguitarbus = 48

function trackDecorator.setupTrackDefaults(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, 'I_NCHAN', 4) -- set track to 4 channels
end

function trackDecorator.createSendToGroupMaster(currentTrack, group)
    trackCount = reaper.CountTracks(0) - 1
    groupBit = 1 << (group - 32 -1)
    groupRes = math.floor(2^((group - 32) - 1))

    for trackId = 0, trackCount do
        track = reaper.GetTrack(0, trackId)

        res = reaper.GetSetTrackGroupMembershipHigh(track, 'SOLO_SLAVE', groupBit, 0)

	-- reaper.ShowConsoleMsg(res .. " : " .. groupRes ..  "\n")
        if res == groupRes then

            reaper.GetSetTrackGroupMembershipHigh(track, 'SOLO_SLAVE', groupBit, groupBit)
            trackDecorator.createPostFaderSend(currentTrack, track)
        end
    end
end

function trackDecorator.decorateSnare(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.drums)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.snare)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.snarebus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'snare')
end

function trackDecorator.decorateKick(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.drums)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.kick)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.kickbus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'kick')
end

function trackDecorator.decorateTom(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.drums)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.tombus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'tom', '__dr__ __tom__')
end

function trackDecorator.decorateOverhead(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.drums)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.overheadbus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'overhead')
end

function trackDecorator.decorateRoom(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.drums)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.roombus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.drums, 'room')
end

function trackDecorator.decorateGuitar(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.guitars)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.guitarbus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.guitars, 'guitar')
end

function trackDecorator.decorateGuitarHarmony(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.guitars)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.guitarharmonybus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.guitars, 'guitar')
end

function trackDecorator.decorateAcousticGuitar(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.guitars)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.acousticguitarbus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.guitars, 'acoustic')
end

function trackDecorator.decorateGuitarSolo(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.guitars)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.guitarsolo)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.guitarsolobus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.guitarsolo, 'guitar solo')
end

function trackDecorator.decorateSynth(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.synth)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.synthbus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.synth, 'synth')
end

function trackDecorator.decorateBass(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.bass)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.bassupbus)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.bassdownbus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.bass, 'bass')
end

function trackDecorator.decorateVocalLeadOne(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.vocal)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.vocallead1bus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.vocals, 'vocal')
end

function trackDecorator.decorateVocalLeadTwo(currentTrack)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.vocal)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.vocallead2bus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.vocals, 'vocal')
end


function trackDecorator.decorateBackupVocal(currentTrack)
    reaper.SetMediaTrackInfo_Value(currentTrack, "B_MAINSEND", 0)
    trackDecorator.addToGroup(currentTrack, trackDecorator.group.vocal)
    trackDecorator.createSendToGroupMaster(currentTrack, trackDecorator.group.vocalbackupbus)

    return trackDecorator.decorate(currentTrack, trackDecorator.colors.vocals, 'vocal backup')
end

function trackDecorator.createPostFaderSend(currentTrack, receivingTrack)
    sendIndex = reaper.CreateTrackSend(currentTrack, receivingTrack)
    reaper.SetTrackSendInfo_Value(currentTrack, 0, sendIndex, "I_SENDMODE", 0)
end

-- the eventual decorator
function trackDecorator.decorate(currentTrack, color, name)
    _, localTrackName = reaper.GetTrackName(currentTrack, "")

    prefix = localTrackName
    if string.len(localTrackName) == 0 or string.find(localTrackName, 'Track ') ~= nil then
        prefix = name
    end

    reaper.SetTrackColor(currentTrack, color)
    reaper.GetSetMediaTrackInfo_String(currentTrack, "P_NAME", prefix, true)
end

function trackDecorator.addToGroup(currentTrack, group)
    setValue = 1 << (group -1)

    reaper.GetSetTrackGroupMembership(currentTrack, "SOLO_SLAVE", setValue, setValue)
    reaper.GetSetTrackGroupMembership(currentTrack, "MUTE_SLAVE", setValue, setValue)
end

function trackDecorator.removeFromGroup(currentTrack, group)
    setValue = 1 << (group -1)

    reaper.GetSetTrackGroupMembership(currentTrack, "VOLUME_SLAVE", setValue, 0)
    reaper.GetSetTrackGroupMembership(currentTrack, "SOLO_SLAVE", setValue, 0)
    reaper.GetSetTrackGroupMembership(currentTrack, "MUTE_SLAVE", setValue, 0)
end

return trackDecorator
