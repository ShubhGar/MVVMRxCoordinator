//
//  IssueCoreDataManager.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import Foundation


class IssueCoreDataManager{
    static let CDIssueEntity = String(describing:CDIssue.self)
    
    class func save(issues:IssueViewModels){
        CoreDataStack.clearAllData(entityName: CDIssueEntity)
        for issue in issues{
            let cdIssue:CDIssue = CoreDataStack.getObjectFor(entityName: CDIssueEntity) as! CDIssue
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
        return CoreDataStack.loadData(entityName: CDIssueEntity, predicate: nil)
    }
    
    
    
}
