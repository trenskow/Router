//
//  ValueDecoder.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

protocol ValueDecoder {
	var codingPath: [CodingKey] { get }
}

extension ValueDecoder {

	func string<T>(
		_ type: T.Type,
		for item: QueryCoder.ItemType
	) throws -> String {

		guard
			case .constant(let value) = item
		else {
			throw DecodingError.typeMismatch(
				T.self,
				DecodingError.Context(
					codingPath: self.codingPath,
					debugDescription: "Expected \(T.self) but found container instead."))
		}

		return value

	}

	func decode(
		string: String,
	) -> Bool {
		return !["false", "0", "no", ""].contains(string.lowercased())
	}

	func decode(
		string: String
	) -> Double {
		return Double(string) ?? 0
	}

}
