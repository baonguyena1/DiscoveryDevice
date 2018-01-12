//
//  DetectDevice.swift
//  DiscoveryDevice
//
//  Created by Bao Nguyen on 1/12/18.
//  Copyright © 2018 Bao Nguyen. All rights reserved.
//

import UIKit

class DetectDevice: NSObject {
    fileprivate var serviceBrowser: NetServiceBrowser?
    fileprivate var services = [NetService]()
    fileprivate var addresses = [NSObject: URL]()
    fileprivate var timer: Timer?
    
    static let shared = DetectDevice()
    
    // MARK: - public function
    func start() {
        if let timer = self.timer {
            timer.invalidate()
            
        }
    }
    
    func stop() {
        
    }
    
    private func stopBrowsing() {
        guard let serviceBrowser = self.serviceBrowser else {
            return
        }
        serviceBrowser.stop()
        serviceBrowser.delegate = nil
        serviceBrowser.remove(from: .current, forMode: .defaultRunLoopMode)
        self.serviceBrowser = nil
    }
    
    private func startBrowsing() {
        if self.serviceBrowser != nil {
            return
        }
        serviceBrowser = NetServiceBrowser()
        serviceBrowser?.includesPeerToPeer = true
        serviceBrowser?.delegate = self
        serviceBrowser?.searchForServices(ofType: "test", inDomain: "")
        serviceBrowser?.schedule(in: .current, forMode: .defaultRunLoopMode)
    }
}

extension DetectDevice: NetServiceBrowserDelegate {
    
}
