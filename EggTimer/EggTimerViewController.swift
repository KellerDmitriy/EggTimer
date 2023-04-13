//
//  EggTimerViewController.swift
//  EggTimer
//
//  Created by Келлер Дмитрий on 13.04.2023.
//

import UIKit
import AVFoundation

final class EggTimerViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        progressBar.progress = 0
    }
    
    @IBAction func eggsButtonTapped(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle ?? "Medium"
        totalTime = eggTimes[hardness] ?? 420
        
        progressBar.progress = 0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
                return print("error")
            }
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
        }
    }
}

