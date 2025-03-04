//
//  ImageFromPhoneCarouselView.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 04.03.2025.
//

import UIKit

class ImageFromPhoneCarouselView: UIView, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var images: [String]
    
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    private let addImageButton = UIButton()

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

        addImageButton.setTitle("Add Image", for: .normal)
        addImageButton.backgroundColor = UIColor.customGreen
        addImageButton.layer.cornerRadius = 10
        addImageButton.addTarget(self, action: #selector(didTapAddImageButton), for: .touchUpInside)
        addSubview(addImageButton)
        
        setupImages()
    }
    
    private func setupImages() {
        for (index, url) in images.enumerated() {
            let imageView = UIImageView()
            imageView.loadImage(from: "http://127.0.0.1:8000" + url)
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
        pageControl.frame = CGRect(x: 0, y: scrollView.frame.maxY, width: frame.width, height: 20)
        addImageButton.frame = CGRect(x: frame.width - 120, y: frame.height - 60, width: 100, height: 40)
        setupImages()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
    
    @objc private func didTapAddImageButton() {
        print(1)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        if let viewController = self.window?.rootViewController {
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            let imageName = UUID().uuidString + ".jpg"
            if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                let fileManager = FileManager.default
                let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent(imageName)
                
                try? imageData.write(to: fileURL)
                
                images.append(fileURL.absoluteString)
                pageControl.numberOfPages = images.count
                setupImages()
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
