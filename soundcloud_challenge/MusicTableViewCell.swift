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
                playCountLabel.text = "\(song.playCount)"
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










//if !containerView.isAnimating && !tabBarContainer.isAnimating {
//    let translation = gesture.translation(in: self.containerView)
//    let opacityPercent = translation.y / containerView.frame.height
//    
//    _ = containerView.contents.map {$0.alpha = opacityPercent}
//    
//    self.containerView .frame.origin.y = translation.y - containerView.frame.height
//    
//    var editedPoint = CGPoint(x: 0, y: 0)
//    
//    if gesture.state == .ended {
//        let velocity = gesture.velocity(in: self.containerView)
//        if velocity.y < 300 && containerView.isUp {
//            if translation.y < containerView.frame.height/2 {
//                editedPoint = CGPoint(x: 0, y: -containerView.frame.height+3)
//            }
//        } else {
//            editedPoint = CGPoint(x:0,y: 0)
//        }
//        
//        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut,.curveEaseIn], animations: {
//            self.containerView.isAnimating = true
//            self.tabBarContainer.isAnimating = true
//            self.containerView.frame.origin = editedPoint
//            
//            if editedPoint.x > self.containerView.frame.height/2 && self.tabBarContainer.isUp {
//                self.containerView.isUp = true
//                self.tabBarContainer.center.y += self.tabBarContainer.frame.height
//                self.tabBarContainer.isUp = false
//            } else {
//                self.containerView.isUp = false
//                self.tabBarContainer.center.y -= self.tabBarContainer.frame.height
//                self.tabBarContainer.isUp = true
//            }
//            //
//            _ = self.containerView.contents.map {$0.alpha = 1}
//        }, completion: { (bool) in
//            if bool {
//                self.containerView.isAnimating = false
//                self.tabBarContainer.isAnimating = false
//            }
//        })
//    }
//}
