//
//  NavigationController.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-21.
//

import Foundation

// NavigationController.swift
import SwiftUI

final class NavigationController: ObservableObject {
    @Published var currentView: NavigationItem? = nil
}

enum NavigationItem: Identifiable {
    case logView

    var id: String {
        switch self {
        case .logView:
            return "logView"
        }
    }
}
