//
//  OutputViewController.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController, OutputInterface  {
    
    @IBOutlet private weak var display: UILabel!
    
    func display(_ result: String) {
        display.text = result
    }
}
