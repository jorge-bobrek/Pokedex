//
//  PlayerManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 23/03/23.
//

import Foundation
import AVKit

class PlayerManager {
    static let shared = PlayerManager()
    
    private init() { }
    
    var player: AVPlayer?
    
    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        player = nil
    }
}
