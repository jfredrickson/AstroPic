//
//  ImageFinder.swift
//  AstroPic
//
//  Created by Jeff Fredrickson on 3/23/16.
//  Copyright © 2016 Jeff Fredrickson. All rights reserved.
//

import Foundation

class ImageFinder {
    func getImage(mediaMetadata: MediaMetadata, handler: (Image) -> Void ) {
        // TODO:
        // If image is cached
        //      get image from cache
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(mediaMetadata.url) { (data, response, error) in
            if error == nil {
                // TODO: cache the image
                let image = Image(id: mediaMetadata.id, imageData: data!)
                handler(image)
            } else {
                // TODO: handle request error
            }
        }.resume()
    }
}