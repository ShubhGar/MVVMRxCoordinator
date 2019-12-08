//
//  CommentViewModel.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import Foundation


class CommentViewModel {
    let userName: String
    let body: String
    let updateTimeStamp:Double
    let url:String
    
    init(comment: Comment, url:String) {
        self.body = comment.body
        self.userName = comment.user.name
        let formatter = DateFormatter()
        formatter.dateFormat = DATE_FORMAT
        let date = formatter.date(from: comment.updated_at)
        updateTimeStamp = date?.timeIntervalSinceReferenceDate ?? 0
        self.url = url
    }
    
    init(comment: CDComment) {
        self.body = comment.body ?? ""
        self.userName = comment.name ?? ""
        updateTimeStamp = comment.updated_at
        url = comment.url ?? ""
    }
}
