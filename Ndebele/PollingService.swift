//
//  PollingService.swift
//  Ndebele
//
//  Created by phi on 03/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import Foundation

final class PollingService {

    let notificationName = Notification.Name("PollingNotification")

    var timer: Timer?
    let interval: TimeInterval = 2.0
    var elapsed: TimeInterval = 0.0
    var timerStarted: Date = Date()

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleBackground), name: NSNotification.Name.UIApplicationWillTerminate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    @objc func handleBackground() {
        pause()
    }

    @objc func handleForeground() {
        start()
    }

    func start() {
        timer = Timer.scheduledTimer(timeInterval: (interval - elapsed), target: self, selector: #selector(PollingService.handleTimer), userInfo: nil, repeats: false)
        timerStarted = Date()
    }

    func pause() {
        timer?.invalidate()
        elapsed = Date().timeIntervalSince(timerStarted)
    }

    @objc func handleTimer() {
        timer?.invalidate()
        elapsed = 0.0
        start()

        // Tick Tock
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
}
