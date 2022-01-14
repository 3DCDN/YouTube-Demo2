//
//  Response.swift
//  YouTube-Demo
//
//  Created by Richard St. Onge on 2022-01-13.
//

import Foundation

class Response: Decodable {
    
    var items: [Video]?
    
    enum CodingKeys: String, CodingKey {
        case items // no need for = since it matches var declaration
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([Video].self, forKey: .items)
    }
}
