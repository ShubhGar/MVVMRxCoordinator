//
//  IssueViewModel.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import Foundation


class IssueViewModel {
    let title: String
    let body: String
    let commentsCount: Int
    var commentURL: String
    let updateTimeStamp:Double
    
    init(issue: Issue) {
        self.title = issue.title
        self.body = issue.body.count >= 140 ? String(Array(issue.body)[0 ..< 140]) + "..." : issue.body
        self.commentsCount = issue.commentsCount
        self.commentURL = issue.comments
        let formatter = DateFormatter()
        formatter.dateFormat = DATE_FORMAT
        let date = formatter.date(from: issue.updated_at)
        updateTimeStamp = date?.timeIntervalSinceReferenceDate ?? 0
    }
    
    init(issue: CDIssue) {
        self.title = issue.title ?? ""
        if let body = issue.body{
            self.body = body.count >= 140 ? String(Array(body)[0 ..< 140]) + "..." : body
        }
        else{
            self.body = ""
        }
        self.commentsCount = Int(issue.commentsCount)
        self.commentURL = issue.comments ?? ""
        updateTimeStamp = issue.updated_at
    }
}
