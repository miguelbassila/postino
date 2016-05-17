//
//  Postino.swift
//  Postino
//
//  Created by Miguel Bassila on 5/14/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import Foundation

public struct Postino {

  public static let sharedInstance = Postino()

  lazy private var operationQueue: NSOperationQueue = {
    let operationQueue = NSOperationQueue()
    operationQueue.maxConcurrentOperationCount = 1
    return operationQueue
  }()

  public mutating func add(notification: Notification) {
    let operation = NotificationOperation(notification: notification)
    operationQueue.addOperation(operation)
  }
}
