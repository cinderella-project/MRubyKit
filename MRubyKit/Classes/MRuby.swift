import libmruby

@dynamicMemberLookup
public class MRuby {
    let mrb = mrb_open()
    
    public init() {
    }
    
    deinit {
        mrb_close(mrb)
    }
    
    public func eval(source: String) -> MRubyValue {
        return MRubyValue(from: mrb_load_string(mrb, source), by: self)
    }
    
    func symbol(name: String) -> mrb_sym {
        return mrb_intern_cstr(mrb, name)
    }
    
    public var Object: MRubyValue {
        return .init(from: mrb_obj_value(mrb!.pointee.object_class), by: self)
    }
    
    public subscript(dynamicMember name: String) -> MRubyValue {
        return .init(from: mrb_gv_get(mrb, symbol(name: name)), by: self)
    }
    
}

extension MRuby: MRubyConstantVariablePrecedenceCompatible {
    public func constant(_ name: String) -> MRubyValue {
        return MRubyValue(from: mrb_vm_const_get(mrb, symbol(name: name)), by: self)
    }
}
