//
//  ViewController.swift
//  glutenblogPlay2
//
//  Created by Thomas Karg on 10.10.15.
//  Copyright © 2015 Thomas Karg. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
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
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("recipeCell") as UITableViewCell!
        
        return cell
    }

}

