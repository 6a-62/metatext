// Copyright © 2020 Metabolist. All rights reserved.

import SwiftUI
import ViewModels

@main
struct MetatextApp: App {
    // swiftlint:disable weak_delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    // swiftlint:enable weak_delegate

    var body: some Scene {
        WindowGroup {
            RootView(
                // swiftlint:disable force_try
                viewModel: try! RootViewModel(
                    environment: .live(userNotificationCenter: .current()),
                    registerForRemoteNotifications: appDelegate.registerForRemoteNotifications))
                // swiftlint:enable force_try
        }
    }
}
