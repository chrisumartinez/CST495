//
//  HomeViewController.swift
//  Instagram
//
//  Created by Chris Martinez on 10/2/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts : [Post] = []
    var refreshControl : UIRefreshControl!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.post = post
            }
    }
    @objc func fetchPosts(){
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print(error.debugDescription)
            }
        } )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(fetchPosts), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchPosts()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        let post = posts[indexPath.row]
    
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        // Async main thread
                        let image = UIImage(data: data!)
                        cell.postImage.image = image
                    }
                } else {
                    print(error!.localizedDescription)
                }
            })
        }
        cell.postTextLabel.text = post.caption
        return cell
    }

}

