//
//  Issue.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import Foundation


struct Issue: Codable {
    
    let id, title, comments, updated_at, body: String, commentsCount:Int
    
    enum CodingKeys: String, CodingKey {
        case id = "node_id"
        case title, body, updated_at
        case comments = "comments_url"
        case commentsCount = "comments"
    }
}



// MARK: Convenience initializers

extension Issue {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Issue.self, from: data) else { return nil }
        self = me
    }
}


typealias Issues = [Issue]
