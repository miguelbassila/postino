//
//  NotificationOperation.swift
//  Postino
//
//  Created by Miguel Bassila on 3/30/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import Foundation

class NotificationOperation: NSOperation {

  let notification: Notification

  init(notification: Notification) {
    self.notification = notification
  }

  override func main() {
    if cancelled  { return }
  }
}
