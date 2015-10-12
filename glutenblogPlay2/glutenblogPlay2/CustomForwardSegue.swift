//
//  CustomForwardSegue.swift
//  glutenblogPlay2
//
//  Created by Thomas Karg on 12.10.15.
//  Copyright © 2015 Thomas Karg. All rights reserved.
//

import UIKit

class CustomForwardSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let firstVCView = self.sourceViewController.view as UIView!
        let secondVCView = self.destinationViewController.view as UIView!
        
        // Get the screen width and height.
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        // Specify the initial position of the destination view.
        secondVCView.frame = CGRectMake(screenWidth, 0.0, screenWidth, screenHeight)
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        // Animate the transition.
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            firstVCView.frame = CGRectOffset(firstVCView.frame, -screenWidth, 0.0)
            secondVCView.frame = CGRectOffset(secondVCView.frame, -screenWidth, 0.0)
            
            }) { (Finished) -> Void in
                self.sourceViewController.presentViewController(self.destinationViewController ,
                    animated: false,
                    completion: nil)
        }
        
    }


}
