//
//  Constants.swift
//  YouTube-Demo
//
//  Created by Richard St. Onge on 2022-01-12.
//

import Foundation

struct Constants {
    //TODO: Need to store API Key onto Keychain and then retrieve for access
    static var api_key = "AIzaSyCvy4YAJeRy4Lb6P5Za7MW7pPrCjxJr_iM"
    static var playlist_id = "PLrd867FX5ja3MOQNA7l1d4Z7HW1btGlEN"
    static var api_url = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.playlist_id)&key=\(Constants.api_key)"
    static var video_cell_id = "VideoCell"
    
}
