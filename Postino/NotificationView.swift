//
//  NotificationView.swift
//  Postino
//
//  Created by Miguel Bassila on 5/16/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
public class NotificationView: UIView {

  var stackView: UIStackView!

  lazy var labelTitle: UILabel = {
    let label = UILabel()
    label.text = "Miguel"
    return label
  }()

  lazy var labelSubtitle: UILabel = {
    let label = UILabel()
    label.text = "Bassila"
    return label
  }()

  override public init(frame: CGRect) {
    super.init(frame: frame)
    initialSetup()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func initialSetup() {
    stackView = UIStackView(arrangedSubviews: [labelTitle, labelSubtitle])
    stackView.axis = .Vertical
    stackView.distribution = .FillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stackView)
    backgroundColor = getRandomColor()
  }

  func getRandomColor() -> UIColor{
    let randomRed:CGFloat = CGFloat(drand48())
    let randomGreen:CGFloat = CGFloat(drand48())
    let randomBlue:CGFloat = CGFloat(drand48())
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
  }

  override public func layoutSubviews() {
    super.layoutSubviews()

    let topConstraint = NSLayoutConstraint(item: stackView,
                                           attribute: .Top,
                                           relatedBy: .Equal,
                                           toItem: self,
                                           attribute: .Top,
                                           multiplier: 1,
                                           constant: 0)

    let leadingConstraint = NSLayoutConstraint(item: stackView,
                                               attribute: .Leading,
                                               relatedBy: .Equal,
                                               toItem: self,
                                               attribute: .Leading,
                                               multiplier: 1,
                                               constant: 0)

    let trailingConstraint = NSLayoutConstraint(item: stackView,
                                                attribute: .Trailing,
                                                relatedBy: .Equal,
                                                toItem: self,
                                                attribute: .Trailing,
                                                multiplier: 1,
                                                constant: 0)

    let bottomConstraint = NSLayoutConstraint(item: stackView,
                                              attribute: .Bottom,
                                              relatedBy: .Equal,
                                              toItem: self,
                                              attribute: .Bottom,
                                              multiplier: 1,
                                              constant: 0)

    addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
  }
}
