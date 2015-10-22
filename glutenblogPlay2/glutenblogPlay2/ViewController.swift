//
//  ViewController.swift
//  glutenblogPlay2
//
//  Created by Thomas Karg on 10.10.15.
//  Copyright © 2015 Thomas Karg. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import Haneke

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popOverButton: UIButton!
    @IBOutlet weak var maskButton: UIButton!
    @IBOutlet weak var popOverView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var datas: [JSON] = []
    var test = 0
    
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
        
        Alamofire.request(.GET, "http://localhost:8080/glutenblog-web/rest/recipe")
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
                    self.datas = data
                    self.tableView.reloadData()
                }
                
                self.test = self.datas.count
                print("Zeilen1: \(self.test)")
                //self.tableView.reloadData()
                
                
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let test2 = datas.count
        print("Zeilen2: \(test2)")
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("recipeCell") as! RecipeTableViewCell
        
        //comment out if no server is running
        let data = datas[indexPath.row]
        cell.recipeName.text = data["name"].string
        let imgString = data["imgBig"].string!
        print("Image: \(imgString)")
        let urlString = "http:localhost:9000/images/\(imgString)"
        print("URL: \(urlString)")
        let url = NSURL(string: urlString)
        cell.recipeImage.hnk_setImageFromURL(url!)
        let personsInt = data["numberOfServings"].int!
        let persons = "\(personsInt) Pers."
        print("Personen: \(persons)")
        cell.recipeNumber.text = persons
        
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

