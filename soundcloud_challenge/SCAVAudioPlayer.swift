//
//  SCAVAudioPlayer.swift
//  soundcloud_challenge
//
//  Created by Marquavious on 9/17/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit
import AVFoundation

class SCAVAudioPlayer: AVAudioPlayer {
    
    func play(song: Song){
        super.play()
        song.songState = .playing
        
    }
    
     func pause(song: Song){
        super.pause()
        
        song.songState = .paused
        
    }

}
