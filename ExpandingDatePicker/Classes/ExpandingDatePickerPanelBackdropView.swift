//  Created by Fred Potter on 03/29/2019.
//  Copyright (c) 2019 Fred Potter. All rights reserved.

import AppKit

class ExpandingDatePickerPanelBackdropView: NSView {
    weak var datePickerTextual: NSView!
    weak var datePickerGraphical: NSView!

    init(frame frameRect: NSRect, datePickerTextual: NSView, datePickerGraphical: NSView) {
        super.init(frame: frameRect)
        self.datePickerTextual = datePickerTextual
        self.datePickerGraphical = datePickerGraphical
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func pathAroundViews() -> CGPath {
        let result = CGMutablePath()

        let radius: CGFloat = 4.0

        result.move(to: NSMakePoint(datePickerTextual.frame.minX, datePickerTextual.frame.maxY - radius))
        result.addArc(tangent1End: NSMakePoint(datePickerTextual.frame.minX, datePickerTextual.frame.maxY),
                      tangent2End: NSMakePoint(datePickerTextual.frame.minX + radius, datePickerTextual.frame.maxY),
                      radius: radius)
        result.addLine(to: NSMakePoint(datePickerTextual.frame.maxX - radius, datePickerTextual.frame.maxY))
        result.addArc(tangent1End: NSMakePoint(datePickerTextual.frame.maxX, datePickerTextual.frame.maxY),
                      tangent2End: NSMakePoint(datePickerTextual.frame.maxX, datePickerTextual.frame.maxY - radius),
                      radius: radius)
        result.addLine(to: NSMakePoint(datePickerTextual.frame.maxX, datePickerGraphical.frame.maxY + radius))
        result.addArc(tangent1End: NSMakePoint(datePickerTextual.frame.maxX, datePickerGraphical.frame.maxY),
                      tangent2End: NSMakePoint(datePickerTextual.frame.maxX + radius, datePickerGraphical.frame.maxY),
                      radius: radius)
        result.addLine(to: NSMakePoint(datePickerGraphical.frame.maxX - radius, datePickerGraphical.frame.maxY))
        result.addArc(tangent1End: NSMakePoint(datePickerGraphical.frame.maxX, datePickerGraphical.frame.maxY),
                      tangent2End: NSMakePoint(datePickerGraphical.frame.maxX, datePickerGraphical.frame.maxY - radius),
                      radius: radius)
        result.addLine(to: NSMakePoint(datePickerGraphical.frame.maxX, datePickerGraphical.frame.minY + radius))
        result.addArc(tangent1End: NSMakePoint(datePickerGraphical.frame.maxX, datePickerGraphical.frame.minY),
                      tangent2End: NSMakePoint(datePickerGraphical.frame.maxX - radius, datePickerGraphical.frame.minY),
                      radius: radius)
        result.addLine(to: NSMakePoint(datePickerGraphical.frame.minX + radius, datePickerGraphical.frame.minY))
        result.addArc(tangent1End: NSMakePoint(datePickerGraphical.frame.minX, datePickerGraphical.frame.minY),
                      tangent2End: NSMakePoint(datePickerGraphical.frame.minX, datePickerGraphical.frame.minY + radius),
                      radius: radius)
        result.closeSubpath()
        return result
    }

    override func draw(_ dirtyRect: NSRect) {
        let ctx = NSGraphicsContext.current!.cgContext

        let path = pathAroundViews()
        ctx.saveGState()
        ctx.addPath(path)
        NSColor.controlBackgroundColor.setFill()
        ctx.fillPath()

        NSColor.gridColor.setStroke()
        ctx.setLineWidth(1.0)
        ctx.strokePath()
        ctx.restoreGState()
    }
}

