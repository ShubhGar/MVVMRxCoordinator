//
//  CommentsViewController.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import UIKit
import RxSwift
class CommentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel :CommentsViewModel?
    public var comments = PublishSubject<[CommentViewModel]>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.setupBinding()
        viewModel?.requestData()
    }
    
    
    
    private func setupBinding(){
        viewModel?.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
      
        viewModel?
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .error)
                case .serverMessage(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .warning)
                }
            })
            .disposed(by: disposeBag)
  
        viewModel?
            .comments
            .observeOn(MainScheduler.instance)
            .bind(to: self.comments)
            .disposed(by: disposeBag)
        
        
        tableView.register(UINib(nibName: CommentTableViewCell.viewIdentifier, bundle: nil), forCellReuseIdentifier: String(describing: CommentTableViewCell.self))
        comments.bind(to: tableView.rx.items(cellIdentifier: CommentTableViewCell.viewIdentifier, cellType: CommentTableViewCell.self)) {  (row,comment,cell) in
            self.setupIssueCell(cell, comment: comment)
        }.disposed(by: disposeBag)

    }
    
    private func setupIssueCell(_ cell: CommentTableViewCell, comment: CommentViewModel) {
        cell.selectionStyle = .none
        cell.setUser(name: comment.userName)
        cell.setComment(body : comment.body)
    }
    
    
}
