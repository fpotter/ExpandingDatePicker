//
//  ViewController.swift
//  ExpandingDatePicker
//
//  Created by Fred Potter on 03/29/2019.
//  Copyright (c) 2019 Fred Potter. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var firstDatePicker: NSDatePicker!

    @objc dynamic var date: Date = { Calendar.current.date(from: DateComponents(year: 2019, month: 1, day: 1))!}()
    {
        didSet {
            print("Date set: \(date)")
        }
    }

    @IBAction func firstDatePickerChanged(_ sender: NSDatePicker) {
        assert(sender === firstDatePicker)
        print("first date picker changed: \(sender.dateValue)")
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

