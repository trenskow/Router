//
//  QueryDecoder+Key.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension QueryCoder {

	struct Key: CodingKey {

		let stringValue: Swift.String
		let intValue: Int?

		init(
			stringValue: Swift.String
		) {
			self.stringValue = stringValue
			self.intValue = nil
		}

		init(
			intValue: Int
		) {
			self.stringValue = "\(intValue)"
			self.intValue = intValue
		}

	}

}
