//
//  CommentsCoreDataManager.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//
import Foundation


class CommentsCoreDataManager{
    static let CDCommentEntity = String(describing:CDComment.self)
    class func save(comments:CommentViewModels){
        CoreDataStack.clearAllData(entityName: CDCommentEntity)
        for comment in comments{
            let cdComment:CDComment = CoreDataStack.getObjectFor(entityName: CDCommentEntity) as! CDComment
            cdComment.body = comment.body
            cdComment.name = comment.userName
            cdComment.url = comment.url
            cdComment.savedTime = Date().timeIntervalSinceReferenceDate
            cdComment.updated_at = comment.updateTimeStamp
        }
        CoreDataStack.saveContext()
    }
    
    class func getCommentsFor(url:String)->[CDComment]{
        let predicate = NSPredicate(format: "url = %@", url)
        return CoreDataStack.loadData(entityName: CDCommentEntity, predicate: predicate)
    }
}
