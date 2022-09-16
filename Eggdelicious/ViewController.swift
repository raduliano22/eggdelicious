//
//  ViewController.swift
//  Eggdelicious
//
//  Created by Octav Radulian on 16.09.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var boilingTime = ["Soft": 300, "Medium": 420, "Hard": 720]
    var totalTime = 0
    var timePassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func eggTypeBtnPressed(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        totalTime = boilingTime[hardness]!
        progressBar.progress = 0.0
        timePassed = 0
        titleLabel.text = "You selected \(hardness)"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.timePassed < self.totalTime {
                self.timePassed += 1
                let percentageProgress = Float(self.timePassed) / Float(self.totalTime)
                self.progressBar.progress = percentageProgress
            } else {
                Timer.invalidate()
                self.playSound()
                self.titleLabel.text = "Your egg is ready!"
            }
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "egg_alarm", withExtension: "mp3")
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
}

