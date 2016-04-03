//
//  ViewController.swift
//  MyLittleMonster
//
//  Created by Matt Deuschle on 4/3/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let monsterImageArray: [UIImage] = [(UIImage(named: "idle1")!),
                                            (UIImage(named: "idle2")!),
                                            (UIImage(named: "idle3")!),
                                            (UIImage(named: "idle4")!)]

        monsterImg.animationImages = monsterImageArray
        monsterImg.animationDuration = 0.8
        monsterImg.animationRepeatCount = 0
        monsterImg.startAnimating()

    }
}

