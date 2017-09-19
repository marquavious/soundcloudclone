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
    @IBOutlet weak var tabBarContainer: UIView!
    @IBOutlet weak var backViewImageView: SCUIView!
    @IBOutlet weak var backViewArtistLabel: UILabel!
    @IBOutlet weak var backViewSongtitleLabel: UILabel!
    @IBOutlet weak var backViewPlaycountLabel: UILabel!
    
    let orangeBarHeight: CGFloat = 3
    var currentlyPlayingSong: Song?
    var audioPlayer = SCAVAudioPlayer()
    
    var songs = [
        Song(title: "Sonic Boom", uploader: "Roy Woods", likeCount: 230, playCount: 940, mp3Link: "01 Sonic Boom", ablumImage: #imageLiteral(resourceName: "roy")),
        Song(title: "High Hopes", uploader: "partyomo", likeCount: 230, playCount: 940, mp3Link: "01. High Hopes", ablumImage: #imageLiteral(resourceName: "pnd")),
        Song(title: "Summer Friends (feat Jeremih Francis The Lights)", uploader: "Chance The Rapper", likeCount: 230, playCount: 940, mp3Link: "03 - Summer Friends (feat Jeremih Francis The Lights)", ablumImage: #imageLiteral(resourceName: "chance")),
        Song(title: "Without", uploader: "Sampha", likeCount: 230, playCount: 940, mp3Link: "Sampha", ablumImage: #imageLiteral(resourceName: "sampha")),
        Song(title: "Reaper - Exodia (jam edit)", uploader: "jamvvis", likeCount: 230, playCount: 940, mp3Link: "J.K. The Reaper - Exodia (jam edit)_262577496_soundcloud", ablumImage: #imageLiteral(resourceName: "jamis")),
        Song(title: "Bout It - PND", uploader: "partyomo", likeCount: 230, playCount: 940, mp3Link: "Bout It- PND_211209348_soundcloud", ablumImage: #imageLiteral(resourceName: "pndtwo")),
        Song(title: "ledge glow", uploader: "cat soup", likeCount: 230, playCount: 940, mp3Link: "cat soup - icasm 2096 - 09 ledge glow", ablumImage: #imageLiteral(resourceName: "blck")),
        Song(title: "On My Mind", uploader: "Tiber", likeCount: 230, playCount: 940, mp3Link: "On My Mind_246964322_soundcloud", ablumImage: #imageLiteral(resourceName: "tiber")),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backViewImageView.delegate = self
        addTouchGuesterToSelectedView(selectedView:backViewImageView)
        containerView.contents.append(tableView)
        containerView.contents.append(navigationBarView)
    }

    func showNowPlaying(){
        UIView.animate(withDuration: 0.10, delay: 0.10, options: [.curveEaseIn, .curveEaseOut], animations: {
            self.containerView.center.y -= self.containerView.frame.height-self.orangeBarHeight
            self.tabBarContainer.center.y += self.tabBarContainer.frame.height
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        }) { (bool) in
            self.containerView.isUp = true
        }
    }
    
    func dissmissNowPlaying(){
        UIView.animate(withDuration: 0.10, delay: 0.10, options: [.curveEaseIn,.curveEaseOut], animations: {
            self.containerView.center.y += self.containerView.frame.height-self.orangeBarHeight
            self.tabBarContainer.center.y -= self.tabBarContainer.frame.height
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
        }) { (bool) in
            self.containerView.isUp = false
        }
    }
    
    func addTouchGuesterToSelectedView(selectedView:UIView){
        selectedView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleSwitchSongState))
        selectedView.addGestureRecognizer(gesture)
    }
    
    func startSong(song:Song){
        
        do {
            if let player = try? SCAVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: song.mp3Link, ofType: "mp3")!)){
                audioPlayer = player
                audioPlayer.play()
                currentlyPlayingSong = song
                song.songState = .playing
                self.backViewImageView.removedBlurredView()
                
            } else {
                fatalError("Error playing \(song.title)")
            }
        }
    }
    
    func handleSwitchSongState(){
        
        guard let song = currentlyPlayingSong else {
            return
        }
        
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
        } else {
            showNowPlaying()
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
        
        let song = songs[indexPath.row]
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
        let musicCell = tableView.dequeueReusableCell(withIdentifier: "MuisicCell", for: indexPath) as! MusicTableViewCell
        
        musicCell.song = song
        
        if indexPath.row == 0 {
            return musicCell
        } else {
            return headerCell
        }
        
    }
    
    func setUpBackgroundView(song:Song){
        backViewImageView.image = song.ablumImage
        backViewArtistLabel.text = song.uploader
        backViewSongtitleLabel.text = song.title
        backViewPlaycountLabel.text = "■\(song.playCount)"
        self.view.layoutSubviews()
        
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
        let opacityPercent = translation.y / containerView.frame.height
        
        _ = containerView.contents.map {$0.alpha = opacityPercent}
        
        self.containerView .frame.origin.y = translation.y - containerView.frame.height
        
        var editedPoint = CGPoint(x: 0, y: 0)
        
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: self.containerView)
            
            if velocity.y < 300 {

                if translation.y < containerView.frame.height/2 {
                    editedPoint = CGPoint(x: 0, y: -containerView.frame.height+3)
                } else if translation.y > -containerView.frame.height/2 {
                    editedPoint = CGPoint(x:0,y: 0)
                }
            } else {
                editedPoint = CGPoint(x:0,y: 0)
            }
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut,.curveEaseIn], animations: {
                self.containerView.frame.origin = editedPoint
                
                if editedPoint.x > self.containerView.frame.height/2 {
                    self.containerView.isUp = false
                    self.tabBarContainer.center.y -= opacityPercent/self.tabBarContainer.frame.height
                } else {
                    self.containerView.isUp = true
                    self.tabBarContainer.center.y += opacityPercent/self.tabBarContainer.frame.height
                }
                
                _ = self.containerView.contents.map {$0.alpha = 1}
            }, completion: { (bool) in
                
            })
        }
    }
    
}

