//
//  DragImage.swift
//  MyLittleMonster
//
//  Created by Matt Deuschle on 4/3/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import Foundation
import UIKit

class DragImage: UIImageView {

    var originalPostion : CGPoint!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        originalPostion = self.center

    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        if let touch = touches.first {

            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }

    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
}
