//
//  InputViewController.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, InputInterface {
   
    var delegate: InputInterfaceDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InputViewController {
            destination.delegate = delegate
        }
    }
    
    @IBAction func buttonPressed(_ sender: MyButton) {
        symbolPressed(sender)
    }
    
    func symbolPressed(_ symbol: MyButton) {
        
        if let _ = Utility(rawValue: symbol.currentTitle!) {
                delegate?.utilityPressed(symbol)
        } else if let _ = Factorial(rawValue: symbol.currentTitle!) {
            delegate?.factorialPressed(symbol)
        } else if let _ = Function(rawValue: symbol.currentTitle!) {
            delegate?.functionPressed(symbol)
        } else if let _ = Memory(rawValue: symbol.currentTitle!) {
            delegate?.memoryPressed(symbol)
        } else if let _ = Constants(rawValue: symbol.currentTitle!) {
            delegate?.constantsPressed(symbol)
        } else if let _ = Operation(rawValue: symbol.currentTitle!) {
            delegate?.operationPressed(symbol)
        } else {
            delegate?.digitPressed(symbol)
        }
    }
}