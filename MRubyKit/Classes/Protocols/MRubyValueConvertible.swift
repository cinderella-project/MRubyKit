//
//  MRubyValueConvertible.swift
//  Pods
//
//  Created by user on 2020/09/07.
//

import libmruby

public protocol MRubyValueConvertible {
    func convertToMRubyValue(with mruby: MRuby) -> MRubyValue
}

extension MRubyValue: MRubyValueConvertible {
    public func convertToMRubyValue(with mruby: MRuby) -> MRubyValue {
        return self
    }
}

extension String: MRubyValueConvertible {
    public func convertToMRubyValue(with mruby: MRuby) -> MRubyValue {
        return MRubyValue(from: mrb_str_new_cstr(mruby.mrb, self), by: mruby)
    }
}

