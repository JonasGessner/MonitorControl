//
//  MusicControl.swift
//  MonitorControl
//
//  Created by Jonas Gessner on 29.05.21.
//  Copyright © 2021 Jonas Gessner. All rights reserved.
//

import Foundation
import ScriptingBridge

final class MusicApp {
  static let shared = MusicApp()
  
  private let app = SBApplication(bundleIdentifier: "com.apple.Music")!
  
  private init() {}
  
  var airplaying: Bool {
    return app.isRunning && app.airPlayEnabled
  }
  
  var playing: Bool {
    return app.isRunning && app.playerState != iTunesEPlSPaused && app.playerState != iTunesEPlSStopped
  }
  
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
