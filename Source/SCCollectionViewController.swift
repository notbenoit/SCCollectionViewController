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

public
class SCCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Set the cell margin (spacing between lines, columns, and left/right borders of the collectionview). Default to 5
    public var cellMargin: CGFloat = 5
    // Set the cell height. default to 120.
    public var cellHeight: CGFloat = 120
    // Set the base height for the header (height when not scaled up).
    public var headerBaseHeight: CGFloat = 170
    
    /**
    You must override this method to provide the number of cells to show below the header.
    */
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("You must override this dataSource method")
    }
    
    /**
    You must override this method to configure the header view as you like.
    
    :param: header The recycled UICollectionReusableView.
    */
    public func configureHeader(header: UICollectionReusableView) {
        fatalError("You must override this method to configure the header view as you like.")
    }
    
    /**
    You must override this method to configure the cells to your convenience.
    
    :param: cell        The recycled UICollectionViewCell.
    :param: indexPath   The corresponding indexPath.
    */
    public func configureCell(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        fatalError("You must override this method to configure the cells as you like.")
    }
    
    private let reuseIdentifier = "Cell"
    private let headerReuseIdentifier = "Header"
    private var growingHeader: UIView?
    private let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    private let headerMask = UIView()
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Configure UICollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = self.view.bounds
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.clipsToBounds = false
        
        // Let the scrollview go under navigationBar.
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Hide the navigation bar at first
        if let unwrappedNavigationController = self.navigationController {
            unwrappedNavigationController.navigationBar.alpha = 0
        }
        
        headerMask.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let unwrappedNavigationController = self.navigationController {
            self.transitionCoordinator()?.animateAlongsideTransition({ (context) -> Void in
                unwrappedNavigationController.navigationBar.alpha = 0
                }, completion: nil)
        }
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let unwrappedNavigationController = self.navigationController {
            self.transitionCoordinator()?.animateAlongsideTransition({ (context) -> Void in
                unwrappedNavigationController.navigationBar.alpha = 1
                }, completion: nil)
        }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = self.view.bounds
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    final public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let numColumns: CGFloat = 1
        let edgeInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAtIndex: indexPath.section)
        let spacingLeft = edgeInset.left
        let spacingRight = edgeInset.right
        let width = (collectionView.bounds.size.width - spacingLeft - spacingRight - cellMargin*(numColumns-1)) / numColumns
        return CGSize(width: width, height: cellHeight)
    }
    
    final public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
    }
    
    final public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    final public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    final public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: headerBaseHeight)
    }
    
    // MARK: UICollectionViewDataSource
    
    final public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    final public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        // Configure the cell
        cell.backgroundColor = UIColor.clearColor()
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    final public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if (kind == UICollectionElementKindSectionHeader) {
            let supplementaryView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, forIndexPath: indexPath) as! UICollectionReusableView
            
            growingHeader = supplementaryView as UIView
            growingHeader!.clipsToBounds = false
            growingHeader!.backgroundColor = UIColor.clearColor()
            
            configureHeader(supplementaryView)
            
            growingHeader!.maskView = headerMask
            adjustHeaderMaskWithScrollOffset(collectionView.contentOffset.y)
            
            return supplementaryView
        }
        return UICollectionReusableView()
    }
    
    final public func scrollViewDidScroll(scrollView: UIScrollView) {
        if let unwrapperGrowingHeader = growingHeader {
            let scrollOffset = scrollView.contentOffset.y
            let scale = 1 + (min(0, scrollOffset * 0.011)) * (-1.0)
            var transform = CGAffineTransformMakeScale(scale, scale)
            if (scrollOffset <= 0) {
                transform = CGAffineTransformTranslate(transform, 0, min(0, scrollOffset*0.1))
            } else {
                transform = CGAffineTransformTranslate(transform, 0, min(scrollOffset*0.5, 60))
            }
            unwrapperGrowingHeader.transform = transform
            adjustHeaderMaskWithScrollOffset(scrollOffset)
            
            if let unwrappedNavigationController = self.navigationController {
                let barAlpha = max(0, min(1, (scrollOffset/80)))
                unwrappedNavigationController.navigationBar.alpha = barAlpha
            }
        }
    }
    
    private func adjustHeaderMaskWithScrollOffset(offset: CGFloat) {
        // Find bottom of header without growing effect
        let maskBottom = self.view.convertPoint(CGPoint(x: 0, y: headerBaseHeight-offset), toView: growingHeader)
        // We set appropriate frame to clip the header
        headerMask.frame = CGRect(origin: CGPoint(x: 0, y: maskBottom.y - collectionView.bounds.size.height), size: collectionView.bounds.size)
    }
}
