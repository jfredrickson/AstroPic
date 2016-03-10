//
//  ViewController.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/7/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load image from repository
        let repo = MediaRepository()
        let item = repo.getDailyMedia()
        let hdImageData = NSData(contentsOfURL: item.hdUrl)!
        let image = UIImage(data: hdImageData)!
        
        // Display image in view
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
        
        // Set up scrolling
        scrollView.addSubview(imageView)
        scrollView.contentSize = image.size
        
        // Recognize double tap to zoom and assign a callback method
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        // Set zoom scale
        let scaleWidth = scrollView.frame.width / scrollView.contentSize.width
        let scaleHeight = scrollView.frame.height / scrollView.contentSize.width
        let smallerDimension = min(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = smallerDimension
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = smallerDimension
        
        centerImage()
    }
    
    // Center the image view within the scroll view
    func centerImage() {
        if imageView.frame.width < scrollView.bounds.width {
            imageView.frame.origin.x = (scrollView.bounds.width - imageView.frame.width) / 2
        } else {
            imageView.frame.origin.x = 0
        }
        if imageView.frame.height < scrollView.bounds.height {
            imageView.frame.origin.y = (scrollView.bounds.height - imageView.frame.height) / 2
        } else {
            imageView.frame.origin.y = 0
        }
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // Magnify by 50%
        var updatedZoomScale = scrollView.zoomScale * 1.5
        
        // ... but constrain to the maximum zoom scale
        updatedZoomScale = min(updatedZoomScale, scrollView.maximumZoomScale)
        
        // Width and height of the updated area to display
        let width = scrollView.bounds.width / updatedZoomScale
        let height = scrollView.bounds.height / updatedZoomScale
        
        // Determine where the image was tapped and use that as a center
        let tapLocation = recognizer.locationInView(imageView)
        let x = tapLocation.x - (width / 2)
        let y = tapLocation.y - (width / 2)
        let zoomArea = CGRectMake(x, y, width, height)
        
        // Zoom
        scrollView.zoomToRect(zoomArea, animated: true)
    }
    
    // Scale the image view when zooming (implemented for UIScrollViewDelegate)
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // Center the image after zooming (implemented for UIScrollViewDelegate)
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerImage()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        centerImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

