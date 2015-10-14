//
//  DetailViewController.swift
//  glutenblogPlay2
//
//  Created by Thomas Karg on 13.10.15.
//  Copyright © 2015 Thomas Karg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var darkBlue = UIColor(red: 57/255, green: 111/255, blue: 175/255, alpha: 1)
    var lightBlue = UIColor(red: 145/255, green: 184/255, blue: 231/255, alpha: 1)
    var middleBlue = UIColor(red: 74/255, green: 143/255, blue: 226/255, alpha: 1)
    

    @IBOutlet weak var recipeButton: UIButton!
    @IBOutlet weak var recipeView: UIView!
    
    
    @IBOutlet weak var preperationButton: UIButton!
    @IBOutlet weak var preperationView: UIView!
    
    @IBOutlet weak var ingredientsButton: UIButton!
    @IBOutlet weak var ingredientsView: UIView!
    
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var preperationTextView: UITextView!
    
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var imagePopOverView: UIView!
    @IBOutlet weak var maskButton: UIButton!
    
    
    
    @IBAction func recipeButtonDidPress(sender: AnyObject) {
        preperationButton.hidden = false
        recipeButton.hidden = true
        ingredientsButton.hidden = false
        preperationView.backgroundColor = lightBlue
        recipeView.backgroundColor = darkBlue
        ingredientsView.backgroundColor = middleBlue
        descriptionView.hidden = false
        preperationTextView.hidden = true
        ingredientsTextView.hidden = true
    }
    @IBAction func preperationButtonDidPress(sender: AnyObject) {
        preperationButton.hidden = true
        recipeButton.hidden = false
        ingredientsButton.hidden = false
        preperationView.backgroundColor = darkBlue
        recipeView.backgroundColor = lightBlue
        ingredientsView.backgroundColor = middleBlue
        descriptionView.hidden = true
        preperationTextView.hidden = false
        ingredientsTextView.hidden = true
    }
    @IBAction func ingredientsButtonDidPress(sender: AnyObject) {
        preperationButton.hidden = false
        recipeButton.hidden = false
        ingredientsButton.hidden = true
        preperationView.backgroundColor = middleBlue
        recipeView.backgroundColor = lightBlue
        ingredientsView.backgroundColor = darkBlue
        descriptionView.hidden = true
        preperationTextView.hidden = true
        ingredientsTextView.hidden = false
    }
    @IBAction func imagesButtonDidPress(sender: AnyObject) {
        imagePopOverView.hidden = false
        
        let scale = CGAffineTransformMakeScale(0.3, 0.3)
        let translate = CGAffineTransformMakeTranslation(50, -50 )
        imagePopOverView.transform = CGAffineTransformConcat(scale, translate)
        imagePopOverView.alpha = 0
        
        maskButton.hidden = false
        maskButton.alpha = 0
        spring(0.5) {
            self.maskButton.alpha = 1
        }
        
        spring(0.5) {
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.imagePopOverView.transform = CGAffineTransformConcat(scale, translate)
            self.imagePopOverView.alpha = 1
        }
    }
    
    @IBAction func closePopButtonDidPress(sender: AnyObject) {
        
        spring(0.5) {
            self.maskButton.alpha = 0
            //self.maskButton.hidden = true
        }
        
        spring(0.5) {
            self.imagePopOverView.hidden = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
