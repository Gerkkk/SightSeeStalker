//
//  ImageCarouselView.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 09.02.2025.
//

import UIKit

class ImageCarouselView: UIView, UIScrollViewDelegate {

    private var images: [String]
    
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()

    init(images: [String]) {
        self.images = images
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        addSubview(scrollView)

        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.textSupporting
        pageControl.currentPageIndicatorTintColor = UIColor.customGreen
        addSubview(pageControl)

        setupImages()
    }

    private func setupImages() {
        for (index, url) in images.enumerated() {
            let imageView = UIImageView()
            imageView.loadImage(from: "http://127.0.0.1:8000" + url)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(
                x: CGFloat(index) * self.frame.width,
                y: 0,
                width: self.frame.width,
                height: self.frame.height * 0.8
            )
        }

        scrollView.contentSize = CGSize(width: self.frame.width * CGFloat(images.count), height: self.frame.height * 0.8)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.8)
        pageControl.frame = CGRect(x: 0, y: scrollView.frame.maxY, width: frame.width, height: 20)
        setupImages()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
}

