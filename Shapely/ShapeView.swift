//
//  ShapeView.swift
//  Shapely
//
//  Created by John Alstru on 9/13/15.
//  Copyright (c) 2015 nilpoint.sample. All rights reserved.
//

import UIKit

enum ShapeSelector : Int {
  case Square = 1
  case Rectangle
  case Circle
  case Oval
  case Triangle
  case Star
  
}

class ShapeView : UIView {
  let initialSize = CGSize(width: 100.0, height: 100.0)
  let alternateHeight: CGFloat = 100.0/2
  let strokeWidth = CGFloat(8.0)
  let shape: ShapeSelector
  var color: UIColor = UIColor.whiteColor()
  var path: UIBezierPath {
    var rect = bounds
    rect.inset(dx: strokeWidth/2.0, dy: strokeWidth/2.0)
    var shapePath: UIBezierPath
    switch shape {
    case .Square, .Rectangle:
      shapePath = UIBezierPath(rect: rect)
      break;
    default:
      // TODO: Add cases for remaining shapes
      shapePath = UIBezierPath()
    }
    shapePath.lineWidth = strokeWidth
    shapePath.lineJoinStyle = kCGLineJoinRound
    return shapePath
  }
  
  init(shape: ShapeSelector) {
    self.shape = shape
    var frame = CGRect(origin: CGPointZero, size: initialSize)
    if (shape == .Rectangle || shape == .Oval) {
      frame.size.height = alternateHeight
    }
    super.init(frame: frame)
    opaque = false
    backgroundColor = nil
    clearsContextBeforeDrawing = true
  }

  required init(coder aDecoder: NSCoder) {
    shape = .Square
    super.init(coder: aDecoder)
  }
  
  override func drawRect(rect: CGRect) {
    color.setStroke()
    path.stroke()
  }
}