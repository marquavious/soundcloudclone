//
//  Song.swift
//  soundcloud_challenge
//
//  Created by Marquavious on 9/14/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import Foundation
import UIKit

class Song {
    
    enum SongState {
        case playing
        case paused
        case stopped
        case none
    }
    
    var title: String = "Unknown"
    var uploader: String = "Unknown"
    var likeCount: Int = 100
    var playCount: Int = 100
    var songLength: Float = 100
    var mp3Link: String = "Unknown"
    var albumArtLink: String = "Unknown"
    var ablumImage: UIImage?
    var songState: SongState = .none
    
    var albumArtInUrlFormat: URL? {
        get {
            if let url = URL(string: self.albumArtLink) {
                return url
            } else {
                return nil
            }
        }
    }
    
    var mp3LinkInUrlFormat: URL? {
        get {
            if let url = URL(string: self.mp3Link) {
                return url
            } else {
                return nil
            }
        }
    }
    
    init(title: String, uploader: String, likeCount: Int, playCount: Int, mp3Link:String, ablumImage: UIImage){
        self.title = title
        self.uploader = uploader
        self.likeCount = likeCount
        self.playCount = playCount
        self.mp3Link = mp3Link
        self.ablumImage = ablumImage
    }
    
}

