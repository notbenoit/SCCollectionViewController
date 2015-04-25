//
//  SCNavigationBar.swift
//  GHCollectionViewController
//
//  Created by Benoit Layer on 24/04/2015.
//  Copyright (c) 2015 Benoit Layer. All rights reserved.
//

import UIKit

/**
 * I did not override drawRect: to draw the background with a custom alpha, because
 * the rect passed as a paramterer to drawRect: does not
 * cover the status bar space
 *
 * Use this navigation bar as a standard navigation bar. The only thing
 * is that setting its alpha will only set the alpha of the bar background.
 * It takes the current barTintColor and creates a background with
 * corresponding alpha.
 **/

class SCNavigationBar: UINavigationBar {
    
    // Setting the alpha of the status bar only changes the background.
    override var alpha: CGFloat {
        get {
            return 1.0
        }
        set {
            self.setBackgroundImage(createImageBackgroundWithAlpha(newValue), forBarMetrics: UIBarMetrics.Default)
            self.shadowImage = UIImage()
        }
    }
    
    private func createImageBackgroundWithAlpha(alpha: CGFloat) -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        let color = CGColorCreateCopyWithAlpha(self.barTintColor?.CGColor, alpha)
        CGContextSetFillColorWithColor(context, color)
        CGContextFillRect(context, rect);
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        return img
    }
}
