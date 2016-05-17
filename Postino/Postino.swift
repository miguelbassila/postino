//
//  Postino.swift
//  Postino
//
//  Created by Miguel Bassila on 5/14/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
public struct Postino {

  public static let sharedInstance = Postino()

  lazy var operationQueue: NSOperationQueue = {
    let operationQueue = NSOperationQueue()
    operationQueue.maxConcurrentOperationCount = 1
    return operationQueue
  }()

  public mutating func deliver(notification: Notification, at viewController: UIViewController) {
    let operation = NotificationOperation(notification: notification, presentationContext: viewController)
    operationQueue.addOperation(operation)
  }

  public mutating func cancel() {
    operationQueue.cancelAllOperations()
  }
}
