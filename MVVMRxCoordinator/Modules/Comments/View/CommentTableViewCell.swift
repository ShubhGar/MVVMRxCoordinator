//
//  CommentTableViewCell.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import UIKit


class CommentTableViewCell: UITableViewCell {
 
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var commentBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func setUser(name:String)  {
        self.userName.text = name
    }
    
    func setComment(body:String)  {
        self.commentBody.text = body
    }
    
}
