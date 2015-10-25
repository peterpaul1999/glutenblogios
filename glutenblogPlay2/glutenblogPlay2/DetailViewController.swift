//
//  DetailViewController.swift
//  glutenblogPlay2
//
//  Created by Thomas Karg on 13.10.15.
//  Copyright © 2015 Thomas Karg. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    var darkBlue = UIColor(red: 57/255, green: 111/255, blue: 175/255, alpha: 1)
    var lightBlue = UIColor(red: 145/255, green: 184/255, blue: 231/255, alpha: 1)
    var middleBlue = UIColor(red: 74/255, green: 143/255, blue: 226/255, alpha: 1)
    
    var data = getData()
    var number = 1
    
    var recipe: JSON!
    var recipeIngredients: [JSON] = []
    

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
    @IBOutlet weak var popUpImage: UIImageView!
    @IBOutlet weak var popImageBlurView: UIView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeNumber: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredientsSubView: UIView!
    
    
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    
    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravityBehaviour : UIGravityBehavior!
    var snapBehavior : UISnapBehavior!
    
    @IBAction func handleGesture(sender: AnyObject) {
        let myView = imagePopOverView
        let location = sender.locationInView(view)
        let boxLocation = sender.locationInView(imagePopOverView)
        
        if sender.state == UIGestureRecognizerState.Began {
            if snapBehavior != nil {
                animator.removeBehavior(snapBehavior)
            }
            
            let centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(myView.bounds), boxLocation.y - CGRectGetMidY(myView.bounds));
            attachmentBehavior = UIAttachmentBehavior(item: myView, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            
            animator.addBehavior(attachmentBehavior)
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            attachmentBehavior.anchorPoint = location
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            animator.removeBehavior(attachmentBehavior)
            
            snapBehavior = UISnapBehavior(item: myView, snapToPoint: view.center)
            animator.addBehavior(snapBehavior)
            
            let translation = sender.translationInView(view)
            if (translation.y > 100 || translation.y < -100) {
                animator.removeAllBehaviors()
                
                let gravity = UIGravityBehavior(items: [imagePopOverView])
                gravity.gravityDirection = CGVectorMake(0, 10)
                animator.addBehavior(gravity)
                
                if translation.y > 100 { number++ } else {number--}
                
                self.refreshView()
            }
        }
    }
    
    func refreshView() {
        if number > 5 {
            number = 1
        }
        
        if number < 1 {
            number = 5
        }
        
        animator.removeAllBehaviors()
        
        snapBehavior = UISnapBehavior(item: imagePopOverView, snapToPoint: view.center)
        attachmentBehavior.anchorPoint = view.center
        
        imagePopOverView.center = view.center
        
        
        
        viewDidAppear(true)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(Bool())

            let scale = CGAffineTransformMakeScale(0.5, 0.5)
            let translate = CGAffineTransformMakeTranslation(0, -200)
            imagePopOverView.transform = CGAffineTransformConcat(scale, translate)
            
            spring(0.5) {
                let scale = CGAffineTransformMakeScale(1, 1)
                let translate = CGAffineTransformMakeTranslation(0, 0)
                self.imagePopOverView.transform = CGAffineTransformConcat(scale, translate)
            }
        
            //popUpImage.image = UIImage(named: data[number]["image"]!)
            let restString = "imgBig\(number)"
            let imgString = recipe[restString].string!
            let urlString = "http://localhost:8080/glutenblog-web/resources/images/\(imgString)"
            print("URL: \(urlString)")
            let url = NSURL(string: urlString)
            popUpImage.hnk_setImageFromURL(url!)
            imageLabel.text = "Bild \(number) von 5"
            imagePopOverView.alpha = 1
    }
    
    
    @IBAction func recipeButtonDidPress(sender: AnyObject) {
        preperationButton.hidden = false
        recipeButton.hidden = true
        ingredientsButton.hidden = false
        preperationView.backgroundColor = lightBlue
        recipeView.backgroundColor = darkBlue
        ingredientsView.backgroundColor = middleBlue
        descriptionView.hidden = false
        preperationTextView.hidden = true
        ingredientsSubView.hidden = true
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
        ingredientsSubView.hidden = true
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
        ingredientsSubView.hidden = false
    }
    @IBAction func imagesButtonDidPress(sender: AnyObject) {
        number = 1
        //popUpImage.image = UIImage(named: data[number]["image"]!)
        let restString = "imgBig\(number)"
        let imgString = recipe[restString].string!
        let urlString = "http://localhost:8080/glutenblog-web/resources/images/\(imgString)"
        print("URL: \(urlString)")
        let url = NSURL(string: urlString)
        popUpImage.hnk_setImageFromURL(url!)
        
        
        imageLabel.text = "Bild \(number) von 5"
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
            //self.maskView.hidden = true
        }
        
        spring(0.5) {
            self.imagePopOverView.hidden = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        insertBlurView(popImageBlurView, style: UIBlurEffectStyle.Light)
        animator = UIDynamicAnimator(referenceView: view)
        
        recipeName.text = recipe["name"].string
        
        let personsInt = recipe["numberOfServings"].int!
        let persons = "\(personsInt) Pers."
        print("Personen: \(persons)")
        recipeNumber.text = persons
        
        descriptionView.text = recipe["description"].string
        preperationTextView.text = recipe["preperation"].string
        
        let imgString = recipe["imgBig"].string!
        let urlString = "http://localhost:8080/glutenblog-web/resources/images/\(imgString)"
        print("URL: \(urlString)")
        let url = NSURL(string: urlString)
        recipeImage.hnk_setImageFromURL(url!)
        
        createIngredients()
        
    }
    
    func createIngredients() {
        let recipeId = recipe["id"].int!
        let requestString = "http://localhost:8080/glutenblog-web/rest/recipeingredients/recipe/\(recipeId)"
        Alamofire.request(.GET, requestString)
            .responseJSON { response in
                print("REQUEST")
                print(response.request)  // original URL request
                print("RESPONSE")
                print(response.response) // URL response
                print("DATA")
                print(response.data)     // server data
                print("RESULT")
                print(response.result)   // result of response serialization
                
                let jsonData = JSON(response.result.value!)
                
                if let data = jsonData.arrayValue as [JSON]?{
                    self.recipeIngredients = data
                }
                
                print("Ingredients: \(self.recipeIngredients.count)")
                var y : CGFloat = 15
                for ingredient in self.recipeIngredients {
                    print(ingredient["ingredient"]["name"].string!)
                    let label = UILabel(frame: CGRectMake(0, 0, 300, 20))
                    label.center = CGPointMake(155, y)
                    label.textAlignment = NSTextAlignment.Left
                    let ingredientText = "\(ingredient["number"].double!) \(ingredient["unit"]["name"].string!) \(ingredient["ingredient"]["name"].string!)"
                    label.text = ingredientText
                    label.font = UIFont(name: "AvenirNext-Regular", size: 14)
                    label.textColor = UIColor(red: 62/255, green: 78/255, blue: 98/255, alpha: 1)
                    self.ingredientsSubView.addSubview(label)
                    y=y+50
                }
                
        }
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
