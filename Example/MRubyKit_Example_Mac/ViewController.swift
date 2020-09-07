//
//  ViewController.swift
//  MRubyKit_Example_Mac
//
//  Created by user on 2020/09/07.
//

import Cocoa
import MRubyKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mrb = MRuby()
        mrb.eval(source: "a = 1 + 2")
        let hoge = mrb.eval(source: "class Hoge; attr_accessor :a; def initialize(); @a = 5; end; end; Hoge")
        print(hoge.new.a())
        mrb.Object.printf("Ruby Version: %s\n", (mrb.."RUBY_VERSION"))
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

