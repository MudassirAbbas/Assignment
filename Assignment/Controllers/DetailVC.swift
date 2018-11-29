//
//  DetailVC.swift
//  Assignment
//
//  Created by Mudassir Abbas on 28/11/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class DetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK: - IBOUTLET
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var followerTbl: UITableView!
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var followerArr =  [UserModel]()
    var userObj: UserModel!
    //MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        followerTbl.delegate = self
        followerTbl.dataSource = self
        UserProfileSetting()
        LoadFollowers()
        // Do any additional setup after loading the view.
    }
    //MARK: - SET USER PROFILE
    func UserProfileSetting()
    {
        userImg.layer.cornerRadius = 40
        userImg.layer.masksToBounds = true
        if userObj != nil{
            nameLbl.text = userObj.login
            emailLbl.text = userObj.email
            userImg.sd_setImage(with: URL(string: userObj.avatarUrl), completed: nil)
        }
    }
    //MARK: - TABLE VIEW DELEGATES
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if followerArr.count == 0{
            return 1
        }
        return followerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UserTblCell! = tableView.dequeueReusableCell(withIdentifier: "UserTblCell") as? UserTblCell
        if cell == nil {
            tableView.register(UINib(nibName: "UserTblCell", bundle: nil), forCellReuseIdentifier: "UserTblCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "UserTblCell") as? UserTblCell
        }
        if followerArr.count == 0{
            cell.userNameLbl.text = "No Follower exist"
            return cell
        }
        let obj = followerArr[indexPath.row]
        if obj.avatarUrl != nil{
        cell.userImg.sd_setImage(with: URL(string: obj.avatarUrl), completed: nil)
        }
        cell.userImg.layer.cornerRadius = 30
        cell.userImg.layer.masksToBounds = true
        if obj.login != nil{
            cell.userNameLbl.text = obj.login
        }
        return cell
    }
    //MARK: - LOAD FOLLOWERS
    func LoadFollowers()
    {
        self.showActivityIndicatory(uiView: self.view)
        let url = userObj.followersUrl ?? ""
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON(completionHandler: { (response) in
            self.hideActivityIndicator(uiView: self.view)
            print(response.result.value)
            switch(response.result){
            case .success(_):
                let valueArr = response.result.value as! [Dictionary<String,AnyObject>]
                for model in valueArr{
                    let userModel = UserModel.init(fromDictionary: model)
                    self.followerArr.append(userModel)
                }
                self.followerTbl.reloadData()
                break
            case .failure(_):
                break
            }
        })
    }
    //MARK: - SHOW ACTIVITY INDICATOR
    public func showActivityIndicatory(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        loadingView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.style =
            UIActivityIndicatorView.Style.white
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y :loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        uiView.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    //
    public func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        uiView.isUserInteractionEnabled = true
        container.removeFromSuperview()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
