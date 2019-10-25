//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets : [Tweet] = []
    var refreshControl : UIRefreshControl!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        self.updateUserInfo()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200.0; // set to whatever your "average" cell height is

        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getHomeTimeLine), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        self.getHomeTimeLine()
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        APIManager.shared.logout()
    }
    

    
    @IBAction func onRetweet(_ sender: Any) {
    }
    
    
    @objc func getHomeTimeLine() {
        //TODO: Call Alamofire request method
        APIManager.shared.getHomeTimeLine { (tweets: [Tweet]?, error: Error?) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            }
            self.refreshControl.endRefreshing()
    }
    }
    func updateUserInfo() {
        APIManager.shared.getCurrentAccount { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let user = user {
                User.current = user
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        cell.user = tweet.user
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
