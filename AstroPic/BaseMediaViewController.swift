//
//  BaseMediaViewController.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/16/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import UIKit

class BaseMediaViewController: UIViewController {
    
    var mediaItem: MediaItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

