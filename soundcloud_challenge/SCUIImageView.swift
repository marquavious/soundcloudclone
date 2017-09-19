//
//  SCUIView.swift
//  soundcloud_challenge
//
//  Created by Marquavious on 9/17/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit

protocol SCContainerViewDelegate{
    func imageViewWasDraggedToPoint(point: CGPoint, gesture: UIPanGestureRecognizer)
}

class SCUIView: UIImageView {
    
    var delegate: SCContainerViewDelegate?
    var blurEffectView: UIVisualEffectView?
    
    func addBlurredView(){
        UIView.animate(withDuration: 0.10, delay: 0.0, options: [.curveEaseIn, .curveEaseOut], animations: {
            self.blurEffectView?.layer.opacity = 1
        }) { (bool) in
            
        }
    }
    
    func removedBlurredView(){
        UIView.animate(withDuration: 0.10, delay: 0.0, options: [.curveEaseIn, .curveEaseOut], animations: {
            self.blurEffectView?.layer.opacity = 0
        }) { (bool) in
            
        }
    }
    
    func createBlurredView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.frame
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.layer.opacity = 0
        if let blurEffectView = blurEffectView {
            self.addSubview(blurEffectView)
        }
    }
    
    func addPanGesture(){
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(viewWasDragged(_:)))
        self.addGestureRecognizer(gesture)
        self.isUserInteractionEnabled = true
    }
    
    func viewWasDragged(_ gesture:UIPanGestureRecognizer){
        let translation = gesture.translation(in: self)
        delegate?.imageViewWasDraggedToPoint(point: translation, gesture: gesture)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createBlurredView()
        addPanGesture()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
