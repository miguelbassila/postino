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

  let notification: Notification
  let presentationContext: UIViewController

  private enum State {
    case Started
    case Finished
  }

  private var internalState: State = .Started
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

  init(notification: Notification, presentationContext: UIViewController) {
    self.notification = notification
    self.presentationContext = presentationContext
  }

  override func start() {
    super.start()
  }

  override func main() {
    if cancelled  { return }

    dispatch_async(dispatch_get_main_queue()) { [unowned self] () -> () in
      let notificationView = NotificationView(frame: CGRect(x: 0, y: -100, width: self.presentationContext.view.frame.size.width, height: 100))
      self.presentationContext.view.addSubview(notificationView)

      UIView.animateWithDuration(0.3) {
        var notificationViewFrame = notificationView.frame
        notificationViewFrame.origin.y += notificationViewFrame.size.height
        notificationView.frame = notificationViewFrame
      }

      UIView.animateWithDuration(0.3, delay: 2, options: .TransitionNone, animations: {
        var notificationViewFrame = notificationView.frame
        notificationViewFrame.origin.y -= notificationViewFrame.size.height
        notificationView.frame = notificationViewFrame
      }) { (finished) in
        notificationView.removeFromSuperview()
        self.state = .Finished
      }
    }
  }
}
