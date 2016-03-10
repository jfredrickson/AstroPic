//
//  MediaItem.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/7/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import Foundation

class MediaItem : NSObject {
    var date : NSDate = NSDate()
    var explanation : String = ""
    var hdUrl : NSURL = NSURL()
    var mediaType : String = ""
    var title : String = ""
    var sdUrl : NSURL = NSURL()
}