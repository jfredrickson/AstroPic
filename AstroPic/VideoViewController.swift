//
//  VideoViewController.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/16/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import UIKit

class VideoViewController: BaseMediaViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(URL: mediaItem.sdUrl)
        webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

