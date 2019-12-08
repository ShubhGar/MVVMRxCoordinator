//
//  LoadingViewable.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import UIKit


protocol loadingViewable {
    func startAnimating()
    func stopAnimating()
}
extension loadingViewable where Self : UIViewController {
    func startAnimating(){
        let animateLoading = loadingView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.addSubview(animateLoading)
        view.bringSubviewToFront(animateLoading)
        animateLoading.restorationIdentifier = loadingView.viewIdentifier
        animateLoading.center = view.center
        animateLoading.loadingViewMessage = "Loading"
        animateLoading.cornerRadius = 15
        animateLoading.clipsToBounds = true
        animateLoading.startAnimation()
    }
    func stopAnimating() {
        for item in view.subviews
            where item.restorationIdentifier == loadingView.viewIdentifier {
                UIView.animate(withDuration: 0.3, animations: {
                    item.alpha = 0
                }) { (_) in
                    item.removeFromSuperview()
                }
        }
    }
}
