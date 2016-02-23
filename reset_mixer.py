from reaper_python import *

# RPR_Main_SaveProject(0, True)
path = RPR_GetProjectPathEx(0)

print path

for track_number in range(0, RPR_CountTracks(0) + 1):
    track = RPR_GetTrack(0, track_number)

    RPR_SetMediaTrackInfo_Value(track, "D_VOL", 1.0)
    RPR_SetMediaTrackInfo_Value(track, "D_PAN", 0)
    RPR_SetMediaTrackInfo_Value(track, "I_SELECTED", 1)

    for fx_identifier in range(0, RPR_TrackFX_GetCount(track) + 1):
        RPR_TrackFX_SetEnabled(track, fx_identifier, False)