//
//  RouterNavigator.swift
//  Router
//
//  Created by Kristian Trenskow on 09/03/2025.
//

@MainActor
public protocol RouterNavigator {
	func navigate(to relativePath: String)
	func back()
}
