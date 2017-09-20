//
//  SCContainerView.swift
//  soundcloud_challenge
//
//  Created by Marquavious on 9/17/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import Foundation
import UIKit


class SCContainerView: UIView {
    
    var overview: UIView?
    var contents = [UIView]()
    var isUp: Bool = false
    var isAnimating: Bool = false
    var halfHeight:CGFloat = 0.0
    var height:CGFloat = 0.0 {
        didSet{
            halfHeight = self.height/2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        height = self.frame.height
    }
    
    func addViews(_ views:[UIView]){
        for view in views {
            contents.append(view)
        }
    }
}
