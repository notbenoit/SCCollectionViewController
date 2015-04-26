// Copyright (c) 2015 Benoit Layer
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
