//
//  ViewController.swift
//  ExpandingDatePicker
//
//  Created by Fred Potter on 03/29/2019.
//  Copyright (c) 2019 Fred Potter. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @objc dynamic var date: Date = { Calendar.current.date(from: DateComponents(year: 2019, month: 1, day: 1))!}()
    {
        didSet {
            print("Date set: \(date)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }


}

