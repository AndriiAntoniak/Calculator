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
    
    @IBOutlet weak var soundButton: UIButton!
    
    private var validator = CalculatorValidator()
    
    private var outputController: OutputViewController?
    
    private var inputController: InputViewController?
    
    private var anim = false
    
    private var sound = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let soundDefault = defaults.object(forKey: "currentSound") as! Bool?
        if let _ = soundDefault {
            switch soundDefault {
            case true?: soundButton.setImage(#imageLiteral(resourceName: "soundOn32"), for: .normal)
            case false?: soundButton.setImage(#imageLiteral(resourceName: "soundOff32"), for: .normal)
            case .none:
                soundButton.setImage(#imageLiteral(resourceName: "soundOn32"), for: .normal)
                defaults.set(true,forKey: "currentSound")
            }
            sound = soundDefault!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputSegue" {
          inputController = segue.destination as? InputViewController
            inputController?.delegate = self
        }
        else if segue.identifier == "OutputSegue" {
            outputController = segue.destination as? OutputViewController
        }
    }
    
    @IBAction func animationSwitch(_ sender: UIButton) {
        defer {
            anim = anim ? false : true
        }
        inputController?.animationThread(anim ? false : true)
        usleep(5000)
        inputController?.animationThread(anim ? false : true)
        usleep(5000)
        inputController?.animationThread(anim ? false : true)
    }
    
    @IBAction func soundSwitch(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if  sender.currentImage == #imageLiteral(resourceName: "soundOn32") {
            sender.setImage(#imageLiteral(resourceName: "soundOff32"), for: .normal)
            defaults.set(false,forKey: "currentSound")
        } else {
            sender.setImage(#imageLiteral(resourceName: "soundOn32"), for: .normal)
            defaults.set(true,forKey: "currentSound")
        }
        let soundDefault = defaults.object(forKey: "currentSound") as! Bool?
        sound = soundDefault!
    }
    
    func digitPressed(_ value: MyButton) {
        let printValue = validator.digit(value.currentTitle!)
        if validator.buttonAnimation() {
            value.pulse()
        }else {
            value.shake()
            checkForSound()
        }
        outputController?.display(printValue)
    }
    
    func operationPressed(_ operation: MyButton) {
        let printValue = validator.operation(Operation(rawValue: operation.currentTitle!)!)
        if validator.buttonAnimation() {
            operation.pulse()
        }else {
            operation.shake()
            checkForSound()
        }
        outputController?.display(printValue)
    }
    
    func functionPressed(_ function: MyButton) {
        let printValue = validator.function(Function(rawValue: function.currentTitle!)!)
        if validator.buttonAnimation() {
            function.pulse()
        }else {
            function.shake()
            checkForSound()
        }
        outputController?.display(printValue)
    }
    
    func utilityPressed(_ utility: MyButton) {
        let printValue = validator.utility(Utility(rawValue: utility.currentTitle!)!)
        if validator.buttonAnimation() {
            utility.pulse()
        }else {
            utility.shake()
            checkForSound()
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
        checkForSound()
        outputController?.display(printValue)
    }
    
    func factorialPressed(_ factorial: MyButton) {
        let printValue = validator.factorial(Factorial(rawValue: factorial.currentTitle!)!)
        if validator.buttonAnimation() {
            factorial.pulse()
        }else {
            checkForSound()
            factorial.shake()
            checkForSound()
        }
        outputController?.display(printValue)
    }
    
    func constantsPressed(_ constants: MyButton) {
        let printValue = validator.constants(Constants(rawValue: constants.currentTitle!)!)
        if validator.buttonAnimation() {
            constants.pulse()
        }else {
            constants.shake()
            checkForSound()
        }
        outputController?.display(printValue)
    }
    
    private func checkForSound() {
        if sound {
            playClick()
        }
    }
    
    private func playClick() {
        AudioServicesPlaySystemSound(1104)
    } 
}
