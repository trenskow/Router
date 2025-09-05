//
//  TopLevelEncoder.Encoder.UnkeyedContainer.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension QueryCoder.TopLevelEncoder.Encoder {

	struct UnkeyedContainer: UnkeyedEncodingContainer {

		let codingPath: [CodingKey]
		let userInfo: [CodingUserInfoKey : Any]

		var result: Result

		var count: Int {
			return result.items.count
		}

		var currentKey: String {
			return "\(count)"
		}

		init(
			codingPath: [CodingKey],
			userInfo: [CodingUserInfoKey : Any],
			result: Result
		) {
			self.codingPath = codingPath
			self.userInfo = userInfo
			self.result = result
		}

		func encodeNil() throws { }

		func nestedContainer<NestedKey>(
			keyedBy keyType:
			NestedKey.Type
		) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
			return KeyedEncodingContainer(
				KeyedContainer<NestedKey>(
					codingPath: self.codingPath,
					userInfo: self.userInfo,
					result: self.result))
		}
		
		func nestedUnkeyedContainer() -> any UnkeyedEncodingContainer {
			return UnkeyedContainer(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				result: self.result)
		}
		
		func superEncoder() -> any Encoder {
			return QueryCoder.TopLevelEncoder.Encoder(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				result: self.result)
		}

		func encode(
			_ value: Bool
		) throws {
			self.result.items[self.currentKey] = .constant(value ? "true" : "false")
		}

		func encode(
			_ value: String
		) throws {
			self.result.items[self.currentKey] = .constant(value)
		}

		func encode(
			_ value: Double
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: Float
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: Int
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: Int8
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: Int16
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: Int32
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: Int64
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: UInt
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: UInt8
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: UInt16
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: UInt32
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode(
			_ value: UInt64
		) throws {
			self.result.items[self.currentKey] = .constant("\(value)")
		}

		func encode<T>(
			_ value: T
		) throws where T : Encodable {

			let result = Result()

			self.result.items[self.currentKey] = .container(result)

			try value.encode(
				to: QueryCoder.TopLevelEncoder.Encoder(
					codingPath: self.codingPath + [QueryCoder.Key(stringValue: self.currentKey)],
					userInfo: self.userInfo,
					result: result))

		}

	}

}
