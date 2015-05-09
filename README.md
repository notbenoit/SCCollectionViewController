![SCCollectionViewController](https://raw.githubusercontent.com/notbenoit/notbenoit.github.io/master/images/sccollectionviewcontroller/sccollectionviewcontroller.gif)

# SCCollectionViewController
This framework provides a controller to subclass, which presents a UICollectionView with builtin  animations for a growing header (scale effect), a parallax effect, and a navigation bar background which fades in and out as you scroll through the UICollectionView.

## Requirements

- iOS 7.0+ (do not use cocoapods for iOS before 8, since cocoapods forces Swift frameworks to have a iOS8 deployment target)
- Xcode 6.3 (Usage of Swift 1.2)

## Installation

### CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To add `SCCollectionViewController` to your project, add this lines to your  `Podfile`:

```ruby
use_frameworks!
pod 'SCCollectionViewController', '~> 1.0'
```
The flag `use_frameworks!` is used because this framework is entirely written in Swift, and generates a .framework file.

### Manual
- Simply add the `SCCollectionViewController.xcodeproj` to your workspace and add its framework output as a dependency of your project (see the Sample project).
- You can also build the framework and directly link it to your target.

## Usage
### CollectionView layout setup
You can customize some properties to change the appearance of the controller.

* `cellMargin: CGFloat = 5` It's the spacing between two lines, and the edge insets for left and right (left and right margins).
* `cellHeight: CGFloat = 120` Corresponds to the height of every cell.
* `headerBaseHeight: CGFloat = 170` The height of the header when not scaled.


### Growing header and parallax
First, you **MUST** subclass SCCollectionViewController, and provide your own implementation for the following methods :

```swift
func configureCell(cell: UICollectionViewCell, indexPath: NSIndexPath)
func configureHeader(header: UICollectionReusableView)
func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
```

You can also overrides any delegate method which is not declared `final` in the SCCollectionViewController.

Combine this subclass with your views and models, and you'll be able to customize the cells and headers as you like.

 You'll have automatically the growing header, and parallax effects.

### Fading navigation bar
For the fading effect, you'll have to push your SCCollectionViewController in a navigation controller.
Your navigation controller should have a navigation bar of type `SCNavigationBar` because it overrides the alpha property of the UINavigationBar (to only have the background fading, and not the navigation items). If you do not use the SCNavigationBar, the whole bar will fade out and so will the navigation items.

You can set the class of the navigation bar directly in your nib or storyboard file, or when you instantiate your UINavigationController with `init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?)`

## Limitations
Right now, the SCCollectionViewController is made for a single section in the UICollectionView.

## Changelog
### 1.0.1
Used the mask property on CALayer instead of the mnew maskView property of UIView in order to be run on iOS7.0+.

### 1.0.0
Initial version

## Creator

- [Benoît Layer](http://github.com/notbenoit) ([@notbenoit](https://twitter.com/notbenoit))

## License

SCCollectionViewController is released under the MIT license. See LICENSE for details.
