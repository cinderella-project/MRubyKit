//
//  MRubyConstantVariablePrecedence.swift
//  Pods
//
//  Created by user on 2020/09/07.
//

import Foundation

public protocol MRubyConstantVariablePrecedenceCompatible {
    func constant(_ value: String) -> MRubyValue
}

infix operator ..: MRubyConstantVariablePrecedence

precedencegroup MRubyConstantVariablePrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
}

public func ..(left: MRubyConstantVariablePrecedenceCompatible, right: String) -> MRubyValue {
    return left.constant(right)
}
