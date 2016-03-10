//
//  MediaRepository.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/7/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import Foundation

class MediaRepository : NSObject {
    let baseUrlPath = "https://api.nasa.gov/planetary/apod"
    var apiKey : String = ""
    
    override init() {
        super.init()
        let filePath = NSBundle.mainBundle().pathForResource("PrivateConfiguration", ofType:"plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        apiKey = plist?.objectForKey("API_KEY") as! String
    }
    
    func getDailyMedia() -> MediaItem {
        let url = NSURL(string: baseUrlPath + "?api_key=" + apiKey)
        let data = NSData(contentsOfURL: url!)
        let mediaItem = MediaItem()
        let receivedData = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
        if let data = receivedData as? NSDictionary {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            mediaItem.date = dateFormatter.dateFromString(data.valueForKey("date") as! String)!
            mediaItem.explanation = data.valueForKey("explanation") as! String!
            mediaItem.hdUrl = NSURL(string: data.valueForKey("hdurl") as! String)!
            mediaItem.sdUrl = NSURL(string: data.valueForKey("url") as! String)!
            mediaItem.mediaType = data.valueForKey("media_type") as! String
            mediaItem.title = data.valueForKey("title") as! String
        }
        return mediaItem
    }
}