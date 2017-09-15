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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBarContainer: UIView!
    @IBOutlet weak var backViewImageView: UIImageView!
    @IBOutlet weak var backViewArtistLabel: UILabel!
    @IBOutlet weak var backViewSongtitleLabel: UILabel!
    @IBOutlet weak var backViewPlaycountLabel: UILabel!
    
    var currentlyPlayingSong: Song?
    
    var audioPlayer = AVAudioPlayer()
    var controllerIsUp = false
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showNowPlaying(){
        UIView.animate(withDuration: 0.10, delay: 0.10, options: [.curveEaseIn, .curveEaseOut], animations: {
            self.containerView.center.y -= self.containerView.frame.height-3
            self.tabBarContainer.center.y += self.tabBarContainer.frame.height
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        }) { (bool) in
            self.controllerIsUp = true
        }
    }
    
    func dissmissNowPlaying(){
        UIView.animate(withDuration: 0.10, delay: 0.10, options: [.curveEaseIn,.curveEaseOut], animations: {
            self.containerView.center.y += self.containerView.frame.height-3
            self.tabBarContainer.center.y -= self.tabBarContainer.frame.height
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
        }) { (bool) in
            self.controllerIsUp = false
        }
    }
    
    func playSong(song: String){
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: song, ofType: "mp3")!))
            audioPlayer.play()
        } catch {
            print(error)
        }
    }
    
    func runAnimation(){
        if controllerIsUp {
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
    
    func setUpBackgroundView(song:Song, completion: ()->()){
        backViewImageView.image = song.ablumImage
        backViewArtistLabel.text = song.uploader
        backViewSongtitleLabel.text = song.title
        backViewPlaycountLabel.text = "■\(song.playCount)"
        self.view.layoutSubviews()
        completion()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellSong = songs[indexPath.row]
        

        //currentlyPlayingSong = cellSong
        setUpBackgroundView(song: cellSong) { 
            runAnimation()
            playSong(song:cellSong.mp3Link)
        }
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

