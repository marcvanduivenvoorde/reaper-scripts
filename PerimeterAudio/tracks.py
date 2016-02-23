from reaper_python import *


def get_tracks():
    track_list = [];
    for i in range(0,  RPR_CountTracks(0) + 1):
        track_list.append(RPR_GetTrack(0, i))

    return track_list