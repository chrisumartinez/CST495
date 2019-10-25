//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Chris Martinez on 10/8/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatMessageField: UITextField!
    var chatMessages : [PFObject] = []
    var refreshControl : UIRefreshControl!
    
    @objc func fetchMessages(){
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.limit = 20
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.chatMessages = messages
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()            }
            else{
                print(error.debugDescription)
            }
        }
    }
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(fetchMessages), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        fetchMessages()
        tableView.reloadData()
        super.viewDidLoad()
        
    }
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = chatMessages[indexPath.row]
        
        cell.chatMessageLabel.text = message["text"] as? String
        if let chatUser = message["user"] as? PFUser{
            cell.chatMessageUsername.text = chatUser.username
        } else {
            cell.chatMessageUsername.text = "?"
        }
        
        return cell
    }
}
