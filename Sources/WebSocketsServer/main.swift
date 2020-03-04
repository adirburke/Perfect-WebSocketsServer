//
//  UploadHandler.swift
//  Upload Enumerator
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//



import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

import Foundation

    public func getEnviroment(forString string : String) -> String? {
        return ProcessInfo.processInfo.environment[string]
    }
    
func resourceString(_ path: String) -> String {
    let file = URL(fileURLWithPath: path)
    if let data = try? Data(contentsOf: file) {
        if let returnString =  String(data: data, encoding: .utf8) {
            return returnString
        }
    }
    return ""
        
        
        
}
public struct Certificates {
    
    static let mainPath = "/Users/server/cert/"
    public static var trustCertCollection: String {
        let path = mainPath + "zaraca.crt"
        return resourceString(path)
    }
    

    
    public static var certChain: String {
        let name = getEnviroment(forString: "FILENAME_CERT") ?? "localhost"

        let path = mainPath + "\(name).crt"
        return resourceString(path)
    }
    
    public static var privateKey: String {
        let name = getEnviroment(forString: "FILENAME_PRIVATEKEY") ?? "localhost"
        
        let path = mainPath + "\(name).key"
        return resourceString(path)
    }
    
    
    public static var RMSServerCert: String {
        let name = "docker-rms"
        let path = mainPath + "\(name).crt"
        return resourceString(path)
    }
    
    public static var RMSServerKey: String {
        let name = "docker-rms"
        let path = mainPath + "\(name).key"
        return resourceString(path)
    }
    
}

do {
    // Launch the HTTP server on port 8181
//    try HTTPServer.launch(name: "websockets server",
//						  port: 8181,
//						  routes: makeRoutes(),
//						  responseFilters: [(try HTTPFilter.contentCompression(data: [:]), .high)])
//
    
    var server = HTTPServer()
    let cert = Certificates.certChain
    let key = Certificates.privateKey
    
    server.ssl = (sslCert: cert, sslKey: key)
    
    server.addRoutes( makeRoutes())
    server.serverPort = 8181
    server.serverAddress = "0.0.0.0"
    try server.start()
    
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
