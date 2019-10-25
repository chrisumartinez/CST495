//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Chris Martinez on 10/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import TTTAttributedLabel
import AFNetworking


class TweetCell: UITableViewCell {

    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var tweetDateLabel: UILabel!
    @IBOutlet weak var tweetHandleLabel: UILabel!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: TTTAttributedLabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var user: User!
    
    var tweet: Tweet! {
        didSet{
            
            
            let stringFavoriteCount = updateTweetStrings(str: (String(tweet!.favoriteCount)))
            let stringRetweetCount = updateTweetStrings(str: String((tweet!.retweetCount)))
            retweetButton.setTitle(stringRetweetCount, for: .normal)
            favoriteButton.setTitle(stringFavoriteCount, for: .normal)
            
            tweetDateLabel.text = tweet?.createdAtString
            tweetHandleLabel.text = tweet?.user?.screenName
            tweetNameLabel.text = tweet?.user?.name
            tweetTextLabel.text = tweet?.text
    
            if let imageURL = tweet!.user!.profilepic{
                profileImageView.af_setImage(withURL: imageURL)
            } else {
                profileImageView.image = UIImage(named: "profile-Icon")
            }
        }
    }
    
    func updateIcons(_ tweet: Tweet) {
        if (tweet.favorited! == true) {
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
        }
        else {
            self.favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
        }
        if (tweet.retweeted == true) {
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
        }
        else {
            self.retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
        }
    }
    
    
    @IBAction func onRetweet(_ sender: Any) {
        
        if (tweet!.retweeted == false){
            APIManager.shared.retweet(self.tweet!) { (post, error)  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var reTweetCount = self.tweet.retweetCount as Int
                    reTweetCount += 1
                    self.tweet.retweetCount = reTweetCount
                    self.tweet.retweeted = true
                    self.updateIcons(self.tweet)
                }
            }
        } else {
            APIManager.shared.unretweet(self.tweet) {(post, error) in
                if let error = error{
                    print(error.localizedDescription)
                } else {
                    var retweetCount = self.tweet.retweetCount as Int
                    retweetCount -= 1
                    self.tweet.retweetCount = retweetCount
                    self.tweet.retweeted = false
                    self.updateIcons(self.tweet)
                }
            }
        }

  
    }
    
    
    
    @IBAction func onFavorite(_ sender: Any) {

        if (tweet!.favorited! == false){
            APIManager.shared.favorite(self.tweet!) { (post, error) in
                if let  error = error {
                    print(error.localizedDescription)
                } else if let tweet = self.tweet {
                    var tweetCount = tweet.favoriteCount as Int
                    tweetCount += 1
                    tweet.favoriteCount = tweetCount
                    tweet.favorited = true
                    self.updateIcons(self.tweet)
                }
            }
        }
        else{
            APIManager.shared.unfavorite(self.tweet)  {(post, error) in
                if let error = error{
                    print(error.localizedDescription)
                } else {
                    var tweetCount = self.tweet.favoriteCount as Int
                    tweetCount -= 1
                    self.tweet.favoriteCount = tweetCount
                    self.tweet.favorited = false
                    self.updateIcons(self.tweet)
                }
            }
        }

    }
    
    func updateTweetStrings(str : String) -> String{
        var updatedString : String!
        updatedString = str
        return updatedString
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
