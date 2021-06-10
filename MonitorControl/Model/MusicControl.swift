//
//  MusicControl.swift
//  MonitorControl
//
//  Created by Jonas Gessner on 29.05.21.
//  Copyright © 2021 Jonas Gessner. All rights reserved.
//

import Foundation
import ScriptingBridge
import Combine

// Alternative way of doing this stuff: https://github.com/nbolar/PlayStatus/blob/master/PlayStatus/Scripts.swift

final class MusicApp: ObservableObject {
  static let shared = MusicApp()
  
  private let app = SBApplication(bundleIdentifier: "com.apple.Music")!

  private init() {
    DistributedNotificationCenter.default().addObserver(self, selector: #selector(musicChanged(_:)), name: NSNotification.Name(rawValue: "com.apple.Music.playerInfo"), object: nil)
    
    updatePlaying()
  }
  
  private func updatePlaying() {
      playing = app.isRunning && app.playerState != MusicEPlSPaused && app.playerState != MusicEPlSPaused
  }
  
  @objc private func musicChanged(_ ob: Notification) {
    DispatchQueue.main.async {
      self.updatePlaying()
      self.objectWillChange.send() // Abuse of this API because the object already changed but fuck this will change shit
//      self.playing = (ob.userInfo?["Player State"] as? String) == "Playing"
    }
  }
  
  var airplaying: Bool {
    return app.isRunning && app.airPlayEnabled
  }
  
  var wantsSmallVolumeIncrements: Bool {
    return app.currentAirPlayDevices.contains(where: {
      let kind = ($0 as! NSObject).kind
      let sensitive = kind != MusicEAPDBluetoothDevice
      return sensitive
    })
  }
  
  private(set) var playing: Bool = false
  
  func fastForward() {
    app.fastForward()
  }
  
  func rewind() {
    app.rewind()
  }
  
  func resume() {
    app.resume()
  }
  
  func next() {
    app.nextTrack()
  }
  
  func previous() {
    app.backTrack()
  }
  
  func togglePlay() {
    app.playpause()
  }
  
  var volume: Int {
    get {
      return app.isRunning ? app.soundVolume : 0
    }
    
    set {
      let bounded = max(min(100, newValue), 0)
      if app.isRunning {
        app.soundVolume = bounded
      }
    }
  }
}
