//
//  AppDelegate.swift
//  NoiseBuddy
//
//  Created by Guilherme Rambo on 13/11/19.
//  Copyright © 2019 Guilherme Rambo. All rights reserved.
//

import Cocoa
import NoiseCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    private func makeListeningModeController() -> NCListeningModeStatusProvider {
        if UserDefaults.standard.bool(forKey: "NBUseMockListeningModeController") {
            return MockListeningModeController()
        } else {
            return NCListeningModeController()
        }
    }

    private lazy var preferences = Preferences()

    private lazy var touchBarController: TouchBarUIController = {
        TouchBarUIController(
            listeningModeController: self.makeListeningModeController(),
            preferences: self.preferences
        )
    }()

    private lazy var menuBarController: MenuBarUIController = {
        MenuBarUIController(
            listeningModeController: self.makeListeningModeController(),
            preferences: self.preferences
        )
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        preferences.register()

        touchBarController.install()
        menuBarController.install()
    }

}

