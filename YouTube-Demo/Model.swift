//
//  Model.swift
//  YouTube-Demo
//
//  Created by Richard St. Onge on 2022-01-12.
//

import Foundation

protocol ModelDelegate {
    
    func videosFetched(_ videos:[Video])
}

class Model {
    var delegate: ModelDelegate?
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
            
            /* [from https://stackoverflow.com/questions/32997955/error-call-can-throw-but-is-not-marked-with-try-and-the-error-is-not-handled?rq=1]
             Use the try! keyword to have the program trap if an error is thrown, this is only appropriate if you know for a fact the function will never throw given the current circumstances - similar to using ! to force unwrap an optional (seems unlikely given the method name)
             */
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(Response.self, from: data!)
                // try decoder.decode(Response.self, from: data ?? Data())
                if response.items != nil {
                    // Call the videosFetched method of the delegate in main thread using DispatchQueue
                    DispatchQueue.main.async { // will cause a crash otherwise since the interface is not updated through the main thread.
                        self.delegate?.videosFetched(response.items!)
                    }
                    
                }
                dump(response)
            } catch {
                print("There is an error: \(error.localizedDescription)")
            }
        }
        // Start the data task
        datatask.resume()
    }
}
