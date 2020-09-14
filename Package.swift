// swift-tools-version:5.1

//
//  Package.swift
//  PerfectExample-WebSocketsServer
//
//  Created by Kyle Jessup on 3/22/16.
//	Copyright (C) 2016 PerfectlySoft, Inc.
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

import PackageDescription

let package = Package(
	name: "WebSocketsServer",
	platforms: [
		.macOS(.v10_15)
	],
	products: [
		.executable(name:  "WebSocketsServer", targets: ["WebSocketsServer"]),
	],
	dependencies: [
		// .package(url:"https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
		// .package(url:"https://github.com/PerfectlySoft/Perfect-WebSockets.git", from: "3.0.0"),
		.package(path: "~/Dev/Perfect/Perfect-WebSockets"),
		.package(path: "~/Dev/Perfect/Perfect-HTTPServer"),
	],
	targets: [
		.target(name:  "WebSocketsServer", dependencies: ["PerfectHTTPServer", "PerfectWebSockets"]),
	]
)
