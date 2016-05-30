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

  lazy private var invisibleView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callAction(_:))))
    return view
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
    backgroundColor = getRandomColor()
    self.addSubview(stackView)
    self.addSubview(invisibleView)
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

  @objc func callAction(gesture: UITapGestureRecognizer) {
    gesture.view?.removeGestureRecognizer(gesture)
    guard let onTapAction = notification.action else {
      return
    }

    onTapAction(notification)
  }

  override public func layoutSubviews() {
    let topConstant: CGFloat = UIApplication.sharedApplication().statusBarHidden ? 0 : 20

    let stackViewTopConstraint = NSLayoutConstraint(item: stackView,
                                                    attribute: .Top,
                                                    relatedBy: .Equal,
                                                    toItem: self,
                                                    attribute: .Top,
                                                    multiplier: 1,
                                                    constant: topConstant)

    let stackViewLeadingConstraint = NSLayoutConstraint(item: stackView,
                                                        attribute: .Leading,
                                                        relatedBy: .Equal,
                                                        toItem: self,
                                                        attribute: .Leading,
                                                        multiplier: 1,
                                                        constant: 0)

    let stackViewTrailingConstraint = NSLayoutConstraint(item: stackView,
                                                         attribute: .Trailing,
                                                         relatedBy: .Equal,
                                                         toItem: self,
                                                         attribute: .Trailing,
                                                         multiplier: 1,
                                                         constant: 0)

    let stackViewBottomConstraint = NSLayoutConstraint(item: stackView,
                                                       attribute: .Bottom,
                                                       relatedBy: .Equal,
                                                       toItem: self,
                                                       attribute: .Bottom,
                                                       multiplier: 1,
                                                       constant: 0)

    let invisibleViewTopConstraint = NSLayoutConstraint(item: invisibleView,
                                                        attribute: .Top,
                                                        relatedBy: .Equal,
                                                        toItem: self,
                                                        attribute: .Top,
                                                        multiplier: 1,
                                                        constant: 0)

    let invisibleViewLeadingConstraint = NSLayoutConstraint(item: invisibleView,
                                                            attribute: .Leading,
                                                            relatedBy: .Equal,
                                                            toItem: self,
                                                            attribute: .Leading,
                                                            multiplier: 1,
                                                            constant: 0)

    let invisibleViewTrailingConstraint = NSLayoutConstraint(item: invisibleView,
                                                             attribute: .Trailing,
                                                             relatedBy: .Equal,
                                                             toItem: self,
                                                             attribute: .Trailing,
                                                             multiplier: 1,
                                                             constant: 0)

    let invisibleViewBottomConstraint = NSLayoutConstraint(item: invisibleView,
                                                           attribute: .Bottom,
                                                           relatedBy: .Equal,
                                                           toItem: self,
                                                           attribute: .Bottom,
                                                           multiplier: 1,
                                                           constant: 0)
    addConstraints([stackViewTopConstraint,
      stackViewLeadingConstraint,
      stackViewTrailingConstraint,
      stackViewBottomConstraint,
      invisibleViewTopConstraint,
      invisibleViewLeadingConstraint,
      invisibleViewTrailingConstraint,
      invisibleViewBottomConstraint])
    
    super.layoutSubviews()
  }
}
