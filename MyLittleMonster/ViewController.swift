//
//  ViewController.swift
//  MyLittleMonster
//
//  Created by Matt Deuschle on 4/3/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImage!
    @IBOutlet weak var heartImg: DragImage!
    @IBOutlet weak var foodImg: DragImage!

    @IBOutlet var penalty1Image: UIImageView!
    @IBOutlet var penalty2Image: UIImageView!
    @IBOutlet var penalty3Image: UIImageView!

    let dimAlpha: CGFloat = 0.2
    let opaque: CGFloat = 1.0
    let maxPenalties = 3

    var currentPenalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg

        penalty1Image.alpha = dimAlpha
        penalty2Image.alpha = dimAlpha
        penalty3Image.alpha = dimAlpha

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)

        startTimer()

    }

    func itemDroppedOnCharacter(notif: AnyObject) {

        monsterHappy = true
        startTimer()

        foodImg.alpha = dimAlpha
        foodImg.userInteractionEnabled = false
        heartImg.alpha = dimAlpha
        heartImg.userInteractionEnabled = false

    }

    func startTimer() {

        if timer != nil {
            timer.invalidate()
        }

        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }

    func changeGameState() {

        if !monsterHappy {

            currentPenalties += 1

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
    }
}

