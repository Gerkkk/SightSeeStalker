//
//  ImageFromPhoneCarouselView.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 04.03.2025.
//

import UIKit

class ImageFromPhoneCarouselView: UIView, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var images: [UIImage]
    
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    private let addImageButton = UIButton(type: .system)

    init(images: [UIImage]) {
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

        addImageButton.setTitle("Add Image", for: .normal)
        addImageButton.backgroundColor = UIColor.customGreen
        addImageButton.setTitleColor(UIColor.backgroundCol, for: .normal)
        addImageButton.layer.cornerRadius = 10
        addImageButton.addTarget(self, action: #selector(didTapAddImageButton), for: .touchUpInside)
        addSubview(addImageButton)
        
        setupImages()
    }
    
    private func setupImages() {
        print("LOL")
        for (index, image) in images.enumerated() {
            let imageView = UIImageView()
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 30
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
        scrollView.pinTop(to: self.topAnchor)
        scrollView.pinCenterX(to: self)
        scrollView.setHeight(0.8 * frame.height)
        pageControl.setWidth(frame.width)
        
        pageControl.pinTop(to: scrollView.bottomAnchor)
        pageControl.pinCenterX(to: self)
        pageControl.setWidth(frame.width)
        pageControl.setHeight(0.05 * frame.height)
        
        addImageButton.pinTop(to: pageControl.bottomAnchor, 2)
        addImageButton.pinCenterX(to: self)
        addImageButton.setWidth(80)
        addImageButton.setHeight(frame.height * 0.15 - 2)
        setupImages()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
    
    @objc private func didTapAddImageButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        if let viewController = self.window?.rootViewController {
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            images.append(image)
            pageControl.numberOfPages = images.count
            setupImages()
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
