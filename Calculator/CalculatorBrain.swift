//
//  CalculatorBrain.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//
import AVFoundation
import Foundation

class CalculatorBrain: CalculatorInterface {
    
   // private var
    private var storeValue = "0"
    private var previousCame:String? = "0"
    private var dotSecurity = true
    private var openBrackets = 0
    private var animation = true
    //private array for history?
    private var history:[String] = []
    
    //function for calc my expression after pressed =
    func PerformOperation()->String{
        //
        if openBrackets == 0 {
            let varForTry =  try? CalculatePostfixNotation(expression: storeValue)
            if varForTry == Double.infinity{
                animation = false
            }else if varForTry!.isNaN{
                animation = false
            }
            else
            {
                history.removeAll()
                var temp = Decimalpoint(varForTry!)
                for i in temp.characters{
                    history.append(String(i))
                    previousCame = String(i)
                }
                return temp
            }
        }
        animation = false
        return storeValue
    }
    
  
    
    //function witch return resalt in int or double
    func Decimalpoint(_ doubleValue:Double)->String{
        let intValue=Int(doubleValue)
        if doubleValue != Double(intValue){
            dotSecurity = false
            return String(doubleValue)
        }else{
            dotSecurity = true
            return String(intValue)
        }
    }
    
    // function for calculation my expression
    func CalculatePostfixNotation (expression str: String) throws ->Double{
        let rpn = ReversePolandNotation(tokens: StringSeparator(str))
        var stack: [String] = [] // store digit
        for token in rpn{
            if Double(token) != nil{
                stack += [token]
            }else if !stack.isEmpty && (token == Function.cos.rawValue || token == Factorial.fact.rawValue || token == Function.ln.rawValue || token == Function.lg.rawValue || token == Function.sin.rawValue || token == Function.tan.rawValue || token == Function.sqrt.rawValue  ){
                if let operand = Double(stack.removeLast()){
                    switch token{
                    case Function.cos.rawValue: stack += [String(cos(operand))]
                    case Factorial.fact.rawValue:
                        if Int64(operand) < 21{
                        stack += [String(Facrotial(value: Int64(operand)))]
                        }else{
                            stack += [String(Double.infinity)]
                        }
                    case Function.ln.rawValue: stack += [String(log(operand))]
                    case Function.lg.rawValue: stack += [String(log10(operand))]
                    case Function.sin.rawValue: stack += [String(sin(operand))]
                    case Function.tan.rawValue: stack += [String(tan(operand))]
                    case Function.sqrt.rawValue: stack += [String(sqrt(operand))]
                    default:break
                    }
                }
            }else{
                if stack.count > 1 {
                    if let secondOperand = Double(stack.removeLast()), let firstOperand = Double(stack.removeLast()){
                        switch token{
                        case Operation.percent.rawValue: stack += [String((firstOperand / 100) * secondOperand)]
                        case Operation.plus.rawValue: stack += [String(firstOperand + secondOperand)]
                        case Operation.minus.rawValue: stack += [String(firstOperand - secondOperand)]
                        case Operation.div.rawValue: stack += [String(firstOperand / secondOperand)]
                        case Operation.mult.rawValue: stack += [String(firstOperand * secondOperand)]
                        case Operation.exp.rawValue: stack += [String(pow(firstOperand , secondOperand))]
                        default: break
                        }
                    }
                }else{
                    return 0.0
                }
            }
        }
        return Double(stack.removeLast())!
    }
    
    // function for reverse my function
    func ReversePolandNotation(tokens:[String])->[String]{
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
    
        for token in tokens{
            switch token{
            case Utility.leftBracket.rawValue: stack += [token]
            case Utility.rightBracket.rawValue:
                while !stack.isEmpty{
                    let temp = stack.removeLast()
                    if temp == Utility.leftBracket.rawValue{
                        break
                    }else{
                        rpn += [temp]
                    }
                }
            default:
                if let firstOperand = operationPriority[token]{
                    for temp in stack.reversed(){
                        if let secondOperand = operationPriority[temp], !(firstOperand > secondOperand){
                            rpn += [stack.removeLast()]
                            continue
                        }
                        break;
                    }
                    stack += [token]
                }else{
                    rpn += [token]
                }
            }
        }
        return (rpn+stack.reversed())
    }
    
