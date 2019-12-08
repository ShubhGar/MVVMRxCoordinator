//
//  CommentsViewModel.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import Foundation
import RxSwift


typealias CommentViewModels = [CommentViewModel]
class CommentsViewModel{
    var commentURL:String?
    public let comments : PublishSubject<CommentViewModels>
    public let loading: PublishSubject<Bool>
    public let error : PublishSubject<DataError>
    
    init(url : String) {
        commentURL = url
        comments = PublishSubject()
        loading = PublishSubject()
        error = PublishSubject()
    }
    
    public func requestData(){
        
        self.loading.onNext(true)
        self.loading.onNext(true)
        let comments = fetchDataFromDB()
        let currentTimestamp = Date().timeIntervalSinceReferenceDate
        guard comments.count > 0 && (currentTimestamp - comments.first!.savedTime) < (API_FETCH_TIME) else {
            self.fetchDataFromServer()
            return
        }
        self.loading.onNext(false)
        let commentList:CommentViewModels = comments.map{
            return CommentViewModel(comment: $0)
        }.sorted{ $0.updateTimeStamp < $1.updateTimeStamp}
        self.comments.onNext(commentList)
        
    }
    
    private func fetchDataFromServer(){
        APIManager.requestData(url: commentURL ?? "", method: .get, parameters: nil, completion: { (result) in
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                let comments:CommentViewModels = returnJson.arrayValue.compactMap {
                    if let jsonData = try? $0.rawData(options: .prettyPrinted), let comment =  Comment(data: jsonData){
                        return CommentViewModel(comment: comment, url: self.commentURL ?? "")
                    }
                    return nil
                }.sorted{ $0.updateTimeStamp < $1.updateTimeStamp}
                self.comments.onNext(comments)
                self.saveDataToDB(comments: comments)
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext(.internetError(INTERNET_ERROR))
                case .authorizationError(let errorJson):
                    self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                default:
                    self.error.onNext(.serverMessage(UNKNOWN_ERROR))
                }
            }
        })
    }
    
    
    private func fetchDataFromDB()-> [CDComment]{
        CommentsCoreDataManager.getCommentsFor(url: self.commentURL ?? "")
    }
    
    private func saveDataToDB(comments: CommentViewModels){
        CommentsCoreDataManager.save(comments: comments)
    }
}
