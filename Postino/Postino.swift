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

  private let operationQueue = NSOperationQueue()

  private init() {
    operationQueue.maxConcurrentOperationCount = 1
  }

  public func deliver(notification: Notification, atViewController viewController: UIViewController) {
    let operation = NotificationOperation(notification: notification, presentationContext: viewController)
    operationQueue.addOperation(operation)
  }

  public func cancel() {
    operationQueue.cancelAllOperations()
  }
}
