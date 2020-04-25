//
//  ChatController.swift
//  Messenger
//
//  Created by mac on 4/23/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit
import CometChatPro

final class GroupChatController: UIViewController {
  
    let user = CometChat.getLoggedInUser()
    var sender: User!
  private enum Constants {
    static let incomingMessageCell = "incomingMessageCell"
    static let outgoingMessageCell = "outgoingMessageCell"
    static let contentInset: CGFloat = 24
    static let placeholderMessage = "Type something"
  }
  
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var textAreaBackground: UIView!
  @IBOutlet weak var textAreaBottom: NSLayoutConstraint!
  @IBOutlet weak var emptyChatView: UIView!
  
  
  // MARK: - Actions
  
  @IBAction func onSendButtonTapped(_ sender: Any) {
    sendMessage()
  }
  
  
  // MARK: - Interaction
  
  private func sendMessage() {
    let message: String = textView.text
    guard !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
      return
    }
    
    textView.endEditing(true)
    addTextViewPlaceholer()
    scrollToLastCell()
    
    ChatService.shared.sendGroup(message: message)
  }
  
  var messages: [Message] = [] {
    didSet {
      emptyChatView.isHidden = !messages.isEmpty
      tableView.reloadData()
    }
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Group"
    
    emptyChatView.isHidden = false
    setUpTableView()
    setUpTextView()
    startObservingKeyboard()
    
    ChatService.shared.onRecievedMessage = { [weak self] message in
      self?.messages.append(message)
      self?.scrollToLastCell()
    }
    
    tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addTextViewPlaceholer()
    CometChat.messagedelegate = self
    ChatService.shared.getGroupMessages { [weak self] messages in
      self?.messages = messages
      self?.scrollToLastCell()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // Add default shadow to navigation bar
    let navigationBar = navigationController?.navigationBar
    navigationBar?.shadowImage = nil
  }
  
  
  // MARK: - Keyboard
  
  private func startObservingKeyboard() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(
      forName: UIResponder.keyboardWillShowNotification,
      object: nil,
      queue: nil,
      using: keyboardWillAppear)
    notificationCenter.addObserver(
      forName: UIResponder.keyboardWillHideNotification,
      object: nil,
      queue: nil,
      using: keyboardWillDisappear)
  }
  
  deinit {
    let notificationCenter = NotificationCenter.default
    notificationCenter.removeObserver(
      self,
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
    notificationCenter.removeObserver(
      self,
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
  }
  
  private func keyboardWillAppear(_ notification: Notification) {
    let key = UIResponder.keyboardFrameEndUserInfoKey
    guard let keyboardFrame = notification.userInfo?[key] as? CGRect else {
      return
    }
    
    let safeAreaBottom = view.safeAreaLayoutGuide.layoutFrame.maxY
    let viewHeight = view.bounds.height
    let safeAreaOffset = viewHeight - safeAreaBottom
    
    let lastVisibleCell = tableView.indexPathsForVisibleRows?.last
    
    UIView.animate(
      withDuration: 0.3,
      delay: 0,
      options: [.curveEaseInOut],
      animations: {
        self.textAreaBottom.constant = -keyboardFrame.height + safeAreaOffset
        self.view.layoutIfNeeded()
        if let lastVisibleCell = lastVisibleCell {
          self.tableView.scrollToRow(
            at: lastVisibleCell, at: .bottom, animated: false)
        }
    })
  }
  
  private func keyboardWillDisappear(_ notification: Notification) {
    UIView.animate(
      withDuration: 0.3,
      delay: 0,
      options: [.curveEaseInOut],
      animations: {
        self.textAreaBottom.constant = 0
        self.view.layoutIfNeeded()
    })
  }
  
  
  // MARK: - Set up
  
  private func setUpTextView() {
    textView.isScrollEnabled = false
    textView.textContainer.heightTracksTextView = true
    textView.delegate = self
    
    textAreaBackground.layer.addShadow(
      color: UIColor(red: 189 / 255, green: 204 / 255, blue: 215 / 255, alpha: 54 / 100),
      offset: CGSize(width: 2, height: -2),
      radius: 4)
  }
  
  private func setUpTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.contentInset = UIEdgeInsets(top: Constants.contentInset, left: 0, bottom: 0, right: 0)
    tableView.allowsSelection = false
  }
}

// MARK: - UITableViewDataSource
extension GroupChatController: UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let message = messages[indexPath.row]
    if message.isIncoming {
            let cell = tableView.dequeueReusableCell(
            withIdentifier: "incomingMessageCell", for: indexPath) as? IncomingMessageTableViewCell
    //        DispatchQueue.main.async {
        self.sender = message.sender
                cell!.userImage.set(image: self.sender?.avatar ?? "", with: self.sender?.name ?? "")
    //        }
            cell!.message = message
            
            if indexPath.row < messages.count - 1 {
              let nextMessage = messages[indexPath.row + 1]
                cell!.showsAvatar = message.sender != nextMessage.sender
            } else {
                cell!.showsAvatar = true
            }
            
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(
            withIdentifier: "outgoingMessageCell", for: indexPath) as? OutgoingMessageTableViewCell
    //        DispatchQueue.main.async {
                cell!.userImage.set(image: self.user?.avatar ?? "", with: self.user?.name ?? "")
    //        }
            cell!.message = message
            
            if indexPath.row < messages.count - 1 {
              let nextMessage = messages[indexPath.row + 1]
                cell!.showsAvatar = message.sender != nextMessage.sender
            } else {
                cell!.showsAvatar = true
            }
            
            return cell!
        }
  }
  
  private func scrollToLastCell() {
    let lastRow = tableView.numberOfRows(inSection: 0) - 1
    guard lastRow > 0 else {
      return
    }
    
    let lastIndexPath = IndexPath(row: lastRow, section: 0)
    tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
  }
}

// MARK: - UITextViewDelegate
extension GroupChatController: UITextViewDelegate {
  private func addTextViewPlaceholer() {
    textView.text = Constants.placeholderMessage
    textView.textColor = .placeholderBody
  }
  
  private func removeTextViewPlaceholder() {
    textView.text = ""
    textView.textColor = .darkBody
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    removeTextViewPlaceholder()
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      addTextViewPlaceholer()
    }
  }
}

extension GroupChatController: CometChatMessageDelegate {

    func onTextMessageReceived(textMessage: TextMessage) {
        DispatchQueue.main.async {
            self.messages.append(Message(textMessage, isIncoming: true))
            self.scrollToLastCell()
            print("TextMessage received successfully: " + textMessage.stringValue())
        }
    }
}
