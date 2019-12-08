//
//  IssuesTableViewController.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import UIKit
import RxSwift


class IssuesTableViewController: UIViewController,StoryboardInitializable {
    
    
    @IBOutlet private weak var issuesTableView: UITableView!
    
    public var issues = PublishSubject<[IssueViewModel]>()
    
    private let disposeBag = DisposeBag()
    var selectIssue: AnyObserver<IssueViewModel>?
    var issueSelected: Observable<IssueViewModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        issuesTableView.backgroundColor = .clear
        issuesTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setupBinding(){
        
        issuesTableView.register(UINib(nibName: IssueTableViewCell.viewIdentifier, bundle: nil), forCellReuseIdentifier: String(describing: IssueTableViewCell.self))
        issues.bind(to: issuesTableView.rx.items(cellIdentifier: IssueTableViewCell.viewIdentifier, cellType: IssueTableViewCell.self)) {  (row,issue,cell) in
            self.setupIssueCell(cell, issue: issue)
        }.disposed(by: disposeBag)
        
        if let selectIssue = self.selectIssue{
            issuesTableView.rx.modelSelected(IssueViewModel.self)
                .bind(to: selectIssue)
                .disposed(by: disposeBag)
        }
        
    }
    
    private func setupIssueCell(_ cell: IssueTableViewCell, issue: IssueViewModel) {
        cell.selectionStyle = .none
        cell.setIssue(title: issue.title)
        cell.setIssue(body : issue.body)
    }
    
}
