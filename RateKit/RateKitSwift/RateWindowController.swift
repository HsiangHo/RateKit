//
//  RateWindowController.swift
//  RateKitSwift
//
//  Created by thierryH24 on 14/11/2018.
//  Copyright © 2018 thierryH24. All rights reserved.
//

import AppKit

final class RateWindowController: NSWindowController {
    
    enum RateWindowPosition : Int {
        case center
        case topRight
        case topLeft
    }
    enum RateResult : Int {
        case rated
        case later
        case timeout
    }
    
    typealias RateCompletionCallback = (RateResult) -> Void
    
    var configure: RateConfigure!
    var ivIcon: NSImageView!
    var lbName: NSTextField!
    var lbDetailText: NSTextField!
    var btnLike: NSButton!
    var btnIgnore: NSButton!
    var nTimeout: Int = 0
    var block: RateCompletionCallback!
    
    init(configure: RateConfigure) {

        self.configure = configure
        
        super.init(window: nil)
        self.initializeRateWindowController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func requestRateWindow(_ pos: RateWindowPosition, with block: @escaping RateCompletionCallback) {
        self.block = block
        window?.orderOut(nil)
        let nGap: CGFloat = 10
        let rctScreen: NSRect? = NSScreen.main?.visibleFrame
        var rctTmpWnd: NSRect = (window?.frame)!
        var rctWnd: NSRect = (window?.frame)!
        
        switch pos {
        case .topLeft:
            rctTmpWnd.origin.x = NSMinX(rctScreen!) - NSWidth(rctWnd)
            rctTmpWnd.origin.y = NSMaxY(rctScreen!) - NSHeight(rctWnd) - CGFloat(nGap)
            window?.makeKeyAndOrderFront(nil)
            window?.setFrame(rctTmpWnd, display: false)
            rctWnd.origin.x = NSMinX(rctScreen!) + nGap
            rctWnd.origin.y = NSMaxY(rctScreen!) - NSHeight(rctWnd) - nGap
            window?.animator().setFrame(rctWnd, display: true)
            
        case .topRight:
            rctTmpWnd.origin.x = NSMaxX(rctScreen!)
            rctTmpWnd.origin.y = NSMaxY(rctScreen!) - NSHeight(rctWnd) - nGap
            window?.makeKeyAndOrderFront(nil)
            window?.setFrame(rctTmpWnd, display: false)
            rctWnd.origin.x = NSMaxX(rctScreen!) - NSWidth(rctWnd) - nGap
            rctWnd.origin.y = NSMaxY(rctScreen!) - NSHeight(rctWnd) - nGap
            window?.animator().setFrame(rctWnd, display: true)
        
        case .center:
            window?.makeKeyAndOrderFront(nil)
            window?.center()
        }
        
        if nTimeout > 0 {
            perform(#selector(self.timeoutFunc), with: nil, afterDelay: TimeInterval(nTimeout))
        }
    }
    
    @IBAction func likeButton_click(_ sender: Any) {
        if nil != configure?.rateURL {
            NSWorkspace.shared.open(configure!.rateURL!)
        }
        window?.orderOut(nil)
        if block != nil {
            block!(.rated)
        }
    }
    
    @IBAction func ignoreButton_click(_ sender: Any) {
        window?.orderOut(nil)
        if block !=  nil {
            block!(.later)
        }
    }
    
    // MARK: - private methods
    func initializeRateWindowController() {
        
        nTimeout = 0
        block = nil
        let rctWindow: NSRect = NSMakeRect(0, 0, 210, 306)
        let window = NSWindow(contentRect: rctWindow, styleMask: [.titled, .fullSizeContentView], backing: .buffered, defer: true)
        self.window = window
        window.level = .floating
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.isMovableByWindowBackground = true
        window.center()
        window.backgroundColor = NSColor.white
        
        ivIcon = NSImageView(frame: NSMakeRect((NSWidth(rctWindow) - 64) / 2, NSHeight(rctWindow) - 86, 64, 64))
        ivIcon.imageScaling = .scaleAxesIndependently
        window.contentView?.addSubview(ivIcon)
        ivIcon.image = configure?.icon
        
        lbName = NSTextField(frame: NSMakeRect(0, NSMinY(ivIcon.frame) - 40, NSWidth(rctWindow), 30))
        lbName.isEditable = false
        lbName.isBezeled = false
        lbName.isSelectable = false
        lbName.textColor = NSColor(calibratedRed: 80 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 1.0)
        lbName.backgroundColor = NSColor.clear
        lbName.font = NSFont(name: "HelveticaNeue", size: 21)
        lbName.alignment = .center
        lbName.stringValue = (configure?.name)!
        window.contentView?.addSubview(lbName)
        
        lbDetailText = NSTextField(frame: NSMakeRect(35, NSMinY(lbName.frame) - 100, NSWidth(rctWindow) - 70, 90))
        lbDetailText.isEditable = false
        lbDetailText.isBezeled = false
        lbDetailText.isSelectable = false
        lbDetailText.textColor = NSColor.gray
        lbDetailText.backgroundColor = NSColor.clear
        lbDetailText.font = NSFont(name: "HelveticaNeue", size: 12)
        lbDetailText.lineBreakMode = .byWordWrapping
        lbDetailText.stringValue = (configure?.detailText)!
        window.contentView?.addSubview(lbDetailText)
        
        btnLike = NSButton(frame: NSMakeRect(30, NSMinY(lbDetailText.frame) - 50, NSWidth(rctWindow) - 60, 40))
        btnLike?.title = (configure?.likeButtonTitle)!
        btnLike.bezelStyle = .rounded
        btnLike.font = NSFont(name: "HelveticaNeue", size: 15)
        btnLike.keyEquivalent = "\r"
        btnLike.target = self
        btnLike.action = #selector(self.likeButton_click(_:))
        window.contentView?.addSubview(btnLike)
        
        btnIgnore = NSButton(frame: NSMakeRect(30, NSMinY(btnLike.frame) - 10, NSWidth(rctWindow) - 60, 15))
        let color = NSColor.lightGray
        let title = configure?.ignoreButtonTitle
        let colorTitle = NSMutableAttributedString(string: title!)
        colorTitle.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: title!.count))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        colorTitle.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: (title?.count)!))
        if let aSize = NSFont(name: "HelveticaNeue", size: 11) {
            colorTitle.addAttribute(.font, value: aSize, range: NSRange(location: 0, length: (title?.count)!))
        }
        btnIgnore.attributedTitle = colorTitle
        btnIgnore.target = self
        btnIgnore.action = #selector(self.ignoreButton_click(_:))
        btnIgnore.bezelStyle = .roundRect
        btnIgnore.isBordered = false
        window.contentView?.addSubview(btnIgnore)
    }
    
    @objc func timeoutFunc() {
        if (window?.isVisible)! {
            window?.orderOut(nil)
            if block != nil {
                block!(.timeout)
            }
        }
    }
}
