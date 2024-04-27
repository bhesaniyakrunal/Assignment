//
//  SocialMediaTableViewCell.swift
//  Assignment
//
//  Created by MacBook on 4/27/24.
//

import UIKit
protocol SocialCellDeleget {
    func like(index:Int)
    func Comment(index:Int)
    func share(index:Int)
}


class SocialMediaTableViewCell: UITableViewCell {
    @IBOutlet weak var labelProfileName: UILabel!
    @IBOutlet weak var labelId: UILabel!

    var socialDeleget: SocialCellDeleget? = nil
    var index = IndexPath()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func displayData(post:Post){
        self.labelProfileName.text = post.title
        self.labelId.text = String(describing: post.id)
    }
}
