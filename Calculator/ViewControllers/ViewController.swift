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
    
    @IBOutlet weak var leadingSettingsOnConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leadingSettingsOffConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var soundButton: UIButton!
    
    private var validator = CalculatorValidator()
    
    private var outputController: OutputViewController?
    
    private var inputController: InputViewController?
    
    private var anim = false
    
    private var sound = true
    
    private var isSettings = false
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let soundDefault = defaults.bool(forKey: "currentSound") //{
        switch soundDefault {
        case true:
            soundButton.setImage(#imageLiteral(resourceName: "soundOn32"), for: .normal)
            defaults.set(true,forKey: "currentSound")
        case false:
            soundButton.setImage(#imageLiteral(resourceName: "soundOff32"), for: .normal)
            defaults.set(false,forKey: "currentSound")
        }
        sound = defaults.bool(forKey: "currentSound")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingsInitialConditions()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        settingsInitialConditions()
        animateConstraints()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputSegue" {
            inputController = segue.destination as? InputViewController
            inputController?.delegate = self
        } else if segue.identifier == "OutputSegue" {
            outputController = segue.destination as? OutputViewController
        }
    }
    
    @IBAction func animationSwitch(_ sender: UIButton) {
            anim = anim ? false : true
        inputController?.animationThread(anim)
        usleep(5000)
        inputController?.animationThread(anim)
        usleep(5000)
        inputController?.animationThread(anim)
    }
    
    @IBAction func soundSwitch(_ sender: UIButton) {
        if  sender.currentImage == #imageLiteral(resourceName: "soundOn32") {
            sender.setImage(#imageLiteral(resourceName: "soundOff32"), for: .normal)
            defaults.set(false,forKey: "currentSound")
        } else {
            sender.setImage(#imageLiteral(resourceName: "soundOn32"), for: .normal)
            defaults.set(true,forKey: "currentSound")
        }
        sound = defaults.bool(forKey: "currentSound")
    }
    
    @IBAction func settingsSwitch(_ sender: UIButton) {
        switch isSettings {
        case true:
            isSettings = false
            leadingSettingsOnConstraint.isActive = false
            leadingSettingsOffConstraint.isActive = true
        case false:
            isSettings = true
            leadingSettingsOnConstraint.isActive = true
            leadingSettingsOffConstraint.isActive = false
        }
        animateConstraints()
    }
    
    func animateConstraints() {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func settingsInitialConditions() {
        isSettings = false
        leadingSettingsOnConstraint.isActive = false
        leadingSettingsOffConstraint.isActive = true
    }
    
    func digitPressed(_ value: MyButton) {
        let printValue = validator.digit(value.currentTitle!)
        if validator.buttonAnimation() {
            value.pulse()
        } else {
            value.shake()
            checkForSound()
        }
        outputController?.display(printValue)
    }
    
    func operationPressed(_ operation: MyButton) {
        let printValue = validator.operation(Operation(rawValue: operation.currentTitle!)!)
        if validator.buttonAnimation() {
            operation.pulse()
        } else {
            operation.shake()
            checkForSound()
        }
        outputController?.display(printValue)
    }
    
    func functionPressed(_ function: MyButton) {
        let printValue = validator.function(Function(rawValue: function.currentTitle!)!)
        if validator.buttonAnimation() {
            function.pulse()
        } else {
            function.shake()
            checkForSound()
        }
        outputController?.display(printValue)
    }
    
    func utilityPressed(_ utility: MyButton) {
        let printValue = validator.utility(Utility(rawValue: utility.currentTitle!)!)
        if validator.buttonAnimation() {
            utility.pulse()
        } else {
            utility.shake()
            checkForSound()
        }
        outputController?.display(printValue)
    }
    
    func memoryPressed(_ memory: MyButton) {
        let printValue = validator.memory(Memory(rawValue: memory.currentTitle!)!)
        if validator.buttonAnimation() {
            memory.pulse()
        } else {
            memory.shake()
        }
        checkForSound()
        outputController?.display(printValue)
    }
    
    func factorialPressed(_ factorial: MyButton) {
        let printValue = validator.factorial(Factorial(rawValue: factorial.currentTitle!)!)
        if validator.buttonAnimation() {
            factorial.pulse()
        } else {
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
        } else {
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
