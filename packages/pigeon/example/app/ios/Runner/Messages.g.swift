// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon, do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

/// Error class for passing custom error details to Dart side.
final class PigeonError: Error {
  let code: String
  let message: String?
  let details: Any?

  init(code: String, message: String?, details: Any?) {
    self.code = code
    self.message = message
    self.details = details
  }

  var localizedDescription: String {
    return
      "PigeonError(code: \(code), message: \(message ?? "<nil>"), details: \(details ?? "<nil>")"
  }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func createConnectionError(withChannelName channelName: String) -> PigeonError {
  return PigeonError(
    code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.",
    details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum Code: Int {
  case one = 0
  case two = 1
}

/// Generated class from Pigeon that represents data sent in messages.
struct MessageData {
  var name: String? = nil
  var description: String? = nil
  var code: Code
  var data: [String: String]

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> MessageData? {
    let name: String? = nilOrValue(pigeonVar_list[0])
    let description: String? = nilOrValue(pigeonVar_list[1])
    let code = pigeonVar_list[2] as! Code
    let data = pigeonVar_list[3] as! [String: String]

    return MessageData(
      name: name,
      description: description,
      code: code,
      data: data
    )
  }
  func toList() -> [Any?] {
    return [
      name,
      description,
      code,
      data,
    ]
  }
}

private class MessagesPigeonCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 129:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return Code(rawValue: enumResultAsInt)
      }
      return nil
    case 130:
      return MessageData.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class MessagesPigeonCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? Code {
      super.writeByte(129)
      super.writeValue(value.rawValue)
    } else if let value = value as? MessageData {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class MessagesPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return MessagesPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return MessagesPigeonCodecWriter(data: data)
  }
}

class MessagesPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = MessagesPigeonCodec(readerWriter: MessagesPigeonCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol ExampleHostApi {
  func getHostLanguage() throws -> String
  func add(_ a: Int64, to b: Int64) throws -> Int64
  func sendMessage(message: MessageData, completion: @escaping (Result<Bool, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class ExampleHostApiSetup {
  static var codec: FlutterStandardMessageCodec { MessagesPigeonCodec.shared }
  /// Sets up an instance of `ExampleHostApi` to handle messages through the `binaryMessenger`.
  static func setUp(
    binaryMessenger: FlutterBinaryMessenger, api: ExampleHostApi?, messageChannelSuffix: String = ""
  ) {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let getHostLanguageChannel = FlutterBasicMessageChannel(
      name:
        "dev.flutter.pigeon.pigeon_example_package.ExampleHostApi.getHostLanguage\(channelSuffix)",
      binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getHostLanguageChannel.setMessageHandler { _, reply in
        do {
          let result = try api.getHostLanguage()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getHostLanguageChannel.setMessageHandler(nil)
    }
    let addChannel = FlutterBasicMessageChannel(
      name: "dev.flutter.pigeon.pigeon_example_package.ExampleHostApi.add\(channelSuffix)",
      binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      addChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let aArg = args[0] as! Int64
        let bArg = args[1] as! Int64
        do {
          let result = try api.add(aArg, to: bArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      addChannel.setMessageHandler(nil)
    }
    let sendMessageChannel = FlutterBasicMessageChannel(
      name: "dev.flutter.pigeon.pigeon_example_package.ExampleHostApi.sendMessage\(channelSuffix)",
      binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      sendMessageChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let messageArg = args[0] as! MessageData
        api.sendMessage(message: messageArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      sendMessageChannel.setMessageHandler(nil)
    }
  }
}
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol MessageFlutterApiProtocol {
  func flutterMethod(
    aString aStringArg: String?, completion: @escaping (Result<String, PigeonError>) -> Void)
}
class MessageFlutterApi: MessageFlutterApiProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  private let messageChannelSuffix: String
  init(binaryMessenger: FlutterBinaryMessenger, messageChannelSuffix: String = "") {
    self.binaryMessenger = binaryMessenger
    self.messageChannelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
  }
  var codec: MessagesPigeonCodec {
    return MessagesPigeonCodec.shared
  }
  func flutterMethod(
    aString aStringArg: String?, completion: @escaping (Result<String, PigeonError>) -> Void
  ) {
    let channelName: String =
      "dev.flutter.pigeon.pigeon_example_package.MessageFlutterApi.flutterMethod\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(
      name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([aStringArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(PigeonError(code: code, message: message, details: details)))
      } else if listResponse[0] == nil {
        completion(
          .failure(
            PigeonError(
              code: "null-error",
              message: "Flutter api returned null value for non-null return value.", details: "")))
      } else {
        let result = listResponse[0] as! String
        completion(.success(result))
      }
    }
  }
}