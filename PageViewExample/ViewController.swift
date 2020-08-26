//
//  ViewController.swift
//  PageViewExample
//
//  Created by Shunzhe Ma on 8/26/20.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    private var views = [UIView]()
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDemoData()
        
        // UIScrollViewを画面に追加します
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        // 各ビューを `UIScrollView` に追加します
        for i in 0..<views.count {
            let view = views[i]
            view.frame = CGRect(x: CGFloat(i) * self.view.frame.size.width, y: 200, width: self.view.frame.size.width, height: 300)
            scrollView.addSubview(view)
        }
        
        // `UIPageControl` を画面に追加します
        pageControl = UIPageControl(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 50)))
        pageControl.numberOfPages = views.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(self.pageUpdated), for: .valueChanged)
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
        
        /// 全てのインジケーター画像を同じ画像に設定できます
//        pageControl.preferredIndicatorImage = UIImage(systemName: "star.fill")
        
        /// または、ページ毎に異なる画像を設定できます
        pageControl.setIndicatorImage(UIImage(systemName: "sun.max.fill"), forPage: 0)
        pageControl.setIndicatorImage(UIImage(systemName: "cloud.sun.fill"), forPage: 1)
        pageControl.setIndicatorImage(UIImage(systemName: "cloud.drizzle.fill"), forPage: 2)
        
        /// UIPageControl の背景を常に見えるように設定
        pageControl.backgroundStyle = .prominent
        
        /// プログラムの変数を設定することで、UIPageControlの上をスクロールすることでユーザーはページを切り替えることができます:
        pageControl.allowsContinuousInteraction = true
        
    }
    
    // プログラムのレイアウトを設定します
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // ScrollView
        scrollView.frame = self.view.frame
        let totalWidth = CGFloat(views.count) * self.view.frame.size.width
        scrollView.contentSize = CGSize(width: totalWidth, height: self.view.bounds.height)
        // Page Control
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let leading = pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        view.addConstraints([leading, trailing, bottom])
    }
    
    // データ例
    func loadDemoData() {
        for i in 0..<3 {
            // UIKit 一部のビューの例を追加することができます：
            let view = UITextView()
            view.text = "Test \(String(i))"
            view.textAlignment = .center
            view.font = .preferredFont(forTextStyle: .largeTitle)
            view.isSelectable = false
            view.isEditable = false
            views.append(view)
            // または、一部のSwiftUIビューを追加することができます
//            let view = textOnlyView(contentText: "Page \(String(i))")
//            loadSwiftUIViews([view])
        }
    }
    
    func loadSwiftUIViews<Content: View>(_ swiftUIViews: [Content]) {
        for view in swiftUIViews {
            let hostingVC = UIHostingController(rootView: view)
            addChild(hostingVC)
            hostingVC.didMove(toParent: self)
            views.append(hostingVC.view)
        }
    }
    
    // プログラムの変数を設定することで、UIPageControlの上をスクロールすることでユーザーはページを切り替えることができます:
    @objc func pageUpdated() {
        let xPosition = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        let newScrollViewPosition = CGPoint(x: xPosition, y: 0)
        scrollView.setContentOffset(newScrollViewPosition, animated: true)
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNum = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        self.pageControl.currentPage = pageNum
    }
    
}
