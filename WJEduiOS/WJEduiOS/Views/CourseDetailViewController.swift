//
//  CourseDetailViewController.swift
//  WJEduiOS
//
//  Created by samson on 23/1/2017.
//  Copyright © 2017 samson. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
protocol CourseDetailViewInterface: class {
    
    //    func showNoContentScreen()
}

//var  slected:NSInteger  自动选中第一个

private var CourseDetailViewControllerKVOContext = 0
class CourseDetailViewController: UIViewController {
    
    
    var rootLayout : TGLinearLayout!
    var bottomScrollView:UIScrollView!
    var rootVideoView : PlayerView?
    var tabindexSelect : TabIndexSelect?
    var isFullscreenMode : Bool!
//    /// 正在播放视频的URL
//    var playingNewsUrl: String = ""
//    /// 正在播放视频的播放器
//    var playingPlayerView: WLVideoPlayerView?
    
     weak var timeSlider: UISlider!
     weak var startTimeLabel: UILabel!
     weak var durationLabel: UILabel!
     weak var rewindButton: UIButton!
     weak var playPauseButton: UIButton!
     weak var fastForwardButton: UIButton!
     weak var fullscreenButton: UIButton!
     weak var playerView: PlayerView!
   
    
    override func loadView() {
        loadInitView()
    }
    static let assetKeysRequiredToPlay = [
        "playable",
        "hasProtectedContent"
    ]
    let player = AVPlayer()
    var currentTime: Double {
        get {
            return CMTimeGetSeconds(player.currentTime())
        }
        set {
            let newTime = CMTimeMakeWithSeconds(newValue, 1)
            player.seek(to: newTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        }
    }
    var asset: AVURLAsset? {
        didSet {
            guard let newAsset = asset else { return }
            
            asynchronouslyLoadURLAsset(newAsset)
        }
    }
    var rate: Float {
        get {
            return player.rate
        }
        
        set {
            player.rate = newValue
        }
    }
    
    var duration: Double {
        guard let currentItem = player.currentItem else { return 0.0 }
        
        return CMTimeGetSeconds(currentItem.duration)
    }
    private var playerLayer: AVPlayerLayer? {
        return playerView.playerLayer
    }
    let timeRemainingFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        
        return formatter
    }()
    /*
     A token obtained from calling `player`'s `addPeriodicTimeObserverForInterval(_:queue:usingBlock:)`
     method.
     */
    private var timeObserverToken: Any?
    
