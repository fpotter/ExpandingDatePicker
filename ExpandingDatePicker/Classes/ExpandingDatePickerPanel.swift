//  Created by Fred Potter on 03/29/2019.
//  Copyright (c) 2019 Fred Potter. All rights reserved.

import AppKit
import ObjectiveC

class ExpandingDatePickerPanel: NSPanel {
    weak var datePicker: ExpandingDatePicker?

    override var canBecomeKey: Bool {
        return true
    }

    override func resignKey() {
        super.resignKey()
        datePicker?.dismissExpandingPanel()
    }

    override func cancelOperation(_ sender: Any?) {
        datePicker?.dismissExpandingPanel(refocusDatePicker: true)
    }

    override func selectNextKeyView(_ sender: Any?) {
        datePicker?.dismissExpandingPanel()
        if let nextKeyView = datePicker?.nextKeyView {
            datePicker?.window?.makeFirstResponder(nextKeyView)
        }
    }

    override func selectPreviousKeyView(_ sender: Any?) {
        datePicker?.dismissExpandingPanel()
        if let previousKeyView = datePicker?.previousKeyView {
            datePicker?.window?.makeFirstResponder(previousKeyView)
        }
    }
}
