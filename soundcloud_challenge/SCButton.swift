//
//  SCButton.swift
//  soundcloud_challenge
//
//  Created by Marquavious on 9/22/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit

class SCButton: UIButton {
    
    enum ButtonType {
        case play, skip, rewind
    }
    
    var type: ButtonType? {
        didSet{
            if let type = type {
                let image = setupButton(type: type)
                self.imageView?.contentMode = .scaleAspectFit
                self.setImage(image, for: .normal)
            }
        }
    }
    
    func setupButton(type:ButtonType) -> UIImage {
        switch type {
        case .play:
            return #imageLiteral(resourceName: "playbutton")
        case .skip :
            return #imageLiteral(resourceName: "skipbutton")
        case .rewind:
            return #imageLiteral(resourceName: "rewindbutton")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