    private var playerItem: AVPlayerItem? = nil {
        didSet {
            /*
             If needed, configure player item here before associating it with a player.
             (example: adding outputs, setting text style rules, selecting media options)
             */
            player.replaceCurrentItem(with: self.playerItem)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Moya
//        let productList =  ApiService.getCourseType()
//        NSLog("productList: \(productList)")
        //http://47.90.92.155/edu/public/typeall
        
        // Do any additional setup after loading the view.
//        playingPlayerView = WLVideoPlayerView(url: URL(string: "http://flv2.bn.netease.com/videolib3/1701/23/YHFSu4496/HD/YHFSu4496-mobile.mp4"))
//        playingPlayerView?.customControlView = controlView
//        playingPlayerView?.placeholderView = UIImageView(image: UIImage(named: "placeholder"))
//        playingPlayerView?.playInView(rootVideoView!)
        
//        rootVideoView?.addSubview(controlView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        if let timeObserverToken = timeObserverToken {
//            player.removeTimeObserver(timeObserverToken)
//            self.timeObserverToken = nil
//        }
//        
//        player.pause()
//        
//        removeObserver(self, forKeyPath: #keyPath(CourseDetailViewController.player.currentItem.duration), context: &CourseDetailViewControllerKVOContext)
//        removeObserver(self, forKeyPath: #keyPath(CourseDetailViewController.player.rate), context: &CourseDetailViewControllerKVOContext)
//        removeObserver(self, forKeyPath: #keyPath(CourseDetailViewController.player.currentItem.status), context: &CourseDetailViewControllerKVOContext)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.changeBackButton(#selector(self.rightBarButtonAction(_:)), title: AppPlist.UserViewConfigText.courseDetailTitleText,viewController: self)
        
        addObserver(self, forKeyPath: #keyPath(CourseDetailViewController.player.currentItem.duration), options: [.new, .initial], context: &CourseDetailViewControllerKVOContext)
        addObserver(self, forKeyPath: #keyPath(CourseDetailViewController.player.rate), options: [.new, .initial], context: &CourseDetailViewControllerKVOContext)
        addObserver(self, forKeyPath: #keyPath(CourseDetailViewController.player.currentItem.status), options: [.new, .initial], context: &CourseDetailViewControllerKVOContext)
        
        playerView.playerLayer.player = player
//        playerView.playerLayer.frame = playerView.frame
        playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
//        let movieURL = URL(string:"http://flv2.bn.netease.com/videolib3/1701/24/eXOLU3162/HD/eXOLU3162-mobile.mp4")
//        let url = URL(string:"http://flv2.bn.netease.com/videolib3/1701/24/eXOLU3162/HD/eXOLU3162-mobile.mp4")
//
//        if let movieURL = url {
//            self.player = AVPlayer(url: movieURL)
//        }
        let movieURL = NSURL.init(string: "47.90.92.155/edu/public/video")
        
            //Bundle.main.url(forResource: "ElephantSeals", withExtension: "mov")!
        asset = AVURLAsset(url: movieURL as! URL, options: nil)
         NSLog("screenBounds.width === %f", playerView.playerLayer.frame.width)
//        NSLog("play frame == %@", playerView.playerLayer.frame)
        // Make sure we don't have a strong reference cycle by only capturing self as weak.
        let interval = CMTimeMake(1, 1)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [unowned self] time in
            let timeElapsed = Float(CMTimeGetSeconds(time))
            
            self.timeSlider.value = Float(timeElapsed)
            self.startTimeLabel.text = self.createTimeString(time: timeElapsed)
        }
        
        
    }
    // MARK: - Asset Loading
    
    func asynchronouslyLoadURLAsset(_ newAsset: AVURLAsset) {
        /*
         Using AVAsset now runs the risk of blocking the current thread (the
         main UI thread) whilst I/O happens to populate the properties. It's
         prudent to defer our work until the properties we need have been loaded.
         */
        newAsset.loadValuesAsynchronously(forKeys: CourseDetailViewController.assetKeysRequiredToPlay) {
            /*
             The asset invokes its completion handler on an arbitrary queue.
             To avoid multiple threads using our internal state at the same time
             we'll elect to use the main thread at all times, let's dispatch
             our handler to the main queue.
             */
            DispatchQueue.main.async {
                /*
                 `self.asset` has already changed! No point continuing because
                 another `newAsset` will come along in a moment.
                 */
                guard newAsset == self.asset else { return }
                
                /*
                 Test whether the values of each of the keys we need have been
                 successfully loaded.
                 */
                for key in CourseDetailViewController.assetKeysRequiredToPlay {
                    var error: NSError?
                    
                    if newAsset.statusOfValue(forKey: key, error: &error) == .failed {
                        let stringFormat = NSLocalizedString("error.asset_key_%@_failed.description", comment: "Can't use this AVAsset because one of it's keys failed to load")
                        
                        let message = String.localizedStringWithFormat(stringFormat, key)
                        
                        self.handleErrorWithMessage(message, error: error)
                        
                        return
                    }
                }
                
                // We can't play this asset.
                if !newAsset.isPlayable || newAsset.hasProtectedContent {
                    let message = NSLocalizedString("error.asset_not_playable.description", comment: "Can't use this AVAsset because it isn't playable or has protected content")
                    
                    self.handleErrorWithMessage(message)
                    
                    return
                }
                
                /*
                 We can play this asset. Create a new `AVPlayerItem` and make
                 it our player's current item.
                 */
                self.playerItem = AVPlayerItem(asset: newAsset)
            }
        }
    }
    // MARK: - KVO Observation
    
    // Update our UI when player or `player.currentItem` changes.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        // Make sure the this KVO callback was intended for this view controller.
        guard context == &CourseDetailViewControllerKVOContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        if keyPath == #keyPath(CourseDetailViewController.player.currentItem.duration) {
            // Update timeSlider and enable/disable controls when duration > 0.0
            
            /*
             Handle `NSNull` value for `NSKeyValueChangeNewKey`, i.e. when
             `player.currentItem` is nil.
             */
            let newDuration: CMTime
            if let newDurationAsValue = change?[NSKeyValueChangeKey.newKey] as? NSValue {
                newDuration = newDurationAsValue.timeValue
            }
            else {
                newDuration = kCMTimeZero
            }
            
            let hasValidDuration = newDuration.isNumeric && newDuration.value != 0
            let newDurationSeconds = hasValidDuration ? CMTimeGetSeconds(newDuration) : 0.0
            let currentTime = hasValidDuration ? Float(CMTimeGetSeconds(player.currentTime())) : 0.0
            
            timeSlider.maximumValue = Float(newDurationSeconds)
            
            timeSlider.value = currentTime
            playPauseButton.isEnabled = hasValidDuration
            timeSlider.isEnabled = hasValidDuration
            startTimeLabel.isEnabled = hasValidDuration
            startTimeLabel.text = createTimeString(time: currentTime)
            
            durationLabel.isEnabled = hasValidDuration
            durationLabel.text = createTimeString(time: Float(newDurationSeconds))
        }
        else if keyPath == #keyPath(CourseDetailViewController.player.rate) {
            // Update `playPauseButton` image.
            
            let newRate = (change?[NSKeyValueChangeKey.newKey] as! NSNumber).doubleValue
            
            let buttonImageName = newRate == 1.0 ? "player_pause" : "player_play"
            
            let buttonImage = UIImage(named: buttonImageName)
            
            playPauseButton.setImage(buttonImage, for: UIControlState())
        }
        else if keyPath == #keyPath(CourseDetailViewController.player.currentItem.status) {
            // Display an error if status becomes `.Failed`.
            
            /*
             Handle `NSNull` value for `NSKeyValueChangeNewKey`, i.e. when
             `player.currentItem` is nil.
             */
            let newStatus: AVPlayerItemStatus
            
            if let newStatusAsNumber = change?[NSKeyValueChangeKey.newKey] as? NSNumber {
                newStatus = AVPlayerItemStatus(rawValue: newStatusAsNumber.intValue)!
            }
            else {
                newStatus = .unknown
            }
            
            if newStatus == .failed {
                handleErrorWithMessage(player.currentItem?.error?.localizedDescription, error:player.currentItem?.error)
            }
        }
    }
    
    // Trigger KVO for anyone observing our properties affected by player and player.currentItem
    override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        let affectedKeyPathsMappingByKey: [String: Set<String>] = [
            "duration":     [#keyPath(CourseDetailViewController.player.currentItem.duration)],
            "rate":         [#keyPath(CourseDetailViewController.player.rate)]
        ]
        
        return affectedKeyPathsMappingByKey[key] ?? super.keyPathsForValuesAffectingValue(forKey: key)
    }
    
    // MARK: - Error Handling
    
    func handleErrorWithMessage(_ message: String?, error: Error? = nil) {
        NSLog("Error occured with message: \(message), error: \(error).")
        
        let alertTitle = NSLocalizedString("alert.error.title", comment: "Alert title for errors")
        let defaultAlertMessage = NSLocalizedString("error.default.description", comment: "Default error message when no NSError provided")
        
        let alert = UIAlertController(title: alertTitle, message: message == nil ? defaultAlertMessage : message, preferredStyle: UIAlertControllerStyle.alert)
        
        let alertActionTitle = NSLocalizedString("alert.error.actions.OK", comment: "OK on error alert")
        
        let alertAction = UIAlertAction(title: alertActionTitle, style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Convenience
    
    func createTimeString(time: Float) -> String {
        let components = NSDateComponents()
        components.second = Int(max(0.0, time))
        
        return timeRemainingFormatter.string(from: components as DateComponents)!
    }

}
extension CourseDetailViewController:NavigationP,TabIndexClick,UIScrollViewDelegate{
    

    /**
     导航栏右键
     */
    func rightBarButtonAction(_ sender: AnyObject){
        self.navigationController!.popViewController(animated: true)
    }
    
    func loadInitView()  {
        let scrollView = UIScrollView()
        self.view = scrollView
        scrollView.backgroundColor = AppPlist.mainViewBgColor
        
        
        rootLayout = TGLinearLayout(.vert)
        rootLayout.tg_width.equal(.fill)
        rootLayout.tg_height.equal(.wrap)
        rootLayout.tg_height.min(scrollView.tg_height)
        rootLayout.tg_vspace = 0
        scrollView.addSubview(rootLayout)
//
//
        playerView = self.createPlayerView()
        rootLayout.addSubview(playerView)

        let scrollAndTabView = UIScrollAndTabView()
        scrollAndTabView.initWithTabName(nameList: AppPlist.CourseDetailTab.courseDetailTabNameList,isIcon: false,tabpos: 1)
        scrollAndTabView.tg_width.equal(.fill)
        scrollAndTabView.tg_height.equal(TGDimeAdapter.height(45))
        scrollAndTabView.tabClickProtocal = self
        tabindexSelect = scrollAndTabView.self
        rootLayout.addSubview(scrollAndTabView)

        bottomScrollView = UIScrollView()
        bottomScrollView.tg_width.equal(.fill)
        bottomScrollView.tg_height.equal(.fill)
        bottomScrollView.backgroundColor = .white
        bottomScrollView.delegate = self
        //        bottomScrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        bottomScrollView.contentSize = CGSize(width: screenBounds.width*4, height: bottomScrollView.frame.height)
        bottomScrollView.isPagingEnabled = true
        //        bottomScrollView.delegate = self
        rootLayout.addSubview(bottomScrollView)
        
        //创建课程模块信息视图
        for i in 0..<4{
            let view = TGLinearLayout(.vert)
            view.tg_width.equal(.fill)
            view.tg_height.equal(.wrap)
//            view.tg_left.equal(screenBounds.width*CGFloat(i))
            view.frame = CGRect(x: 0+screenBounds.width*CGFloat(i), y: 0, width: screenBounds.width, height: 0)
            view.backgroundColor = AppPlist.mainViewBgColor
            view.tg_height.min(bottomScrollView.tg_height)
            
            switch i {
            case 0:
                let courseTitleListView = CourseTitleListView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.width))
                //默认选中第一个
                courseTitleListView.titleListView.selectRow(at: (NSIndexPath.init(row: 0, section: 0)) as IndexPath, animated:false, scrollPosition: .none)
                view.addSubview(courseTitleListView)
                break
            case 1:
                let courseDetailView = CourseDetailView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.width))
                courseDetailView.setCourseInfoModel(title: "PS基础教程", infotext: "本课程从最基本的Photoshop界面认知开始，步步深入，带领大家学习ps技术，了解ps的基本应用方···")
                courseDetailView.setCourseNeadToKnowInfoModel(needtitle: "课程须知", needinfotext: "没有任何Photoshop经验的UI程序开发者，对UI设计知识感兴趣的用户均可学习。", teachtoldtitle: "老师告诉你能学到什么？", teachtoldtext: "轻松学习ps基础知识，UI设计基础知识，可以利用ps设计UI界面，活动海报、H5简单界面等。")
                view.addSubview(courseDetailView)
                break
            case 2:
                let userCommentListView = UserCommentListView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.width))
                
                              
                view.addSubview(userCommentListView)
                break
            case 3:
                let userQuestListView = UserQuestListView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.width))
                
                
                view.addSubview(userQuestListView)
                break
            default:
                break
            }
            bottomScrollView.addSubview(view)
        }

