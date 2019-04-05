//  Created by Fred Potter on 03/29/2019.
//  Copyright (c) 2019 Fred Potter. All rights reserved.

import AppKit

open class ExpandingDatePicker: NSDatePicker {
    var panel: ExpandingDatePickerPanel!

    var isRefocusingToSourceDatePicker = false

    override open func becomeFirstResponder() -> Bool {
        if isRefocusingToSourceDatePicker {
            return super.becomeFirstResponder()
        } else {
            displayPanel()
            return false
        }
    }

    func displayPanel() {
        assert(panel == nil)
        let controller = ExpandingDatePickerPanelController(sourceDatePicker: self)
        let controllerViewSize = controller.view.frame.size

        let frameInWindow = convert(bounds, to: nil)
        let frameInScreen = window!.convertToScreen(frameInWindow)
        let distanceFromTopOfControllerViewToBottomEdgeOfTextualPicker =
            (controller.view.frame.height - controller.datePickerTextual.frame.minY)

        // Make the bottom edge of the textual date picker in the panel line up exactly
        // with the bottom edge of the source date picker. This way, the text won't appear
        // to jump around on expansion.
        let panelContentRect = NSRect(x: frameInScreen.minX,
                                      y: frameInScreen.minY - controllerViewSize.height + distanceFromTopOfControllerViewToBottomEdgeOfTextualPicker,
                                      width: controllerViewSize.width,
                                      height: controllerViewSize.height)

        panel = ExpandingDatePickerPanel(
            contentRect: panelContentRect,
            styleMask: .borderless,
            backing: .buffered,
            defer: true)
        panel.backgroundColor = NSColor.clear
        panel.isOpaque = false
        panel.hasShadow = true
        panel.hidesOnDeactivate = false
        panel.isMovableByWindowBackground = false
        panel.contentViewController = controller
        panel.sourceDatePicker = self

        // Unfortunatley, when this panel gets shown as a child window via
        // -[NSWindow addChildWindow:ordered:] and made key, the traffic lights in
        // the parent window will turn gray.  This doesn't happen in Calendar.app
        // because Apple uses a private API to allow the child window to share key-window
        // status with the parent window.  Instead of `-[NSWindow addChildWindow:ordered:]`,
        // Calender uses the private `-[NSWindow addChildWindow:ordered:shareKey:]`.
        //
        // Found in CalendarUI.framework at:
        // -[IIDatePickerWithMiniCal _openCalendarPickerWindowAndConfigureKeyViews]

        // If you want to try the private API, replace the addChildWindow call with
        // the following —
//        let methodSel = Selector(("addChildWindow:ordered:shareKey:"))
//        let methodIMP = class_getMethodImplementation(NSWindow.self, methodSel)
//        let methodFunc = unsafeBitCast(methodIMP, to: (@convention(c)(Any?, Selector?, Any?, Int, Bool) -> Void).self)
//        methodFunc(window!, methodSel, panel, NSWindow.OrderingMode.above.rawValue, true)

        window?.addChildWindow(panel, ordered: .above)

        panel.makeKey()

        alphaValue = 0.0
    }

    private func convertEvent(event: NSEvent, toPanel: NSPanel) -> NSEvent {
        let eventWindow = event.window!

        let locationInScreen = eventWindow.convertToScreen(
            NSRect(x: event.locationInWindow.x,
                   y: event.locationInWindow.y,
                   width: 0,
                   height: 0)).origin
        let locationInPanel = toPanel.convertFromScreen(
            NSRect(x: locationInScreen.x,
                   y: locationInScreen.y,
                   width: 0,
                   height: 0)).origin

        // Convert amd forward the event to the NSDatePicker instance inside the panel.  That way,
        // if someone clicks on the Year field, for example, the panel will open and the Year field
        // will be focused.
        let newEvent = NSEvent.mouseEvent(with: event.type,
                                          location: locationInPanel,
                                          modifierFlags: event.modifierFlags,
                                          timestamp: event.timestamp,
                                          windowNumber: toPanel.windowNumber,
                                          context: nil,
                                          eventNumber: event.eventNumber,
                                          clickCount: event.clickCount,
                                          pressure: event.pressure)!
        return newEvent
    }

    override open func mouseDown(with event: NSEvent) {
        guard isEnabled else {
            return
        }

        if window?.firstResponder === self && panel == nil {
            // To get to this state, the expandable date picker became the first responder,
            // it expanded, the user hit escape, and then focus went back to the plain textual
            // date picker.  If the user clicks in the textfield again, it should re-expand.
            displayPanel()
        }

        let controller = panel!.contentViewController as! ExpandingDatePickerPanelController
        controller.datePickerTextual.mouseDown(with: convertEvent(event: event, toPanel: panel!))
    }

    func dismissExpandingPanel(refocusDatePicker: Bool = false) {
        window?.removeChildWindow(panel)
        panel.orderOut(self)
        panel = nil

        alphaValue = 1.0

        if refocusDatePicker {
            isRefocusingToSourceDatePicker = true
            window?.makeFirstResponder(self)
            isRefocusingToSourceDatePicker = false
        }
    }

    override open func viewWillDraw() {
        super.viewWillDraw()

        if datePickerMode != .single {
            fatalError("ExpandableDatePicker's datePickerMode must be .single")
        }

        if datePickerStyle != .textField && datePickerStyle != .textFieldAndStepper {
            fatalError("ExpandableDatePicker's datePickerStyle must be .textField")
        }

        if datePickerElements != [.yearMonthDay] {
            fatalError("ExpandableDatePicker's datePickerElements must be [.yearMonthDay]")
        }
    }
}

