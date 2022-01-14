//
//  Model.swift
//  YouTube-Demo
//
//  Created by Richard St. Onge on 2022-01-12.
//

import Foundation

class Model {
    
    func getVideos() {
        // Create URL object
        guard let url = URL(string: Constants.api_url) else {
            return
        }
        // Get a URL Session Object
        let session = URLSession.shared
        
        // Get a data task from the URL Session Object
        let datatask = session.dataTask(with: url) { (data, response, error) in
            //Check if there were any errors
            if error != nil || data == nil {
                return
            }
            // Parsing the data into video objects
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            decoder.decode(Response.self, from: try data)
        }
        // Start the data task
        datatask.resume()
    }
}
