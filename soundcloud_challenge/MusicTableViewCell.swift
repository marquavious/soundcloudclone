//
//  MusicTableViewCell.swift
//  soundcloud_challenge
//
//  Created by Marquavious on 9/14/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    var song: Song? {
        didSet{
            if let song = song {
                albumImageView.image = song.ablumImage
                uploaderNameLabel.text = song.uploader
                songTitleLabel.text = song.title
                playCountLabel.text = "■\(song.playCount)"
                songlLengthLabel.text = String(song.songLength)
            }
        }
    }

    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var uploaderNameLabel: UILabel!
    
    @IBOutlet weak var songTitleLabel: UILabel!
    
    @IBOutlet weak var playCountLabel: UILabel!
    
    @IBOutlet weak var songlLengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
