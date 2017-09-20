//
//  ViewController.swift
//  soundcloud_challenge
//
//  Created by Marquavious on 9/13/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var navigationBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: SCContainerView!
    @IBOutlet weak var tabBarContainer: SCTabBarView!
    @IBOutlet weak var backViewImageView: SCUIView!
    @IBOutlet weak var backViewArtistLabel: UILabel!
    @IBOutlet weak var backViewSongtitleLabel: UILabel!
    @IBOutlet weak var backViewPlaycountLabel: UILabel!
    
    let orangeBarHeight: CGFloat = 3
    var currentlyPlayingSong: Song?
    var audioPlayer = SCAVAudioPlayer()
    let songs = SCMusicDatabase.songs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backViewImageView.delegate = self
        containerView.isUp = false
        tabBarContainer.isUp = true
        addTouchGuesterToSelectedView(selectedView:backViewImageView)
        containerView.addViews([tableView,navigationBarView])
    }
    
    func showNowPlaying(){
        UIView.animate(withDuration: 0.10, delay: 0.10, options: [.curveEaseIn, .curveEaseOut], animations: {
            self.containerView.isAnimating = true
            self.tabBarContainer.isAnimating = true
            self.containerView.center.y -= self.containerView.height-self.orangeBarHeight
            self.tabBarContainer.center.y += self.tabBarContainer.frame.height
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        }) { (bool) in
            if bool {
                self.containerView.isUp = true
                self.tabBarContainer.isUp = false
                self.containerView.isAnimating = false
                self.tabBarContainer.isAnimating = false
            }
        }
    }
    
    func dissmissNowPlaying(){
        UIView.animate(withDuration: 0.10, delay: 0.10, options: [.curveEaseIn,.curveEaseOut], animations: {
            self.containerView.isAnimating = true
            self.tabBarContainer.isAnimating = true
            self.containerView.center.y += self.containerView.height-self.orangeBarHeight
            self.tabBarContainer.center.y -= self.tabBarContainer.frame.height
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
        }) { (bool) in
            if bool {
                self.containerView.isUp = false
                self.tabBarContainer.isUp = true
                self.containerView.isAnimating = false
                self.tabBarContainer.isAnimating = false
            }
        }
    }
    
    func addTouchGuesterToSelectedView(selectedView:UIView){
        selectedView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleSwitchSongState))
        selectedView.addGestureRecognizer(gesture)
    }
    
    func setUpBackgroundView(song:Song){
        backViewImageView.image = song.ablumImage
        backViewArtistLabel.text = song.uploader
        backViewSongtitleLabel.text = song.title
        backViewPlaycountLabel.text = "■\(song.playCount)"
        self.view.layoutSubviews()
    }
    
    func startSong(song:Song){
        do {
            if let player = try? SCAVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: song.mp3Link, ofType: "mp3")!)){
                audioPlayer = player
                audioPlayer.play()
                currentlyPlayingSong = song
                song.songState = .playing
                self.backViewImageView.removedBlurredView()
                
            } else {fatalError("Error playing \(song.title)")}
        }
    }
    
    func handleSwitchSongState(){
        
        guard let song = currentlyPlayingSong else { return }
        
        switch song.songState {
        case .paused:
            audioPlayer.play(song: song)
            backViewImageView.removedBlurredView()
        default:
            audioPlayer.pause(song: song)
            backViewImageView.addBlurredView()
        }
    }
    
    func runAnimation(){
        if self.containerView.isUp {
            dissmissNowPlaying()
        } else if !self.containerView.isUp {
            showNowPlaying()
        } else {
            print("idk")
        }
    }
    
    @IBAction func nowPlayingButtonTapped(_ sender: Any) {
        runAnimation()
    }
    
    @IBAction func hideNowPlayingButtonTapped(_ sender: Any) {
        runAnimation()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
        let musicCell = tableView.dequeueReusableCell(withIdentifier: "MuisicCell", for: indexPath) as! MusicTableViewCell
        let song = songs[indexPath.row]
        musicCell.song = song
        
        if indexPath.row == 0 {
            return musicCell
        } else {
            return headerCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = songs[indexPath.row]
        setUpBackgroundView(song: songs[indexPath.row])
        runAnimation()
        startSong(song:song)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 63
        } else {
            return 101
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
}

extension ViewController: SCContainerViewDelegate {
    
    func imageViewWasDraggedToPoint(point: CGPoint, gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.containerView)
        let velocity = gesture.velocity(in: self.containerView)
        let opacityPercent = translation.y / containerView.frame.height
        _ = containerView.contents.map {$0.alpha = opacityPercent}
        self.containerView.frame.origin.y = translation.y - containerView.height
        var baseCGPoint = CGPoint(x: 0, y: 0)
        var tabBarBaseCGPoint = CGPoint(x: 0, y: 0)
        
        self.containerView .frame.origin.y = translation.y - containerView.height
        
        if gesture.state == .ended {
            if velocity.y < 1500 {
                if translation.y < containerView.halfHeight {
                    baseCGPoint = CGPoint(x: 0, y: -containerView.height+orangeBarHeight)
                    tabBarBaseCGPoint = CGPoint(x: 0, y: view.frame.height)
                }
            } else {
                baseCGPoint = CGPoint(x:0,y: 0)
                tabBarBaseCGPoint = CGPoint(x: 0, y: view.frame.height - tabBarContainer.frame.height)
            }
            
            if !containerView.isAnimating && !tabBarContainer.isAnimating {
                containerView.isAnimating = true
                tabBarContainer.isAnimating = true
                
                if baseCGPoint.y > self.containerView.halfHeight {
                    self.containerView.isUp = true
                } else {
                    self.containerView.isUp = false
                }
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut,.curveEaseIn], animations: {
                    self.containerView.frame.origin = baseCGPoint
                    
                    if baseCGPoint.y > self.containerView.halfHeight {
                        self.tabBarContainer.frame.origin = tabBarBaseCGPoint
                    } else {
                        self.tabBarContainer.frame.origin = tabBarBaseCGPoint
                    }
                    _ = self.containerView.contents.map {$0.alpha = 1}
                }, completion: { (bool) in
                    if bool{
                        self.containerView.isAnimating = false
                        self.tabBarContainer.isAnimating = false
                    }
                })
            }
        }
    }
}

