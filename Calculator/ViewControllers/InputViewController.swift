//
//  InputViewController.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class InputViewController: UIViewController,InputInterface{
   var delegate: InputInterfaceDelegate?
   
    
    func symbolPressed(_ symbol: MyButton){
        
        if let _ = Utility(rawValue: symbol.currentTitle!){
                delegate?.UtilityPressed(symbol)
        }else if let _ = Factorial(rawValue: symbol.currentTitle!){
            delegate?.FactorialPressed(symbol)
        }else if let _ = Function(rawValue: symbol.currentTitle!){
            delegate?.FunctionPressed(symbol)
        }else if let _ = Memory(rawValue: symbol.currentTitle!){
            delegate?.MemoryPressed(symbol)
        }else if let _ = Constants(rawValue: symbol.currentTitle!){
            delegate?.ConstantsPressed(symbol)
        }else if let _ = Operation(rawValue: symbol.currentTitle!){
            delegate?.OperationPressed(symbol)
        }else{
            delegate?.DigitPressed(symbol)
        }
    }
    

    @IBAction func ButtonPressed(_ sender: MyButton) {
        symbolPressed(sender)
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InputViewController{
            destination.delegate = delegate
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
