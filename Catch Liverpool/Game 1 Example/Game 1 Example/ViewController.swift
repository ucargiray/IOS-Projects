//
//  ViewController.swift
//  Game 1 Example
//
//  Created by Giray Uçar on 10.11.2020.
//  Copyright © 2020 Ahmet Giray Uçar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 10
    var highScore = 0
    var hideTimer = Timer()
    var gameSpeed = 0.0
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var highscoreLabel: UILabel!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet var image5: UIImageView!
    @IBOutlet var image6: UIImageView!
    @IBOutlet var image7: UIImageView!
    @IBOutlet var image8: UIImageView!
    @IBOutlet var image9: UIImageView!
    var imageList = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        scoreLabel.text = "Score:\(score)"
        timeLabel.text = "Time: \(counter)"
        
        let recog1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        image1.addGestureRecognizer(recog1)
        image2.addGestureRecognizer(recog2)
        image3.addGestureRecognizer(recog3)
        image4.addGestureRecognizer(recog4)
        image5.addGestureRecognizer(recog5)
        image6.addGestureRecognizer(recog6)
        image7.addGestureRecognizer(recog7)
        image8.addGestureRecognizer(recog8)
        image9.addGestureRecognizer(recog9)
        
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        image7.isUserInteractionEnabled = true
        image8.isUserInteractionEnabled = true
        image9.isUserInteractionEnabled = true
        
        imageList = [image1,image2,image3,image4,image5,image6,image7,image8,image9]
        
        
    }
    
    @objc func hideLiverpool(){
        for liverpool in imageList{
            liverpool.isHidden = true
        }
        let randomInt = Int.random(in: 0..<9)
        imageList[randomInt].isHidden = false
    }
    
    @objc func increaseScore(){
        score = score + 1
        scoreLabel.text = "Score:\(score)"
        
    }
    
    @objc func countDown() {
    counter -= 1
    timeLabel.text = "Time: \(counter)"
    
    if counter == 0 {
        timer.invalidate()
        hideTimer.invalidate()
        
        for liverpool in imageList {
            liverpool.isHidden = true
        }

        if self.score > self.highScore {
            self.highScore = self.score
            highscoreLabel.text = "Highscore: \(self.highScore)"
            UserDefaults.standard.set(self.highScore, forKey: "highscore")
                }
        
        let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
               let actionNo = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
               
               let actionOk = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                    self.score = 0
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.counter = 10
                    self.timeLabel.text = String(self.counter)
                    self.startButtonOutlet.isHidden = false
                    self.fastModeButton.isHidden = false
                    self.normalModeButton.isHidden = false
                    self.slowModeButton.isHidden = false
            }
        
        alert.addAction(actionOk)
        alert.addAction(actionNo)
        self.present(alert, animated: true, completion: nil)
        }

    }
    @IBAction func startGame(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: gameSpeed, target: self, selector: #selector(hideLiverpool), userInfo: nil, repeats: true)
        startButtonOutlet.isHidden = true
        fastModeButton.isHidden = true
        normalModeButton.isHidden = true
        slowModeButton.isHidden = true
    }
    @IBOutlet var fastModeButton: UIButton!
    @IBOutlet var normalModeButton: UIButton!
    @IBOutlet var slowModeButton: UIButton!
    @IBOutlet var startButtonOutlet: UIButton!
    @IBAction func slowMode(_ sender: UIButton) {
        slowModeButton.backgroundColor = UIColor.orange
        fastModeButton.backgroundColor = UIColor.white
        normalModeButton.backgroundColor = UIColor.white
        gameSpeed = 2.0
    }
    @IBAction func normalMode(_ sender: UIButton) {
        normalModeButton.backgroundColor = UIColor.orange
        slowModeButton.backgroundColor = UIColor.white
        fastModeButton.backgroundColor = UIColor.white
        gameSpeed = 1.0
    }
    @IBAction func fastMode(_ sender: UIButton) {
        fastModeButton.backgroundColor = UIColor.orange
        slowModeButton.backgroundColor = UIColor.white
        normalModeButton.backgroundColor = UIColor.white
        gameSpeed = 0.5
    }
}
