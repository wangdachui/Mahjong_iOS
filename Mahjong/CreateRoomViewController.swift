//
//  CreateRoomViewController.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

class CreateRoomViewController: UIViewController {

    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var radarView: EasyRadarView!
    
    let connectManager = MPCManager()
    var selectedUsers: [User] = []
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRadarView()
        connectManager.delegate = self
    }
    
    private func setupRadarView() {
        //设置是否开启调试日志
        EasyRadarView.enableLog = true
        //设置背景图
        radarView.bgImage = UIImage(named: "radar_bg")
        //设置中心视图图片
        radarView.centerViewImage = UIImage(named: "photo")
        //设置圈数
        radarView.circleNum = 3
        //设置指针半径
        radarView.indicatorViewRadius = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 2 - 24
        //设置每个圈与圈的增量距离
        radarView.circleIncrement = 10.0
        
        //设置标注点击回调
        radarView.pointTapBlock = { (radarPointView) in
            print("tag:\(radarPointView.tag)")
            if let user = radarPointView.user {
                self.didClickOnUser(user)
            }
        }
    }
    
    //MARK: - Action
    private func didClickOnUser(_ user: User) {
        print("\(#function) name = \(user.name)")
        if !selectedUsers.compactMap({ $0.userId }).contains(user.userId) {
            selectedUsers.append(user)
        }
    }

    @IBAction func didClickOnFindButton(_ sender: UIButton) {
        connectManager.resume()
        radarView.scan()
    }
    
}

//MARK: - MPCManagerDelegate
extension CreateRoomViewController: ConnectManagerDelegate {

    func didConnected() {
        
    }
    
    func didDisconnected() {
        
    }
    
    func didReceive(message: MessagePayload) {
        
    }
    
    func didAdded(user: User) {
        radarView.addPointView(user)
    }
    
    func didRemoved(user: User) {
        radarView.removePointView(user)
    }
}
