//
//  Music.h
//  MonitorControl
//
//  Created by Jonas Gessner on 29.05.21.
//  Copyright © 2021 Jonas Gessner. All rights reserved.
//

#import <ScriptingBridge/ScriptingBridge.h>

enum iTunesEPlS {
  iTunesEPlSStopped = 'kPSS',
  iTunesEPlSPlaying = 'kPSP',
  iTunesEPlSPaused = 'kPSp',
  iTunesEPlSFastForwarding = 'kPSF',
  iTunesEPlSRewinding = 'kPSR'
};
typedef enum iTunesEPlS iTunesEPlS;

@interface SBApplication ()

@property (readonly) BOOL AirPlayEnabled;  // is AirPlay currently enabled?
@property BOOL mute;  // has the sound output been muted?
@property double playerPosition;  // the player’s position within the currently playing track in seconds.
@property (readonly) iTunesEPlS playerState;  // is iTunes stopped, paused, or playing?
@property NSInteger soundVolume;  // the sound output volume (0 = minimum, 100 = maximum)

- (void) backTrack;  // reposition to beginning of current track or go to previous track if already at start of current track
- (void) fastForward;  // skip forward in a playing track
- (void) nextTrack;  // advance to the next track in the current playlist
- (void) pause;  // pause playback
- (void) playOnce:(BOOL)once;  // play the current track or the specified track or file.
- (void) playpause;  // toggle the playing/paused state of the current track
- (void) previousTrack;  // return to the previous track in the current playlist
- (void) resume;  // disable fast forward/rewind and resume playback, if playing.
- (void) rewind;  // skip backwards in a playing track
- (void) stop;  // stop playback

@end
