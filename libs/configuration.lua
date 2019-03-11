local configuration = {
    kick = {
        vca = 1,
        color = 26316,
        send = 'kick-bus __dr__',
        name = 'kick __dr__'
    },
    snare = {
        vca = 1,
        color = 26316,
        send = 'snare-bus __dr__',
        name = 'snare __dr__'
    },
    tom = {
        vca = 1,
        color = 26316,
        send = 'tom-bus __dr__',
        name = 'tom __dr__'
    },
    overhead = {
        vca = 1,
        color = 26316,
        send = 'overhead-bus __dr__',
        name = 'overhead __dr__'
    },
    room = {
        vca = 1,
        color = 26316,
        send = 'room-bus __dr__',
        name = 'room __dr__'
    },
    drumreverb = {
        vca = 1,
        color = 26316,
        send = 'drum-wet-bus __dr__',
        name = 'drumverb __dr__'
    },
    guitar = {
        vca = 2,
        color = 8849466,
        send = 'guitar-bus __gtr__',
        name = 'guitar __gtr__'
    },
    guitarsolo = {
        vca = 2,
        color = 8849466,
        send = 'solo-bus __gtr__',
        name = 'solo __gtr__'
    },
    bass = {
        vca = 3,
        color = 6293644,
        send = 'bass-bus __bass__',
        name = 'bass __bass__'
    },
    vocal = {
        vca = 4,
        color = 12619858,
        send = 'vocal-bus __vox__',
        name = 'vocal __vox__'
    },
}

return configuration
