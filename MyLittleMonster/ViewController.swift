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

    override func viewDidLoad() {
        super.viewDidLoad()

        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)

    }

    func itemDroppedOnCharacter(notif: AnyObject) {

    }

}

