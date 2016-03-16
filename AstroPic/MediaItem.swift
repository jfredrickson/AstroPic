//
//  MediaItem.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/7/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import Foundation

class MediaItem {
    var date: NSDate
    var title: String
    var explanation: String
    var mediaType: String
    var url: NSURL
    var hdUrl: NSURL
    
    init(date: NSDate, title: String, explanation: String, mediaType: String, url: NSURL, hdUrl: NSURL) {
        self.date = date
        self.title = title
        self.explanation = explanation
        self.mediaType = mediaType
        self.url = url
        self.hdUrl = hdUrl
    }
    
    convenience init() {
        self.init(date: NSDate(), title: "", explanation: "", mediaType: "UnknownMedia", url: NSURL(), hdUrl: NSURL())
    }
}