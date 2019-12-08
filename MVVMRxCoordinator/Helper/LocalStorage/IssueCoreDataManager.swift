//
//  IssueCoreDataManager.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import Foundation


class IssueCoreDataManager{
    
    
    class func save(issues:IssueViewModels){
        for issue in issues{
            let cdIssue:CDIssue = CoreDataStack.getObjectFor(entityName: String(describing:CDIssue.self)) as! CDIssue
            cdIssue.body = issue.body
            cdIssue.comments = issue.commentURL
            cdIssue.commentsCount = Int16(issue.commentsCount)
            cdIssue.title = issue.title
            cdIssue.savedTime = Date().timeIntervalSinceReferenceDate
            cdIssue.updated_at = issue.updateTimeStamp
        }
        CoreDataStack.saveContext()
    }
    
    class func getIssue()->[CDIssue]{
        return CoreDataStack.loadData(entityName: String(describing:CDIssue.self), predicate: nil)
    }
    
    
    
}