    //string by characters
    func StringSeparator(_ equationStr: String) -> [String] {
        let tokens = equationStr.characters.split{ $0 == " " }.map(String.init)
        return tokens
    }
    
    //calculate factorial of number function
    func Facrotial(value temp:Int64)->Int64{
        return temp > 1 ? (temp * Facrotial(value: temp-1)) : 1
    }
	

    
    //Calculator interface
    
    //process digit
    func digit(_ value: String)->String{
        
        let temp = String(value)
        if storeValue == "0"{
            storeValue = temp
            previousCame = temp
            history.append(previousCame!)
        }else if storeValue == "-0"{
            storeValue = "-" + temp
            previousCame = temp
            history.removeLast()
            history.append(previousCame!)
        }else if Int(previousCame!) != nil || previousCame == Utility.dot.rawValue || previousCame! == "±"{
            storeValue += temp
            previousCame = temp
            history.append(previousCame!)
        }else if previousCame != Utility.rightBracket.rawValue{
            storeValue += " " + temp
            previousCame = temp
            history.append(" \(previousCame!)")
        }else{
            animation = false
        }
        return storeValue
    }
    
    
    
    
    //process memory
    func memory(_ memory: Memory)->String{
        switch memory{
        case .allclean:
            storeValue = "0"
            previousCame = "0"
            dotSecurity = true
            openBrackets = 0
            history.removeAll()
        case .clean:
            if !history.isEmpty{
                let temp = history.removeLast()
                if temp == Utility.dot.rawValue{
                    dotSecurity = true
                }else if temp == " )"{
                    openBrackets += 1
                }
                if history.isEmpty{
                    storeValue = "0"
                    previousCame = "0"
                    dotSecurity = true
                    openBrackets = 0
                }else{
                    var temp = history
                    storeValue=temp.removeFirst()
                    while !temp.isEmpty{
                        storeValue+=temp.removeFirst()
                    }
                    for i in storeValue.characters.reversed(){
                        previousCame! = String(i)
                    }
                     var temp1 = history
                    if temp1.removeLast() == Utility.dot.rawValue && temp1.isEmpty{
                        storeValue = "0"
                        previousCame = "0"
                        dotSecurity = true
                        openBrackets = 0
                    }
                }
            }
        }
        return storeValue
    }
    
