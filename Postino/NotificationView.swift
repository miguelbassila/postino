//
//  NotificationView.swift
//  Postino
//
//  Created by Miguel Bassila on 5/16/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
class NotificationView: UIView {

  private let notification: Notification

  private enum LabelType {
    case Title
    case Subtitle
  }

  lazy private var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [self.labelTitle, self.labelSubtitle])
    stackView.axis = .Vertical
    stackView.distribution = .FillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  lazy private var labelTitle: UILabel = {
    return self.configureLabel(self.notification.title, type: .Title)
  }()

  lazy private var labelSubtitle: UILabel = {
    return self.configureLabel(self.notification.subtitle, type: .Subtitle)
  }()

  init(notification: Notification, frame: CGRect) {
    self.notification = notification
    super.init(frame: frame)
    self.initialSetup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func initialSetup() {
    self.addSubview(stackView)
    backgroundColor = getRandomColor()
  }

  private func configureLabel(text: String, type: LabelType) -> UILabel {
    let label = UILabel()
    label.text = text
    return label
  }

  private func getRandomColor() -> UIColor{
    let randomRed:CGFloat = CGFloat(drand48())
    let randomGreen:CGFloat = CGFloat(drand48())
    let randomBlue:CGFloat = CGFloat(drand48())
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
  }

  @objc private func callAction(gesture: UIGestureRecognizer) {
    guard let onTapAction = notification.action else {
      return
    }

    onTapAction(notification)
  }

  override public func layoutSubviews() {
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
    super.layoutSubviews()
  }
}
