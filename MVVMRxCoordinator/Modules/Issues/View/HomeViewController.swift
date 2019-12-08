//
//  HomeViewController.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import UIKit
import RxSwift
 

class HomeViewController: UIViewController,StoryboardInitializable {
    
    
    @IBOutlet weak var issuesVCView: UIView!
    
    private lazy var issuesViewController: IssuesTableViewController = {
        var viewController = IssuesTableViewController.initFromStoryboard()
        let _selectIssue = PublishSubject<IssueViewModel>()
        viewController.selectIssue = _selectIssue.asObserver()
        viewController.issueSelected = _selectIssue.asObservable()
        viewController.issueSelected?.subscribe(onNext: { [weak self] in
            if $0.commentsCount < 1{
                MessageView.sharedInstance.showOnView(message: NO_COMMENTS, theme: .error)
            }
            else{
                self?.homeViewModel?.selectIssue.onNext($0)
            }
        }).disposed(by: disposeBag)
        self.add(asChildViewController: viewController, to: issuesVCView)
        return viewController
    }()
    
    var homeViewModel: HomeViewModel?
    
    let disposeBag = DisposeBag()
    
    // MARK: - View's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        homeViewModel?.requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    // MARK: - Bindings
    private func setupBindings() {

        homeViewModel?.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)

        homeViewModel?
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
        
        homeViewModel?
            .issues
            .observeOn(MainScheduler.instance)
            .bind(to: issuesViewController.issues)
            .disposed(by: disposeBag)
        
    }
    
    
}
