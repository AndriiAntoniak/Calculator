//
//  Protocols.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/11/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation

protocol InputInterface{
    func symbolPressed(_ symbol: MyButton)
}

protocol OutputInterface {
    func display(_ result: String)
}

protocol CalculatorInterface {
    func digit(_ value: String)->String
    func operation(_ operation: Operation)->String
    func function(_ function: Function)->String
    func memory(_ memory: Memory)->String
    func utility(_ utility: Utility)->String
    //
    func factorial(_ factorial: Factorial)->String
    func constants(_ constants: Constants)->String
}
