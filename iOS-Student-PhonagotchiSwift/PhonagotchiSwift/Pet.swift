//
//  Pet.swift
//  PhonagotchiSwift
//
//  Created by Michael Reining on 1/22/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import Foundation
import UIKit

class Pet {
    var mood: Mood = .normal
    init() {
    }
    
    func petMonkey(_ velocity: CGFloat) {
        print("velocity: \(velocity)")
        if velocity > 400 {
            print("You are moving me too fast!")
            self.mood = .sad
        }else {
            self.mood = .happy
        }
//        if velocity == 0 {
//            self.mood = .Normal
//        }
//        if velocity > 10 && velocity < 100 {
//            self.mood = .Happy
//        }
    }
}


enum Mood {
    case normal, happy, sad
}

