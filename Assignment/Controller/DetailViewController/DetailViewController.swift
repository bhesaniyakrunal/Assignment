//
//  DetailViewController.swift
//  Assignment
//
//  Created by MacBook on 4/27/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var labelDetails: UILabel!
    
    var details: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelDetails.text = details
    }


}
