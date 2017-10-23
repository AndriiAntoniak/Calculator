//
//  Delegate.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation

protocol InputInterfaceDelegate	{
    func digitPressed(_ value: MyButton)
    func operationPressed(_ operation: MyButton)
    func functionPressed(_ function: MyButton)
    func utilityPressed(_ utility: MyButton)
    func memoryPressed(_ memory: MyButton)
    func factorialPressed(_ factorial: MyButton)
    func constantsPressed(_ constants: MyButton)
}
