//
//  MediaRepository.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/7/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import Foundation

class MediaRepository {
    let baseUrlPath = "https://api.nasa.gov/planetary/apod"
    var apiKey: String
    
    init() {
        let filePath = NSBundle.mainBundle().pathForResource("PrivateConfiguration", ofType:"plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        apiKey = plist?.objectForKey("API_KEY") as! String
    }
    
    func requestMediaMetadata(date: NSDate, handler: (MediaMetadata) -> Void) {
        let dateString = formatDate(date)
        let url = NSURL(string: "\(baseUrlPath)?date=\(dateString)&api_key=\(apiKey)")!
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url) { (data, response, error) in
            if error == nil {
                let mediaMetadata = self.jsonToMediaMetadata(data!)
                handler(mediaMetadata)
            } else {
                handler(MediaMetadata())
            }
        }.resume()
    }
    
    func formatDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.stringFromDate(date)
    }
    
    func jsonToMediaMetadata(jsonData: NSData) -> MediaMetadata {
        let mediaMetadata = MediaMetadata()
        let receivedData = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
        if let data = receivedData as? NSDictionary {
            if let date = data.valueForKey("date") as? String {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if let dateObj = dateFormatter.dateFromString(date) {
                    mediaMetadata.date = dateObj
                }
            }
            if let title = data.valueForKey("title") as? String {
                mediaMetadata.title = title
            }
            if let explanation = data.valueForKey("explanation") as? String {
                mediaMetadata.explanation = explanation
            }
            if let mediaType = data.valueForKey("media_type") as? String {
                mediaMetadata.mediaType = mediaType
            }
            if let url = data.valueForKey("url") as? String {
                mediaMetadata.url = NSURL(string: url)!
            }
            if let hdUrl = data.valueForKey("hdurl") as? String {
                mediaMetadata.hdUrl = NSURL(string: hdUrl)!
            }
        }
        return mediaMetadata
    }
}