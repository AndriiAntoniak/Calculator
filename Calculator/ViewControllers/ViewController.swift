//
//  ViewController.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/5/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController,InputInterfaceDelegate {
    
    
    var anim = false
    
    @IBAction func animationSwitcher(_ sender: UIButton) {
    //    delegateVar?.animationThread(anim ? false : true)
     
           inputController?.animationThread(anim ? false : true)
   //
       
        defer {
            anim = anim ? false : true
        }
        print(anim)
    }
    
    var outputController: OutputViewController? = nil
    
    //
    var inputController: InputViewController?
    //
    
    private var validator = CalculatorValidator()
    
    
    //
    
    
    
    
    
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputSegue"{
          inputController = segue.destination as? InputViewController
            inputController?.delegate = self
            
            //  let destinationVC=segue.destination as! InputViewController
          //  destinationVC.delegate = self
        }
        else if segue.identifier == "OutputSegue"{
            outputController = segue.destination as? OutputViewController
        }
    }
    
    func digitPressed(_ value: MyButton) {
        let printValue = validator.digit(value.currentTitle!)
        if validator.buttonAnimation() {
            value.pulse()
        }else {
            value.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func operationPressed(_ operation: MyButton) {
        let printValue = validator.operation(Operation(rawValue: operation.currentTitle!)!)
        if validator.buttonAnimation() {
            operation.pulse()
        }else {
            operation.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func functionPressed(_ function: MyButton) {
        let printValue = validator.function(Function(rawValue: function.currentTitle!)!)
        if validator.buttonAnimation() {
            function.pulse()
        }else {
            function.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func utilityPressed(_ utility: MyButton) {
        let printValue = validator.utility(Utility(rawValue: utility.currentTitle!)!)
        if validator.buttonAnimation() {
            utility.pulse()
        }else {
            utility.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func memoryPressed(_ memory: MyButton) {
        let printValue = validator.memory(Memory(rawValue: memory.currentTitle!)!)
        if validator.buttonAnimation() {
            memory.pulse()
        }else {
            memory.shake()
        }
        playClick()
        outputController?.display(printValue)
    }
    
    func factorialPressed(_ factorial: MyButton) {
        let printValue = validator.factorial(Factorial(rawValue: factorial.currentTitle!)!)
        if validator.buttonAnimation() {
            factorial.pulse()
        }else {
            playClick()
            factorial.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func constantsPressed(_ constants: MyButton) {
        let printValue = validator.constants(Constants(rawValue: constants.currentTitle!)!)
        if validator.buttonAnimation() {
            constants.pulse()
        }else {
            constants.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    private func playClick(){
        AudioServicesPlaySystemSound(1104)
    } 
}
