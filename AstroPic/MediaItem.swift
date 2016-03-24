//
//  MediaItem.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/7/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import UIKit

class MediaItem {
    var id: String
    var title: String?
    var explanation: String?
    var thumbnailImage: UIImage?
    var url: NSURL?
    var hdUrl: NSURL?
    var date: NSDate
    var localizedDate: String {
        return NSDateFormatter.localizedStringFromDate(self.date, dateStyle: .LongStyle, timeStyle: .NoStyle)
    }
    var text: String {
        if let title = self.title {
            return "\(self.localizedDate): \(title)"
        } else {
            return self.localizedDate
        }
    }
    
    init(date: NSDate) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        self.id = formatter.stringFromDate(date)
        self.date = date
        self.thumbnailImage = UIImage(named: "placeholder")
    }
}