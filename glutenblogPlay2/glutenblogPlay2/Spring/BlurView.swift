//
//  BlurView.swift
//  ShotsDemo
//
//  Created by Meng To on 2014-07-04.
//  Copyright (c) 2014 Meng To. All rights reserved.
//

import UIKit

func insertBlurView (view: UIView, style: UIBlurEffectStyle) {
    view.backgroundColor = UIColor.clearColor()
    
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    print(view.bounds.height)
    print(view.bounds.width)
    print(view.tag)
    blurEffectView.frame = view.bounds
    view.insertSubview(blurEffectView, atIndex: 0)
}