//
//  MRubyDynamicCallableKeyPath.swift
//  Pods
//
//  Created by user on 2020/09/07.
//

import libmruby

@dynamicCallable
@dynamicMemberLookup
public struct MRubyDynamicCallableKeyPath {
    let mruby: MRuby
    let value: MRubyValue
    let name: String
    
    public subscript(dynamicMember name: String) -> MRubyDynamicCallableKeyPath {
        return .init(mruby: mruby, value: self(), name: name)
    }
    
    public func dynamicallyCall(withArguments args: [MRubyValueConvertible]) -> MRubyValue {
        let val = mrb_funcall_argv(mruby.mrb, value.internalValue, mruby.symbol(name: name), mrb_int(args.count), args.map { $0.convertToMRubyValue(with: mruby).internalValue })
        return MRubyValue(from: val, by: mruby)
    }
}
