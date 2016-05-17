//
//  Notification.swift
//  Postino
//
//  Created by Miguel Bassila on 3/29/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import Foundation

public struct Notification {
  let title: String
  let subtitle: String

  public init(title: String, subtitle: String) {
    self.title = title
    self.subtitle = subtitle
  }
}
