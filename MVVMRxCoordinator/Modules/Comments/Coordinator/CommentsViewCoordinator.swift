//
//  CommentsViewCoordinator.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import UIKit
import RxSwift


class CommentsViewCoordinator: BaseCoordinator<String> {
    
    private let rootViewController: UIViewController
    private let commentURL: String
    init(commentURL: String, rootViewController: UIViewController) {
        self.commentURL = commentURL
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<CoordinationResult> {
        let viewController = CommentsViewController(nibName: CommentsViewController.vcIdentifier, bundle: nil)
        let viewModel = CommentsViewModel(url: commentURL)
        viewController.viewModel = viewModel
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return Observable.never()
    }
    
}
