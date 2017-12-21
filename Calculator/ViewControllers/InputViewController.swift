//
//  InputViewController.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, InputInterface {
    
    @IBOutlet var calculatorWhiteButton: [MyButton]!
    
    var delegate: InputInterfaceDelegate?
    
    var thread = DispatchQueue.global(qos: .background)
    
    var lol : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(calculatorWhiteButton.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InputViewController {
            destination.delegate = delegate
        }
    }
    
    @IBAction func buttonPressed(_ sender: MyButton) {
        symbolPressed(sender)
    }
    
    func animationThread(_ swither: Bool) {
        switch swither {
        case true:
            lol =  true
            thread.async {
                while self.lol {
                    print(1)
                    DispatchQueue.main.async {
                        let i = Int(arc4random()) % self.calculatorWhiteButton.count
                        self.calculatorWhiteButton[i].backgroundColor = UIColor(red: CGFloat(arc4random()) / CGFloat(UINT32_MAX), green: CGFloat(arc4random()) / CGFloat(UINT32_MAX), blue: CGFloat(arc4random()) / CGFloat(UINT32_MAX), alpha: 1)
                        self.calculatorWhiteButton[i].pulse()
                    }
                    usleep(500000)
                }
            }
        case false:
            lol =  false
            for button in calculatorWhiteButton {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
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
