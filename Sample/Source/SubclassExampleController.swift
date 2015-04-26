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
import SCCollectionViewController

class SubclassExampleController: SCCollectionViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We want something fashion as our back button :)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "button_back"), style: .Plain, target: self, action: "back:")
    }
    
    func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func configureHeader(header: UICollectionReusableView) {
        // Since the header is recycled, I check for the existence of the imageview.
        var imageView: UIImageView? = header.viewWithTag(0) as? UIImageView
        if let unwrappedImageView = imageView {
            
        } else {
            imageView = UIImageView(frame: header.bounds)
            imageView!.image = UIImage(named: "town")
            header.addSubview(imageView!)
        }
    }
    
    override func configureCell(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        // Simple cell with just a background color.
        cell.backgroundColor = UIColor.lightGrayColor()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Let's say we want 10 cells for the demo.
        return 10
    }
}
