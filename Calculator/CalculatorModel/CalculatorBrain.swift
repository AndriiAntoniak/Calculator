//
//  CalculatorBrain.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//
import AVFoundation
import Foundation

class CalculatorBrain {
    
    // function for calculation my expression
    func calculatePostfixNotation (expression str: String) throws ->Double {
        let rpn = reversePolandNotation(tokens: stringSeparator(str))
        var stack: [String] = [] // store digit
        for token in rpn {
            if Double(token) != nil {
                stack += [token]
            } else if !stack.isEmpty && (token == Function.cos.rawValue || token == Factorial.fact.rawValue || token == Function.ln.rawValue || token == Function.lg.rawValue || token == Function.sin.rawValue || token == Function.tan.rawValue || token == Function.sqrt.rawValue  ) {
                if let operand = Double(stack.removeLast()) {
                    switch token {
                    case Function.cos.rawValue: stack += [String(cos(operand))]
                    case Factorial.fact.rawValue:
                        if Double(operand) <= 170.0 && Double(operand) >= 0.0 {
                        stack += [String(format:"%g" , factorial(value: Double(operand)))]
                        } else if Double(operand) > 170.0 {
                            stack += [String(Double.infinity)]
                        } else {
                            stack += [String(Double.nan)]
                        }
                    case Function.ln.rawValue: stack += [String(log(operand))]
                    case Function.lg.rawValue: stack += [String(log10(operand))]
                    case Function.sin.rawValue: stack += [String(sin(operand))]
                    case Function.tan.rawValue: stack += [String(tan(operand))]
                    case Function.sqrt.rawValue: stack += [String(sqrt(operand))]
                    default:break
                    }
                }
            } else {
                if stack.count > 1 {
                    if let secondOperand = Double(stack.removeLast()), let firstOperand = Double(stack.removeLast()) {
                        switch token {
                        case Operation.percent.rawValue: stack += [String((firstOperand / 100) * secondOperand)]
                        case Operation.plus.rawValue: stack += [String(firstOperand + secondOperand)]
                        case Operation.minus.rawValue: stack += [String(firstOperand - secondOperand)]
                        case Operation.div.rawValue: stack += [String(firstOperand / secondOperand)]
                        case Operation.mult.rawValue: stack += [String(firstOperand * secondOperand)]
                        case Operation.exp.rawValue: stack += [String(pow(firstOperand , secondOperand))]
                        default: break
                        }
                    }
                } else {
                    return 0.0
                }
            }
        }
        return Double(stack.removeLast())!
    }
    
    // function for reverse my function
    func reversePolandNotation(tokens:[String])->[String] {
        var rpn : [String]   = [] // buffer for expression
        var stack : [String] = [] // buffer for operation
        //prioritise my operations
        let operationPriority : Dictionary <String,Int> = [
            Operation.plus.rawValue:2,
            Operation.minus.rawValue:2,
            Operation.mult.rawValue:3,
            Operation.div.rawValue:3,
            Operation.exp.rawValue:4,
            Function.lg.rawValue:4,
            Function.ln.rawValue:4,
            Function.cos.rawValue:5,
            Function.sin.rawValue:5,
            Function.tan.rawValue:5,
            Function.sqrt.rawValue:5,
            Factorial.fact.rawValue:6,
            Operation.percent.rawValue:3,
        ]
        //filling rpn-array and drop brackets
        for token in tokens {
            switch token {
            case Utility.leftBracket.rawValue: stack += [token]
            case Utility.rightBracket.rawValue:
                while !stack.isEmpty {
                    let temp = stack.removeLast()
                    if temp == Utility.leftBracket.rawValue {
                        break
                    }else {
                        rpn += [temp]
                    }
                }
            default:
                if let firstOperand = operationPriority[token] {
                    for temp in stack.reversed() {
                        if let secondOperand = operationPriority[temp], !(firstOperand > secondOperand) {
                            rpn += [stack.removeLast()]
                            continue
                        }
                        break;
                    }
                    stack += [token]
                } else{
                    rpn += [token]
                }
            }
        }
        return (rpn+stack.reversed())
    }
    
    //string by characters
    func stringSeparator(_ equationStr: String) -> [String] {
        let tokens = equationStr.split{ $0 == " " }.map(String.init)
        return tokens
    }
    
    //calculate factorial of number function
    func factorial(value temp:Double)->Double {
        return temp > 1.0 ? (temp * factorial(value: temp-1)) : 1.0
    }
}
