//
//  ViewController.swift
//  MyLittleMonster
//
//  Created by Matt Deuschle on 4/3/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImage!
    @IBOutlet weak var heartImg: DragImage!
    @IBOutlet weak var foodImg: DragImage!

    @IBOutlet var penalty1Image: UIImageView!
    @IBOutlet var penalty2Image: UIImageView!
    @IBOutlet var penalty3Image: UIImageView!
    @IBOutlet var startOverButton: UIButton!

    let dimAlpha: CGFloat = 0.2
    let opaque: CGFloat = 1.0
    let maxPenalties = 3

    var currentPenalties = 0
    var timer: NSTimer!
    var startOverTimer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0

    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)

        do {

            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")
            let url = NSURL(fileURLWithPath: resourcePath!)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)

            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))

            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))

            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))

            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))

            musicPlayer.prepareToPlay()
            musicPlayer.play()

            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()

        } catch let err as NSError {
            
            print(err.debugDescription)
        }

        newGame()
    }

    func newGame() {

        heartImg.hidden = false
        foodImg.hidden = false

        startOverButton.hidden = true
        currentPenalties = 0

        monsterImg.playIdleAnimation()

        penalty1Image.alpha = dimAlpha
        penalty2Image.alpha = dimAlpha
        penalty3Image.alpha = dimAlpha
        
        startTimer()
    }

    func itemDroppedOnCharacter(notif: AnyObject) {

        monsterHappy = true
        startTimer()

        foodImg.alpha = dimAlpha
        foodImg.userInteractionEnabled = false
        heartImg.alpha = dimAlpha
        heartImg.userInteractionEnabled = false

        if currentItem == 0 {

            sfxHeart.play()
        }

        else {

            sfxBite.play()
        }
    }

    func startTimer() {

        if timer != nil {
            timer.invalidate()
        }

        timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }

    func changeGameState() {

        if !monsterHappy {

            currentPenalties += 1
            sfxSkull.play()

            if currentPenalties == 1 {

                penalty1Image.alpha = opaque
                penalty2Image.alpha = dimAlpha
            }

            else if currentPenalties == 2 {

                penalty2Image.alpha = opaque
                penalty3Image.alpha = dimAlpha

            }

            else if currentPenalties >= 3 {

                penalty3Image.alpha = opaque
            }

            else {

                penalty1Image.alpha = dimAlpha
                penalty2Image.alpha = dimAlpha
                penalty3Image.alpha = dimAlpha
            }
            
            if currentPenalties >= maxPenalties {
                
                gameOver()
            }
        }

        let rand = arc4random_uniform(2)

        if rand == 0 {

            foodImg.alpha = dimAlpha
            foodImg.userInteractionEnabled = false

            heartImg.alpha = opaque
            heartImg.userInteractionEnabled = true

        } else {

            heartImg.alpha = dimAlpha
            heartImg.userInteractionEnabled = false

            foodImg.alpha = opaque
            foodImg.userInteractionEnabled = true
        }

        currentItem = rand
        monsterHappy = false
    }

    func gameOver() {

        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
        heartImg.hidden = true
        foodImg.hidden = true

        startOverTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.startOver), userInfo: nil, repeats: false)
    }

    func startOver() {

        startOverButton.hidden = false
    }

    @IBAction func startOverButtonPressed(sender: AnyObject) {

        newGame()
    }
    
}

