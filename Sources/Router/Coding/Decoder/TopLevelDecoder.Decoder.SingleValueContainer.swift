//
//  TopLevelDecoder.Decoder.SingleValueContainer.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension QueryCoder.TopLevelDecoder.Decoder {

	struct SingleValueDecoder: SingleValueDecodingContainer, ValueDecoder {

		let codingPath: [CodingKey]
		let userInfo: [CodingUserInfoKey : Any]

		let items: [String: QueryCoder.ItemType]

		init(
			codingPath: [CodingKey],
			userInfo: [CodingUserInfoKey : Any],
			items: [String: QueryCoder.ItemType]
		) {
			self.codingPath = codingPath
			self.userInfo = userInfo
			self.items = items
		}

		func string<T>(
			_ type: T.Type
		) throws -> String {

			guard
				let items = self.items.first,
				case .constant(let value) = items.value
			else {
				throw DecodingError.valueNotFound(
					type,
					DecodingError.Context(
						codingPath: self.codingPath,
						debugDescription: "Expected \(T.self) but found nil or container instead."))
			}

			return value

		}

		func decodeNil() -> Bool {
			return self.items.count == 0
		}

		func decode(
			_ type: Bool.Type
		) throws -> Bool {
			return self.decode(
				string: try self.string(
					type))
		}

		func decode(
			_ type: String.Type
		) throws -> String {
			return try self.string(
				type)
		}

		func decode(
			_ type: Double.Type
		) throws -> Double {
			return self.decode(
				string: try self.string(
					type))
		}

		func decode(
			_ type: Float.Type
		) throws -> Float {
			return Float(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: Int.Type
		) throws -> Int {
			return Int(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: Int8.Type
		) throws -> Int8 {
			return Int8(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: Int16.Type
		) throws -> Int16 {
			return Int16(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: Int32.Type
		) throws -> Int32 {
			return Int32(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: Int64.Type
		) throws -> Int64 {
			return Int64(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: UInt.Type
		) throws -> UInt {
			return UInt(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: UInt8.Type
		) throws -> UInt8 {
			return UInt8(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: UInt16.Type
		) throws -> UInt16 {
			return UInt16(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: UInt32.Type
		) throws -> UInt32 {
			return UInt32(self.decode(
				string: try self.string(
					type)))
		}

		func decode(
			_ type: UInt64.Type
		) throws -> UInt64 {
			return UInt64(self.decode(
				string: try self.string(
					type)))
		}

		func decode<T>(
			_ type: T.Type
		) throws -> T where T : Decodable {
			return try T(from: QueryCoder.TopLevelDecoder.Decoder(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				items: self.items))
		}

	}

}
