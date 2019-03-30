//  Created by Fred Potter on 03/29/2019.
//  Copyright (c) 2019 Fred Potter. All rights reserved.

import AppKit

class ExpandingDatePickerPanel: NSPanel {
    weak var sourceDatePicker: ExpandingDatePicker?

    override var canBecomeKey: Bool {
        return true
    }

    override func resignKey() {
        super.resignKey()
        sourceDatePicker?.dismissExpandingPanel()
    }

    override func cancelOperation(_ sender: Any?) {
        sourceDatePicker?.dismissExpandingPanel(refocusDatePicker: true)
    }

    override func selectNextKeyView(_ sender: Any?) {
        sourceDatePicker?.dismissExpandingPanel()
        if let nextKeyView = sourceDatePicker?.nextKeyView {
            sourceDatePicker?.window?.makeFirstResponder(nextKeyView)
        }
    }

    override func selectPreviousKeyView(_ sender: Any?) {
        sourceDatePicker?.dismissExpandingPanel()
        if let previousKeyView = sourceDatePicker?.previousKeyView {
            sourceDatePicker?.window?.makeFirstResponder(previousKeyView)
        }
    }
}
