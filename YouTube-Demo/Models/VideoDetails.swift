//
//  VideoDetails.swift
//  YouTube-Demo
//
//  Created by Richard St. Onge on 2022-01-12.
//

import Foundation

struct Video: Decodable {
    
    var videoID = ""
    var title = ""
    var description = ""
    var published = Date()
    var thumbnail = ""
    
    enum CodingKeys: String, CodingKey { // CodingKey Protocol allows us to pass the enum type to the nestedContainer function as a "key"
        
        case snippet // start of JSON search block
        case thumbnails
        case high
        case resourceId
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoID = "videoId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        // Parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parse publish date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // Parse the thumbnail info and links
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails) // Looking inside snippet Container
        let highThumbnailContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high) // Looking inside thumbnail Container
        self.thumbnail = try highThumbnailContainer.decode(String.self, forKey: .thumbnail)
        
        // Parse the Video ID
        let resourceIDContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId) // Looking inside snippet Container
        self.videoID = try resourceIDContainer.decode(String.self, forKey: .videoID)                                   // for the videoID
    }
}
