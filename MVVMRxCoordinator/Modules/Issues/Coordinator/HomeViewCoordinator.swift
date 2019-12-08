//
//  HomeViewCoordinator.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//
import UIKit
import RxSwift
import SafariServices

class HomeViewCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController.initFromStoryboard()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.homeViewModel = viewModel
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewModel.showCommentList.subscribe(onNext: { [weak self] in self?.showComments(by: $0, in: viewController) }).disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    
    private func showComments(by url:String, in rootViewController: UIViewController) {
        let commentsCoordinator = CommentsViewCoordinator(commentURL: url, rootViewController: rootViewController)
        _ = coordinate(to: commentsCoordinator)
    }
}
