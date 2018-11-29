//
//  ViewController.swift
//  Assignment
//
//  Created by Mudassir Abbas on 27/11/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import Alamofire

class SearchVC: UIViewController,UISearchBarDelegate{
    //MARK: - IBOUTLET
    @IBOutlet weak var searchField: UISearchBar!
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    //MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.layer.cornerRadius = 30
        searchField.layer.masksToBounds = true
        searchField.backgroundImage = UIImage()
        searchField.delegate = self
    }
    //MARK: - SEARCH BAR DELEGATE
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchUserFrmApi(searchTxt: searchBar.text!)
    }
    //MARK: - SEARCH USER WITH USERNAME
    func SearchUserFrmApi(searchTxt: String)
    {
        self.showActivityIndicatory(uiView: self.view)
        let url = "https://api.github.com/users/\(searchTxt)"
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON(completionHandler: { (response) in
            self.hideActivityIndicator(uiView: self.view)
            switch(response.result){
            case .success(_):
                let value = response.result.value as! Dictionary<String,AnyObject>
                let userModel = UserModel.init(fromDictionary: value)
                if userModel.login != nil
                {
                    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
                    vc.userObj = userModel
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.ShowAlert()
                }
                break
            case .failure(_):
                break
            }
            })
    }
    //MARK: - SHOW ALERT
    func ShowAlert()
    {
        let alert = UIAlertController(title: "Not Found", message: "User not found", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}


