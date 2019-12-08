//
//  IssueTableViewCell.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func setIssue(title : String){
        self.issueTitle.text = title
    }
    
    func setIssue(body : String){
        self.issueBody.text = body
    }
    
}
