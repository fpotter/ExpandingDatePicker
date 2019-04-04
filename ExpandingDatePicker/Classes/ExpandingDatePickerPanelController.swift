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
    let datePickerTextual: InternalDatePicker
    let datePickerGraphical: NSDatePicker

    init(sourceDatePicker: ExpandingDatePicker) {
        datePickerTextual = InternalDatePicker(frame: .zero)
        datePickerTextual.datePickerMode = .single
        datePickerTextual.datePickerStyle = .textField
        datePickerTextual.datePickerElements = .yearMonthDay
        datePickerTextual.controlSize = sourceDatePicker.controlSize
        datePickerTextual.font = sourceDatePicker.font
        datePickerTextual.calendar = sourceDatePicker.calendar
        datePickerTextual.timeZone = sourceDatePicker.timeZone
        datePickerTextual.minDate = sourceDatePicker.minDate
        datePickerTextual.maxDate = sourceDatePicker.maxDate
        datePickerTextual.sizeToFit()
        datePickerTextual.drawsBackground = false
        datePickerTextual.isBordered = false
        datePickerTextual.isEnabled = true
        datePickerTextual.expandingDatePicker = sourceDatePicker

        datePickerGraphical = NSDatePicker(frame: .zero)
        datePickerGraphical.datePickerMode = .single
        datePickerGraphical.datePickerStyle = .clockAndCalendar
        datePickerGraphical.datePickerElements = .yearMonthDay
        datePickerGraphical.sizeToFit()
        datePickerGraphical.drawsBackground = false
        datePickerGraphical.isBordered = false
        datePickerGraphical.isEnabled = true
        datePickerGraphical.calendar = sourceDatePicker.calendar
        datePickerGraphical.timeZone = sourceDatePicker.timeZone
        datePickerGraphical.minDate = sourceDatePicker.minDate
        datePickerGraphical.maxDate = sourceDatePicker.maxDate

        datePickerTextual.bind(.value,
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

        // Replicate any bindings so that changing the date will immediately update
        // the bounded obj+keyPath.
        for bindingName in sourceDatePicker.exposedBindings {
            guard let bindingInfo = sourceDatePicker.infoForBinding(bindingName) else {
                continue
            }

            guard let keyPath = bindingInfo[.observedKeyPath] as? String,
                let object = bindingInfo[.observedObject] else {
                    continue
            }
            let options = bindingInfo[.options] as? [NSBindingOption: Any]

            datePickerTextual.bind(bindingName,
                                   to: object,
                                   withKeyPath: keyPath,
                                   options: options)
            datePickerGraphical.bind(bindingName,
                                   to: object,
                                   withKeyPath: keyPath,
                                   options: options)
        }

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let stack = NSStackView(views: [datePickerTextual, datePickerGraphical])
        stack.spacing = 0
        stack.orientation = .vertical
        stack.alignment = .left

        // Force layout now so the `bounds` will be true.
        stack.needsLayout = true
        stack.layoutSubtreeIfNeeded()

        let backdropView = ExpandingDatePickerPanelBackdropView(frame: stack.bounds,
                                                                 datePickerTextual: datePickerTextual,
                                                                 datePickerGraphical: datePickerGraphical)
        backdropView.addSubview(stack)
        view = backdropView
    }
}

