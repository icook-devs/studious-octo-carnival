//
//  OverlayView.swift
//  OverlayView
//
//  Created by Sambasiva Rao Dodigam on 5/22/17.
//  Copyright © 2017 Kaiser Permanente. All rights reserved.
//

import UIKit

class Overlay: UIView {
    static var currentOverlay: OverlayView?

    static func show(on overlayTarget: UIView,
                     isTrasparent: Bool = true,
                     loadingText: String? = nil,
                     overlayAlpha: CGFloat = 0.68) {
        // Clear it first in case it was already shown
        hide()
        currentOverlay = OverlayView()
        if let overlay = currentOverlay {
            if isTrasparent {
                overlay.alpha = overlayAlpha
            } else {
                overlay.alpha = 1.0
            }
            if let textString = loadingText {
                overlay.label.isHidden = false
                overlay.label.text = textString
            } else {
                overlay.label.isHidden = true
            }

            overlay.frame = overlayTarget.frame
            overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            overlayTarget.addSubview(overlay)
            overlayTarget.bringSubview(toFront: overlay)
        }
    }

    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
        }
    }

}

class OverlayView: UIView {

    var view: UIView!
    @IBOutlet weak var label: UILabel!

    // MARK: init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if self.subviews.count == 0 {
            xibSetup()
        }
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    private func xibSetup() {
        if let loadedView = loadViewFromNib() {
            self.view = loadedView
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
    }

    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OverlayView", bundle: bundle)
        for object in nib.instantiate(withOwner: self, options: nil) {
            if let view: UIView = object as? UIView {
                return view
            }
        }
        return nil
    }

}
