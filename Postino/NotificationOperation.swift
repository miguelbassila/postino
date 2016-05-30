//
//  NotificationOperation.swift
//  Postino
//
//  Created by Miguel Bassila on 3/30/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
class NotificationOperation: NSOperation {

  private let notification: Notification
  private let presentationContext: UIViewController

  private let animationOptions: UIViewAnimationOptions = [.CurveEaseInOut, .AllowUserInteraction]
  private let animationDefaultDuration = 0.5
  private let animationDefaultDelay = 1.5
  private let statusBarDifference: CGFloat = UIApplication.sharedApplication().statusBarHidden ? 0 : 20

  lazy private var notificationFrame: CGRect = {
    let width = self.presentationContext.view.frame.size.width
    let height: CGFloat =  44 + self.statusBarDifference
    return CGRect(x: 0, y: -100, width: width, height: height)
  }()

  private enum State {
    case Ready
    case Executing
    case Finished
    case Canceled
  }

  private var internalState: State = .Ready

  private var state: State {
    get {
      return self.internalState
    }

    set (newValue) {
      willChangeValueForKey("state")
      internalState = newValue
      didChangeValueForKey("state")
    }
  }

  override var finished: Bool {
    return state == .Finished
  }

  class func keyPathsForValuesAffectingIsFinished() -> NSSet {
    return ["state"]
  }

  class func keyPathsForValuesAffectingIsExecuting() -> NSSet {
    return ["state"]
  }

  class func keyPathsForValuesAffectingIsCanceled() -> NSSet {
    return ["state"]
  }

  class func keyPathsForValuesAffectingIsReady() -> NSSet {
    return ["state"]
  }

  init(notification: Notification, presentationContext: UIViewController) {
    self.notification = notification
    self.presentationContext = presentationContext
  }

  override func main() {
    if cancelled  {
      state = .Canceled
      return
    }

    state = .Executing

    dispatch_async(dispatch_get_main_queue()) { [unowned self] () -> () in
      let notificationView = NotificationView(notification: self.notification, frame: self.notificationFrame)


      guard let navigationController = self.presentationContext.navigationController else {
        return
      }

      navigationController.navigationBar.addSubview(notificationView)

      UIView.animateWithDuration(self.animationDefaultDuration, delay: 0, options: self.animationOptions, animations: {
        var frame = self.notificationFrame
        frame.origin.y = -self.statusBarDifference
        notificationView.frame = frame
        }, completion: { (finished) in
          if finished {
            self.performSelector(#selector(self.dismiss(_:)), withObject: notificationView, afterDelay: self.animationDefaultDelay)
          }
      })
    }
  }

  @objc private func dismiss(view: UIView) {
    UIView.animateWithDuration(self.animationDefaultDuration, delay: 0, options: self.animationOptions, animations: {
      var frame = view.frame
      frame.origin.y = -frame.size.height - self.statusBarDifference
      view.frame = frame
      }) { (finished) in
        self.state = .Finished
    }
  }
}
