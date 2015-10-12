//
//  ViewController.swift
//  glutenblogPlay2
//
//  Created by Thomas Karg on 10.10.15.
//  Copyright © 2015 Thomas Karg. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popOverButton: UIButton!
    @IBOutlet weak var maskButton: UIButton!
    @IBOutlet weak var popOverView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func popOverButtonDidPress(sender: AnyObject) {
        
        popOverView.hidden = false
        let scale = CGAffineTransformMakeScale(0.3, 0.3)
        let translate = CGAffineTransformMakeTranslation(-50, -50 )
        popOverView.transform = CGAffineTransformConcat(scale, translate)
        popOverView.alpha = 0
        
        maskButton.hidden = false
        maskButton.alpha = 0
        spring(0.5) {
            self.maskButton.alpha = 1
        }
        
        spring(0.5) {
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.popOverView.transform = CGAffineTransformConcat(scale, translate)
            self.popOverView.alpha = 1
        }
    }
    
    @IBAction func maskButtonDidPress(sender: AnyObject) {
        spring(0.5) {
            self.maskButton.alpha = 0
            //self.maskButton.hidden = true
        }
        
        spring(0.5) {
            self.popOverView.hidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = 101
        tableView.separatorColor = UIColor(red: 62/255, green: 78/255, blue: 98/255, alpha: 1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("recipeCell") as UITableViewCell!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("detailSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    

}

