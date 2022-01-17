//
//  ImageCacheManager.swift
//  YouTube-Demo
//
//  Created by Richard St. Onge on 2022-01-17.
//

import Foundation

class CacheManager {
    
    static var cache:[String:Data] = [:] // assign empty dictionary literal
    
    static func setVideoCache(url: String, data: Data?) {
        // Store the image data and use the url as the key
        cache[url] = data
    }
    
    static func getVideoCache(url: String) -> Data? {
        
        // Attempt to get the data for the specified url which is keyed
        return cache[url]
    }
    
}
