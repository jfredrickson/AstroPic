//
//  IndexViewController.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/22/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mediaItems: [MediaItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstTenDates = getPreviousDates(NSDate(), numberOfDates: 10)
        for date in firstTenDates {
            let mediaItem = MediaItem(date: date)
            mediaItems.append(mediaItem)
            MediaRepository().requestMediaMetadata(date, handler: mediaMetadataLoaded)
        }
    }
    
    func mediaMetadataLoaded(mediaMetadata: MediaMetadata) {
        let mediaItemIndex = mediaItems.indexOf { (mediaItem) in
            mediaItem.id == mediaMetadata.id
        }
        if let index = mediaItemIndex {
            let mediaItem = mediaItems[index]
            mediaItem.title = mediaMetadata.title
            mediaItem.explanation = mediaMetadata.explanation
            mediaItem.url = mediaMetadata.url
            mediaItem.hdUrl = mediaMetadata.hdUrl
        }
        if (mediaMetadata.mediaType == "image") {
            ImageFinder().getImage(mediaMetadata, handler: imageLoaded)
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
    }
    
    func imageLoaded(image: Image) {
        let mediaItemIndex = mediaItems.indexOf { (mediaItem) in
            mediaItem.id == image.id
        }
        if let index = mediaItemIndex {
            mediaItems[index].thumbnailImage = UIImage(data: image.imageData)
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func getPreviousDates(startingWithDate: NSDate, numberOfDates: Int) -> [NSDate] {
        let calendar = NSCalendar.currentCalendar()
        var dates: [NSDate] = []
        for i in (0...(numberOfDates - 1)) {
            if let date = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: (0 - i), toDate: startingWithDate, options: NSCalendarOptions()) {
                dates.append(date)
            }
        }
        return dates
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count;
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MediaCell", forIndexPath: indexPath) as! MediaCell
        cell.label.text = mediaItems[indexPath.row].text
        cell.imageView.image = mediaItems[indexPath.row].thumbnailImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let wideScreen = view.bounds.width > 420
        let width = wideScreen ? (view.bounds.width / 2) : view.bounds.width
        let height = width * 0.6
        return CGSize(width: width, height: height)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let destinationViewController = segue.destinationViewController.childViewControllers.filter { (viewController) in
//            return viewController.isKindOfClass(BaseMediaViewController)
//        }.first as! BaseMediaViewController
        let destinationViewController = segue.destinationViewController as! BaseMediaViewController
        if (segue.identifier == "showImage") {
            if let indexPaths = collectionView.indexPathsForSelectedItems() {
                if let indexPath = indexPaths.first {
                    let mediaItem = mediaItems[indexPath.row]
                    destinationViewController.mediaItem = mediaItem
                }
            }
        }
    }
}
