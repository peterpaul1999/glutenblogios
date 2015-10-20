//
//  RecipeTableViewCell.swift
//  glutenblogPlay2
//
//  Created by Thomas Karg on 20.10.15.
//  Copyright © 2015 Thomas Karg. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeCategories: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
