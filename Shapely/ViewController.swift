//
//  ViewController.swift
//  Shapely
//
//  Created by John Alstru on 9/13/15.
//  Copyright (c) 2015 nilpoint.sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
      let shapeView = ShapeView(shape: .Square)
      view.addSubview(shapeView)
      
      var shapeFrame = shapeView.frame
      let safeRect = CGRectInset(view.bounds, shapeFrame.width, shapeFrame.height)
      
      var randomCenter = safeRect.origin
      randomCenter.x += CGFloat(arc4random_uniform(UInt32(safeRect.width)))
      randomCenter.y += CGFloat(arc4random_uniform(UInt32(safeRect.height)))
      shapeView.center = randomCenter
    }
  }

}