    // process operations + - * / ^ %
    func operation(_ operation: Operation)->String{
        let temp = String(describing: operation.rawValue)
        if  Int(previousCame!) != nil || previousCame! == Utility.rightBracket.rawValue || previousCame! == Factorial.fact.rawValue || previousCame! == Constants.e.rawValue || previousCame! == Constants.pi.rawValue{
            storeValue += " " + temp
            history.append(" \(temp)")
            previousCame = temp
            dotSecurity = true
        }else if previousCame! == Operation.div.rawValue || previousCame! == Operation.exp.rawValue || previousCame! == Operation.minus.rawValue || previousCame! == Operation.mult.rawValue || previousCame! == Operation.percent.rawValue || previousCame! == Operation.plus.rawValue {
            storeValue.removeLast()
            history.removeLast()
            storeValue += temp
            previousCame = temp
            dotSecurity = true
            history.append(" \(temp)")
        }else{
            animation = false
        }
        return storeValue
    }
    //process function cos sin tan ...
    func function(_ function: Function)->String{
        let temp = String(describing: function.rawValue)
        if storeValue == "0"{
            storeValue = temp + " ("
            history.append("\(temp) (")
            openBrackets += 1
            dotSecurity = true
            previousCame = "("
        }else if previousCame! == "+" || previousCame! == "-" || previousCame! == "^" || previousCame! == "x" || previousCame! == "/" || previousCame! == "%" || previousCame! == "("{
            storeValue += " " + temp + " ("
            openBrackets += 1
            dotSecurity = true
            previousCame = "("
            history.append(" \(temp) (")
        }else{
            animation = false
        }
        return storeValue
    }
    //process utility
    func utility(_ utility: Utility)->String{
        let temp = String(describing: utility.rawValue)
        switch temp{
        case ".":
            if let _ = Int(previousCame!) {
                if dotSecurity{
                    previousCame = temp
                    storeValue += temp
                    history.append(temp)
                    dotSecurity = false
                }else{
                    animation = false
                }
            }else{
                animation = false
            }
        case "(":
            if storeValue == "0"{
                storeValue = temp
                previousCame = temp
                history.append(temp)
                openBrackets += 1
                dotSecurity = true
            }else if previousCame! != "!" && previousCame! != ")" && Int(previousCame!) == nil && previousCame! != "."{
                storeValue += " " + temp
                history.append(" \(temp)")
                previousCame = temp
                openBrackets += 1
                dotSecurity = true
            }else{
                animation = false
            }
        case ")":
            if (previousCame! == "!" || previousCame! == ")" || Int(previousCame!) != nil) && openBrackets > 0{
                storeValue += " " + temp
                previousCame = temp
                openBrackets -= 1
                dotSecurity = true
                history.append(" \(temp)")
            }else{
                animation = false
            }
        case "=":
            if previousCame! != "+" && previousCame! != "-" && previousCame! != "^" && previousCame! != "x" && previousCame! != "/" && previousCame! != "%" && previousCame! != "(" && previousCame! != "±"{
                storeValue = PerformOperation()
            }else{
               animation = false
            }
        case "±":
            if storeValue == "0"{
                storeValue = "-0"
                previousCame = "0"
                history.append("-")
                history.append("0")
                dotSecurity = true
            }else if previousCame == "±"{
                var last = ""
                for i in history.reversed(){
                    last = i
                    break
                }
                if last == " -"{
                    storeValue.removeLast()
                    storeValue += "+"
                    history.removeLast()
                    history.append(" +")
                    previousCame = "±"
                    dotSecurity = true
                }else{
                    storeValue.removeLast()
                    storeValue += "-"
                    history.removeLast()
                    history.append(" -")
                    previousCame = "±"
                    dotSecurity = true
                }
            }else if previousCame! == "+" || previousCame! == "-" || previousCame! == "^" || previousCame! == "x" || previousCame! == "/" || previousCame! == "%" || previousCame! == "("{
                storeValue += " -"
                history.append(" -")
                previousCame = "±"
                dotSecurity = true
            }else{
                animation = false
            }
            
        default: break
        }
        return storeValue
    }
    //TODO:  label(count of elements) , = like last operation , GITHUB
    var resultClosure: ((Double?, Error?) -> Void)?
    
    
    func factorial(_ factorial: Factorial)->String{
        let temp = String(describing: factorial.rawValue)
        if let _ = Int(previousCame!) {
            storeValue += " " + temp
            dotSecurity = true
            previousCame = temp
            history.append(" \(temp)")
        }else if previousCame! == "π" || previousCame! == "e"{
            storeValue += " " + temp
            dotSecurity = true
            previousCame = temp
            history.append(" \(temp)")
        }else{
            animation = false
        }
        return storeValue
    }
    func constants(_ constants: Constants)->String{
        //
        let temp = String(describing: constants.rawValue)
        var newOperand:String? = "0"
        switch temp{
        case "π":
             newOperand = String(Double.pi)
        case "e":
             newOperand = String(M_E)
        default: break
        }
        if previousCame! == "+" || previousCame! == "-" || previousCame! == "^" || previousCame! == "x" || previousCame! == "/" || previousCame! == "%" || previousCame! == "("{
            storeValue += " " + newOperand!
            dotSecurity = false
            history.append(" \(newOperand!)")
            previousCame = String(newOperand!.removeLast())
        }else if storeValue == "0" {
            storeValue = newOperand!
            dotSecurity = false
            history.append("\(newOperand!)")
            previousCame = String(newOperand!.removeLast())
        }else if previousCame! == "±"{
            storeValue += newOperand!
            dotSecurity = false
            history.append("\(newOperand!)")
            previousCame = String(newOperand!.removeLast())
        }else{            animation = false
        }
        return storeValue
    }
    
    
    
   
    
    //function for choosen of animation
    public func Animation()->Bool{
        defer{
            animation = true
        }
        return animation
    }



}
