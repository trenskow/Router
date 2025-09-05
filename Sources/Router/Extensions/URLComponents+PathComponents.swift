//
//  URLComponents+PathComponents.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import Foundation

extension URLComponents {

	var pathComponents: [String] {
		return self.percentEncodedPath
			.split(separator: "/")
			.map { $0.removingPercentEncoding ?? String($0) }
	}

}
