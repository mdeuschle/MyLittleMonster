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

    }

    func startTimer() {

        if timer != nil {
            timer.invalidate()
        }

        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }

    func changeGameState() {

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

    func gameOver() {

        timer.invalidate()
        monsterImg.playDeathAnimation()
    }
}

