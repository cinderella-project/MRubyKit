//
//  MRubyValue.swift
//  Pods
//
//  Created by user on 2020/09/07.
//

import libmruby

@dynamicMemberLookup
public class MRubyValue: CustomStringConvertible {
    let mruby: MRuby
    let internalValue: mrb_value
    
    init(from internalValue: mrb_value, by mruby: MRuby) {
        self.internalValue = internalValue
        self.mruby = mruby
        mrb_gc_register(mruby.mrb, internalValue)
    }
    
    deinit {
        mrb_gc_unregister(mruby.mrb, internalValue)
    }
    
    public var description: String {
        let arenaIndex = mrb_gc_arena_save(mruby.mrb)
        let descValue = mrb_str_to_str(mruby.mrb, internalValue)
        let desc = mrb_str_to_cstr(mruby.mrb, descValue)!
        // String(cString:) は内容をコピーするので mruby 側の GC に捨てられてもよい
        // また Retured string will be freed automatically on next GC. とのことなので恐らく自分でfreeする必要はない
        let swiftDesc = String(cString: desc)
        mrb_gc_arena_restore(mruby.mrb, arenaIndex)
        return swiftDesc
    }
    
    public subscript(dynamicMember name: String) -> MRubyDynamicCallableKeyPath {
        return .init(mruby: mruby, value: self, name: name)
    }
    
}

extension MRubyValue: MRubyConstantVariablePrecedenceCompatible {
    public func constant(_ name: String) -> MRubyValue {
        return MRubyValue(from: mrb_const_get(mruby.mrb, internalValue, mruby.symbol(name: name)), by: mruby)
    }
}
