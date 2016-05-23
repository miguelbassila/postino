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
      let frame = CGRect(x: 0, y: -100, width: self.presentationContext.view.frame.size.width, height: 100)
      let notificationView = NotificationView(notification: self.notification, frame: frame)
      self.presentationContext.view.addSubview(notificationView)

      UIView.animateWithDuration(0.3, delay:0 , options: [.AllowUserInteraction], animations: {
        var y = notificationView.frame.origin.y
        y += 100
        notificationView.frame.origin.y = y
        }, completion: { (finished) in
          if finished {
            self.state = .Finished
          }
      })
    }
  }
}
