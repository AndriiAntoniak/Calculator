//
//  OutputViewController.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController, OutputInterface  {
    
    @IBOutlet private weak var leadingDispayConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leadingDispayConstraint.constant = display.frame.height / 2
    }
    
    func display(_ result: String) {
        display.text = result
    }
}
