//
//  SCCollectionViewController.swift
//  SCCollectionViewController
//
//  Created by Benoit Layer on 24/04/2015.
//  Copyright (c) 2015 Benoit Layer. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"
let headerReuseIdentifier = "Header"

public
class SCCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Set the cell margin (spacing between lines, columns, and left/right borders of the collectionview). Default to 5
    public var cellMargin: CGFloat = 5
    // Set the cell height. default to 120.
    public var cellHeight: CGFloat = 120
    // Set the base height for the header (height when not scaled up).
    public var headerBaseHeight: CGFloat = 170
    
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "button_back"), style: .Plain, target: self, action: "back:")
        
        headerMask.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
    }
    
    func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.transitionCoordinator()?.animateAlongsideTransition({ (context) -> Void in
            self.navigationController!.navigationBar.alpha = 0
            }, completion: nil)
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.transitionCoordinator()?.animateAlongsideTransition({ (context) -> Void in
            self.navigationController!.navigationBar.alpha = 1
            }, completion: nil)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = self.view.bounds
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let numColumns: CGFloat = 1
        let edgeInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAtIndex: indexPath.section)
        let spacingLeft = edgeInset.left
        let spacingRight = edgeInset.right
        let width = (collectionView.bounds.size.width - spacingLeft - spacingRight - cellMargin*(numColumns-1)) / numColumns
        return CGSize(width: width, height: cellHeight)
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    // MARK: UICollectionViewDataSource
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 10
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        // Configure the cell
        cell.backgroundColor = UIColor.lightGrayColor()
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: headerBaseHeight)
    }
    
    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if (kind == UICollectionElementKindSectionHeader) {
            let supplementaryView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, forIndexPath: indexPath) as! UICollectionReusableView
            
            growingHeader = supplementaryView as UIView
            growingHeader!.clipsToBounds = false
            growingHeader!.backgroundColor = UIColor.lightGrayColor()
            
            var imageView: UIImageView? = supplementaryView.viewWithTag(0) as? UIImageView
            if let unwrappedImageView = imageView {
                
            } else {
                imageView = UIImageView(frame: supplementaryView.bounds)
                imageView!.image = UIImage(named: "town")
                supplementaryView.addSubview(imageView!)
            }
            
            growingHeader!.maskView = headerMask
            adjustHeaderMaskWithScrollOffset(collectionView.contentOffset.y)
            
            return supplementaryView
        }
        return UICollectionReusableView()
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
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
            
            let barAlpha = max(0, min(1, (scrollOffset/80)))
            self.navigationController?.navigationBar.alpha = barAlpha
        }
    }
    
    private func adjustHeaderMaskWithScrollOffset(offset: CGFloat) {
        // Find bottom of header without growing effect
        let maskBottom = self.view.convertPoint(CGPoint(x: 0, y: headerBaseHeight-offset), toView: growingHeader)
        // We set appropriate frame to clip the header
        headerMask.frame = CGRect(origin: CGPoint(x: 0, y: maskBottom.y - collectionView.bounds.size.height), size: collectionView.bounds.size)
    }
    
    
    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
