//
//  EventMessenger.swift
//  UIKit-SwiftUI-Event-Sample
//
//  Created by cano on 2022/06/16.
//

import Foundation
import SwiftUI

class EventMessenger: ObservableObject {
    @Published var tapCount: Int = 0
}
