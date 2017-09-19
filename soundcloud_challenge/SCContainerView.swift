//
//  SCContainerView.swift
//  soundcloud_challenge
//
//  Created by Marquavious on 9/17/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import Foundation
import UIKit

//protocol SCContainerViewDelegate {
//    func animateOverviewAlpha(point: CGPoint);
//}

class SCContainerView: UIView {
    
    var overview: UIView?
    var contents = [UIView]()
    var isUp: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
}
