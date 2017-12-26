//
//  CalculatorValidator.swift
//  Calculator
//
//  Created by Andrii Antoniak on 12/14/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation

class CalculatorValidator: CalculatorInterface {
    
    private var brain = CalculatorBrain()
    
    private var storeValue = "0"
    
    private var previousCame:String? = "0"
    
    private var dotSecurity = true
    
    private var openBrackets = 0
    
    private var animation = true
    
    private var result = false
    
    private var error = false
    
    private var history:[String] = []
    
    func digit(_ value: String) -> String {
        let temp = String(value)
        if result || error {
            storeValue = temp
            previousCame = temp
            history.removeAll()
            history.append(previousCame!)
            result = false
        } else if storeValue == "0" {
            storeValue = temp
            previousCame = temp
            history.append(previousCame!)
            
        } else if storeValue == "-0" {
            storeValue = "-" + temp
            previousCame = temp
            history.removeLast()
            history.append(previousCame!)
        } else if Int(previousCame!) != nil || previousCame == Utility.dot.rawValue || previousCame! == "±" {
            storeValue += temp
            previousCame = temp
            history.append(previousCame!)
        } else if previousCame != Utility.rightBracket.rawValue {
            storeValue += " " + temp
            previousCame = temp
            history.append(" \(previousCame!)")
        } else {
            animation = false
        }
        error = false
        return storeValue
    }
    
    func operation(_ operation: Operation) -> String {
        let temp = String(describing: operation.rawValue)
        if  !error && Int(previousCame!) != nil || previousCame! == ")" || isFactorial(previousCame!) || isConstants(previousCame!) {
            storeValue += " " + temp
            history.append(" \(temp)")
            previousCame = temp
            dotSecurity = true
        } else if Operation(rawValue: previousCame!) != nil {
            storeValue.removeLast()
            history.removeLast()
            storeValue += temp
            previousCame = temp
            dotSecurity = true
            history.append(" \(temp)")
        } else {
            animation = false
        }
        result = false
        return storeValue
    }
    
    func isConstants(_ text: String) -> Bool {
        return Constants(rawValue: text) != nil ? true : false
    }
    
    func isFactorial(_ text: String) -> Bool {
        return Factorial(rawValue: text) != nil ? true : false
    }
    
    func function(_ function: Function) -> String {
        let temp = String(describing: function.rawValue)
        if result || error {
            storeValue = temp + " ("
            history.removeAll()
            history.append("\(temp) (")
            openBrackets += 1
            dotSecurity = true
            previousCame = "("
            result = false
            error = false
        } else if storeValue == "0" {
            storeValue = temp + " ("
            history.append("\(temp) (")
            openBrackets += 1
            dotSecurity = true
            previousCame = "("
        } else if previousCame! == "+" || previousCame! == "-" || previousCame! == "^" || previousCame! == "x" || previousCame! == "/" || previousCame! == "%" || previousCame! == "("{
            storeValue += " " + temp + " ("
            openBrackets += 1
            dotSecurity = true
            previousCame = "("
            history.append(" \(temp) (")
        } else {
            animation = false
        }
        return storeValue
    }
    
    func commonMemoryCleaner() {
        storeValue = "0"
        previousCame = "0"
        dotSecurity = true
        openBrackets = 0
        history.removeAll()
        result = false
    }
    
    func memory(_ memory: Memory) -> String {
        switch memory {
        case .allclean:
            commonMemoryCleaner()
        case .clean:
            if result || error {
                commonMemoryCleaner()
            } else {
                if !history.isEmpty {
                    let temp = history.removeLast()
                    if temp == Utility.dot.rawValue {
                        dotSecurity = true
                    } else if temp == " )" || temp == ")" {
                        openBrackets += 1
                    } else if temp == " (" || temp == "(" || temp.count > 2 {
                        openBrackets -= 1
                    }
                    if history.isEmpty {
                        storeValue = "0"
                        previousCame = "0"
                        dotSecurity = true
                        openBrackets = 0
                    } else {
                        var temp = history
                        storeValue=temp.removeFirst()
                        while !temp.isEmpty {
                            storeValue+=temp.removeFirst()
                        }
                        for i in storeValue.reversed() {
                            previousCame! = String(i)
                            break
                        }
                        var temp1 = history
                        if temp1.removeLast() == Utility.dot.rawValue && temp1.isEmpty {
                            storeValue = "0"
                            previousCame = "0"
                            dotSecurity = true
                            openBrackets = 0
                        }
                    }
                }
            }
        }
        error = false
        return storeValue
    }
    
    func utility(_ utility: Utility) -> String {
        let temp = String(describing: utility.rawValue)
        switch temp {
        case ".":
            if  Int(previousCame!) != nil && !result {
                if dotSecurity {
                    previousCame = temp
                    storeValue += temp
                    history.append(temp)
                    dotSecurity = false
                } else {
                    animation = false
                }
            } else {
                animation = false
            }
        case "(", ")":
            bracketsPressed(temp)
        case "=":
            if Operation(rawValue: previousCame!) == nil && previousCame! != "(" && previousCame! != "±" {
                storeValue = performEqualPressed()
            } else {
                animation = false
            }
        case "±":
            signPressed()
        default: break
        }
        return storeValue
    }
    
