//
//  Netwrok.swift
//  GraphQLDemo
//
//  Created by Rohit Gupta on 21/02/20.
//  Copyright © 2020 Sahabe Alam. All rights reserved.
//

import Foundation
import Apollo

// MARK: - Singleton Wrapper

class Network {
  static let shared = Network()
  
  // Configure the network transport to use the singleton as the delegate.
  private lazy var networkTransport: HTTPNetworkTransport = {
    let transport = HTTPNetworkTransport(url: URL(string: "https://graphql-compose.herokuapp.com/northwind/")!)
    transport.delegate = self
    return transport
  }()
    
  // Use the configured network transport in your Apollo client.
  private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport)
}

// MARK: - Pre-flight delegate

extension Network: HTTPNetworkTransportPreflightDelegate {

  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          shouldSend request: URLRequest) -> Bool {
    print(request)
    // If there's an authenticated user, send the request. If not, don't.
    return true ///UserManager.shared.hasAuthenticatedUser
  }
  
  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        willSend request: inout URLRequest) {
                        
    // Get the existing headers, or create new ones if they're nil
    var headers = request.allHTTPHeaderFields ?? [String: String]()

    // Add any new headers you need
    ///headers["Authorization"] = "Bearer \(UserManager.shared.currentAuthToken)"
  
    // Re-assign the updated headers to the request.
    request.allHTTPHeaderFields = headers
    
    ///Logger.log(.debug, "Outgoing request: \(request)")
  }
}

// MARK: - Task Completed Delegate

extension Network: HTTPNetworkTransportTaskCompletedDelegate {
  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        didCompleteRawTaskForRequest request: URLRequest,
                        withData data: Data?,
                        response: URLResponse?,
                        error: Error?) {
    ///Logger.log(.debug, "Raw task completed for request: \(request)")
    print("Raw task completed for request: \(request)")
                        
    if let error = error {
      ///Logger.log(.error, "Error: \(error)")
        print(error)
    }
    
    if let response = response {
     /// Logger.log(.debug, "Response: \(response)")
        print(response)
    } else {
        print("No URL Response received")
      ///Logger.log(.error, "No URL Response received!")
    }
    
    if let data = data {
        print( "Data: \(String(describing: String(bytes: data, encoding: .utf8)))")
      ///Logger.log(.debug, "Data: \(String(describing: String(bytes: data, encoding: .utf8)))")
    } else {
        print("No data received!")
      ///Logger.log(.error, "No data received!")
    }
  }
}

// MARK: - Retry Delegate

extension Network: HTTPNetworkTransportRetryDelegate {

  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        receivedError error: Error,
                        for request: URLRequest,
                        response: URLResponse?,
                        retryHandler: @escaping (_ shouldRetry: Bool) -> Void) {
    // Check if the error and/or response you've received are something that requires authentication
   /* guard UserManager.shared.requiresReAuthentication(basedOn: error, response: response) else {
      // This is not something this application can handle, do not retry.
      retryHandler(false)
      return
    }*/
    
    // Attempt to re-authenticate asynchronously
   /* UserManager.shared.reAuthenticate { success in
      // If re-authentication succeeded, try again. If it didn't, don't.
      retryHandler(success)
    }*/
  }
}

