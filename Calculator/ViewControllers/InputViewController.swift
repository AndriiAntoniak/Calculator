//
//  InputViewController.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, InputInterface {
    
     var thread = DispatchQueue.global(qos: .background)
    
    var lol : Bool!
    
       func animationThread(_ swither: Bool) {
        switch swither {
        case true:
            
            
            lol =  true
            thread.async {
                while self.lol {
                    print(1)
                    DispatchQueue.main.async {
                        self.sevenButton.backgroundColor = UIColor(red: CGFloat(arc4random()) / CGFloat(UINT32_MAX), green: CGFloat(arc4random()) / CGFloat(UINT32_MAX), blue: CGFloat(arc4random()) / CGFloat(UINT32_MAX), alpha: 1)
                    }
                 //   sleep(1)
                    usleep(500000)
                }
                print("thread")
            }

        case false:
            lol =  false
            sevenButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
  
    
    
    var delegate: InputInterfaceDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InputViewController {
            destination.delegate = delegate
        }
    }
    
    @IBAction func buttonPressed(_ sender: MyButton) {
        symbolPressed(sender)
    }
    
    
    //
    
    @IBOutlet weak var sevenButton: MyButton!
    
    
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("DID LOAD")
//        if lol != nil {
//            animationThread(lol)
//        }
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
