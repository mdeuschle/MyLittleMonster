//
//  MonsterImage.swift
//  MyLittleMonster
//
//  Created by Matt Deuschle on 4/3/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import Foundation
import UIKit

class MonsterImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }

    func playIdleAnimation() {

        self.image = UIImage(named: "idle1")

        self.animationImages = nil

        let monsterImageArray: [UIImage] = [(UIImage(named: "idle1")!),
                                            (UIImage(named: "idle2")!),
                                            (UIImage(named: "idle3")!),
                                            (UIImage(named: "idle4")!)]

        self.animationImages = monsterImageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }

    func playDeathAnimation() {

        self.image = UIImage(named: "dead5")

        self.animationImages = nil

        let monsterImageArray: [UIImage] = [(UIImage(named: "dead1")!),
                                            (UIImage(named: "dead2")!),
                                            (UIImage(named: "dead3")!),
                                            (UIImage(named: "dead4")!),
                                            (UIImage(named: "dead5")!)]

        self.animationImages = monsterImageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()

    }
}
