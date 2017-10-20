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
    
    
    
    //
    func DigitPressed(_ value: MyButton){
        let printValue = brain.digit(value.currentTitle!)
        if brain.Animation(){
            value.pulse()
        }else{
            value.shake()
        }
        outputController?.display(printValue)
    }
    func OperationPressed(_ operation: MyButton){
        let printValue = brain.operation(Operation(rawValue: operation.currentTitle!)!)
        if brain.Animation(){
            operation.pulse()
        }else{
            operation.shake()
        }
        outputController?.display(printValue)
    }
    func FunctionPressed(_ function: MyButton){
        let printValue = brain.function(Function(rawValue: function.currentTitle!)!)
        if brain.Animation(){
            function.pulse()
        }else{
            function.shake()
        }
        outputController?.display(printValue)
    }
    func UtilityPressed(_ utility: MyButton){
        let printValue = brain.utility(Utility(rawValue: utility.currentTitle!)!)
        if brain.Animation(){
            utility.pulse()
        }else{
            utility.shake()
        }
        outputController?.display(printValue)
    }
    func MemoryPressed(_ memory: MyButton){
        let printValue = brain.memory(Memory(rawValue: memory.currentTitle!)!)
        if brain.Animation(){
            memory.pulse()
        }else{
            memory.shake()
        }
        outputController?.display(printValue)
    }
    func FactorialPressed(_ factorial: MyButton){
        let printValue = brain.factorial(Factorial(rawValue: factorial.currentTitle!)!)
        if brain.Animation(){
            factorial.pulse()
        }else{
            playClick()
            factorial.shake()
        }
        outputController?.display(printValue)
    }
    func ConstantsPressed(_ constants: MyButton){
        let printValue = brain.constants(Constants(rawValue: constants.currentTitle!)!)
        if brain.Animation(){
            constants.pulse()
        }else{
            constants.shake()
        }
        outputController?.display(printValue)
    }
    //
    
    
    //for sound
    private func playClick(){
        AudioServicesPlaySystemSound(1104)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

