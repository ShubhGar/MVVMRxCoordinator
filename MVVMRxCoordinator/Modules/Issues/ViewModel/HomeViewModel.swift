//
//  HomeViewModel.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import Foundation
import RxSwift


typealias IssueViewModels = [IssueViewModel]
class HomeViewModel {
    
    
    public let issues : PublishSubject<IssueViewModels>
    public let loading: PublishSubject<Bool>
    public let error : PublishSubject<DataError>
    let selectIssue: AnyObserver<IssueViewModel>
    let showCommentList: Observable<String>
    
    private let disposable = DisposeBag()
    
    init(){
        issues = PublishSubject()
        loading = PublishSubject()
        error = PublishSubject()
        let _selectIssue = PublishSubject<IssueViewModel>()
        self.selectIssue = _selectIssue.asObserver()
        self.showCommentList = _selectIssue.asObservable().compactMap { $0.commentURL }
    }
    
    
    public func requestData(){
        self.loading.onNext(true)
        let issues = fetchDataFromDB()
        let currentTimestamp = Date().timeIntervalSinceReferenceDate
        guard issues.count > 0 && (currentTimestamp - issues.first!.savedTime) < (API_FETCH_TIME) else {
            self.fetchDataFromServer()
            return
        }
        self.loading.onNext(false)
        let issueList:IssueViewModels = issues.map{
            return IssueViewModel(issue: $0)
        }.sorted{ $0.updateTimeStamp < $1.updateTimeStamp}
        self.issues.onNext(issueList)
        
    }
    
    private func fetchDataFromServer(){
        APIManager.requestData(url: ISSUE_LIST, method: .get, parameters: nil, completion: { (result) in
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                let issues:IssueViewModels = returnJson.arrayValue.compactMap {
                    if let jsonData = try? $0.rawData(options: .prettyPrinted), let issue =  Issue(data: jsonData){
                        return IssueViewModel(issue: issue)
                    }
                    return nil
                }.sorted{ $0.updateTimeStamp < $1.updateTimeStamp}
                self.issues.onNext(issues)
                self.saveDataToDB(issues: issues)
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
    
    
    private func fetchDataFromDB()-> [CDIssue]{
        return IssueCoreDataManager.getIssue()
        
    }
    
    private func saveDataToDB(issues: IssueViewModels){
        IssueCoreDataManager.save(issues: issues)
    }
}

