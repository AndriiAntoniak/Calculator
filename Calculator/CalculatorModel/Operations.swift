//
//  Operations.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation

enum Operation: String {
    case plus  = "+"
    case minus = "-"
    case mult  = "x"
    case div   = "/"
    case exp   = "^"
    case percent = "%"
}

enum Factorial: String{
    case fact    = "!"
}
enum Function: String {
    case sqrt    = "sqrt"
    case sin     = "sin"
    case cos     = "cos"
    case tan     = "tan"
    case ln      = "ln"
    case lg     = "lg"
}

enum Memory: String {
    case allclean   = "AC"
    case clean        = "C"
}

enum Utility: String {
    case equal = "="
    case sign = "±"
    case dot          = "."
    case leftBracket  = "("
    case rightBracket = ")"
}

enum Constants: String {
    case pi = "π"
    case e  = "e"
}
