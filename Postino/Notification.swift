//
//  Notification.swift
//  Postino
//
//  Created by Miguel Bassila on 3/29/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import Foundation

public struct Notification {
  public let title: String
  public let subtitle: String

  public typealias onTap = ((Notification) -> ())?
  let action: onTap

  public init(title: String, subtitle: String, action: onTap = nil) {
    self.title = title
    self.subtitle = subtitle
    self.action = action
  }
}
