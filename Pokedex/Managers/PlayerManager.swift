//
//  PlayerManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 23/03/23.
//

import Foundation
import AVKit

class PlayerManager {
    var player: AVPlayer?
    
    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
}
