//
//  ChatService.swift
//  CometChat
//
//  Created by Marin Benčević on 09/08/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import Foundation
import CometChatPro

extension String: Error {}

final class ChatService {
  
  
    static let shared = ChatService()
    static let individual = ChatService()
    private init() {}
  
    private var receiverId: String!
    
    public func setReceiverId(receiverId: String) {
        self.receiverId = receiverId
    }
    
    var onRecievedMessage: ((Message)-> Void)?
  
  
    func send(message: String) {
    
    let textMessage = TextMessage(
        receiverUid: receiverId,
        text: message,
        receiverType: .user)
    
    CometChat.sendTextMessage(
        message: textMessage,
        onSuccess: { [weak self] _ in
            guard let self = self else { return }
            print("Message sent")
            DispatchQueue.main.async {
                self.onRecievedMessage?(Message( sender: CometChat.getLoggedInUser()!, receiverId: self.receiverId,  content: message, isIncoming: false))
            }
        },
        onError: { error in
            print("Error sending message:")
            print(error?.errorDescription ?? "")
        })
    }
    
    func sendGroup(message: String) {
      let textMessage = TextMessage(
        receiverUid: Constants.groupID,
        text: message,
        receiverType: .group)
      
      CometChat.sendTextMessage(
        message: textMessage,
        onSuccess: { [weak self] _ in
          guard let self = self else { return }
          print("Message sent")
          DispatchQueue.main.async {
            self.onRecievedMessage?(Message(sender: CometChat.getLoggedInUser()!, receiverId: Constants.groupID, content: message, isIncoming: false))
          }
        },
        onError: { error in
          print("Error sending message:")
          print(error?.errorDescription ?? "")
      })
    }
  
  private var messagesRequest: MessagesRequest?
    
    func getMessages(onComplete: @escaping ([Message])-> Void) {
    
    let limit = 50
    
    messagesRequest = MessagesRequest.MessageRequestBuilder()
      .set(limit: limit)
      .set(uid: receiverId)
      .build()
    
    messagesRequest!.fetchPrevious(
      onSuccess: { fetchedMessages in
        print("Fetched \(fetchedMessages?.count ?? 0) older messages")
        guard let fetchedMessages = fetchedMessages else {
          onComplete([])
          return
        }
        
        let messages = fetchedMessages
          .compactMap { $0 as? TextMessage }
            .map { Message($0, isIncoming: $0.senderUid == self.receiverId) }
        
        DispatchQueue.main.async {
          onComplete(messages)
        }
    }, onError: { error in
        print("Fetching messages failed with error:")
        print(error?.errorDescription ?? "unknown")
    })
  }
    
    func getGroupMessages(onComplete: @escaping ([Message])-> Void) {
      
      let limit = 50
      
      messagesRequest = MessagesRequest.MessageRequestBuilder()
        .set(limit: limit)
        .set(guid: Constants.groupID)
        .build()
      
      messagesRequest!.fetchPrevious(
        onSuccess: { fetchedMessages in
          print("Fetched \(fetchedMessages?.count ?? 0) older messages")
          guard let fetchedMessages = fetchedMessages else {
            onComplete([])
            return
          }
          
          let messages = fetchedMessages
            .compactMap { $0 as? TextMessage }
            .map { Message($0, isIncoming: $0.senderUid != CometChat.getLoggedInUser()?.uid) }
          
          DispatchQueue.main.async {
            onComplete(messages)
          }
      }, onError: { error in
          print("Fetching messages failed with error:")
          print(error?.errorDescription ?? "unknown")
      })
    }
  
}

extension ChatService: CometChatMessageDelegate {
  func onTextMessageReceived(textMessage: TextMessage) {
    DispatchQueue.main.async {
      self.onRecievedMessage?(Message(textMessage, isIncoming: true))
    }
  }
}
