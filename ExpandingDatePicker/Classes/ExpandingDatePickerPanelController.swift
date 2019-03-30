//  Created by Fred Potter on 03/29/2019.
//  Copyright (c) 2019 Fred Potter. All rights reserved.

import AppKit

class InternalDatePicker: NSDatePicker {
    weak var expandingDatePicker: ExpandingDatePicker?

    override func keyDown(with event: NSEvent) {
        if event.keyCode == 36 || event.keyCode == 76 {
            expandingDatePicker?.dismissExpandingPanel(refocusDatePicker: true)
            return
        } else {
            super.keyDown(with: event)
        }
    }
}

class ExpandingDatePickerPanelController: NSViewController, CALayerDelegate {
    let datePickerText: InternalDatePicker
    let datePickerGraphical: NSDatePicker

    init(sourceDatePicker: ExpandingDatePicker) {
        datePickerText = InternalDatePicker(frame: .zero)
        datePickerText.datePickerMode = .single
        datePickerText.datePickerStyle = .textField
        datePickerText.datePickerElements = .yearMonthDay
        datePickerText.controlSize = sourceDatePicker.controlSize
        datePickerText.font = sourceDatePicker.font
        datePickerText.sizeToFit()
        datePickerText.drawsBackground = false
        datePickerText.isBordered = false
        datePickerText.isEnabled = true
        datePickerText.expandingDatePicker = sourceDatePicker

        datePickerGraphical = NSDatePicker(frame: .zero)
        datePickerGraphical.datePickerMode = .single
        datePickerGraphical.datePickerStyle = .clockAndCalendar
        datePickerGraphical.datePickerElements = .yearMonthDay
        datePickerGraphical.sizeToFit()
        datePickerGraphical.drawsBackground = false
        datePickerGraphical.isBordered = false
        datePickerGraphical.isEnabled = true

        datePickerText.bind(.value,
                            to: sourceDatePicker,
                            withKeyPath: #keyPath(NSDatePicker.dateValue),
                            options: [
                                NSBindingOption.raisesForNotApplicableKeys: true,
                                NSBindingOption.continuouslyUpdatesValue: true,
            ])

        datePickerGraphical.bind(.value,
                                 to: sourceDatePicker,
                                 withKeyPath: #keyPath(NSDatePicker.dateValue),
                                 options: [
                                    NSBindingOption.raisesForNotApplicableKeys: true,
                                    NSBindingOption.continuouslyUpdatesValue: true,
            ])

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let stack = NSStackView(views: [datePickerText, datePickerGraphical])
        stack.spacing = 0
        stack.orientation = .vertical
        stack.alignment = .left

        // Force layout now so the `bounds` will be true.
        stack.needsLayout = true
        stack.layoutSubtreeIfNeeded()

        let backdropView = ExpandingDatePickerPanelBackdropView(frame: stack.bounds,
                                                                 datePickerTextual: datePickerText,
                                                                 datePickerGraphical: datePickerGraphical)
        backdropView.addSubview(stack)
        view = backdropView
    }
}

