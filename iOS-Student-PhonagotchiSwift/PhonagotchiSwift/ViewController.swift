//
//  ViewController.swift
//  PhonagotchiSwift
//
//  Created by Michael Reining on 1/22/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var bananaImageView2: UIImageView!
    @IBOutlet weak var monkeyImageView: UIImageView!
    @IBOutlet weak var bananaImageView: UIImageView!
    
    var lastPosition:CGPoint?
    var pinchRecognized: Bool = false
    var monkey: Pet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monkey = Pet()
        bananaImageView2.alpha = 0.0
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleBananaPan(_ recognizer:UIPanGestureRecognizer) {
        
        //move banana with finger 1. Get new location 2. Update view to new location 3. Reset to zero for new move
        let newLocation = recognizer.translation(in: self.view) //1.
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + newLocation.x, //2.
            y:recognizer.view!.center.y + newLocation.y)
        recognizer.setTranslation(CGPoint.zero, in: self.view) //3.
        
        // If Pan has ended & banana frame is not within monkey frame
        if recognizer.state == .ended && !monkeyImageView.frame.contains(recognizer.view!.frame) {
            animateBananaFallsDown(recognizer.view!)
        }
        
        // If Banana is within monkey frame, let monkey eat banana
        let bananaPosition = recognizer.view!.center
        if monkeyImageView.frame.contains(bananaPosition){
            animateEatBanana(recognizer.view!)
            
        }
    }

    
    
    @IBAction func handlePan(_ recognizer:UIPanGestureRecognizer) {
        
        //move monkey with finger 1. Get new location 2. Update view to new location 3. Reset to zero for new move
        let newLocation = recognizer.translation(in: self.view) //1.
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + newLocation.x, //2.
            y:recognizer.view!.center.y + newLocation.y)
        recognizer.setTranslation(CGPoint.zero, in: self.view) //3.
        
        //detect velocity
        let xVelocity = recognizer.velocity(in: self.view).x
        let yVelocity = recognizer.velocity(in: self.view).y
        let totalVelocity = sqrt(xVelocity * xVelocity + yVelocity * yVelocity)
        
        //if monkey if monkey is moved to much, it gets sad.  If it is sad...
        monkey!.petMonkey(totalVelocity)
        if monkey!.mood == .sad {
            //change image, disable recognizer, show alert, reenable recognizer.
            monkeyImageView.image = UIImage(named: "monkeyUpset")
            recognizer.isEnabled = false
            
            let message = "Please stop petting me!"
            let alert = UIAlertController(title: "Not so fast!", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Sorry!", style: .default, handler: { (action:UIAlertAction) -> Void in
                self.monkeyImageView.image = UIImage(named: "monkey")
                recognizer.isEnabled = true
            })
            alert.addAction(action)
            self.present(alert, animated: true,
                completion: {
                    print("presentViewController(alert, animated: true, completion")
            })
        } else {
            //make it happy again
        }
    }
    
    @IBAction func handlePinch(_ recognizer : UIPinchGestureRecognizer) {
        print("pinch recognized")
        animateSecondBananaAppears()
        
        pinchRecognized = true
        if recognizer.state == .ended {
            print("pinch has ended")
            pinchRecognized = false
        }
    }
    
    func gestureRecognizer(_: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            return true
    }
    
    
    //MARK: Animation Blocks
    
    func animateEatBanana(_ view: UIView) {
        UIView.animate(withDuration: 0.5,
            delay: 0.4,
            options: [],
            animations: {
                view.alpha = 0.0
                let scaleTrans = CGAffineTransform(scaleX: 0.01, y: 0.01)
                let angle = CGFloat(180 * M_PI / 180)
                let rotateTrans = CGAffineTransform(rotationAngle: angle)
                view.transform = scaleTrans.concatenating(rotateTrans)
            },
            completion: { finished in
                //                self.animatefirstBananaReappears()
        })
    }
    
    
    func animateSecondBananaAppears() {
        UIView.animate(withDuration: 0.2,
            delay: 0.4,
            options: UIViewAnimationOptions(),
            animations: {
                self.bananaImageView2.alpha = 1.0
            },
            completion: { finished in
                print("Second Banana is here!")
        })
    }
    
    func animateBananaFallsDown(_ view: UIView) {
        UIView.animate(withDuration: 1.0,
            delay: 0.4,
            options: .curveEaseIn,
            animations: {
                let angle = CGFloat(90 * M_PI / 180)
                view.center = CGPoint(x: 150, y: 800)
                view.transform = CGAffineTransform(rotationAngle: angle)
                view.alpha = 1.0
            },
            completion: { finished in
                print("Banana is falling!")
        })
    }
}
