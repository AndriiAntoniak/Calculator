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
    
    var outputController: OutputViewController? = nil
    
    private var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputSegue"{
            let destinationVC=segue.destination as! InputViewController
            destinationVC.delegate = self
        }
        else if segue.identifier == "OutputSegue"{
            outputController = segue.destination as? OutputViewController
        }
    }
    
    func digitPressed(_ value: MyButton) {
        let printValue = brain.digit(value.currentTitle!)
        if brain.buttonAnimation() {
            value.pulse()
        }else {
            value.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func operationPressed(_ operation: MyButton) {
        let printValue = brain.operation(Operation(rawValue: operation.currentTitle!)!)
        if brain.buttonAnimation() {
            operation.pulse()
        }else {
            operation.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func functionPressed(_ function: MyButton) {
        let printValue = brain.function(Function(rawValue: function.currentTitle!)!)
        if brain.buttonAnimation() {
            function.pulse()
        }else {
            function.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func utilityPressed(_ utility: MyButton) {
        let printValue = brain.utility(Utility(rawValue: utility.currentTitle!)!)
        if brain.buttonAnimation() {
            utility.pulse()
        }else {
            utility.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func memoryPressed(_ memory: MyButton) {
        let printValue = brain.memory(Memory(rawValue: memory.currentTitle!)!)
        if brain.buttonAnimation() {
            memory.pulse()
        }else {
            memory.shake()
        }
        playClick()
        outputController?.display(printValue)
    }
    
    func factorialPressed(_ factorial: MyButton) {
        let printValue = brain.factorial(Factorial(rawValue: factorial.currentTitle!)!)
        if brain.buttonAnimation() {
            factorial.pulse()
        }else {
            playClick()
            factorial.shake()
            playClick()
        }
        outputController?.display(printValue)
    }
    
    func constantsPressed(_ constants: MyButton) {
        let printValue = brain.constants(Constants(rawValue: constants.currentTitle!)!)
        if brain.buttonAnimation() {
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

