//
//  ViewController.swift
//  Shapely
//
//  Created by John Alstru on 9/13/15.
//  Copyright (c) 2015 nilpoint.sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let colors = [ UIColor.redColor(), UIColor.greenColor(),
    UIColor.blueColor(), UIColor.yellowColor(),
    UIColor.purpleColor(), UIColor.orangeColor(),
    UIColor.grayColor(), UIColor.whiteColor() ]

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func addShape(sender: AnyObject!) {
    if let button = sender as? UIButton {
      if let shapeSelector = ShapeSelector(rawValue: button.tag) {
        let shapeView = ShapeView(shape: shapeSelector)
        shapeView.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        view.addSubview(shapeView)
        
        var shapeFrame = shapeView.frame
        let safeRect = CGRectInset(view.bounds, shapeFrame.width, shapeFrame.height)
        
        var randomCenter = safeRect.origin
        randomCenter.x += CGFloat(arc4random_uniform(UInt32(safeRect.width)))
        randomCenter.y += CGFloat(arc4random_uniform(UInt32(safeRect.height)))
        shapeView.center = randomCenter
        
        let pan = UIPanGestureRecognizer(target: self, action: "moveShape:")
        pan.maximumNumberOfTouches = 1
        shapeView.addGestureRecognizer(pan)
        
        let pin = UIPinchGestureRecognizer(target: self, action: "resizeShape:")
        shapeView.addGestureRecognizer(pin)
      }
    }
  }
  
  func moveShape(gesture: UIPanGestureRecognizer) {
    if let shapeView = gesture.view as? ShapeView {
      let dragDelta = gesture.translationInView(shapeView.superview!)
      switch gesture.state {
      case .Began, .Changed:
        shapeView.transform = CGAffineTransformMakeTranslation(dragDelta.x, dragDelta.y)
        break;
      case .Ended:
        shapeView.transform = CGAffineTransformIdentity
        shapeView.frame = CGRectOffset(shapeView.frame, dragDelta.x, dragDelta.y)
        break;
      default:
        shapeView.transform = CGAffineTransformIdentity
      }
    }
  }
  
  func resizeShape(gesture: UIPinchGestureRecognizer) {
    if let shapeView = gesture.view as? ShapeView {
      let pinchScale = gesture.scale
      switch gesture.state {
      case .Began, .Changed:
        shapeView.transform = CGAffineTransformMakeScale(pinchScale, pinchScale)
        break;
      case .Ended:
        shapeView.transform = CGAffineTransformIdentity
        var frame = shapeView.frame
        let xDelta = frame.width * pinchScale - frame.width
        let yDelta = frame.height * pinchScale - frame.height
        frame.size.width += xDelta
        frame.size.height += yDelta
        frame.origin.x -= xDelta/2
        frame.origin.y -= yDelta/2
        shapeView.frame = frame
        shapeView.setNeedsDisplay()
        break;
      default:
        shapeView.transform = CGAffineTransformIdentity
      }
    }
  }

}

