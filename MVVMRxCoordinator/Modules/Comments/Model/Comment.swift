//
//  Comment.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import Foundation


struct Comment: Codable {
    let id: Double
    let updated_at, body: String
    let user:User
}


struct User: Codable {
    let id: Double
    let name : String
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case id
    }
}


// MARK: Convenience initializers

extension Comment {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Comment.self, from: data) else{
            return nil
        }
        self = me
    }
}

