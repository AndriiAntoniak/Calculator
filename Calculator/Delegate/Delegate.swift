//
//  Delegate.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation

protocol InputInterfaceDelegate	{
    func DigitPressed(_ value: MyButton)
    func OperationPressed(_ operation: MyButton)
    func FunctionPressed(_ function: MyButton)
    func UtilityPressed(_ utility: MyButton)
    func MemoryPressed(_ memory: MyButton)
    func FactorialPressed(_ factorial: MyButton)
    func ConstantsPressed(_ constants: MyButton)
}