    func signPressed() {
        if storeValue == "0" && !error {
            storeValue = "-0"
            previousCame = "0"
            history.append("-")
            history.append("0")
            dotSecurity = true
        } else if storeValue == "-0" {
            storeValue = "0"
            previousCame = "0"
            history.removeAll()
            history.append("0")
            dotSecurity = true
        } else if previousCame == "±" {
            var last = ""
            for i in history.reversed() {
                last = i
                break
            }
            last = last == " -" ? "+" : "-"
            storeValue.removeLast()
            storeValue += "\(last)"
            history.removeLast()
            history.append(" \(last)")
            previousCame = "±"
            dotSecurity = true
            last = " \(last)"
        } else if Operation(rawValue: previousCame!) != nil || previousCame! == "(" {
            storeValue += " -"
            history.append(" -")
            previousCame = "±"
            dotSecurity = true
        } else {
            animation = false
        }
    }
    
    func bracketsPressed(_ bracket: String) {
        switch bracket {
        case ")":
            if (previousCame! == "!" || previousCame! == ")" || Int(previousCame!) != nil) && openBrackets > 0 {
                storeValue += " " + bracket
                previousCame = bracket
                openBrackets -= 1
                dotSecurity = true
                history.append(" \(bracket)")
            } else {
                animation = false
            }
        case "(":
            if result || error {
                storeValue = bracket
                previousCame = bracket
                history.removeAll()
                history.append(bracket)
                openBrackets += 1
                dotSecurity = true
                result = false
                error = false
            } else if storeValue == "0" {
                storeValue = bracket
                previousCame = bracket
                history.append(bracket)
                openBrackets += 1
                dotSecurity = true
            } else if previousCame! != "!" && previousCame! != ")" && Int(previousCame!) == nil && previousCame! != "." {
                storeValue += " " + bracket
                history.append(" \(bracket)")
                previousCame = bracket
                openBrackets += 1
                dotSecurity = true
            } else {
                animation = false
            }
        default: break
        }
    }
    
    func factorial(_ factorial: Factorial) -> String {
        
        let temp = String(describing: factorial.rawValue)
        if Int(previousCame!) != nil {
            storeValue += " " + temp
            dotSecurity = true
            previousCame = temp
            history.append(" \(temp)")
            result = false
        } else if previousCame! == "π" || previousCame! == "e" {
            storeValue += " " + temp
            dotSecurity = true
            previousCame = temp
            history.append(" \(temp)")
        } else {
            animation = false
        }
        return storeValue
    }
    
    func constants(_ constants: Constants) -> String {
        
        let temp = String(describing: constants.rawValue)
        var newOperand:String? = "0"
        switch temp {
        case "π":
            newOperand = String(Double.pi)
        case "e":
            newOperand = String(M_E)
        default: break
        }
        if previousCame! == "+" || previousCame! == "-" || previousCame! == "^" || previousCame! == "x" || previousCame! == "/" || previousCame! == "%" || previousCame! == "(" {
            storeValue += " " + newOperand!
            dotSecurity = false
            history.append(" \(newOperand!)")
            previousCame = String(newOperand!.removeLast())
        } else if storeValue == "0" || error {
            storeValue = newOperand!
            dotSecurity = false
            history.append("\(newOperand!)")
            previousCame = String(newOperand!.removeLast())
        } else if result {
            storeValue = newOperand!
            dotSecurity = false
            history.removeAll()
            history.append("\(newOperand!)")
            previousCame = String(newOperand!.removeLast())
            result = false
        } else if previousCame! == "±" {
            storeValue += newOperand!
            dotSecurity = false
            history.append("\(newOperand!)")
            previousCame = String(newOperand!.removeLast())
        } else {
            animation = false
        }
        return storeValue
    }
    
    public func performEqualPressed () -> String {
        if openBrackets == 0 {
            let varForTry =  try? brain.calculatePostfixNotation(expression: storeValue)
            if varForTry == Double.infinity {
                history.removeAll()
                storeValue = "0"
                previousCame = "0"
                dotSecurity = true
                error = true
                animation = false
                return "infinity"
            } else if varForTry!.isNaN {
                history.removeAll()
                storeValue = "0"
                previousCame = "0"
                dotSecurity = true
                error = true
                animation = false
                return "not a number"
            } else {
                history.removeAll()
                let temp = decimalpoint(varForTry!)
                for i in temp {
                    history.append(String(i))
                    previousCame = String(i)
                }
                result = true
                return temp
            }
        }
        animation = false
        return storeValue
    }
    
    //function witch return resalt in int or double
    func decimalpoint(_ doubleValue:Double) -> String {
        if doubleValue < Double(Int.max) {
            let intValue = Int(doubleValue)
            if doubleValue != Double(intValue) {
                dotSecurity = false
                return String(doubleValue)
            } else {
                dotSecurity = true
                return String(intValue)
            }
        } else {
            dotSecurity = false
            return String(doubleValue)
        }
    }
    
    public func buttonAnimation() -> Bool {
        defer {
            animation = true
        }
        return animation
    }
}
