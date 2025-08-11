//
//  Fetch_IPAddress.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 05/08/25.
//
import Foundation
import Network

func getLocalIPAddress() -> String? {
    var address: String?
    
    var ifaddr: UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr else {
        return nil
    }
    
    for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let interface = ptr.pointee
        
        let addrFamily = interface.ifa_addr.pointee.sa_family
        if addrFamily == UInt8(AF_INET) { // IPv4 only
            let name = String(cString: interface.ifa_name)
            if name == "en0" { // Wi-Fi interface
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST)
                address = String(cString: hostname)
            }
        }
    }
    
    freeifaddrs(ifaddr)
    return address
}

