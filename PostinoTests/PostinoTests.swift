//
//  PostinoTests.swift
//  PostinoTests
//
//  Created by Miguel Bassila on 3/29/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import XCTest
@testable import Postino

class PostinoTests: XCTestCase {

  func testThatQueueConfig() {
    var postino = Postino()
    XCTAssertEqual(postino.operationQueue.maxConcurrentOperationCount, 1)
  }

  func testThatAddToQueue() {
    var postino = Postino()
    XCTAssertEqual(postino.operationQueue.operationCount, 0)
    postino.deliver(Notification(title: "Title", subtitle: "Subtitle"))
    XCTAssertEqual(postino.operationQueue.operationCount, 1)
    postino.deliver(Notification(title: "Title", subtitle: "Subtitle"))
    XCTAssertEqual(postino.operationQueue.operationCount, 2)
  }
}