//        let button = UIButton()
//        button.tg_width.equal(TGDimeAdapter.width(50))
//        button.tg_height.equal(TGDimeAdapter.width(50))
//        button.tg_right.equal(20)
//        button.tg_bottom.equal(20)
//        button.setImage(UIImage(named:"plusinicon"), for: .normal)
//        
//        rootLayout.addSubview(button)
//        rootLayout.bringSubview(toFront: button)
    }
    
    func createPlayerView() -> PlayerView {
        rootVideoView = PlayerView()
        //        imageView.tg_height.equal(100%)   //图片视图占用剩余的高度。
        rootVideoView!.tg_width.equal(100%)
        rootVideoView!.tg_height.equal(TGDimeAdapter.height(220))
        rootVideoView!.backgroundColor = CFTool.color(3)
        
        let layout = TGLinearLayout(.horz)
        layout.tg_width.equal(100%)
        layout.tg_height.equal(.fill)
        rootVideoView?.addSubview(layout)
        
        let bottomLayout = TGRelativeLayout()
        bottomLayout.tg_width.equal(100%)
        bottomLayout.tg_height.equal(TGDimeAdapter.height(40))
        bottomLayout.tg_left.equal(0)
        bottomLayout.backgroundColor = UIColor(red: 49/255, green: 53/255, blue: 71/255, alpha: 1.0)
        bottomLayout.tg_bottom.equal(0)
        layout.addSubview(bottomLayout)
        
        playPauseButton = {
            let button = UIButton()
            button.tg_width.equal(TGDimeAdapter.width(30))
            button.tg_height.equal(TGDimeAdapter.width(30))
            button.tg_left.equal(0)
            button.tg_centerY.equal(0)
            button.addTarget(self, action: #selector(buttonWasPressed(_:)), for: .touchUpInside)
            button.tag = 201
            button.setImage(UIImage(named:"player_pause"), for: .normal)
            bottomLayout.addSubview(button)
            return button
        }()
        
        fullscreenButton = {
            let button = UIButton()
            button.tg_width.equal(TGDimeAdapter.width(30))
            button.tg_height.equal(TGDimeAdapter.width(30))
            button.tg_right.equal(0,offset:2)
            button.tg_centerY.equal(0)
            button.setImage(UIImage(named:"player_fullscreen"), for: .normal)
            bottomLayout.addSubview(button)
            button.addTarget(self, action: #selector(fullScreenClick), for: .touchUpInside)
            return button
        }()
    

        startTimeLabel = {
            let label = UILabel()
            label.text = "00:00"
            label.adjustsFontSizeToFitWidth = true
            label.textColor = UIColor(red: 110/255, green: 110/255, blue: 110/255, alpha: 1.0)
            label.font = UIFont(name: AppPlist.appPingFangMediumFontString, size: 12)
            label.lineBreakMode = .byTruncatingMiddle
            label.tg_centerY.equal(0)
            label.tg_left.equal(playPauseButton.tg_right,offset:5)       //左边和父视图左对齐
//            label.tg_top.equal(-3)
            //    sectionTitleLabel.tg_right.equal(imageView.tg_right)                //右边是图标的左边。
            label.sizeToFit()
            bottomLayout.addSubview(label)
            return label
        }()
    
        
        durationLabel = {
            let label = UILabel()
            label.text = "00:00"
            label.adjustsFontSizeToFitWidth = true
            label.textColor = UIColor(red: 110/255, green: 110/255, blue: 110/255, alpha: 1.0)
            label.font = UIFont(name: AppPlist.appPingFangMediumFontString, size: 12)
            label.lineBreakMode = .byTruncatingMiddle
            label.tg_right.equal(fullscreenButton.tg_left,offset:5)       //左边和父视图左对齐
            label.tg_centerY.equal(0)
            label.sizeToFit()
            bottomLayout.addSubview(label)
            return label
        }()

        
        timeSlider = {
            let slideritem = UISlider()
            slideritem.tg_width.equal(.fill)
            slideritem.tg_height.equal(TGDimeAdapter.height(20))
            slideritem.tg_centerY.equal(0)
            slideritem.addTarget(self, action: #selector(self.timeSliderDidChange(_:)), for: .valueChanged)
            slideritem.tg_left.equal(startTimeLabel.tg_right,offset:5)
            slideritem.tg_right.equal(durationLabel.tg_left,offset:5)
            slideritem.setThumbImage(UIImage(named:"player_thumb"), for: .normal)
            bottomLayout.addSubview(slideritem)
            return slideritem
            }()
    
        
        return rootVideoView!

    }
    
    func tabClickAtIndex(index: Int) {
//        SVProgressHUD.show()
//        eventHandler?.loadAllGoods(index: index)
        var offset = self.bottomScrollView.contentOffset
        offset.x = self.bottomScrollView.frame.width*CGFloat(index-1)
        self.bottomScrollView.setContentOffset(offset, animated: true)

    }
    
    //课程item点击事件执行
    func handleCellLayoutTap(_ sender:UIView)-> Void {
        
    }
    
    func timeSliderDidChange(_ sender: UISlider) {
        currentTime = Double(sender.value)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        resetSmsVerifyCodeLabelAndTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //获取偏移量
        let offset = scrollView.contentOffset
        let currentPage = offset.x / (self.bottomScrollView.frame.width)
        tabindexSelect?.tabIndexSelect(index: Int(currentPage))
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        timerForlabel = Timer.scheduledTimer(timeInterval: timeScrollViewBeginScroll, target: self, selector: #selector(self.countdown(_:)), userInfo: nil, repeats: true)
    }

    
    //MARK: Actions
    
    func buttonWasPressed(_ sender: UIButton) {
        switch sender.tag {
        case 201:
            if player.rate != 1.0 {
                // Not playing forward, so play.
                if currentTime == duration {
                    // At end, so got back to begining.
                    currentTime = 0.0
                }
                player.play()
            }
            else {
                // Playing, so pause.
                player.pause()
            }
            break
        default:
            break
        }
    }
    
    func fullScreenClick(sender:UIButton) -> Void {
         sender.isSelected = !sender.isSelected
        if sender.isSelected {
        
//        playerView.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
//            rootVideoView?.tg_height.equal(screenBounds.width)
//            rootVideoView?.tg_width.equal(screenBounds.height)
//        } else {
////        rootVideoView?.tg_height.equal(screenBounds.height)
//
        }
    }
}

